//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract HotelRoom {
    enum Statuses {
        Vacant,
        Occupied
    }
    Statuses currentStatus;
    event Occupy(address _occupant, uint256 _value);
    address payable public owner;
    uint256 public balance;

    constructor() {
        owner = payable(msg.sender);
        balance = msg.sender.balance;
        currentStatus = Statuses.Vacant;
    }

    modifier onlyVacant() {
        require(currentStatus == Statuses.Vacant, "Currently occupied");
        _;
    }

    modifier costs(uint256 _amount) {
        _amount = 2 ether;
        require(msg.value >= _amount, "Not Enough Ether provided");
        _;
    }

    receive() external payable onlyVacant costs(2 ether) {
        currentStatus = Statuses.Occupied;
        owner.transfer(msg.value);
        emit Occupy(msg.sender, msg.value);
    }

    function revertState() public {
        currentStatus = Statuses.Vacant;
    }
}
