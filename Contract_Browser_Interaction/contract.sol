pragma solidity ^0.4.0;

contract MyContract{
  address creator;
  uint256 myNumber;
  function MyContract() public{
      creator=msg.sender;
      myNumber=3;
  }
  function getCreator() public constant returns (address){
      return creator;
  }
  function getMyNumber() public constant returns (uint256){
      return myNumber;
  }
  function setMyNumber(uint256 newNumber) public {
      myNumber=newNumber;
  }
  function kill() public{
      if(msg.sender==creator){
          selfdestruct(creator);
      }
  }
  
}
