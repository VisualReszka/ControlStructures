// SPDX-License-Identifier: MIT
pragma solidity ^0.8.23;

import "forge-std/Script.sol";
import "../src/ControlStructures.sol";

contract DeployControlStructures is Script {
    function run() external {
        vm.startBroadcast();
        ControlStructures controlStructures = new ControlStructures();
        console.log("ControlStructures deployed at:", address(controlStructures));
        vm.stopBroadcast();
    }
}
