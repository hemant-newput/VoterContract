//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract Variables {
    string public stringValue;
    bool public myBool = true;
    int256 public myInt = -1;
    uint256 public myUnsignedInt = 2 ether;
    uint8 public myUint8 = 8;
    uint256 public myUint256 = 2000;
    enum State {
        Waiting,
        Ready,
        Active
    }
    State public state;

    constructor() {
        //no need to specify public to a constructor
        stringValue = "Hemant";
    }

    Person[] public people;
    uint256 public peopleCount;
    struct Person {
        string _firstName;
        string _lastName;
        uint256 age;
    }

    function addPerson(
        string memory _firstName,
        string memory _lastName,
        uint256 _age
    ) public {
        people.push(Person(_firstName, _lastName, _age));
        peopleCount += 1;
    }

    function getPerson() public {}

    function getValue() public view returns (string memory) {
        //always need to specify memory keyword
        return stringValue;
    }

    function setValue(string memory _value) public {
        stringValue = _value;
    }

    function activate() public {
        state = State.Active;
    }

    function isActive() public view returns (bool) {
        return state == State.Active;
    }
}
