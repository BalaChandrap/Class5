contract Owanble {
    
    address public admin;
    
    constructor() public {
        admin = msg.sender;
    }
    
    modifier onlyAdmin () {
        require(msg.sender == admin);
        _;
    }
}

contract TimeBased {
    uint256 public freezeTimeStamp;
    
    constructor () public {
        freezeTimeStamp = now +30;
    }
    
    modifier onlyAllowedTime () {
        require(now<= freezeTimeStamp);
        _;
    }
}



contract StructMap is Owanble,TimeBased {
    
    enum results {failed,absent,passed}
    
    struct Student {
        uint8 rollno;
        string name;
        uint8  marks;
        results examResult;
    }
    
    
    event SudnetAdded(address _studentAddress,address indexed _cretedBy,uint256 timeStamp);
    
      
    mapping (address => Student) studentDetails;
    
    
    constructor() public  {
         freezeTimeStamp = now+30;
    }

    function addStudent(address _studentAddress,uint8 _rollno,string _name, uint8 _marks) public onlyAdmin onlyAllowedTime {
        
        
        if(_marks >35)
        {
             studentDetails[_studentAddress] = Student(_rollno,_name,_marks,results.passed);
        }
        else {
            studentDetails[_studentAddress] = Student(_rollno,_name,_marks,results.failed);
        }
        
        emit SudnetAdded(_studentAddress,msg.sender,now);
    }
    
    function getStudentDetails(address _studentAddress) public view onlyAdmin returns(uint8,string,uint8,results) {
        
        Student memory temp = studentDetails[_studentAddress];
        
        return (temp.rollno,temp.name,temp.marks,temp.examResult);
    }
}
