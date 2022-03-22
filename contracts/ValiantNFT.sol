// SPDX-License-Identifier: MIT
pragma solidity 0.8.4; 

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract ValiantTrader is ERC721, Pausable, Ownable, ERC721URIStorage, ERC721Enumerable {

    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;



    // string public MEMBER_PROVENANCE = "";

    // string public LICENSE_TEXT = "";

    // bool licenseLocked = false; // TEAM CAN'T EDIT THE LICENSE AFTER THIS GETS TRUE

    uint256 public constant traderPrice = 89000000000000000; // 0.089 ETH

    uint public constant maxTraderPurchase = 10;

    uint256 public constant MAX_TRADERS = 10000;

    bool public saleIsActive = false;
    
    string private _baseTokenURI;
    mapping(uint => string) public traderNames;
    
    // Reserve 125 trees for team - Giveaways/Prizes etc
    uint public traderReserve = 1000;
    
    event traderNameChange(address _by, uint _tokenId, string _name);
    
    // event licenseisLocked(string _licenseText);

    uint256 public tokenCounter;
    mapping (uint256 => string) private _tokenURIs;

    constructor() ERC721("TraderNFT", "VTN") {
        tokenCounter = 0;
    }

    function withdraw() public onlyOwner {
        uint balance = address(this).balance;
        payable(msg.sender).transfer(balance);
    }

    function reserveTraders(address _to, uint256 _reserveAmount) public onlyOwner {        
        uint supply = totalSupply();
        require(_reserveAmount > 0 && _reserveAmount <= traderReserve, "Not enough reserve left for team");
        for (uint i = 0; i < _reserveAmount; i++) {
            _safeMint(_to, supply + i);
        }
        traderReserve = traderReserve - _reserveAmount;
    }

    // function setProvenanceHash(string memory provenanceHash) public onlyOwner {
    //     MEMBER_PROVENANCE = provenanceHash;
    // }

//     function _setBaseURI(string memory baseURI) internal virtual {
//     _baseTokenURI = baseURI;
//   }

  function _baseURI() internal view override returns (string memory) {
    return _baseTokenURI;
  }

  // Administrative zone
  function setBaseURI(string memory baseURI) public onlyOwner {
    _setBaseURI(baseURI);
  }


    function flipSaleState() public onlyOwner {
        saleIsActive = !saleIsActive;
    }

    function tokensOfOwner(address _owner) external view returns(uint256[] memory ) {
        uint256 tokenCount = balanceOf(_owner);
        if (tokenCount == 0) {
            // Return an empty array
            return new uint256[](0);
        } else {
            uint256[] memory result = new uint256[](tokenCount);
            uint256 index;
            for (index = 0; index < tokenCount; index++) {
                result[index] = tokenOfOwnerByIndex(_owner, index);
            }
            return result;
        }
    }

    // // Returns the license for tokens
    // function tokenLicense(uint _id) public view returns(string memory) {
    //     require(_id < totalSupply(), "CHOOSE A TRADER WITHIN RANGE");
    //     return LICENSE_TEXT;
    // }
    
    // // Locks the license to prevent further changes 
    // function lockLicense() public onlyOwner {
    //     licenseLocked =  true;
    //     emit licenseisLocked(LICENSE_TEXT);
    // }
    
    // // Change the license
    // function changeLicense(string memory _license) public onlyOwner {
    //     require(licenseLocked == false, "License already locked");
    //     LICENSE_TEXT = _license;
    // }
    

    // function mintPosseMember(string memory _tokenURI) public {
    //     _safeMint(msg.sender, tokenCounter);
    //     _setTokenURI(tokenCounter, _tokenURI);

    //     tokenCounter++;
    // }

    function mintTrader(uint numberOfTokens) public payable {
        require(saleIsActive, "Sale must be active to mint traders");
        require(numberOfTokens > 0 && numberOfTokens <= maxTraderPurchase, "Can only mint 20 tokens at a time");
        require(totalSupply() + numberOfTokens <= MAX_TRADERS, "Purchase would exceed max supply of Members");
        require(msg.value >= traderPrice * numberOfTokens, "Ether value sent is not correct");
        
        for(uint i = 0; i < numberOfTokens; i++) {
            uint mintIndex = totalSupply();
            if (totalSupply() < MAX_TRADERS) {
                _safeMint(msg.sender, mintIndex);
            }
        }

    }

 

    function changeTraderName(uint _tokenId, string memory _name) public {
        require(ownerOf(_tokenId) == msg.sender, "Hey, your wallet doesn't own this tree!");
        require(sha256(bytes(_name)) != sha256(bytes(traderNames[_tokenId])), "New name is same as the current one");
        traderNames[_tokenId] = _name;
        
        emit traderNameChange(msg.sender, _tokenId, _name);
        
    }
    
    function viewTraderName(uint _tokenId) public view returns( string memory ){
        require( _tokenId < totalSupply(), "Choose a trader within range" );
        return traderNames[_tokenId];
    }
    
    
    // GET ALL TREES OF A WALLET AS AN ARRAY OF STRINGS. WOULD BE BETTER MAYBE IF IT RETURNED A STRUCT WITH ID-NAME MATCH
    function traderNamesOfOwner(address _owner) external view returns(string[] memory ) {
        uint256 tokenCount = balanceOf(_owner);
        if (tokenCount == 0) {
            // Return an empty array
            return new string[](0);
        } else {
            string[] memory result = new string[](tokenCount);
            uint256 index;
            for (index = 0; index < tokenCount; index++) {
                result[index] = traderNames[ tokenOfOwnerByIndex(_owner, index) ] ;
            }
            return result;
        }
    }

    function _setTokenURI(uint256 _tokenId, string memory _tokenURI) internal virtual override {
        require(
            _exists(_tokenId),
            "ERC721Metadata: URI set of nonexistent token"
        );  // Checks if the tokenId exists
        _tokenURIs[_tokenId] = _tokenURI;
    }

    // function tokenURI(uint256 _tokenId) public view virtual override returns(string memory) {
    //     require(
    //         _exists(_tokenId),
    //         "ERC721Metadata: URI set of nonexistent token"
    //     );
    //     return _tokenURIs[_tokenId];
    // }

    function pause() public onlyOwner {
        _pause();
    }

    function unpause() public onlyOwner {
        _unpause();
    }

    function _beforeTokenTransfer(address from, address to, uint256 tokenId)
        internal
        whenNotPaused
        override(ERC721, ERC721Enumerable)
    {
        super._beforeTokenTransfer(from, to, tokenId);
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
        override(ERC721, ERC721Enumerable)
        returns (bool)
    {
        return super.supportsInterface(interfaceId);
    }

}