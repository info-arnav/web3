// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./priceConverter.sol";

error NotOwner();

contract FundMe {
    using PriceConvertor for uint256;

    uint256 public constant minumumUsd = 50 * 1e18;
    address[] public funders;

    mapping(address => uint256) public addressToAmount;

    address public immutable owner;

    constructor() {
        owner = msg.sender;
    }

    function fund() public payable {
        require(
            msg.value.getConversion() >= minumumUsd,
            "Must send atleast 50 USD"
        );
        funders.push(msg.sender);
        addressToAmount[msg.sender] = msg.value;
        //require(msg.value > 1e18, "Must send atleast 1 Etherium");  //1e18 == 1*10**18 = 1 etherium
    }

    function withraw() public onlyOwner {
        for (uint256 x = 0; x < funders.length; x = x + 1) {
            address funder = funders[x];
            addressToAmount[funder] = 0;
        }
        funders = new address[](0);
        (bool callSuccess, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        //payable(msg.sender).transfer(address(this).balance);
        require(callSuccess, "Call Failed");
    }

    receive() external payable {
        fund();
    }

    fallback() external payable {
        fund();
    }

    modifier onlyOwner() {
        //require(msg.sender == owner, "Access Denied");
        if (msg.sender != owner) {
            revert NotOwner();
        }
        _;
    }
}
