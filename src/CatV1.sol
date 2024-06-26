// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";
import {Initializable} from "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import {OwnableUpgradeable} from "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";

/**
 * @title CatV1
 * @author note-xin
 * @notice this contract is a section of cyfrin-foundry-course-f23
 * @dev Impliments UUPS upgradeable pattern
 */
contract CatV1 is Initializable, OwnableUpgradeable, UUPSUpgradeable {
    /* State Variables */
    uint256 internal number;

    /* Functions */
    /* Constructor */
    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    /* External Functions */
    function getNumber() external view returns (uint256) {
        return number;
    }

    function contractVersion() external pure returns (uint256) {
        return 1;
    }

    /* Public Functions */
    function intialize() public initializer {
        __Ownable_init(address(msg.sender));
        __UUPSUpgradeable_init();
    }

    /* Internal Functions */
    /**
     * @dev This function decides who all can upgrade the contract
     */
    function _authorizeUpgrade(address newImplementation) internal override {

    }

}