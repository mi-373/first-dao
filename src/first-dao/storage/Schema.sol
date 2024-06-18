// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

library Schema {
    // Global State
    /// @custom:storage-location erc7201:firstDAO.GlobalState
    struct GlobalState {
        string id;
        uint value;
        Proposal[] proposals;
        address[] members;
        uint proposalDurationSeconds;
        uint tallyFrequencySeconds;
    }

    // Proposals
    struct Proposal {
        string id;
        address proposerAddress;
        string votingStatus;
        string votingResult;
        uint startTime;
        Vote[] votes;
    }

    // Votes
    struct Vote {
        string id;
        string proposalId;
        address voterAddress;
        bool voteValue;
    }
}