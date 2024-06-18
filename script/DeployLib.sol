// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {MCDevKit} from "@mc/devkit/Flattened.sol";
// Bundle interface
import {FirstDAOFacade} from "bundle/first-dao/interfaces/FirstDAOFacade.sol";
// Functions
import {Initialize} from "bundle/first-dao/functions/protected/Initialize.sol";
import {MemberAdd} from "bundle/first-dao/functions/MemberAdd.sol";
import {Propose} from "bundle/first-dao/functions/Propose.sol";
import {Vote} from "bundle/first-dao/functions/Vote.sol";
import {Tally} from "bundle/first-dao/functions/Tally.sol";
import {Increment} from "bundle/first-dao/functions/Increment.sol";
import {Execute} from "bundle/first-dao/functions/Execute.sol";

library DeployLib {
    function bundleName() internal returns(string memory) {
        return "SimpleDAO";
    }

    function deploySimpleDAO(MCDevKit storage mc, uint256 initialNumber) internal returns(MCDevKit storage) {
        mc.init(bundleName());
        mc.use("Initialize", Initialize.initialize.selector, address(new Initialize()));
        mc.use("MemberAdd", MemberAdd.addMember.selector, address(new MemberAdd()));
        mc.use("Propose", Propose.createProposal.selector, address(new Propose()));
        mc.use("Vote", Vote.castVote.selector, address(new Vote()));
        mc.use("Tally", Tally.tallyVotes.selector, address(new Tally()));
        mc.use("Increment", Increment.execute.selector, address(new Increment()));
        mc.use("Execute", Execute.executeProposal.selector, address(new Execute()));
        mc.useFacade(address(new FirstDAOFacade()));
        mc.deploy(abi.encodeCall(Initialize.initialize, initialNumber));
        return mc;
    }
}
