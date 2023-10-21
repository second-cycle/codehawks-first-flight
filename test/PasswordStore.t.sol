// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

import {Test, console} from "forge-std/Test.sol";
import {PasswordStore} from "../src/PasswordStore.sol";
import {DeployPasswordStore} from "../script/DeployPasswordStore.s.sol";

contract PasswordStoreTest is Test {
    PasswordStore public passwordStore;
    DeployPasswordStore public deployer;
    address public owner;

    function setUp() public {
        deployer = new DeployPasswordStore();
        passwordStore = deployer.run();
        owner = msg.sender;
    }

    // This test should pass to ensure the contract owner is able to change the password.

    function test_owner_can_set_password() public {
        vm.startPrank(owner);
        string memory expectedPassword = "myNewPassword";
        passwordStore.setPassword(expectedPassword);
        string memory actualPassword = passwordStore.getPassword();
        assertEq(actualPassword, expectedPassword);
    }

    // This test should pass to ensure a non-owner address cannot set the password.

    function test_non_owner_cannot_set_password() public {
        vm.startPrank(address(1));
        string memory expectedPassword = "myReallyNewPassword";
        passwordStore.setPassword(expectedPassword);
        vm.stopPrank();

        vm.startPrank(owner);
        string memory actualPassword = passwordStore.getPassword();
        assertTrue(keccak256(abi.encodePacked(actualPassword)) != keccak256(abi.encodePacked(expectedPassword)));
    }

    // This test should pass to ensure a non-owner address cannot read the password.

    function test_non_owner_reading_password_reverts() public {
        vm.startPrank(address(1));

        vm.expectRevert(PasswordStore.PasswordStore__NotOwner.selector);
        passwordStore.getPassword();
    }
}
