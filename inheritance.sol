pragma solidity ^0.4.0;

contract mortal{
    address owner;
    modifier onlyowner(){
       if(msg.sender==owner){
           _;
       }
       else{
           revert();
       }
   }
    function mortal() public{
        owner=msg.sender;
    }
    function kill() public onlyowner{
        selfdestruct(owner);
    }
}
//someContract will extend mortal's fns
contract SomeContract is mortal{
   uint public myvar;
    
    function SomeContract() payable public{
        myvar=5;
    }
    function setmyvar(uint _myvar) public onlyowner{
        
        myvar=_myvar;
    }
    function getmyvar() constant public returns(uint){
        return 5*myvar;
    }
    function getmycontractbalance() public constant returns(uint){
        return this.balance;
    }
   
    function() public payable{
        
    }
}