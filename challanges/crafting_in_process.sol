pragma solidity ^0.4.18;

import "./ERC721.sol";

contract Marketplace is ERC721 {
    address public owner;
    uint256 public itemId = 1;
    mapping(uint => GameItem) public gameItems;
    
    struct GameItem {
        string name;
        uint256 attackPower;
    }
    modifier onlyOwner {
        require(msg.sender==owner);
        _;
    }

    function Marketplace() public {
        owner = msg.sender;
    }

    function createItem(string _name, uint256 _attackPower, address _to) public onlyOwner {
        _mint(_to,itemId);
        GameItem memory gameItem = GameItem(_name, _attackPower);
        gameItems[itemId] = gameItem;
        itemId++;
    }

    function tradeItem(uint256 _itemId, address _to) public canOperate(_itemId) {
        _safeTransferFrom(msg.sender, _to, _itemId, "");
    }
}