// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract WalletApp {
    address public owner;
    uint256 public balance;

    constructor() {
        owner = msg.sender;
    }

    receive() payable external {
        balance += msg.value;
    }

    modifier ownerOnly() {
        require (msg.sender == owner, 'Only owner can withdraw');
        _;
    }

    event Success (address owner, string message);

    function withdraw(uint amount, address payable destAddr) public ownerOnly {
        require (amount <= balance, 'Insufficient funds');
        destAddr.transfer(amount);
        balance -= amount;
        emit Success(msg.sender, 'Congrats, your transaction has been processed!');        
    }
}

