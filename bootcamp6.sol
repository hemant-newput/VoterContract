//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract GlobalVariables {
    function globalVars()
        external
        view
        returns (
            address,
            uint256,
            uint256
        )
    {
        address sender = msg.sender;
        uint256 timestamp = block.timestamp;
        uint256 blockNum = block.number;
        return (sender, timestamp, blockNum);
    }
}

contract ViewAndPureFunction {
    uint256 public num = 2000;

    function viewFunction() external view returns (uint256) {
        return num;
    }

    function pureFunction() external pure returns (uint256) {
        return 1; //does not modify any data in blockchain also does not read anything from blockchain or state variables
    }
}

contract DefaultValues {
    bool public b; // false
    uint256 public u; // 0
    int256 public i; // 0
    address public a; // 0x0000000000000000000000000000000000000000
    bytes32 public b32; // 0x0000000000000000000000000000000000000000000000000000000000000000
}

contract Constants {
    address public constant MY_ADDRESS =
        0x617F2E2fD72FD9D5503197092aC168c91465E7f2; //21442 gas
    uint256 public constant MY_UINT = 2000; //21371 gas
}

contract Var {
    address public MY_ADDRESS = 0x617F2E2fD72FD9D5503197092aC168c91465E7f2; // 23575 gas
    uint256 public MY_UINT = 2000; //23471 gas
}

contract IFElse {
    function example(uint256 _x) external pure returns (uint256) {
        if (_x < 10) {
            return 1;
        } else {
            return 2;
        }
    }

    function ternanry(uint256 _x) external pure returns (uint256) {
        return (_x < 10) ? 1 : 2;
    }
}

contract ForAndWhileLoops {
    function loops() external pure {
        for (uint256 i = 0; i < 10; i++) {
            if (i == 3) {
                continue;
            }
            if (i == 5) {
                break;
            }
        }
        uint256 j = 0;
        while (true) {
            j++;
        }
    }

    function sum(uint256 _x) external pure returns (uint256) {
        uint256 result;
        for (uint256 s = 0; s <= _x; s++) {
            result += s;
        }
        return result;
    }
}

contract Event {
    event log(address sender, uint256 value);
    event IndexedLog(address indexed sender, uint256 val);

    function example() external {
        emit log(msg.sender, 1234); //22913
    }

    function exampleIndexed() external {
        emit IndexedLog(msg.sender, 1234); //22911
    }
}
