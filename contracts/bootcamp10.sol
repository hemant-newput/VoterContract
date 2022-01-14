//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract CallTestContract {
    function setX(TestContract _test, uint256 _x) external {
        _test.setX(_x);
    }

    function getX(address _test) external view returns (uint256) {
        uint256 x = TestContract(_test).getX();
        return x;
    }

    function setXandReceiveEther(address _test, uint256 _x) external payable {
        TestContract(_test).setXandReceiveEther{value: msg.value}(_x);
    }

    function getXandValue(address _test)
        external
        view
        returns (uint256, uint256)
    {
        (uint256 x, uint256 value) = TestContract(_test).getXandValue();
        return (x, value);
    }
}

contract TestContract {
    uint256 public x;
    uint256 public value = 132;

    function setX(uint256 _x) external {
        x = _x;
    }

    function getX() external view returns (uint256) {
        return x;
    }

    function setXandReceiveEther(uint256 _x) external payable {
        x = _x;
        value = msg.value;
    }

    function getXandValue() external view returns (uint256, uint256) {
        return (x, value);
    }
}
