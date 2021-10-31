pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";
import "github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/math/SafeMath.sol";


// TODO: We might only need ERC20 if we are making a fungible token but using it more like an NFT
// and not trading it for actual Ether.

contract BlockBayToken is ERC20, ERC20Detailed {
    using SafeMath for uint;

    address payable owner;
    //1 BBT = 1000 Wei

    // TODO: If you need to have an exchange rate, can just probably set it to 1, and if you
    // need decimal places, can probably just set it to 18.  But again, we aren't going to buy and
    // sell these with Ether, we will likely just mint all of them at the beginning of the auction
    // by calling either a constructor or a mintTokens function that you provide, with our `numItems`
    // value.
    uint public exchangeRate = 1000

    modifier onlyOwner {
        require(msg.sender == owner, "You do not have permission to mint these tokens!");
        _;
    }

    constructor(uint initial_supply) ERC20Detailed("BlockBayToken", "BBT", 18) public {
        owner = msg.sender;
        _mint(owner, initial_supply);    // could be minted at deploy or once tokens are purchased
    }

    function mint(address recipient, uint amount) public onlyOwner {
        _mint(recipient, amount);
    }     
    
    // TODO: We probably won't have this token be purchased by ether, won't use a payable function
    // to mint them.
    function purchase() public payable {
        uint amount = msg.value.mul(exchangeRate);
        // mint tokens to their address automatically
        _mint(msg.sender, amount);
        balances[msg.sender] = balances[msg.sender].add(amount);
        owner.transfer(msg.value);
    }

  // TODO: Pobably need a function that can transfer tokens to a specified address, that we will
  // use to transfer tokens to auction winners, such as:
  // `transferToken(topNBids[i].address, 1);`


    //metadata for products
    struct ListedProduct {
        string name;
        string seller;
        uint priceInBBT;
        uint QRCode;
    }
    
    mapping(address => uint) balances;
    mapping(uint => ListedProduct) public itemSearch;
    
    function getProduct(uint productID) public {
        return itemSearch[productID]
    }
    
    // need to save the product somehow
    function purchaseItem
        
}

/**
TODO: Could add getters for specific fields from the product struct such as:
These are really rough ideas only:

getName(productID) public {
    return itemSearch[productID].name
}

getSeller(productID) public {
    return itemSearch[productID].seller
}
*/
