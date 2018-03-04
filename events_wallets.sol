pragma solidity ^0.4.0;

import "github.com/ethereum/solidity/std/mortal.sol";

//someContract will extend mortal's fns
// A simple wallet in which you are allowed to send ether(Limit: maxTransferbal) if you are in the mapping
contract SimpleWallet is mortal{
   mapping (address => permission) myAddressMapping;
   
   event someOneAddedSomeOne(address personWhoAdded, address personWhoGotAdded, uint hisTransferLimit);
   event fundsAreSent(address sender, address receiver, uint amount);
   event someOneRemoved(address personWhoRemoved, address personWhoGotRemoved);
   struct permission{
       bool isAllowed;
       uint maxTransferbal;
}
    function addAddresstoSendersList(address permitted, uint balance) public onlyowner{
        myAddressMapping[permitted]=permission(true,balance);
        //firing the event
        someOneAddedSomeOne(msg.sender,permitted,balance);
}    
    
    //classical send function
    function sendFunds(address receiver, uint amountinwei) public {
        if(myAddressMapping[msg.sender].isAllowed){
            if(myAddressMapping[msg.sender].maxTransferbal>=amountinwei){
                bool isReallySent=receiver.send(amountinwei);
                if(!isReallySent){
                    revert();
                }
                fundsAreSent(msg.sender,  receiver,  amountinwei);
            }else{
                revert();
            }
        }else{
            revert();
        }
    }
    
    function sendFund(address receiver, uint amountinwei) public {
        require(myAddressMapping[msg.sender].isAllowed);
        require(myAddressMapping[msg.sender].maxTransferbal >= amountinwei);
        bool isTheAmountReallySent = receiver.send(amountinwei);
        require(isTheAmountReallySent == true);
        fundsAreSent(msg.sender,  receiver,  amountinwei);
    }
    
    function removeFromSendersList(address add) public{
        myAddressMapping[add].isAllowed=false;
        someOneRemoved(msg.sender, add);
    }
    //another remove function
    function removeFromeList(address add) public{
        delete myAddressMapping[add];
        someOneRemoved(msg.sender, add);

    }
   
    function() public payable{
        
    }
}