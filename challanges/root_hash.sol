pragma solidity ^0.4.19;

contract Root {
  function findRoot(bytes array) public pure returns(bytes32){
        uint parts = array.length / 32;
        bytes32 hash;
        for(uint i = 0; i < parts; i++){
            if(i==0){
                hash = bytesToBytes32(array,i*32);
            }
            else {
                hash = keccak256(hash,bytesToBytes32(array,i*32));
            }
        }
        return hash;
  }

  function bytesToBytes32(bytes b, uint offset) public pure returns (bytes32) {
        bytes32 out;
        for (uint i = 0; i < 32; i++) {
            out |= bytes32(b[offset + i] & 0xFF) >> (i * 8);
        }
        return out;
  }
}
