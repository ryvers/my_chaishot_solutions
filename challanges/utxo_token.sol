pragma solidity ^0.4.19;

contract Token {
  struct UTXO {
      address owner;
      uint256 value;
      bool isSpent;
      bytes32 id;
  }

  UTXO[] public utxos;
  uint256 public index;
  mapping (bytes32 => uint256) idToIndexOfUtxo;
  address private owner;
  event NewUTXO(address owner, bytes32 id, uint256 value);

  function Token() public {
      owner = msg.sender;
      index=0;
  }

  function initialize(address _owner, uint256 _value) public {
      require(msg.sender == owner);
      createUtxo(_owner,_value);
  }

  function createUtxo(address _owner, uint256 _value) private {
      bytes32 id = keccak256(now,_owner,_value);
      UTXO memory utxo = UTXO(_owner,_value,false,id);
      utxos.push(utxo);
      idToIndexOfUtxo[id] = index;
      index++;
      NewUTXO(_owner,id,_value);
  }

  function spend(bytes32 _id, uint256 _amount, address _to) public {
      uint i = idToIndexOfUtxo[_id];
      require(utxos[i].owner == msg.sender);
      require(utxos[i].isSpent == false);
      require(utxos[i].value >= _amount);
      
      if(utxos[i].value > _amount){
          utxos[i].isSpent = true;
          createUtxo(msg.sender,utxos[i].value-_amount);
          createUtxo(_to,_amount);
      }
      if(utxos[i].value == _amount){
          utxos[i].isSpent = true;
          createUtxo(_to,_amount);
      }
  }
}
