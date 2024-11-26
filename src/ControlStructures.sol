// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

// Custom error for AfterHours
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
        // Panic if time is out of range
        if (_time >= 2400) {
            revert("Time out of bounds"); // Triggers an error for invalid time
        }

        // Revert with custom error if time is after hours
        if (_time > 2200 || _time < 800) {
            revert AfterHours(_time);
        }

        // Revert during lunch
        if (_time >= 1200 && _time <= 1259) {
            revert("At lunch!");
        }

        // Return time-specific greetings
        if (_time >= 800 && _time <= 1199) {
            return "Morning!";
        } else if (_time >= 1300 && _time <= 1799) {
            return "Afternoon!";
        } else if (_time >= 1800 && _time <= 2200) {
            return "Evening!";
        }

        // Fallback for unexpected time ranges
        return "Invalid time range";
    }
}
