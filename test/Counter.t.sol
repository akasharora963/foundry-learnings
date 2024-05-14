// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console, stdError} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();
    }

    function test_Increment() public {
        counter.inc();
        counter.inc();
        uint256 test = counter.get();
        console.log("Counter is :", test);
        assertEq(counter.count(), 2);
    }

    function test_Decrement() public {
        assertEq(counter.count(), 0);
        counter.inc();
        assertEq(counter.count(), 1);
        counter.dec();
        assertEq(counter.count(), 0);
    }

    function testFailDec() public {
        counter.dec();
    }

    function testDecUnderFlow() public {
        vm.expectRevert(stdError.arithmeticError);
        counter.dec();
    }
}
