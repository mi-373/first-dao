// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Storage} from "../storage/Storage.sol";
import {Schema} from "../storage/Schema.sol";

contract Propose {
    // Event to emit when a new proposal is created
    event ProposalCreated(string id, address proposer, address contractAddress);

    mapping(string => address) private proposalToContract;

    // Function to create a new proposal
    function createProposal(
        string memory proposalId,
        address proposerAddress,
        uint startTime,
        address contractAddress
    ) public {
        Schema.Vote[] memory votes = new Schema.Vote[](1);
        Schema.Vote memory newVote = Schema.Vote({
            id: "",
            proposalId: "",
            voterAddress: address(0),
            voteValue: false
        });
        votes[0] = newVote;
        Schema.Proposal memory newProposal = Schema.Proposal({
            id: proposalId,
            proposerAddress: proposerAddress,
            votingStatus: "Pending",
            votingResult: "None",
            startTime: startTime,
            votes: votes
            // votes: new Schema.Vote[](1)
        });
        Storage.GlobalState().proposals.push(newProposal);
        proposalToContract[proposalId] = contractAddress;
        emit ProposalCreated(proposalId, proposerAddress, contractAddress);
    }

    // Function to get the contract address associated with a proposal
    function getContractAddress(
        string memory proposalId
    ) public view returns (address) {
        return proposalToContract[proposalId];
    }
}