from evm_trace.vmtrace import VMTrace, to_trace_frames, from_rpc_response
import json 

vm_trace_file =  "./vmTrace.json"
vmTrace = json.load(open(vm_trace_file))
rpc_response = {"result": {"vmTrace": vmTrace, "trace": [], "stateDiff": {}}}

rpc_response = json.dumps(rpc_response).encode("utf-8")

vm_trace = from_rpc_response(rpc_response)

# print(vm_trace)

for frame in to_trace_frames(vm_trace):
    if len(frame.storage)>0:
        print(frame.__str__())
        print(frame.storage)
        # break
    # print(frame.__str__())
