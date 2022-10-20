 // SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MNFT is ERC721, Ownable {
    constructor() ERC721("MNFT", "MFT") {}

    function mint(address to, uint256 amount) public onlyOwner {
        _safeMint(to, amount);
    }
}