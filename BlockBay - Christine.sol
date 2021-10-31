pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/math/SafeMath.sol";


// TODO: We might only need ERC20 if we are making a fungible token but using it more like an NFT
// and not trading it for actual Ether.

contract BlockBayToken is ERC20 {
    using SafeMath for uint;

    address payable seller;

    // TODO: If you need to have an exchange rate, can just probably set it to 1, and if you
    // need decimal places, can probably just set it to 18.  But again, we aren't going to buy and
    // sell these with Ether, we will likely just mint all of them at the beginning of the auction
    // by calling either a constructor or a mintTokens function that you provide, with our `numItems`
    // value.

    modifier onlySeller {
        require(msg.sender == seller, "You do not have permission to mint these tokens!");
        _;
    }

    constructor(uint initial_supply) ERC20() public {
        seller = msg.sender;
        _mint(seller, initial_supply); 
    }

    function mint(address recipient, uint numItems) public onlySeller {    //should we leave out public? error message
        _mint(recipient, numItems);
    }     
    
    // TODO: We probably won't have this token be purchased by ether, won't use a payable function
    // to mint them.
    


  // TODO: Pobably need a function that can transfer tokens to a specified address, that we will
  // use to transfer tokens to auction winners, such as:
  // `transferToken(topNBids[i].address, 1);`

    //could save this transfer function for after the auction ends, awarding each winner a token
    //function transfer(address seller, address recipient, uint256 numItems) public {    
     //   balances[recipient] = balances[recipient].add(numItems);
     //   balanceOf[seller] = balanceOf[seller].sub(numItems);
   // }


    //metadata for products
    struct ListedProduct {
        string name;
        string seller;
        uint tokenID;
    }
    
    mapping(address => uint) balances;
    mapping(uint => ListedProduct) public artCollection;    // 
    
    //function getProduct(uint productURI) public {    //is this function still necessary?
     //   return productSearch[productID];
   // }

    function getName(uint tokenID) public {
        return productSearch[tokenID].name;
    }

    function getSeller(uint tokenID) public {
        return productSearch[tokenID].seller;
    }
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








    //use streamlit getters to display the product  refer to 
    // streamlit.write(product.name, product.seller)
    // streamlist.display(product)
/**
pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC721/ERC721Full.sol";

contract ArtToken is ERC721Full {
    constructor() public ERC721Full("ArtToken", "ART") {}

    function registerArtwork(address owner, string memory tokenURI)
        public
        returns (uint256)
    {
        uint256 tokenId = totalSupply();
        _mint(owner, tokenId);
        _setTokenURI(tokenId, tokenURI);

        return tokenId;
    }
}

*/