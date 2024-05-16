// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console, stdError} from "forge-std/Test.sol";
import {Auction} from "../src/Time.sol";

contract TimeTest is Test {
    Auction public auction;
    uint256 private startTime;

    function setUp() public {
        auction = new Auction();
        startTime = block.timestamp;
    }

    function testBidFailsBeforeStart() public {
        vm.expectRevert(bytes("cannot bid"));
        auction.bid();
    }

    function testBid() public {
        vm.warp(startTime + 1 days);
        auction.bid();
    }

    function testBidFailsAferEnd() public {
        vm.expectRevert(bytes("cannot bid"));
        vm.warp(startTime + 2 days);
        auction.bid();
    }

    function testTimestamp() public {
        uint256 t = block.timestamp;
        // set block.timestamp to t + 100
        skip(100);
        assertEq(block.timestamp, t + 100);

        // set block.timestamp to t + 100 - 100;
        rewind(100);
        assertEq(block.timestamp, t);
    }

    function testBlockNumber() public {
        uint256 b = block.number;
        // set block number to 11
        vm.roll(11);
        assertEq(block.number, 11);
    }

    function testBidEndFails() public {
        vm.expectRevert(bytes("cannot end"));
        vm.warp(startTime + 1.5 days);
        auction.end();
    }

    function testBidEnd() public {
        vm.warp(startTime + 2 days);
        auction.end();
    }
}
