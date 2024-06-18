// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Schema} from "./Schema.sol";

library Storage {
    function GlobalState() internal pure returns(Schema.GlobalState storage ref) {
        assembly { ref.slot := 0x520053d0dbd829a99ee1a9bb0df20c648e4dd1af4d0bc8d0c8d2eec4599ebf00 }
    }
}
