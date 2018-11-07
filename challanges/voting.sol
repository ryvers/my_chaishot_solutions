pragma solidity ^0.4.19;

contract Voting {
    address private owner;
    uint totalVotes;
    struct voteObj {
        uint voteId;
        bool supports;
    }
    mapping (address => bool) voters;
    mapping (address => voteObj) votings;
    
    function Voting() public{
        owner = msg.sender;
        totalVotes=0;
    }

    modifier onlyOwner {
        require(msg.sender == owner);
        _;
    }

    function register(address addr) onlyOwner public {
        voters[addr] = true;
    }

    function vote(bool supports) public {
        require(voters[msg.sender]==true);
        votings[msg.sender].supports = supports;
        votings[msg.sender].voteId = 1;
        totalVotes+=1;
    }

    function numberVotes() public view returns(uint) {
        return totalVotes;
    }

    function myVote() public view returns(int) {
        require(voters[msg.sender] == true);
        if(votings[msg.sender].voteId == 0){
            return -1;
        }
        if(votings[msg.sender].supports == true){
            return 1;
        }
        return 0;
    }
}
