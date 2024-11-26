// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/ControlStructures.sol";

contract ControlStructuresTest is Test {
    ControlStructures controlStructures;

    function setUp() public {
        controlStructures = new ControlStructures();
    }

    // Test FizzBuzz function
    function testFizzBuzz() public {
        assertEq(controlStructures.fizzBuzz(3), "Fizz");
        assertEq(controlStructures.fizzBuzz(5), "Buzz");
        assertEq(controlStructures.fizzBuzz(15), "FizzBuzz");
        assertEq(controlStructures.fizzBuzz(7), "Splat");
    }

    // Test DoNotDisturb function for time >= 2400 (Panic)
    function testDoNotDisturbOutOfBounds() public {
        vm.expectRevert(); // Expect Panic (0x1)
        controlStructures.doNotDisturb(2400);
    }

    // Test DoNotDisturb function for AfterHours error
    function testDoNotDisturbAfterHours() public {
        vm.expectRevert(abi.encodeWithSelector(AfterHours.selector, 2300));
        controlStructures.doNotDisturb(2300);

        vm.expectRevert(abi.encodeWithSelector(AfterHours.selector, 700));
        controlStructures.doNotDisturb(700);
    }

    // Test DoNotDisturb function for "At lunch!"
    function testDoNotDisturbLunchTime() public {
        vm.expectRevert(bytes("At lunch!"));
        controlStructures.doNotDisturb(1215);
    }

    // Test DoNotDisturb function for valid time ranges
    function testDoNotDisturbMorning() public {
        assertEq(controlStructures.doNotDisturb(900), "Morning!");
    }

    function testDoNotDisturbAfternoon() public {
        assertEq(controlStructures.doNotDisturb(1500), "Afternoon!");
    }

    function testDoNotDisturbEvening() public {
        assertEq(controlStructures.doNotDisturb(1900), "Evening!");
    }

    // Test DoNotDisturb function for unexpected fallback (if applicable)
    function testDoNotDisturbUnexpectedTime() public {
        assertEq(controlStructures.doNotDisturb(0), "Invalid time range");
    }
}
