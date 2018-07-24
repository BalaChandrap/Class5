pragma solidity ^0.4.20;

contract Sample {
    
    uint x;
    
    function setValue(uint _value) public {
        x= _value;
    }
    
    function getValue() public view  returns (uint) {
        
        return x;
    }
    
    function returnSum(uint a, uint b) public pure returns (uint) {
        uint c = a+b;
        return c;
    }
    
}
