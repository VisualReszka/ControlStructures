// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/ControlStructures.sol";

contract ControlStructuresTest is Test {
    ControlStructures controlStructures;

    // Runs before each test
    function setUp() public {
        controlStructures = new ControlStructures();
    }

    function testFizzBuzz() public view {
        string memory result = controlStructures.fizzBuzz(15);
        assertEq(result, "FizzBuzz", "Expected FizzBuzz");

        result = controlStructures.fizzBuzz(3);
        assertEq(result, "Fizz", "Expected Fizz");

        result = controlStructures.fizzBuzz(5);
        assertEq(result, "Buzz", "Expected Buzz");

        result = controlStructures.fizzBuzz(7);
        assertEq(result, "Splat", "Expected Splat");
    }

    // Test DoNotDisturb function
    function testDoNotDisturb() public {
        // Expect revert for time out of bounds
        vm.expectRevert(bytes("Time out of bounds"));
        controlStructures.doNotDisturb(2400);

        // Expect custom error AfterHours
        vm.expectRevert(abi.encodeWithSelector(AfterHours.selector, 2300));
        controlStructures.doNotDisturb(2300);

        // Expect revert for "At lunch!"
        vm.expectRevert(bytes("At lunch!"));
        controlStructures.doNotDisturb(1230);

        // Test valid times
        string memory result = controlStructures.doNotDisturb(900);
        assertEq(result, "Morning!", "Expected Morning!");

        result = controlStructures.doNotDisturb(1400);
        assertEq(result, "Afternoon!", "Expected Afternoon!");

        result = controlStructures.doNotDisturb(1900);
        assertEq(result, "Evening!", "Expected Evening!");
    }
}
