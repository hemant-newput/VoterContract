//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract S {
    event Log(string message);

    function foo() public virtual {
        emit Log("S.Foo");
    }

    function bar() public virtual {
        emit Log("S.bar");
    }
}

contract F is S {
    function foo() public virtual override {
        emit Log("F.Foo");
        S.foo();
    }

    function bar() public virtual override {
        emit Log("F.bar");
        super.bar();
    }
}

contract G is S {
    function foo() public virtual override {
        emit Log("G.Foo");
        S.foo();
    }

    function bar() public virtual override {
        emit Log("G.bar");
        super.bar();
    }
}

contract H is F, G {
    function foo() public virtual override(F, G) {
        emit Log("H.Foo");
        F.foo(); //this will only call F.foo
    }

    function bar() public virtual override(F, G) {
        emit Log("H.bar");
        super.bar(); //this will call all the parents
    }
}
//The order of execution of parent constructor is the same order in which they are inherited
