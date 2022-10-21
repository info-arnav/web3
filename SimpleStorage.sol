// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0; // >=0.8.7 <0.8.10

contract SimpleStorage {
    // bool hasFavouriteNumber = true;
    // uint256 favouriteNumber = 123;
    // string favouriteNumberInText = "Five";
    // int256 favouriteInt = -5;
    // address myAddress = 0xFe58067a4b92f34E1BEb85B2f924FeaA3AD98a52;
    // bytes32 favouriteBytes = "cat";
    uint256 public favouriteNumber;
    mapping(string => uint256) public nmaeTofavouriteNumber;
    // People public person = People({favouriteNumber:2, name:"Patrick"});
    struct People {
        uint256 favouriteNumber;
        string name;
    }
    People[] public people;

    function store(uint256 _favouriteNumber) public virtual {
        favouriteNumber = _favouriteNumber;
    }

    function retrieve() public view returns (uint256) {
        return favouriteNumber;
    }

    function addPerson(string memory _name, uint256 _favouriteNumber) public {
        people.push(People(_favouriteNumber, _name));
        nmaeTofavouriteNumber[_name] = _favouriteNumber;
        // People memory newPerson = People({favoutriteNumber:_favouriteNumber, name: _name});
        //People.push(newPerson);
    }
}
// 0xd9145CCE52D386f254917e481eB44e9943F39138
