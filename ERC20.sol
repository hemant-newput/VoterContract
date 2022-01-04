//SPDX-License-Identifier: Unlicensed
pragma solidity ^0.8.0;

abstract contract ERC20Token {
    function name() public view virtual returns (string memory);
    function symbol() public view virtual returns (string memory);
    function decimals() public view virtual returns (uint8);
    function totalSupply() public view virtual returns (uint256);
    function balanceOf(address _owner) public view virtual returns (uint256 balance);
    function transfer(address _to, uint256 _value) public virtual returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) public virtual returns (bool success);
    function approve(address _spender, uint256 _value) public virtual returns (bool success);
    function allowance(address _owner, address _spender) public view virtual returns (uint256 remaining);

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}

contract Owner {
    address public owner;
    address public newOwner;

    event OwnershipTransferred(address indexed _from, address indexed _to);
    constructor() {
        owner = msg.sender;
    }

    modifier isOwner() {
        require(msg.sender == owner);
        _;
    }

    function transferOwnership(address _to) public isOwner {
        newOwner = _to;
    }

    function acceptOwnership() public {
        require(msg.sender == newOwner);
        owner = newOwner;
        newOwner = address(0); //garbage address
    }
}

contract Token is ERC20Token, Owner {
    string public _symbol;
    string public _name;
    uint8 public _decimal;
    uint public _totalSupply;
    address public _minter;
    mapping(address => uint) balances;

    constructor() {
        _symbol = "HS";
        _name = "Hemant";
        _decimal = 0;
        _totalSupply = 1000;
        _minter = 0xf0DebA4d74b8A5863CbB14Ed16ae1b8A32F4179f;

        balances[_minter] = _totalSupply;
        emit Transfer(address(0),_minter,_totalSupply);
    }
    function name() public view override returns (string memory) {
        return _name;
    }
    function symbol() public view override returns (string memory) {
        return _symbol;
    }
    function decimals() public view override returns (uint8) {
        return _decimal;
    }
    function totalSupply() public view override returns (uint256) {
        return _totalSupply;
    }
    function balanceOf(address _owner) public view override returns (uint256 balance) {
        return balances[_owner];
    }
    function transferFrom(address _from, address _to, uint256 _value) public override returns (bool success){
        require(balances[_from] >= _value);
        balances[_from] -= _value;
        balances[_to] += _value;
        emit Transfer(_from,_to,_value);
        return true;
    }
    function transfer(address _to, uint256 _value) public override returns (bool success){
        require(balances[_minter] >= _value);
        balances[_minter] -= _value;
        balances[_to] += _value;
        emit Transfer(_minter,_to,_value);
        return true;
    }
    function approve(address _spender, uint256 _value) public override returns (bool success){
        return true;
    }
    function allowance(address _owner, address _spender) public view override returns (uint256 remaining){
        return 0;
    }
    function mint(uint _amount) public returns(bool) {
        require(msg.sender == _minter, "Only minter can confiscate");
        balances[_minter]+= _amount;
        _totalSupply+= _amount;
        return true;
    }
    function confiscate(address _target, uint _amount) public returns(bool) {
        require(msg.sender == _minter, "Only minter can confiscate");
        if(balances[_target] >= _amount) {
            balances[_target] -= _amount;
            _totalSupply -= _amount;
        } else {
            _totalSupply -= balances[_target];
            balances[_target] = 0;
        }
        return true;
    }
}