//SPDX-License-Identifier:- Unlicensed
pragma solidity >=0.4.0 < 0.9.0;

// A simple contract to change the state of a variable
contract SimpleStorage{
    uint storedData;
    function set(uint x) public{
        storedData = x;
    }
    function get() public view returns(uint){
        return storedData;
    }
}
