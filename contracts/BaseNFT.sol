// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract BaseNFT is ERC721, Ownable {
    using Strings for uint256;

    uint256 public mintPrice = 0.01 ether;
    uint256 public totalSupply;
    uint256 public maxSupply;
    
    struct Trait {
        string species;
        string color;
        uint256 power;
    }
    
    mapping(uint256 => Trait) public traits;
    
    constructor(string memory _name, string memory _symbol, uint256 _maxSupply) 
        ERC721(_name, _symbol)
        Ownable(msg.sender)
    {
        maxSupply = _maxSupply;
    }
    
    function mint() public payable {
        require(msg.value >= mintPrice, "Insufficient payment");
        require(totalSupply < maxSupply, "Max supply reached");
        
        uint256 tokenId = totalSupply + 1;
        _safeMint(msg.sender, tokenId);
        
        // Generate random traits
        traits[tokenId] = Trait({
            species: "Base",
            color: "Blue",
            power: uint256(keccak256(abi.encodePacked(block.timestamp, tokenId))) % 100
        });
        
        totalSupply++;
    }
    
    function getTraits(uint256 tokenId) public view returns (Trait memory) {
        require(_exists(tokenId), "Token does not exist");
        return traits[tokenId];
    }
}