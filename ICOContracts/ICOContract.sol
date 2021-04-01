// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.0;

contract ICOContract {
    struct Buyers {
        uint token;
    }
    
    address private owner;
    uint public initialPrice;
    uint public totalSupply;
    uint public minimumPurchase;
    uint public periodOfOffer;
    mapping(address => Buyers) internal buyers;
    
    constructor() {
        owner = msg.sender;
    }
    
    modifier isMinimumPurchase() {
        require(msg.value >= minimumPurchase, "need more money");
        _;
    }
    
    modifier isPeriodOfOffer() {
        require(periodOfOffer >= block.timestamp, "time is up!");
        _;
    }
    
    modifier isOwner() {
        require(msg.sender == owner, "you are not the owner");
        _;
    }
    
    function myToken () public view returns(uint) {
        return buyers[msg.sender].token;
    }
    
    function purchase () public payable isMinimumPurchase isPeriodOfOffer {
        uint coins = msg.value / minimumPurchase;
        buyers[msg.sender].token += coins;
    }
    
    // setter
    function setInitialPrice (uint _weiMoney) public payable isOwner {
        initialPrice = _weiMoney * 1 wei;
    }
    
    function setTotalSupply (uint _ether) public isOwner {
        totalSupply = _ether * 1 ether;
    }
    
    function setMinimumPurchase (uint _weiMoney) public isOwner {
        minimumPurchase = _weiMoney * 1 wei;
    }
    
    function setPeriodOfOffer (uint _time) public isOwner {
        // https://www.epochconverter.com/ or below
        periodOfOffer = block.timestamp +  _time * 60 seconds;
    }
    
    // selfdestruct
    function closeContract() public isOwner {
        selfdestruct(payable(owner));
    }
}