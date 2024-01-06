import os
import requests
import sys
import logging

session = requests.Session()
session.params = {}

class chifra():
    def __init__(self):
        pass

    from ._usage import isValidCommand, usage
    from ._utils import toUrl

    from ._abis import abis
    from ._blocks import blocks
    from ._chunks import chunks
    from ._config import config
    # from ._daemon import daemon
    # from ._explore import explore
    from ._export import export
    from ._init import init
    from ._list import list
    from ._logs import logs
    from ._monitors import monitors
    from ._names import names
    from ._receipts import receipts
    from ._scrape import scrape
    from ._slurp import slurp
    from ._state import state
    from ._tokens import tokens
    from ._traces import traces
    from ._transactions import transactions
    from ._when import when

    def dispatch(self):
        # logging.getLogger().setLevel(logging.INFO)
        if self.isValidCommand() == False:
            self.usage("The first argument must be one of the valid commands.")

        response = ""
        option =  sys.argv[1]
        if option == 'abis':
                return self.abis()
        elif option == 'blocks':
                return self.blocks()
        elif option == 'chunks':
                return self.chunks()
        elif option == 'config':
                return self.config()
        elif option == 'daemon':
                return self.daemon()
        elif option == 'explore':
                return self.explore()
        elif option == 'export':
                return self.export()
        elif option == 'init':
                return self.init()
        elif option == 'list':
                return self.list()
        elif option == 'logs':
                return self.logs()
        elif option == 'monitors':
                return self.monitors()
        elif option == 'names':
                return self.names()
        elif option == 'receipts':
                return self.receipts()
        elif option == 'scrape':
                return self.scrape()
        elif option == 'slurp':
                return self.slurp()
        elif option == 'state':
                return self.state()
        elif option == 'tokens':
                return self.tokens()
        elif option == 'traces':
                return self.traces()
        elif option == 'transactions':
                return self.transactions()
        elif option == 'when':
                return self.when()

    def cmdLine(self):
        ret = "chifra"
        for i, arg in enumerate(sys.argv):
            if i > 0:
                ret += (" " + arg)
        return ret
