// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Storage} from "../storage/Storage.sol";
import {Schema} from "../storage/Schema.sol";

contract Tally {
    // Event to emit when a proposal is tallied
    event ProposalTallied(string proposalId, string result);

    // Function to tally votes and determine the result of a proposal
    function tallyVotes(string memory proposalId) public {
        for (uint i = 0; i < Storage.GlobalState().proposals.length; i++) {
            if (keccak256(bytes(Storage.GlobalState().proposals[i].id)) == keccak256(bytes(proposalId))) {
                uint yesVotes = 0;
                uint noVotes = 0;
                for (uint j = 0; j < Storage.GlobalState().proposals[i].votes.length; j++) {
                    if (Storage.GlobalState().proposals[i].votes[j].voteValue) {
                        yesVotes++;
                    } else {
                        noVotes++;
                    }
                }
                if (yesVotes > noVotes) {
                    Storage.GlobalState().proposals[i].votingResult = "Accepted";
                } else {
                    Storage.GlobalState().proposals[i].votingResult = "Rejected";
                }
                Storage.GlobalState().proposals[i].votingStatus = "Tallied";
                emit ProposalTallied(proposalId, Storage.GlobalState().proposals[i].votingResult);
                break;
            }
        }
    }
}
