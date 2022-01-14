// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract MyContract {
  string public message;
  address public owner;
  function hello() public pure returns(string memory){
    return "Hello World";
  }
  constructor(string memory _message) {
    message = _message;
    owner = msg.sender;
  }
  function setMessage(string memory _message) public payable {
    require(msg.value > 1 ether);
    message = _message;
  }
  function getMessage() public view returns(string memory) {
    require(msg.sender == owner);
    return message;
  }
}
