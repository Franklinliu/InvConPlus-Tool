import json
import logging
import os 
import sys
sys.setrecursionlimit(2000)

from typing import List

from Crypto.Hash import keccak
from evm_trace import TraceFrame, ParityTraceList, get_calltree_from_parity_trace
from evm_trace.vmtrace import VMTrace, VMTraceFrame, to_trace_frames, from_rpc_response

from invconplus.plugin.quickNode import fetchAllRuntimeInformation
from invconplus.plugin.chifra_usdt import fetchTransaction

def keccak256(buffer: bytes) -> bytes:
    """
    Computes the keccak256 hash of the input `buffer`.

    Parameters
    ----------
    buffer :
        Input for the hashing function.

    Returns
    -------
    hash : `ethereum.base_types.Hash32`
        Output of the hash function.
    """
    k = keccak.new(digest_bits=256)
    return bytes(k.update(buffer).digest())

class Instruction:
    def __init__(self, frame: VMTraceFrame) -> None:
        self.frame = frame
        self.children: list["Instruction"] = []
    @property
    def op(self) -> str:
        return self.frame.op
    @property
    def stack(self) -> list:
        return self.frame.stack
    @property
    def depth(self) -> int:
        return self.frame.depth
    @property
    def pc(self) -> int:
        return self.frame.pc
    @property
    def memory(self) -> list:
        return self.frame.memory
    @property
    def storage(self) -> dict:
        return self.frame.storage
    
    @property
    def index_values(self):
        if self.op in  ["KECCAK256", "SHA3"]:
            return [] 
        elif self.op in ["SSTORE"]:
            return [] 
        elif self.op in ["MSTORE"]:
            # value = hex(self.stack[-2])
            value = f"{self.stack[-2]:#0{66}x}"
            return [value] 
        elif self.op in ["ADD"]:
            # x = hex(self.stack[-1])
            # y = hex(self.stack[-2])
            # return [x, y]
            return []
        else:
            return []

    def dependend(self, ins: "Instruction") -> bool:
        if self.op in  ["KECCAK256", "SHA3"]:
            memory_start_index = self.stack[-1]
            size = self.stack[-2]
            if ins.op in ["MSTORE", "MSTORE8"]:
                mstore_memory_start_index = ins.stack[-1]
                value = ins.stack[-2]
                if ins.op == "MSTORE":
                    word_size = 32 
                    if memory_start_index  <= mstore_memory_start_index and mstore_memory_start_index + word_size <= memory_start_index+size:
                        if value == int(self.memory[mstore_memory_start_index:mstore_memory_start_index+word_size].hex(), 16):
                            return True
                        else:
                            return False
                else:
                    word_size = 8 
                    if memory_start_index  <= mstore_memory_start_index and mstore_memory_start_index + word_size <= memory_start_index+size:
                        if value == int(self.memory[mstore_memory_start_index:mstore_memory_start_index+word_size].hex(), 16):
                            return True
                        else:
                            return False
              
        elif self.op in ["SSTORE"]:
            key =  self.stack[-1]
            value = self.stack[-2]
            if ins.op in ["KECCAK256", "SHA3"]:
                memory_start_index = ins.stack[-1]
                size = ins.stack[-2]
                data = ins.memory[memory_start_index:memory_start_index+size]
                slot = int(keccak256(data).hex(), 16)
                if slot == key:
                    return True
                else:
                    return False
            elif ins.op in ["ADD"]:
                x = ins.stack[-1]
                y = ins.stack[-2]
                if x + y == key:
                    return True
                else:
                    return False
        elif self.op in ["MSTORE"]:
            value = self.stack[-2]
            if ins.op in ["ADD"]:
                x = ins.stack[-1]
                y = ins.stack[-2]
                if x + y  == value:
                    return True
                else:
                    return False
            elif ins.op in  ["KECCAK256", "SHA3"]:
                memory_start_index = ins.stack[-1]
                size = ins.stack[-2]
                data = ins.memory[memory_start_index:memory_start_index+size]
                _hash = int(keccak256(data).hex(), 16)
                if _hash == value:
                    return True
                else:
                    return False
        elif self.op in ["ADD"]:
            x = self.stack[-1]
            y = self.stack[-2]
            if ins.op in  ["KECCAK256", "SHA3"]:
                memory_start_index = ins.stack[-1]
                size = ins.stack[-2]
                data = ins.memory[memory_start_index:memory_start_index+size]
                _hash = int(keccak256(data).hex(), 16)
                if _hash == x or _hash == y:
                    return True
                else:
                    return False
        
        return False
    
    def __str__(self) -> str:
        return f"{self.op} {self.stack} {self.depth} {self.pc} {self.memory} {self.storage}"
    
    def __json__(self) -> dict:
        if self.op in  ["KECCAK256", "SHA3"]:
            memory_start_index = self.stack[-1]
            size = self.stack[-2]
            data = self.memory[memory_start_index:memory_start_index+size]
            _hash = int(keccak256(data).hex(), 16)
            return {
                "op": self.op,
                "pc": self.pc,
                "data": data.hex(),
                "hash": hex(_hash),
                "children": [child.__json__() for child in self.children]
            }
        elif self.op in ["SSTORE"]:
            key =  self.stack[-1]
            value = self.stack[-2]
            return {
                "op": self.op,
                "pc": self.pc,
                "key": hex(key),
                "value": value,
                "children": [child.__json__() for child in self.children]
            }
        elif self.op in ["MSTORE"]:
            value = self.stack[-2]
            return {
                "op": self.op,
                "pc": self.pc,
                "value": hex(value),
                "children": [child.__json__() for child in self.children]
            }
        elif self.op in ["MSTORE8"]:
            value = self.stack[-2]
            return {
                "op": self.op,
                "pc": self.pc,
                "value": hex(value),
                "children": [child.__json__() for child in self.children]
            }
        elif self.op in ["ADD"]:
            x = self.stack[-1]
            y = self.stack[-2]
            return {
                "op": self.op,
                "pc": self.pc,
                "x": hex(x),
                "y": hex(y),
                "children": [child.__json__() for child in self.children]
            }
        else:
            return {
                "op": self.op,
                # "stack": self.stack,
                # "depth": self.depth,
                "pc": self.pc,
                # "memory": self.memory,
                # "storage": self.storage,
                "children": [child.__json__() for child in self.children]
            }

