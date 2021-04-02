// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.0;

contract ICOContract {
    address private owner;
    uint public initialPrice;
    uint public totalSupply;
    uint public minimumPurchase;
    uint public periodOfOffer;
    mapping(address => uint) internal buyers;
    
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
    
    modifier isContactExist() {
        require(owner != address(0x00));
        require(initialPrice != 0);
        require(totalSupply != 0);
        require(minimumPurchase != 0);
        require(periodOfOffer != 0);
        _;
    }
    
    function myToken () public view returns(uint) {
        return buyers[msg.sender];
    }
    
    function purchase () public payable isMinimumPurchase isPeriodOfOffer isContactExist {
        // how to handle decimal in solidity??
        uint coins = msg.value / minimumPurchase;
        buyers[msg.sender] += coins;
        // uint remain = msg.value % minimumPurchase;
        // payable(msg.sender).transfer(remain);
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
    
    function setPeriodOfOffer (uint _minutes) public isOwner {
        // https://www.epochconverter.com/ or below
        periodOfOffer = block.timestamp +  _minutes * 60 seconds;
    }
    
    // selfdestruct
    function closeContract() public isOwner {
        selfdestruct(payable(owner));
    }
}