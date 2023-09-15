// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >= 0.8.7 <= 0.9;
//pragma solidity >=0.4.22 <0.9.0; 

contract Money {
    uint balance = 0;


    modifier validateDeposit(uint amount) {
        require(amount > 0, "Invalid amount.");
        _;
    }

    modifier validateWithdrawal(uint amount) {
        require(amount > 0, "Invalid amount.");
        require(amount <= balance, "Insufficient balance.");
        _;
    }

    event depositCompplete(uint amount);
    event withdrawalComplete(uint amount);

    function Deposit(uint amount) external validateDeposit(amount) {
        balance += amount;
        emit depositCompplete(amount);
    }

    function Withdraw(uint amount) external validateWithdrawal(amount) {
        balance -= amount;
        emit withdrawalComplete(amount);
    }

    function Balance() view external returns (uint) {
        return balance;
    }
}