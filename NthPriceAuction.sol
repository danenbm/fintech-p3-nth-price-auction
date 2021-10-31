pragma solidity ^0.5.0;

// TODO: add safe math everywhere applicable.

contract NthPriceAuction{
    // Beneficiary of the auction.
    address payable public sellerAddress;
    // Time the auction starts.
    uint256 public auctionStartTime;
    // Time the auction ends.
    uint256 public auctionEndTime;
    // Number of items to auction and thus max number of winners.
    uint numItemsToAuction;
    // Set to true when auction ends.
    bool public auctionEnded;
    // Index for the smallest of the top N bids.
    uint smallestTopNBidsIndex;

    // Bid structure used to store info about a bid that was placed.
    struct Bid {
        address bidder;
        uint value;
        uint256 timestamp;
    }

    // List of the top N bids.
    Bid[] topNBids;

    // Mapping to bids to return to store bidders that did not win. 
    mapping(address => uint) bidsToReturn;

    // TODO: Cases where there are ties - I think already covered by our list.
    // TODO: Cases where there are not enough buyers
    // TODO: Collusion 

    // TODO: Get events added/working.
    // Events - to log when the auction has ended
    //event AuctionEnded(address winners, uint ___);

    // Modifier to ensure this action occurs within the timeframe of the auction.
    modifier withinAuction {
        require(block.timestamp >= auctionStartTime && block.timestamp <= auctionEndTime);
        _;
    }

    // Function to create an auction of `numItems` items,
    // for 'durationSeconds' seconds, on behalf of the
    // beneficiary address of `seller`.
    constructor (
        address payable seller,
        uint durationSeconds,
        uint numItems
    ) public {
        require(numItems > 0);

        sellerAddress = seller;
        auctionStartTime = block.timestamp;
        auctionEndTime = auctionStartTime + durationSeconds;
        numItemsToAuction = numItems;
        auctionEnded = false;
        smallestTopNBidsIndex = 0;
    }

    // Payable function that allows someone to send Ether to make a bid.
    function bid() public payable withinAuction {
        // TODO: Does using payable mean it requires non-zero Ether to be sent?

        // Save bid parameters in a struct object.
        Bid memory newBid = Bid(msg.sender, msg.value, block.timestamp);

        if (topNBids.length < numItemsToAuction) {
            // If there's any space in the list, add the new
            // bid to the list.
            topNBids.push(newBid);
        } else if (newBid.value > topNBids[smallestTopNBidsIndex].value) {
            // If the new bid is greater than the current smallest of
            // the top N bids, add the current smallest of the top N bids
            // address and value to the bidsToReturn mapping.
            // TODO Should this be `+=` or just `=`.
            bidsToReturn[topNBids[smallestTopNBidsIndex].bidder]
                += topNBids[smallestTopNBidsIndex].value;
        
            // Replace the current smallest bid with this new one.
            topNBids[smallestTopNBidsIndex] = newBid;
        } else {
            // If the bid does not make it into the top N list, then return
            // the Ether to the bidder.
            revert("Sorry you have been outbid.");
        }

        //TODO: Using minIndex because I think it is cheaper to update
        // a memory variable than a storage variable so we only
        // update smallestTopNBidsIndex after the loop.

        // Find the new smallest of the top N bids.
        uint minIndex = 0;
        for (uint i = 1; i < topNBids.length; i++) {
            // Using less than or equal here so that if there are duplicates,
            // the newer bid is the one that is set to be the minIndex,
            // which means the newer bid will be overwritten by a new bid
            // that outbids its value.
            if (topNBids[i].value <= topNBids[minIndex].value) {
                minIndex = i;
            }
        }

        // Only after the loop is finished do we update the
        // storage variable.
        smallestTopNBidsIndex = minIndex;
    }

    function auctionEnd() public payable {
        require(!auctionEnded);
        require(block.timestamp > auctionEndTime);

        // Set bool so that auction can only be ended once.    
        auctionEnded = true;

        // TODO: Emit events.
        //emit AuctionEnded(winners, ___);

        // Transfer Ether to the beneficiary, in the amount of
        // the smallest of the top N bids times the number of
        // bidders in the top N bids list.
        if (topNBids.length > 0) {
            uint amountToTransfer = topNBids[smallestTopNBidsIndex].value * topNBids.length;
            sellerAddress.transfer(amountToTransfer);
        }

        // Add remainder between what each top N bidder bid, and
        // the price they paid (which was the smallest of the top N bids),
        // to the bidsToReturn mapping.
        for (uint i = 0; i < topNBids.length; i++) {
            uint remainderToReturn = topNBids[i].value - topNBids[smallestTopNBidsIndex].value;
            // TODO Should this be `+=` or just `=`.
            bidsToReturn[topNBids[smallestTopNBidsIndex].bidder] += remainderToReturn;
        }
    }

    // Function for users that did not win to use to receive their bids
    // back. Due to security concerns, it is better to let the bidders
    // withdraw themselves rather then automatically send to them.
    function withdraw() public returns (bool) {
         uint bidValue = bidsToReturn[msg.sender];

         if (bidValue > 0){
            // Set to zero to prevent multiple withdraws.
            bidsToReturn[msg.sender] = 0;
            
            // Send bid amount back to sender.  If it fails,
            // put the bid amount back in the mapping for that
            // sender.
            if (false == msg.sender.send(bidValue)) {
                bidsToReturn[msg.sender] = bidValue;
                return false;
            }
         }

         return true;
    }
}
