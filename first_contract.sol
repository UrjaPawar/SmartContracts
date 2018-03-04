pragma solidity ^0.4.0;

contract SomeContract{
   uint public myvar;
   address owner;
   
   modifier onlyowner(){
       if(msg.sender==owner){
           _;
       }
       else{
           revert();
       }
   }
    
    function SomeContract() payable public{
        myvar=5;
        owner=msg.sender;
    }
    function setmyvar(uint _myvar) public onlyowner{
        
        myvar=_myvar;
    }
    function getmyvar() constant public returns(uint){
        return 5*myvar;
    }
	 function kill() public onlyowner{
        selfdestruct(owner);
    }
    function getmycontractbalance() public constant returns(uint){
        return this.balance;
    }
    function() public payable{
        
    }
}