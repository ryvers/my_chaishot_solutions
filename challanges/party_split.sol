pragma solidity ^0.4.19;

contract Party {
    uint256 minAmount;
    address[] participants;
    
    function Party(uint256 _minAmount) public {
        minAmount = _minAmount;
    }

    function rsvp() public payable {
        if(msg.value > minAmount){
            msg.sender.transfer(msg.value-minAmount);
            participants.push(msg.sender);
            return;
        }else if(msg.value < minAmount){
            msg.sender.transfer(msg.value);
            return;
        } else {
            participants.push(msg.sender);
        }
    }

    function payBill(uint256 amount) public {
        uint totalAmount = minAmount * participants.length;
        require(amount <= totalAmount);
        uint equal_refund = (totalAmount - amount)/participants.length;
        for(uint i=0; i < participants.length; i++){
            participants[i].transfer(equal_refund);
        }
    }

}