pragma solidity ^0.5.0;

contract SealedAuction{
    
    // Variables
    struct Bid {
        bytes32 hiddenBids; // maybe not need to be hidden, can be address instead
        uint deposit;
        uint timestamp;
    }
    
    address payable public seller;
    uint public biddingEndTime;
    uint public reveal; // Potential to cut
    bool public auctionEnd;
    
    mapping(address => Bid) bids; // commit to one bid and that's it!
    
    // Lowest of the top nth bids
    Bid bids [] // List of bids array
    uint bids = new bids[](size);
    uint public currentNthPrice
    
    // Cases where there are ties
    // Cases where there are not enough buyers
    // Collusion 
    
    mapping(address => uint) pendingReturns;
    
    // Events - to log when the auction has ended
    event AuctionEnded(address winners, uint ___)
    
    // Modifiers

    
    // Functions
    
    constructor(
        uint _duration,
        uint _revealTime,
        address payable _winners,
        uint numItems
    ){
        
        bids = new bids[](numItems)
        winners = _winners;
        biddingEndTime = block.timestamp + _duration;
        revealEnd = biddingEnd + _revealTime; // A period for returns manually, but should automate
    }
    

    // An encoding function to record bids as hashes to keep bids hidden
    function createhiddenBids(uint value) public view return (bytes32) {
        return keccak256(abi.encodePacked(value));
        
    }
    
    // Function to record bids in the form of the hashed value
    function bids(bytes32 _blindedBid) public payable {
        bids[msg.sender].push(Bid({
            blindedBid: = _blindedBid,
            deposit: msg.value
        }))
        
    }
    
    function isWinner(Bid bid) {
        if (bid.value > bids[smallestBidIndex].value) {
            bids[smallestBidIndex] = bid;
        }
        uint length = bids.length
        uint minVal = 0
        for (uint i=0; i<length; i++) {
            if (minVal == 0 || bids[i].value < minVal) {
                smallestBidIndex = i
            }
        }
    }
    
    function auctionEnd() public payable {
        require(!ended);
        emit AuctionEnded(winners, ___);
        ended = true;
        seller.transfer(_____);
    }
    
    // For users that did not win to receive their bids back
    function withdraw() public {
        uint amount = pendingReturns[msg.sender];
        if (amount > 0){
            pendingReturns[msg.sender] = 0;
            
            payable(msg.sender).transfer(amount);
        }
    }
    
    // At the end of auction when the transactions execute
    function placeBid(address bidder, uint value) internal returns(bool success) {
        if (value <= ___) {
            return false
        }
        
        if 
        
        ____ = value;
        ____ = bidder;
        return true;
        
    }
    
    // To show all bids once auction ends
    function reveal()
        
        
        
    }
}