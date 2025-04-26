// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Chainverse Identity - Decentralized Cross-Chain Identity Contract
/// @author YOU
/// @notice This contract manages decentralized identities using Soulbound Tokens (SBTs).

contract CVIIdentity {
    struct Profile {
        string handle;
        string metadataURI;
        bool exists;
    }

    mapping(address => Profile) private profiles;

    event ProfileCreated(address indexed user, string handle, string metadataURI);
    event ProfileUpdated(address indexed user, string newHandle, string newMetadataURI);

    /// @notice Create a new identity profile
    /// @param _handle Unique username/handle
    /// @param _metadataURI Link to IPFS/Ceramic metadata
    function createProfile(string calldata _handle, string calldata _metadataURI) external {
        require(!profiles[msg.sender].exists, "Profile already exists");
        profiles[msg.sender] = Profile(_handle, _metadataURI, true);
        emit ProfileCreated(msg.sender, _handle, _metadataURI);
    }

    /// @notice Update existing profile
    /// @param _newHandle New handle
    /// @param _newMetadataURI New metadata link
    function updateProfile(string calldata _newHandle, string calldata _newMetadataURI) external {
        require(profiles[msg.sender].exists, "Profile does not exist");
        profiles[msg.sender].handle = _newHandle;
        profiles[msg.sender].metadataURI = _newMetadataURI;
        emit ProfileUpdated(msg.sender, _newHandle, _newMetadataURI);
    }

    /// @notice Get user profile details
    /// @param _user Address of the user
    /// @return handle, metadataURI
    function getProfile(address _user) external view returns (string memory, string memory) {
        require(profiles[_user].exists, "Profile does not exist");
        return (profiles[_user].handle, profiles[_user].metadataURI);
    }
}
