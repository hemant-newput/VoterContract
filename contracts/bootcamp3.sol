//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract ERC20Token {
    string public name;
    address public myAddress;
    mapping(address => uint256) public balances;

    function mint() public {
        balances[tx.origin] += 1;
    }

    constructor() {
        myAddress = address(this);
    }
}

contract demoERC20 {
    mapping(address => uint256) public balances;
    address payable wallet;
    address public token;
    event Purchase(address indexed _buyer, uint256 _amount);

    constructor(address payable _wallet, address _token) {
        wallet = _wallet;
        token = _token;
    }

    fallback() external payable {
        buyToken();
    }

    receive() external payable {
        buyToken();
    }

    function buyToken() public payable {
        ERC20Token _token = ERC20Token(address(token));
        _token.mint();
        wallet.transfer(msg.value);
        emit Purchase(msg.sender, msg.value);
    }
}
