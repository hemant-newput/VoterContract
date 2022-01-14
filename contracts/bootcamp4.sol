//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;
import "../Libraries/safeMath.sol";

contract Libraries {
    using SafeMath for uint256;
    uint256 public value;

    function calculate(uint256 _value1, uint256 _value2) public {
        value = _value1.div(_value2);
    }
}
