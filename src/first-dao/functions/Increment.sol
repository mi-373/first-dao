// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Storage} from "../storage/Storage.sol";
import {Schema} from "../storage/Schema.sol";
import {IExecutable} from "../interfaces/IExecutable.sol";

contract Increment is IExecutable {
    address public owner;
    mapping(address => bool) public approvedAddresses;

    // Define the onlyApproved modifier
    modifier onlyApproved() {
        require(approvedAddresses[msg.sender], "Not an approved address");
        _;
    }

    // Event to emit when an address is approved
    event AddressApproved(address addr);

    // Event to emit when an increment is executed
    event IncrementExecuted(uint newValue);

    // Initialize the contract and set the owner
    constructor() {
        owner = msg.sender;
    }

    // Function to approve an address
    function approveAddress(address addr) public {
        require(msg.sender == owner, "Only the owner can approve addresses");
        approvedAddresses[addr] = true;
        emit AddressApproved(addr);
    }

    // Function to execute the increment if the proposal is accepted
    function execute() public onlyApproved {
        Storage.GlobalState().value++;
        emit IncrementExecuted(Storage.GlobalState().value);
    }
}