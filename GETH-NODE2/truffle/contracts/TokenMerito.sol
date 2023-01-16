//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";


contract TokenMerito is ERC721URIStorage, ERC721Enumerable, AccessControl {
    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    using SafeMath for uint256;
    using Counters for Counters.Counter;
    
    Counters.Counter private _tokenIds;
    
    string public baseTokenURI;
    
    constructor() ERC721("TokenMerito", "TOME") {
        _setupRole(DEFAULT_ADMIN_ROLE, msg.sender);
    }
    
    function awardAchievement(address student, string memory uri)
        public
        returns (uint256)
    {
        require(hasRole(MINTER_ROLE, msg.sender), "Caller is not a minter");
        
        uint256 newItemId = _tokenIds.current();
        _mint(student, newItemId);
        _setTokenURI(newItemId, uri);

        _tokenIds.increment();
        return newItemId;
    }

    function tokensOfOwner(address _owner) external view returns (uint[] memory) {
        uint tokenCount = balanceOf(_owner);
        uint[] memory tokensId = new uint256[](tokenCount);

        for (uint i = 0; i < tokenCount; i++) {
            tokensId[i] = tokenOfOwnerByIndex(_owner, i);
        }
        return tokensId;
    }

   function _beforeTokenTransfer(address from, address to, uint256 tokenId, uint256 batchSize)
        internal
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId, batchSize);
    }

    function _burn(uint256 tokenId) internal override(ERC721, ERC721URIStorage) {
        super._burn(tokenId);
    }

    function tokenURI(uint256 tokenId)
        public
        view
        override(ERC721, ERC721URIStorage)
        returns (string memory)
    {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId)
        public
        view
        override(ERC721, ERC721Enumerable, AccessControl)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }
    
}