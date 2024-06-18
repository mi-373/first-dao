// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "./IFirstDAO.sol";

contract FirstDAOFacade is IFirstDAO {
    function initialize(uint256 initialNumber) external {}
    function addMember(address member) external {}
    function createProposal(string memory proposalId, address proposerAddress, uint startTime, address contractAddress) external {}
    function getContractAddress(string memory proposalId) external view returns(address) {}
    function castVote(string memory proposalId, string memory voteId, address voteAddress, bool voteValue) external {}
    function tallyVotes(string memory proposalId) external {}
    function executeProposal(string memory proposalId, address contractAddress) external {}
    function approveAddress(address addr) external {}
    function execute() external {}
}
