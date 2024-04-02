//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Banking{
    mapping(address => uint) public balances;
    address payable owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function deposit() public payable{
  require(msg.value > 0 , " Deposit amount should be more than 0");
 balances[msg.sender] += msg.value;
    }
 
    function withdraw(uint amount) public{
   require(msg.sender == owner , " Only owner can withdraw funds");
   require(amount <= balances[msg.sender], "Insufficient funds!");
   require(amount > 0, "Withdrawal amount must be more than 0");
   payable(msg.sender).transfer(amount);
   balances[msg.sender] -= amount;
    }

    function transfer(address payable recipient, uint amount) public{
    require(amount<= balances[msg.sender],"Insufficient funds");
    require(amount > 0, "Transfer amount much be more than 0");
    balances[msg.sender] -= amount;
    balances[recipient] += amount;
    }

    function getBalance(address payable user) public view returns (uint){
    return balances[user];
    }

    function grantAccess(address payable user) public  {
        require(msg.sender == owner, "Only owner can revoke access");
        require(user != owner, "Cannot revoke access for the current owner");
        owner =payable(msg.sender);
    }

    function destroy() public {
    require(msg.sender == owner, "Only owner can destroy the contract");
    owner.transfer(address(this).balance);
    }

    }
