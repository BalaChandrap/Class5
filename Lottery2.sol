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
    
    mapping (address => uint) public participantStatus;
    
    uint randomCounter;
    
    enum  Status {created, open,closed, completed}
    
    Status lotteryStatus;
    
    constructor () public {
        lotteryStatus = Status.created;
    }
    
    function startLottery () public onlyAdmin {
        lotteryStatus = Status.open;
    }
    
    function particitpate(uint _number,uint _ticketNo) public payable {
        uint256 ethAmount = _ticketNo*(1 ether/1 wei);
        require(msg.value == ethAmount);
        require(lotteryStatus == Status.open);
        require(msg.sender!=admin);
        for(uint i=0;i<_ticketNo;i++){
            addressArray.push(msg.sender);
            randomCounter += _number;
            participantStatus[msg.sender]++;
        }
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
    
    function withDraw(uint _ether) public{
        uint256 ethAmount = _ether*(1 ether/ 1 wei);
        admin.transfer(ethAmount);
    }
    
}
