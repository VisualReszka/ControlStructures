// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import {Test, console} from "forge-std/Test.sol";
import "../src/ControlStructures.sol";

contract ControlStructuresTest is Test {
    ControlStructures controlStructures;

    function setUp() public {
        controlStructures = new ControlStructures();
    }

    function testFizzBuzz() public {
        assertEq(controlStructures.fizzBuzz(3), "Fizz");
        assertEq(controlStructures.fizzBuzz(5), "Buzz");
        assertEq(controlStructures.fizzBuzz(15), "FizzBuzz");
        assertEq(controlStructures.fizzBuzz(7), "Splat");
    }

    function testDoNotDisturb() public {
        // Expect reverts
        vm.expectRevert(bytes("Time out of bounds"));
        controlStructures.doNotDisturb(2400);

        vm.expectRevert(abi.encodeWithSelector(AfterHours.selector, 2300));
        controlStructures.doNotDisturb(2300);

        vm.expectRevert(bytes("At lunch!"));
        controlStructures.doNotDisturb(1215);

        // Valid cases
        assertEq(controlStructures.doNotDisturb(900), "Morning!");
        assertEq(controlStructures.doNotDisturb(1500), "Afternoon!");
        assertEq(controlStructures.doNotDisturb(1900), "Evening!");
    }
}
