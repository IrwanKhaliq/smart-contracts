// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.0;

contract Calculator {
  // 4 functions include add, sub, mul, div
  function sum(int _num1, int _num2) public pure returns(int) {
    return _num1 + _num2;
  }

  function sub(int _num1, int _num2) public pure returns(int) {
    return _num1 - _num2;
  }
  
  function mul(int _num1, int _num2) public pure returns(int) {
    return _num1 * _num2;
  }
  
  function div(int _num1, int _num2) public pure returns(int) {
    return _num1 / _num2;
  }
}