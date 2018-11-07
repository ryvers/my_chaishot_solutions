pragma solidity ^0.4.18;

contract Investment {
    address public owner;
    uint256 public exchangeRate = 5;
    uint public tokens = 1000000;
    mapping (address => bool) public validInvestors;
    mapping (address => uint256) public investorTokens;
    mapping (address => uint256) private balances;
    int unlockTime;
    uint startTime;
    bool unlockDistribution;

    function Investment(int _unlockTime) public {
        owner = msg.sender;
        unlockTime = _unlockTime;
        startTime = block.timestamp;
        unlockDistribution = false;
    }

    /* 
    @dev The purpose of this function is for
        investors to put Ether into the contract
        in exchange for some tokens when a distribution occurs.
    */
    function invest() public payable {
        require(msg.value * exchangeRate < tokens);
        validInvestors[msg.sender] = true;
        investorTokens[msg.sender] = msg.value * exchangeRate;
    }

    function transferToken(address _investor, uint _investorToken) public {
        balances[_investor] = _investorToken;
        tokens -= _investorToken;
    }

    modifier onlyAllowed{
        bool allowEntrance = false;
        if(msg.sender == owner){
            allowEntrance = true;
        }else {
            uint256 _unlockTime = uint256(unlockTime);
            if(block.timestamp - startTime >= _unlockTime * 1 days){
                allowEntrance = true;
            } else {
                allowEntrance = false;
            }
        }

        if(allowEntrance==false){
            revert();
        }
        _;
    }


    function approveWithdraw() public onlyAllowed{
        unlockDistribution = true;
    }

    function withdraw() public {
        require(unlockDistribution == true);
        require(validInvestors[msg.sender] == true);
        transferToken(msg.sender, investorTokens[msg.sender]);
    }
}
