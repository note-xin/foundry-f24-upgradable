// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {UUPSUpgradeable} from "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

/**
 * @title CatV2
 * @author note-xin
 * @notice this contract is a section of cyfrin-foundry-course-f23
 * @dev Impliments UUPS upgradeable pattern
 */
contract CatV2 is UUPSUpgradeable{
    /* State Variables */
    uint256 internal number;

    /* Functions */
    /* External Functions */
    function getNumber() external view returns (uint256) {
        return number;
    }

    function contractVersion() external pure returns (uint256) {
        return 2;
    }

    function setNumber(uint256 _number) external {
        number = _number;
    }

    /* Internal Functions */
    /**
     * @dev This function decides who all can upgrade the contract
     */
    function _authorizeUpgrade(address newImplementation) internal override {

    }

}