// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0; 

contract ScoreCard {

    uint256 studentCount = 0;
    address classTeacher;
    mapping (uint256 => StudentDetails) students;
    mapping (uint256 => Scores) scores;
    constructor() {
        classTeacher = msg.sender;
    }

    struct StudentDetails {
        string StudentFirstName;
        string StudentLastName;
        uint256 Id;
    }
    struct Scores {
        uint256 studentId;
        uint256 englishMarks;
        uint256 mathsMarks;
        uint256 scienceMarks;
    }
    function addStudentDetails (string memory _fname, string memory _lname) public onlyClassTeacher(msg.sender) {
        StudentDetails storage studentObj = students[studentCount];
        studentObj.StudentFirstName = _fname;
        studentObj.StudentLastName = _lname;
        studentObj.Id = studentCount;
        emit studentAdded(_fname, _lname, studentCount++);
    }
    function addStudentScores(uint256 _id, uint256 _english, uint256 _maths, uint256 _science) public onlyClassTeacher(msg.sender) studentNotFound(_id) {
        Scores storage score = scores[_id];
        score.studentId = _id;
        score.englishMarks = _english;
        score.mathsMarks = _maths;
        score.scienceMarks = _science;
        emit studentScoresRecorded(_id, _english, _maths, _science);
    }
    function getStudentScores(uint256 _id) external view studentNotFound(_id) returns (Scores memory) {
        Scores memory studentScore = scores[_id];
        return studentScore;
    }
    function getStudentDetails(uint256 _id) external view studentNotFound(_id) returns (StudentDetails memory) {
        StudentDetails memory details = students[_id];
        return details;
    }
    modifier onlyClassTeacher(address _teacher) {
        require(classTeacher == _teacher, "Only the class teacher has access to this function");
        _;
    }
    modifier studentNotFound(uint256 _studentId){
        require(_studentId >= 0 && _studentId <= studentCount, "Student is in a different class.");
        _;
    }
    event studentAdded(string _fname, string _lname, uint256 _id);
    event studentScoresRecorded(uint256 _id, uint256 _english, uint256 _maths, uint256 _science);

    /** 
        modifier invalidScores(uint256 _studentId) {
            //require(scores[_studentId].englishMarks, "");
            //require(true, "Invalid score sheet submitted.");
            _;
        }
    */
}