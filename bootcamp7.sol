//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract S {
    string public name;

    constructor(string memory _name) {
        name = _name;
    }
}

contract T {
    string public text;

    constructor(string memory _text) {
        text = _text;
    }
}

contract U is S("s"), T("T") {
    //static input
}

contract V is S, T {
    constructor(string memory _name, string memory _text) S(_name) T(_text) {
        //dynamc input
    }
}

contract X is S("s"), T {
    constructor(string memory _text) T(_text) {}
}

//The order of execution of parent constructor is the same order in which they are inherited
