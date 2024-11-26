// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Test.sol";
import "../src/ControlStructures.sol";

contract ControlStructuresTest is Test {
    ControlStructures controlStructures;

    function setUp() public {
        controlStructures = new ControlStructures();
    }

    // Test for compareNumbers
    function testCompareNumbers() public view {
        // Case 1: First number is greater
        assertEq(controlStructures.compareNumbers(10, 5), "Number one is greater than number two");

        // Case 2: Second number is greater
        assertEq(controlStructures.compareNumbers(5, 10), "Number one is less than number two");

        // Case 3: Numbers are equal
        assertEq(controlStructures.compareNumbers(10, 10), "Number one equals number two");
    }

    function testCompareNumbersInvalidData() public {
        // Case 4: Invalid data (numberOne or numberTwo <= 0)
        vm.expectRevert(abi.encodeWithSelector(ControlStructures.InvalidData.selector));
        controlStructures.compareNumbers(0, 10);

        vm.expectRevert(abi.encodeWithSelector(ControlStructures.InvalidData.selector));
        controlStructures.compareNumbers(10, 0);
    }

    // Test for FizzBuzz
    function testFizzBuzz() public view {
        // Divisible by 3 and 5
        assertEq(controlStructures.fizzBuzz(15), "FizzBuzz");

        // Divisible by 3 only
        assertEq(controlStructures.fizzBuzz(9), "Fizz");

        // Divisible by 5 only
        assertEq(controlStructures.fizzBuzz(10), "Buzz");

        // Not divisible by 3 or 5
        assertEq(controlStructures.fizzBuzz(7), "Splat");
    }

    // Test for DoNotDisturb
    function testDoNotDisturbMorning() public view {
        // Case: Morning
        assertEq(controlStructures.doNotDisturb(900), "Morning!");
    }

    function testDoNotDisturbAfternoon() public view {
        // Case: Afternoon
        assertEq(controlStructures.doNotDisturb(1500), "Afternoon!");
    }

    function testDoNotDisturbEvening() public view {
        // Case: Evening
        assertEq(controlStructures.doNotDisturb(1900), "Evening!");
    }

    function testDoNotDisturbAtLunch() public {
        // Case: At lunch (should revert)
        vm.expectRevert(bytes("At lunch!"));
        controlStructures.doNotDisturb(1215);
    }

    function testDoNotDisturbAfterHours() public {
        // Case: AfterHours (custom error)
        vm.expectRevert(abi.encodeWithSelector(ControlStructures.AfterHours.selector, 700));
        controlStructures.doNotDisturb(700);

        vm.expectRevert(abi.encodeWithSelector(ControlStructures.AfterHours.selector, 2300));
        controlStructures.doNotDisturb(2300);
    }

    function testDoNotDisturbOutOfBounds() public {
        // Case: Out-of-bounds time (should panic)
        vm.expectRevert(); // Expect panic (assert false)
        controlStructures.doNotDisturb(2500);
    }

    // Test for Loop (ensure it executes correctly without errors)
    function testLoop() public view {
        controlStructures.loop(); // The function doesn't return anything or modify state, so no assertions needed
    }
}
