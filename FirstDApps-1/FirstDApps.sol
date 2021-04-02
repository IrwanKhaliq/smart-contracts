// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.0;

contract FirstDApps {
    struct Wallet {
        uint counter;
        uint deposit;
    }
    mapping(address => Wallet) internal person;

    modifier isNeedMoreEther() {
        require(msg.value >= 0.1 ether, "You have to brought more money for deposit");
        _;
    }
    modifier isNeedMoreCounter() {
        require(person[msg.sender].counter >= 10, "You have to deposit more");
        _;
    }
    modifier isWeiMoneyCorrect(uint _weiMoney) {
        require(person[msg.sender].deposit >= _weiMoney, "Withdraw failed");
        _;
    }
    function myDeposit() public view returns(uint) {
        return person[msg.sender].deposit;
    }
    function myCounter() public view returns(uint) {
        return person[msg.sender].counter;
    }
    function deposit() public payable isNeedMoreEther {
        person[msg.sender].deposit += msg.value;
        person[msg.sender].counter++;
    }
    function withdraw(uint _weiMoney) public isNeedMoreCounter isWeiMoneyCorrect(_weiMoney) {
        //  need help for convert your money? https://eth-converter.com/extended-converter.html
        person[msg.sender].counter -= 10;
        person[msg.sender].deposit -= _weiMoney;
        payable(msg.sender).transfer(_weiMoney);
    }
}