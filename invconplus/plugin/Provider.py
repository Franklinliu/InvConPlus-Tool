from typing import Any 

class Provider:
    params: Any 
    def __init__(self, params: Any) -> None:
        self.params =  params
    
    def read(self) -> Any:
        pass  