// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.3/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts@4.7.3/access/Ownable.sol";
import "@openzeppelin/contracts@4.7.3/token/ERC20/extensions/draft-ERC20Permit.sol";

contract Fractional is ERC20, Ownable, ERC20Permit, ERC721Holder {
    IERC721 public collection; // Address of the NFT to fractionalize
    uint256 tokenId; // this will be the tokenId of the NFT we're attempting to fractionalize
    bool public isFractionalizedAlready = false;
    uint256 salePrice;
    bool public isForSale = false;
    bool public canRedeemFNFTs = false;

    function fractionalize(address _collection, uint256 _tokenId, uint256 _amount) external onlyOwner {
        require(!isFractionalizedAlready, "Sorry, this NFT has already been fractionalized!"); // Check that we didn't already fractionalize this NFT
        require(_amount > 0, "You can't fractionalize zero NFTs");
        collection = IERC721(_collection);
        collection.safeTransferFrom(msg.sender, address(this), _tokenId);
        tokenId = _tokenId;
        isFractionalizedAlready = true;
        _mint(msg.sender, _amount);

        // TL;DR: this function essentially reads an NFT smart contract,
        // transfers from that smart contract to *this* smart contract
        // Then issues/mints '_amount' number of ERC20 tokens to the caller.
    }

    function putUpForSale(uint256 _price) external onlyOwner {
        salePrice = _price;
        isForSale = true;
    }

    function purchase() external payable {
        require(isForSale, "This NFT owner has not put this up for sale!");
        require(msg.value >= salePrice, "You didn't offer enough ETH for the price on offer");
        collection.transferFrom(address(this), msg.sender, tokenId);
        isForSale = false;
        canRedeemFNFTs = true;
    }

    function redeemFNFTs(uint256 _amount) external {
        require(canRedeemFNFTs,
            "You can only redeem your fractionalized NFT when someone offers to buy the whole NFT");
        uint256 totalETH = address(this).balance;
        uint256 toRedeem = _amount * totalETH / totalSupply();

        _burn(msg.sender, _amount);
        payable(msg.sender).transfer(toRedeem);

    }
    constructor() ERC20("MonopolyDice", "MDICE") ERC20Permit("MyToken") {}

}