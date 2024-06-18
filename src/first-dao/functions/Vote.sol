// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Storage} from "../storage/Storage.sol";
import {Schema} from "../storage/Schema.sol";

contract Vote {
    // Event to emit when a vote is cast
    event VoteCast(string proposalId, address voter, bool voteValue);

    // Function to cast a vote
    function castVote(
        string memory proposalId,
        string memory voteId,
        address voterAddress,
        bool voteValue
    ) public {
        for (uint i = 0; i < Storage.GlobalState().proposals.length; i++) {
            if (keccak256(bytes(Storage.GlobalState().proposals[i].id)) == keccak256(bytes(proposalId))) {
                Schema.Vote memory newVote = Schema.Vote({
                    id: voteId,
                    proposalId: proposalId,
                    voterAddress: voterAddress,
                    voteValue: voteValue
                });
                Storage.GlobalState().proposals[i].votes.push(newVote);
                emit VoteCast(proposalId, voterAddress, voteValue);
                break;
            }
        }
    }
}
