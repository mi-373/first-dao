// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./Increment.sol";
import {Storage} from "../storage/Storage.sol";
import {Schema} from "../storage/Schema.sol";
import {IExecutable} from "../interfaces/IExecutable.sol";

contract Execute {
    // Event to emit when an execution is completed
    event Executed(string proposalId, uint newValue);

    // Function to execute the proposal if it is accepted
    function executeProposal(string memory proposalId, address contractAddress) public {
        for (uint i = 0; i < Storage.GlobalState().proposals.length; i++) {
            if (keccak256(bytes( Storage.GlobalState().proposals[i].id)) == keccak256(bytes(proposalId)) &&
                keccak256(bytes( Storage.GlobalState().proposals[i].votingResult)) == keccak256(bytes("Accepted"))) {
                
                if (contractAddress != address(0)) {
                  IExecutable executableContract = Increment(contractAddress);
                  executableContract.execute();
                  emit Executed(proposalId, Storage.GlobalState().value);
                  break;
                }
            }
        }
    }
}