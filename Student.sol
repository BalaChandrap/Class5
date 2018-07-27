contract StructMap {
    
    enum results {failed,absent,passed}
    
    struct Student {
        uint8 rollno;
        string name;
        uint8  marks;
        results examResult;
    }
    
    mapping (address => Student) studentDetails;
    
    function addStudent(address _studentAddress,uint8 _rollno,string _name, uint8 _marks) public {
        
        if(_marks >35)
        {
             studentDetails[_studentAddress] = Student(_rollno,_name,_marks,results.passed);
        }
        else {
            studentDetails[_studentAddress] = Student(_rollno,_name,_marks,results.failed);
        }
    }
    
    function getStudentDetails(address _studentAddress) public view returns(uint8,string,uint8,results){
        
        Student memory temp = studentDetails[_studentAddress];
        
        return (temp.rollno,temp.name,temp.marks,temp.examResult);
    }
}
