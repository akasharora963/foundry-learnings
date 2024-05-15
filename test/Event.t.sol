// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "forge-std/Test.sol";
import {Event} from "../src/Event.sol";

contract EventTest is Test {
    Event public eve;

    event Transfer(address indexed from, address indexed to, uint256 amount);

    function setUp() public {
        eve = new Event();
    }

    function testEmitTransferEvent() external {
        vm.expectEmit(true, true, false, true);

        emit Transfer(address(this), address(1), 123);

        eve.transfer(address(this), address(1), 123);
    }

    function testEmitTransferManyEvent() external {
        address[] memory to = new address[](2);

        to[0] = address(123);
        to[1] = address(999);

        uint256[] memory amounts = new uint256[](2);

        amounts[0] = 89;
        amounts[1] = 56;

        for (uint256 i; i < to.length; i++) {
            vm.expectEmit(true, true, false, true);
            emit Transfer(address(this), to[i], amounts[i]);
        }

        eve.transferMany(address(this), to, amounts);
    }
}
