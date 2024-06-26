// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {CatV1} from "src/CatV1.sol";
import {ERC1967Proxy} from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

/**
 * @title Deploy
 * @author note-xin
 * @notice this is the deploy script for the contract
 */
contract Deploy is Script {
    function run() external returns (address) {
        address proxy = deploy();

        return proxy;
    }

    function deploy() internal returns (address) {
        vm.startBroadcast();
        CatV1 cat = new CatV1();
        ERC1967Proxy proxy = new ERC1967Proxy(address(cat), "");
        vm.stopBroadcast();

        return address(proxy);
    }    
}
