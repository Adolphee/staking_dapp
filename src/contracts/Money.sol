// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity >= 0.8.7 <= 0.9;
//pragma solidity >=0.4.22 <0.9.0; 

contract Money {
    uint256 balance = 0;


    modifier validateDeposit(uint256 amount) {
        require(amount > 0, "Invalid amount.");
        _;
    }

    modifier validateWithdrawal(uint256 amount) {
        require(amount > 0, "Invalid amount.");
        require(amount <= balance, "Insufficient balance.");
        _;
    }

    event depositCompplete(uint256 amount);
    event withdrawalComplete(uint256 amount);

    function Deposit(uint256 amount) external validateDeposit(amount) {
        balance += amount;
        emit depositCompplete(amount);
    }

    function Withdraw(uint256 amount) external validateWithdrawal(amount) {
        balance -= amount;
        emit withdrawalComplete(amount);
    }

    function Balance() view external returns (uint) {
        return balance;
    }
}