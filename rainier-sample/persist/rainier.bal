import ballerina/uuid;
import ballerina/time;

enum Gender {
    M,
    F
}

type Building record {|
    readonly string buildingCode = uuid:createType4AsString();
    string city;
    string state;
    string country;
    string postalCode;

    // many-to-many relationship
    Department[] departments;
    Workspace[] workspaces;
|};

table<Building> key(buildingCode) offices = table [];

type Department record {|
    readonly string deptNo = uuid:createType4AsString();
    string deptName;

    // One-to-many relationship
    Employee[] employees;
    Building[] buildings;
|};

table<Department> key(deptNo) departments = table []; 

type Employee record {|
    readonly string empNo = uuid:createType4AsString();
    string firstName;
    string lastName;
    time:Date birthDate;
    Gender gender;
    time:Date hireDate;

    Department department;

    // One-to-many relationship
    Salary[] salaries;
    Title[] titles;
    Workspace workspace;
|};

table<Employee> key(empNo) employees = table[]; 

type Salary record {|
    readonly string empNo = uuid:createType4AsString();
    int salary;
    readonly time:Date fromDate;
    time:Date toDate;

    Employee employee;
|};

table<Salary> key(empNo, fromDate) salaries = table [];

type Title record {|
    readonly string empNo = uuid:createType4AsString();
    readonly string title;
    readonly time:Date fromDate;
    time:Date toDate;

    Employee employee;
|};

table<Title> key(empNo, title, fromDate) titles = table [];

type Workspace record {|
    readonly string workspaceId = uuid:createType4AsString();
    string workspaceType;

    Building location;
    Employee employee;
|};

table<Workspace> key(workspaceId) workspaces = table [];


// TODO: Design an annotation on table variable to specify unique constranints, indexes, etc.
// TODO: Create issues for language-level constraints
//  1) Table key 
//  2) Table 
// TODO: Create issues for compiler-level issues when using types with module-level visibility in the client class. 