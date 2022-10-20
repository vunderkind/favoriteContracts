# Fractional NFTs

## Overview
To understand how fractional NFTs work, we must first understand the purpose they serve. An NFT is an indivisible token (the tokenIds are in discrete units of 1, 2,3..n). Sometimes, though, we may have a need to divvy up this indivisible thing into smaller units that makes it more accessible. Someone may not be able to buy 1 NFT worth $100,000, but they may be able to buy a _fraction_ of the same NFT if it's been split up into a 10,000 pieces. 

But — as mentioned earlier — NFTs are indivisible! How do we accomplish this?

### The steps are as follows:
1. Mint your NFT as you typically would.
2. Hand over that NFT to a fractionalizing smart contract, in exchange for a number of tokens representing the fractions.
3. Sell or transfer those tokens to the users who want fractions. 
4. Reconstitute the fractional NFT through a buyout/purchase method.

### Explaining the code
The `ERC20` contract is the fractionalizing contract. Once it has been granted `setApprovalForAll` access from the `ERC721` token, it can transfer an NFT from the NFT contract to itself (using the fractionalize method call), transferring a specified number of ERC20 tokens to the sender for their troubles. 

Note — this is a very simple implementation — it can, and will, get super technical in the real world.

### Acknowledgment/appreciation
1. Thanks to [Web3 Club](https://www.youtube.com/watch?v=fDRQDP2xW7o&ab_channel=Web3Club) for the tutorial that I used for this!
2. [Fractiona.art](https://fractional.art) for setting the protocol and standard for fractionalizing NFTs.

_If I missed something, please let me know!_
