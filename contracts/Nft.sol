// SPDX-License-Identifier: GPL-3.0-or-later

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Context.sol";

contract reiNFT is Context, ERC721, Ownable {
    string public baseURI;
    uint256 autoIncreaseTokenId = 0;

    constructor(
        string memory name,
        string memory symbol,
        string memory uri
    ) ERC721(name, symbol) {
        _setBaseURI(uri);
    }

    function mint(address to) public onlyOwner {
        _safeMint(to, autoIncreaseTokenId);
        autoIncreaseTokenId++;
    }

    function batchMint(address[] memory to) public onlyOwner {
        for (uint256 i = 0; i < to.length; i++) {
            address user = to[i];
            mint(user);
        }
    }

    function _setBaseURI(string memory uri) internal onlyOwner {
        baseURI = uri;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override
        returns (string memory)
    {
        return baseURI;
    }
}
