//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract InternalFunctions {
    mapping(uint256 => Person) public people;
    uint256 public peopleCount = 0;
    uint256 openingTime = block.timestamp + 50;
    address owner;
    struct Person {
        string _firstName;
        string _lastName;
        uint256 age;
    }

    constructor() {
        owner = msg.sender;
    }

    modifier isAdmin() {
        require(msg.sender == owner, "Only admin can Add");
        _;
    }
    modifier onlyWhileOpen() {
        require(block.timestamp >= openingTime, "wait for some time");
        _;
    }

    function addPerson(
        string memory _firstName,
        string memory _lastName,
        uint256 _age
    ) public isAdmin onlyWhileOpen {
        people[peopleCount] = Person(_firstName, _lastName, _age);
        incrementCount();
    }

    function incrementCount() internal {
        peopleCount += 1;
    }
}
