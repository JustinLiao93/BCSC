pragma solidity ^0.4.25;
contract Collateral {
    
  address public owner;

  mapping (bytes32=>address[]) public ownerMap;
  mapping (address=>bytes32[]) public collateralMap;

  constructor() public {
      owner = msg.sender;
  }
  
  function addData(bytes32 document) public {
    address[] storage owners = ownerMap[document];
    uint i;
    for(i=0;i<owners.length; i++)
    {
      if(owners[i] == msg.sender)
        return;
    }
    ownerMap[document].push(msg.sender);
    uint count = collateralMap[msg.sender].length;
    for(i=0;i<count; i++)
    {
      if(collateralMap[msg.sender][i] == document)
        return;
    }
    collateralMap[msg.sender].push(document);
  }

  function getCollateralCount(address person) public constant returns(uint) {
    return collateralMap[person].length;
  }

  function getOwnerCount(bytes32 hash) public constant returns(uint) {
    return ownerMap[hash].length;
  }
  
  function getOwnerByPosition(bytes32 hash,uint index) public constant returns(address) {
    return ownerMap[hash][index];
  }
  
  
}