class DependencyGraph:
    def __init__(self, ins: Instruction) -> None:
        self.root =  ins
        self.visited = list()
    
    def add_child(self, ins: "Instruction") -> None:
        self.visited =  list()
        self._add_child(self.root, ins)
        
    
    def _add_child(self, ins_bottom: "Instruction", ins_dependent: "Instruction") -> None:
        if ins_bottom in self.visited:
            return 
        self.visited.append(ins_bottom)
        if ins_bottom.dependend(ins_dependent):
            ins_bottom.children.append(ins_dependent)
        else:
            for child in ins_bottom.children:
                self._add_child(child, ins_dependent)
    
    def visitGetIndexValues(self):
        index_values = []
        self._visitGetIndexValues(self.root, index_values)
        return index_values
    
    def _visitGetIndexValues(self, ins: Instruction, index_values: list = []):
        index_values.extend(ins.index_values)
        for child in ins.children:
            self._visitGetIndexValues(child, index_values)

    def __str__(self) -> str:
        return str(self.root)
    
    def __json__(self) -> dict:
        return self.root.__json__()
    

class Simulator:
    graphs: List[DependencyGraph]
    data: object
    interested_frames: List[VMTraceFrame]
    def __init__(self, tx_hash) -> None:
        logging.debug("analyzing transaction#{0}".format(tx_hash))
        if not os.path.exists(f"./tmp/txs"):
            os.mkdir("./tmp/txs")
        if os.path.exists(f"./tmp/txs/{tx_hash}.json"):
            self.data = json.loads(open(f"./tmp/txs/{tx_hash}.json", "r").read())
        else:
            self.data = fetchAllRuntimeInformation(tx_hash=tx_hash)
               
    def loadAndexec(self):
        vm_trace = from_rpc_response(buffer=json.dumps(self.data).encode("utf-8"))
        self.graphs = list()
        interested_frames = list()
        for frame in to_trace_frames(vm_trace):
            if frame.op in ["KECCAK256", "SHA3", "SSTORE", "MSTORE", "ADD"]:
                interested_frames.append(frame)
        self.interested_frames = interested_frames
        # for frame in reversed(interested_frames):
        #     if frame.op == "SSTORE":
        #         graph = DependencyGraph(Instruction(frame))
        #         self.graphs.append(graph)
        #     else:
        #         for graph in self.graphs:
        #             graph.add_child(Instruction(frame))
    
    def query(self, slot):
        result = []
        slot = slot if isinstance(slot, str) and slot.startswith("0x") else hex(slot)
        graph = None 
        for frame in reversed(self.interested_frames):
            if frame.op == "SSTORE" and frame.stack[-1] == int(slot, 16) and graph is None:
                graph = DependencyGraph(Instruction(frame))
            elif graph is not None and frame.op in ["KECCAK256", "SHA3", "MSTORE", "ADD"]:
                graph.add_child(Instruction(frame))
        
        assert graph is not None 
        result = graph.visitGetIndexValues()

        # for graph in self.graphs:
        #     slot = slot if isinstance(slot, str) and slot.startswith("0x") else hex(slot)
        #     if graph.root.stack[-1] == int(slot, 16):
        #         result = graph.visitGetIndexValues()
        #         break

        if len(result) == 0:
            logging.debug("query storage slot {0} with result {1}".format(slot, set(result)))
        else:
            logging.debug("query storage slot {0} with result {1}".format(slot, set(result)))
        return set(result)


