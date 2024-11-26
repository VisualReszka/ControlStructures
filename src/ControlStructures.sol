// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// Define custom error for AfterHours
error AfterHours(uint256 time);

contract ControlStructures {
    // FizzBuzz function
    function fizzBuzz(uint256 _number) public pure returns (string memory) {
        if (_number % 3 == 0 && _number % 5 == 0) {
            return "FizzBuzz";
        } else if (_number % 3 == 0) {
            return "Fizz";
        } else if (_number % 5 == 0) {
            return "Buzz";
        } else {
            return "Splat";
        }
    }

    // DoNotDisturb function
    function doNotDisturb(uint256 _time) public pure returns (string memory) {
        // Trigger a Panic (0x1) if time is out of bounds
        if (_time >= 2400) {
            assert(false); // Panic: Time out of bounds
        }

        // Revert with custom error for after hours
        if (_time > 2200 || _time < 800) {
            revert AfterHours(_time);
        }

        // Revert with specific string for lunch time
        if (_time >= 1200 && _time <= 1259) {
            revert("At lunch!");
        }

        // Return greetings for valid times
        if (_time >= 800 && _time <= 1199) {
            return "Morning!";
        } else if (_time >= 1300 && _time <= 1799) {
            return "Afternoon!";
        } else if (_time >= 1800 && _time <= 2200) {
            return "Evening!";
        }

        // Fallback for unexpected cases (shouldn't be reached)
        return "Invalid time range";
    }
}
