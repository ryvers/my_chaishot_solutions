start: public(uint256)

@public 
@payable
def __init__(count: uint256):
    self.start=count

@public
def tick():
    self.start=self.start-1
    if(self.start==0):
        selfdestruct(msg.sender)

