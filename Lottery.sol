pragma solidity ^0.4.21;

contract Ownable {
    
    address public admin;
    
    address public newOwner;
    
    event OwnershipTransferred(address _newOwner);
    constructor() public {
        admin = msg.sender;
    }
    
    modifier onlyAdmin {
        require(msg.sender == admin);
        _;
    }
    
    function transferOwnership(address _newOwner) public{
        newOwner = _newOwner;
    }
    
    function acceptOwnership() public {
        require(msg.sender==newOwner);
        admin = newOwner;
        emit OwnershipTransferred(newOwner);
    }
}


contract Lottery is Ownable {
    
    address [] public addressArray;
    
    mapping (address => bool) participantStatus;
    
    uint randomCounter;
    
    enum  Status {created, open,closed, completed}
    
    Status lotteryStatus;
    
    constructor () public {
        lotteryStatus = Status.created;
    }
    
    function startLottery () public onlyAdmin {
        lotteryStatus = Status.open;
    }
    
    function particitpate(uint _number) public payable {
        require(msg.value == 1 ether);
        require(lotteryStatus == Status.open);
        require(msg.sender!=admin);
        require(participantStatus[msg.sender]==false);
        addressArray.push(msg.sender);
        participantStatus[msg.sender] = true;
        randomCounter += _number;
    }
    
    function closeLottery() public onlyAdmin {
        lotteryStatus = Status.closed;
    }
    
    function selectWinner() public onlyAdmin {
        require(lotteryStatus == Status.closed);
        uint number = addressArray.length;
        require(number>1);
        lotteryStatus = Status.completed;
        
        uint total = block.timestamp+block.difficulty+randomCounter;
        uint winner = total%(number-1);
     uint winningAmount = number*(1 ether/  1 wei);
        addressArray[winner].transfer(winningAmount);
    }
    
}
