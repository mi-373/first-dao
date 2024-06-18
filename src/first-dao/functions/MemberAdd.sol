// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Storage} from "../storage/Storage.sol";

contract MemberAdd {
    address public owner;

    // Define the onlyOwner modifier
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the contract owner");
        _;
    }

    // Event to emit when a new member is added
    event MemberAdded(address member);

    // Initialize the contract and set the owner
    constructor() {
        owner = msg.sender;
    }

    // Function to add a new member
    function addMember(address member) public onlyOwner {
        Storage.GlobalState().members.push(member);
        emit MemberAdded(member);
    }
}
