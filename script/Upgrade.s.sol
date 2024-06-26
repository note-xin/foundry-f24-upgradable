// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {CatV2} from "src/CatV2.sol";
import {CatV1} from "src/CatV1.sol";
import {DevOpsTools} from "lib/foundry-devops/src/DevOpsTools.sol";

/**
 * @title Upgrade
 * @author note-xin
 * @notice this is the upgrade script for the contracts
 */
contract Upgrade is Script{
    function run() external returns (address) {
        address mostRecentlyDeployed = DevOpsTools.get_most_recent_deployment("ERC1967Proxy", block.chainid);

        vm.startBroadcast();
        CatV2 cat = new CatV2();
        vm.stopBroadcast();

        address proxy = upgrade(mostRecentlyDeployed, address(cat));

        return proxy;
    }

    function upgrade(address proxyAddress, address newImplementation) public returns (address) {
        vm.startBroadcast();
        CatV1 proxy = CatV1(proxyAddress);
        proxy.upgradeToAndCall(address(newImplementation), "");
        vm.stopBroadcast();

        return address(proxy);
    }

}