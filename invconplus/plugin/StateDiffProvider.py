from typing import Any
from .Provider import Provider
import logging
from .quickNode import fetchStateDiff as fetchStateDiffByQuickNode
from .etherscan import fetchStateDiff as fetchStateDiffByEtherscan
import traceback
import time 

TX_HASH="tx_hash"
class StateDiffProvider(Provider):
    def __init__(self, params) -> None:
        super().__init__(params=params)

    # @input, read a transaction hashes
    # @output, produce a set of state diffs for one or maybe more contract address 
    def read(self) -> Any:
        etherscan_times = 3
        count = 0 
        logging.debug(self.params[TX_HASH])
        try:
            raise Exception("error")
            # while count < etherscan_times:
            #     try:
            #         result = fetchStateDiffByEtherscan(self.params[TX_HASH])
            #         break
            #     except:
            #         count += 1
            #         time.sleep(count+2)
            #         continue
            # return result
            # do not use etherscan anymore
        except:
            # when etherscan fails, use quicknode as a backup
            # traceback.print_exc()
            result = fetchStateDiffByQuickNode(self.params[TX_HASH])
            return result 

if __name__ == "__main__":
    params = dict()
    params[TX_HASH] = "0x4fc330598e1abc9e09dd1e00836d0d2d46b25d3cbce6cc60137dc14897ef65dd"
    sdProvider = StateDiffProvider(params=params)
    sdProvider.read()