// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.0;

contract FirstDApps {
    struct Wallet {
        address id;
        string name;
        uint counter;
        uint deposit;
    }
    mapping(address => Wallet) internal person;
    
    modifier isRegistered() {
        require(person[msg.sender].id == address(0x00), "This account already registered");
        _;
    }
    
    modifier shouldRegistered() {
        require(person[msg.sender].id != address(0x00), "This account haven't register yet");
        _;
    }
    
    modifier isNeedMoreEther() {
        require(msg.value >= 0.1 ether, "You have to brought more money for deposit");
        _;
    }
    
    modifier isNeedMoreCounter() {
        require(person[msg.sender].counter >= 10, "You're transaction history is under 10");
        _;
    }
    
    modifier isWeiMoneyCorrect(uint _weiMoney) {
        require(person[msg.sender].deposit >= _weiMoney, "Nay!, withdraw failed");
        _;
    }
    
    function register(string memory _name) public isRegistered isNeedMoreEther payable {
        Wallet storage newUser = person[msg.sender];
        newUser.id = msg.sender;
        newUser.name = _name;
        newUser.counter = 1;
        newUser.deposit = msg.value;
        
    }
    function myDeposit() public view shouldRegistered returns(uint) {
        return person[msg.sender].deposit;
    }
    function myCounter() public view shouldRegistered returns(uint) {
        return person[msg.sender].counter;
    }
    function deposit() public payable shouldRegistered isNeedMoreEther {
        person[msg.sender].deposit += msg.value;
        person[msg.sender].counter++;
    }
    function withdraw(uint _weiMoney) public shouldRegistered isNeedMoreCounter isWeiMoneyCorrect(_weiMoney) {
        //  need help for convert your money? https://eth-converter.com/extended-converter.html
        person[msg.sender].counter -= 10;
        person[msg.sender].deposit -= _weiMoney;
    }
}
// &copy; Irwan Syafani