def fetchSlotCalculationConstants(address:str, tx_hash: str) -> list:
    if not os.path.exists(f"./tmp/txs"):
        os.mkdir("./tmp/txs")
    if os.path.exists(f"./tmp/txs/{tx_hash}.json"):
        data = json.loads(open(f"./tmp/txs/{tx_hash}.json", "r").read())
        if data is None:
            return []
        if "slots_sha3" in data:
            if len(data["slots_sha3"])>0:
                if isinstance(data["slots_sha3"][0], int):
                    # print([ hex(item) for item in data["slots_sha3"]])
                    return [ hex(item) for item in data["slots_sha3"]]
                else:
                    # print(data["slots_sha3"])
                    return data["slots_sha3"]
    else:
        try:
            data = fetchAllRuntimeInformation(tx_hash=tx_hash)
            if data is None:
                return []
            open(f"./tmp/txs/{tx_hash}.json", "w").write(json.dumps(data, indent=4))
        except:
            return []

    vm_trace = from_rpc_response(buffer=json.dumps(data).encode("utf-8"))
    graphs = list()
    interested_frames = list()
    for frame in to_trace_frames(vm_trace):
        if frame.op in ["KECCAK256", "SHA3", "SSTORE", "MSTORE", "ADD"]:
            interested_frames.append(frame)
    for frame in reversed(interested_frames):
        if frame.op == "SSTORE":
            graph = DependencyGraph(Instruction(frame))
            graphs.append(graph)
        for graph in graphs:
            graph.add_child(Instruction(frame))
    
    result = set()
    for graph in graphs:
        # print(json.dumps(graph.__json__(), indent=4))
        # print("--------------------------------------------------")
        _result = graph.visitGetIndexValues()
        result.update(_result)
        # print(_result)
        # print("--------------------------------------------------")
    # print(list(result))

    data["slots_sha3"] = list(result)
    open(f"./tmp/txs/{tx_hash}.json", "w").write(json.dumps(data, indent=4))
    if  len(data["slots_sha3"])>0 and isinstance(data["slots_sha3"][0], int):
        # print([ hex(item) for item in data["slots_sha3"]])
        return [ hex(item) for item in data["slots_sha3"]]
    else:
        # print(data["slots_sha3"])
        return data["slots_sha3"]
    
def main():
    tx_hash = "0x6b353f3b287f418684fa7aa9fa6e4f001989b1ee6d702db6943daddbe31f9776"
    # "0x25e484b97f3c4c455b1e036b4a9f13e871f000261400a4e618c30cd74ae7deec"
    # "0x1789548a9d809fac1baf8d7a0c6ed93e79d8db9ed819985eff94123d9a17892d"
    # "0x7b1fb133ed1d6d32bcd139f32ce2ae781abdeedad321a86756ecd6f4a7a6cd7b"
    # tx_hash = "0x948b94e827664564401571632d0b2405c09776f1d2bbbdd16f8a068e80e161e1"
    simulator = Simulator(tx_hash=tx_hash)
    simulator.loadAndexec()
    slot = "0xcb2dfae97afc12bcb6c50f25e293cfcf8344509d50871de7e5ca0767c5e868fe"
    result = simulator.query(slot)
    print(result)

    print("--------------------------------------------------")
    print("Storage\t\tValue")
    for graph in simulator.graphs:
        print(hex(graph.root.stack[-1]), hex(graph.root.stack[-2]))
        # if hex(graph.root.stack[-1]) == slot:
        if True:
            print(json.dumps(graph.__json__(), indent=4))
            # print("--------------------------------------------------")
            # print(set(graph.visitGetIndexValues()))
            print("--------------------------------------------------")
    print("--------------------------------------------------")

   

if __name__ == "__main__":
    main()