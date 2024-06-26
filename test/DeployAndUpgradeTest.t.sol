// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {Deploy} from "script/Deploy.s.sol";
import {Upgrade} from "script/Upgrade.s.sol";
import {CatV1} from "src/CatV1.sol";
import {CatV2} from "src/CatV2.sol";

contract DeployAndUpgradeTest is Test {
    /* State Variables */
    address public OWNER = makeAddr("owner");
    address public proxy;

    Deploy public deployer;
    Upgrade public upgrader;

    /* Functions */
    /* Public Functions */
    function setUp() public {
        deployer = new Deploy();
        upgrader = new Upgrade();

        proxy = deployer.run();
    }

    /* Test Functions */
    /**
     * @notice This function tests the deployment of the contract
     */
    function test_isCatV1Deployed() public view{
        // ASSIGN
        uint256 expectedVersion = 1;

        // ACT
        CatV1 cat = CatV1(proxy);

        // ASSERT
        assertEq(expectedVersion, cat.contractVersion());
    }
    /**
     * @notice This function double checks the deployment of the contract
     */
    function test_proxyStartAsV1() public {
        // ACT
        vm.expectRevert();
        CatV2(proxy).setNumber(10);
    }

    /**
     * @notice This function tests the upgradability of the contract
     */
    function test_upgrades() public {
        // ASSIGN
        CatV2 catv2 = new CatV2();
        uint256 expectedVersion = 2;

        // ACT
        upgrader.upgrade(proxy, address(catv2));
        CatV2(proxy).setNumber(10);

        // ASSERT
        assertEq(expectedVersion, CatV2(proxy).contractVersion());
        assertEq(10, CatV2(proxy).getNumber());

    }

}