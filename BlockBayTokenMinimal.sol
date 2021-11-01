pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Mintable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/math/SafeMath.sol";

contract BlockBayToken is ERC20, ERC20Detailed, ERC20Mintable {
    using SafeMath for uint;

    //metadata for products
    struct ListedProduct {
        string name;
        string seller;
        string tokenURI;
    }

    ListedProduct metadata;

    constructor(
        uint initial_supply,
        string memory name,
        string memory seller,
        string memory tokenURI   
    ) ERC20Detailed("BlockBay", "BBT", 18) public {
        mint(msg.sender, initial_supply); 

        metadata = ListedProduct(name, seller, tokenURI);
    }

    function getName() public view returns(string memory) {
        return metadata.name;
    }

    function getSeller() public view returns(string memory) {
        return metadata.seller;
    }

    function getTokenURI() public view returns(string memory) {
        return metadata.tokenURI;
    }
}