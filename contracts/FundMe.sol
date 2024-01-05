//SPDX-License-Identifier:- Unlicensed
pragma solidity >=0.4.0 < 0.9.0;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


contract FundMe{
    // Stores the address of the owner
    address payable owner;
    // Stores how much value has been sent by which address
    mapping(address => uint) valueSent;

    //Setting the address of the owner:-
    constructor(){
        owner = payable(msg.sender);
    }
    //Function to convert the eth to USD
    function getPrice() private view returns(int256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (,int256 answer,,,) = priceFeed.latestRoundData();
        return answer * 10 ** 10;
    }
    // Function for conversion
    function getConversionRate(int ethAmount) private view returns(int){
        int ethPrice = getPrice();
        int ethAmountInUSD = (ethPrice * ethAmount) / (10 ** 18);
        return ethAmountInUSD;

    }
    //Function to send amount to smart contract
    function Send() public payable{
        valueSent[msg.sender] = msg.value;
        int minUSD = 50 * 10 ** 18;
        require(getConversionRate(int(msg.value)) >= minUSD, "You need to spend more eth");

    }

    //Function to withdraw all the funds
    function Withdraw() public payable{
        require(msg.sender == owner);
        owner.transfer(address(this).balance);
    }

}
