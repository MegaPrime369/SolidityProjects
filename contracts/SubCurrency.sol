//SPDX-License-Identifier:- Unlicensed
pragma solidity >=0.4.0 <0.9.0;

// Contract for our coin
//Our coin can only be minted by the creator of this smart contract
contract Coin{
    // minter stores the address of the creator of this smart contract
    address minter;
    // creating a map to store the balances of the addresses
    mapping(address => uint) balances;
    // An event will broadcast a signal to the network with the following informations.
    event Sent(address sender, address receiver, uint amt);

    //Adding a constructor to permanently set the value of the minter
    constructor(){
        minter = msg.sender;
    }

    //Function for minting a new coin and sending it to a specific address
    function mint(address receiver, uint amt) public{
        require(msg.sender == minter);
        balances[receiver] += amt;
    }

    //Function for sending an amt from one address to the other
    function send(address receiver, uint amt) public{
        require(amt <= balances[msg.sender]);
        balances[receiver] += amt;
        balances[msg.sender] -= amt;
        emit Sent(msg.sender, receiver, amt);
    }

    //Function to check the balance of the caller
    function show() public view returns(uint){
        return balances[msg.sender];
    }
}
