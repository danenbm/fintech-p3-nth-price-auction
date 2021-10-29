pragma solidity ^0.5.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v2.5.0/contracts/token/ERC20/ERC20Detailed.sol";


contract BlockBayToken is ERC20, ERC20Detailed {
    //using SafeMath for uint;

    address payable owner = msg.sender;
    
    struct ListedProduct {
        string name;
        string seller;
        uint256 priceInBBT;
    }

    mapping(uint256 => ListedProduct) public itemSearch;
    

    modifier onlyOwner {
        require(msg.sender == owner, "You do not have permission to mint these tokens!");
        _;
    }

    constructor(uint initial_supply) ERC20Detailed("BlockBayToken", "BBT", 18) public {
        owner = msg.sender;
        _mint(owner, initial_supply);
    }

    function mint(address recipient, uint256 amount) public onlyOwner {
        _mint(recipient, amount);



    }
}

