pragma solidity ^0.4.19;

import "./EIP20.sol";

contract TreasureChest {

    function withdraw(address[] addresses) public {
        for(uint i = 0; i < addresses.length; i++){
            EIP20 x = EIP20(addresses[i]);
            x.transfer(msg.sender, x.balanceOf(this));
        }
    }
}
