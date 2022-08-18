// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";

interface IERC721Usable is IERC721 {
    enum UsageMethod {
        None,
        Burn,
        Single,
        Multiple
    }

    function getUsageMethod(uint256 tokenId) external view returns (UsageMethod);
}
