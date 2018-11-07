pragma solidity ^0.4.18;

contract Parity {
    event Even();
    event Odd();

    function check(bytes32 array) public {
        uint256 x = uint256(array);
        if(x%2==0){
            Even();
        }else {
            Odd();
        }
    }
}
