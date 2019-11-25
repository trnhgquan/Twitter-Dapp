pragma solidity ^0.4.24;

import "openzeppelin-solidity/contracts/ownership/Ownable.sol";


contract ClaimTypesRegistry is Ownable {
    uint256[] public claimTypes;

    event claimTypeAdded(uint256 indexed claimType);
    event claimTypeRemoved(uint256 indexed claimType);

    /**
    * @notice Add a trusted claim type (For example: KYC=1, AML=2).
    * Only owner can call.
    *
    * @param claimType The uint256 of claim type
    */
    function addClaimType(uint256 claimType) public onlyOwner {
        uint length = claimTypes.length;
        for (uint i = 0; i < length; i++) {
            require(claimTypes[i] != claimType, "claimType already exists");
        }
        claimTypes.push(claimType);
        emit claimTypeAdded(claimType);
    }

    /**
    * @notice Remove a trusted claim type (For example: KYC=1, AML=2).
    * Only owner can call.
    *
    * @param claimType The uint256 of claim type
    */
    function removeClaimType(uint256 claimType) public onlyOwner {
        uint length = claimTypes.length;
        for (uint i = 0; i < length; i++) {
            if (claimTypes[i] == claimType) {
                delete claimTypes[i];
                claimTypes[i] = claimTypes[length - 1];
                delete claimTypes[length - 1];
                claimTypes.length--;
                emit claimTypeRemoved(claimType);
                return;
            }
        }
    }

    /**
    * @notice Get the trusted claim types for the identity services
    *
    * @return Array of trusted claim types
    */
    function getClaimTypes() public view  returns (uint256[] memory) {
        return claimTypes;
    }
}