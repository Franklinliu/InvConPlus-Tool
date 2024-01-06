from typing import Any, List
from .Provider import Provider
import logging
from .chifra import fetchTransactionsForAccount
from .chifra_usdt import fetchTransactionsForUSDT
USDT_ADDRESS = "0xdAC17F958D2ee523a2206206994597C13D831ec7"
CONTRACT_ADDRESS="contract_address"

class TransactionProvider(Provider):
    def __init__(self, params, maxCount=None, cached_record_number = 0) -> None:
        super().__init__(params=params)
        self.maxCount = maxCount
        self.cached_record_number = cached_record_number

    # @result, a list of transactions
    def read(self) -> List[Any]:
        logging.warning(f"cached record number {self.cached_record_number}")
        logging.debug(self.params[CONTRACT_ADDRESS])
        if self.params[CONTRACT_ADDRESS] == USDT_ADDRESS:
            result =  fetchTransactionsForUSDT(self.params[CONTRACT_ADDRESS], self.maxCount, self.cached_record_number)
        else:
            result = fetchTransactionsForAccount(self.params[CONTRACT_ADDRESS], self.maxCount, self.cached_record_number)
        return result

if __name__ == "__main__":
    params = dict()
    params[CONTRACT_ADDRESS] = "0x1dac5649e2a0c943ffc4211d708f6ddde4742fd6"
    scProvider = TransactionProvider(params=params)
    scProvider.read()