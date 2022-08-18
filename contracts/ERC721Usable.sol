// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "./IERC721Usable.sol";

abstract contract ERC721Usable is IERC721Usable, ERC721 {
    // token Id to Usage Method
    mapping(uint256 => UsageMethod) private _usageMethods;

    //
    mapping(uint256 => uint256) private _usages;

    modifier useModifier(uint256 tokenId, address sender) {
        require(_exists(tokenId), "ERC721: Token does not exist");
        UsageMethod usageMethod = _usageMethods[tokenId];
        if (usageMethod == UsageMethod.Single) {
            require(_usages[tokenId] != 0);
            _usages[tokenId] = 0;
        } else if (usageMethod == UsageMethod.Multiple) {
            require(_usages[tokenId] != 0);
            _usages[tokenId] -= 1;
        }

        _;

        if (usageMethod == UsageMethod.Burn) _burn(tokenId);
    }

    function getUsageMethod(uint256 tokenId) public view override returns (UsageMethod) {
        return _usageMethods[tokenId];
    }
}
