//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Fallback {
    event Log(string func, address sender, uint256 value, bytes data);

    fallback() external payable {
        emit Log("fallback", msg.sender, msg.value, msg.data);
    }

    receive() external payable {
        emit Log("receive", msg.sender, msg.value, ""); // when msg.data is null
    }
}

/* 
3 ways to send ETH
transfer 2300 gas reverts
send 2300 gas returns bool
call all gas returns bool and data
*/

contract SendEther {
    constructor() payable {}

    receive() external payable {}

    function sendViaTransfer(address payable _to) external payable {
        _to.transfer(132);
    }

    function sendViaSend(address payable _to) external payable {
        bool send = _to.send(123);
        require(send, "send Failed");
    }

    function sendViCall(address payable _to) external payable {
        (bool success, bytes memory data) = _to.call{value: 123}("");
        require(success, "Call Failed");
    }
}

contract ETCReceiver {
    uint256 public balance;
    event Log(uint256 amount, uint256 gas);

    receive() external payable {
        emit Log(msg.value, gasleft());
    }

    function getBalance() external returns (uint256) {
        balance = address(this).balance;
        return balance;
    }
}
