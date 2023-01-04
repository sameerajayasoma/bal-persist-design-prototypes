import ballerina/uuid;
import ballerina/time;

enum Gender {
    M,
    F
}

type Department record {|
    readonly string deptNo = uuid:createType4AsString();
    string deptName;

    // One-to-many relationship
    Employee[] employees?;
|};

table<Department> key(deptNo) departments = table []; 

type Employee record {|
    readonly string empNo = uuid:createType4AsString();
    string firstName;
    string lastName;
    time:Date birthDate;
    Gender gender;
    time:Date hireDate;

    @persist:Relation{fields:["deptNo"]}
    Department department?;
    string deptNo;

    // One-to-many relationship
    Salary[] salaries?;
    Title[] titles?;
|};

table<Employee> key(empNo) employees = table[]; 

type Salary record {|
    readonly string empNo;
    int salary;
    readonly time:Date fromDate;
    time:Date toDate;

    @persist:Relation{fields:["empNo"]}
    Employee employee?;
|};

table<Salary> key(empNo, fromDate) salaries = table [];

type Title record {|
    readonly string empNo;
    readonly string title;
    readonly time:Date fromDate;
    time:Date toDate;

    @persist:Relation{fields:["empNo"]}
    Employee employee?;
|};

table<Title> key(empNo, title, fromDate) titles = table [];



// TODO: Design an annotation on table variable to specify unique constranints, indexes, etc.
// TODO: Create issues for language-level constraints
//  1) Table key 
//  2) Table 
// TODO: Create issues for compiler-level issues when using types with module-level visibility in the client class. 