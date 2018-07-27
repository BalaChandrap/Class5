pragma solidity^0.4.20;

contract MappingTest {
    
    
    address public deployer;
    
    address public lastVisitor;
    
    constructor() public {
        deployer = msg.sender;
    }
    
    mapping (address => bool) public visitedContract;
    
    uint public count;
    
    address [] public visitors;
    
    function visit() public {
        count++;
        visitors.push(msg.sender);
        visitedContract[msg.sender] = true;
        lastVisitor = msg.sender;
    }
    
    function getAllVisitors() public view returns(address []){
        return visitors;
    } 
    
}
