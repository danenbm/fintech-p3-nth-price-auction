# Modified Vickrey Auction - Nth Price Sealed Bid

This Ethereum smart contract implements a multi-user price discovery auction, based on the Vickrey Auction definition. The awarded item or items are represented by one or more ERC-1155 tokens.  When the auction ends, the smart contract awards one item to each of the top N bidders at the price of the Nth highest bid, where N is the number of items up for auction.

Key Points of Auction Logic:
* Sealed Auction which means bidders can't see each other's bids
* Bidders can only bid once
* Multiple items (N items) can be up for auction
* The top N bidders pay the price that is the lowest bid out of the top N

Pro's of Auction:
* Encourages true value, willingness of what people want to pay
* Resistant to over and under bidding, competitive bidding wars
* No incentive to bid higher or lower
* Less cost and fees
* All bidders submit bids simultaneously
---

## References

* https://www.bitdegree.org/learn/best-code-editor/solidity-simple-auction-example
* https://allstarce.com/wp-content/uploads/2015/06/Types-of-Auctions-1.pdf
* https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v4.4/contracts/utils/math/SafeMath.sol
* http://github.com/Openzeppelin/Openzeppelin-contracts/blob/master/contracts/access/Ownable.sol
* http://github.com/Openzeppelin/Openzeppelin-contracts/blob/master/contracts/token/ERC1155/ERC1155.sol

---

## Technologies

This Auction Contract makes use of the following:
* Remix Ethereum IDE
* Pragma Solidity ^0.8.0
* OpenZeppelin: SafeMath, ERC1155, Ownable Contracts
* MetaMask
* Injected Web3
* Pinata
* Moralis

---

## Installation Guide

To use this contract:
* Upload NthPriceAuctionToken.sol into Remix Ethereum IDE
* Upload NthPriceAuction.sol into Remix Ethereum IDE
* Compile and Deploy NthPriceAuction.sol
* Use the tokenAddress getter to find the address of the token deployed by the auction in order to link it to Remix Ethereum IDE.

---

## Contributors

* Allen Wong
* Christine Guo 
* LaNaya Johnson 
* Michael Danenberg
