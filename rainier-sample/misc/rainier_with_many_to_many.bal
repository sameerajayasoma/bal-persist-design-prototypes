import ballerina/time;

enum Gender {
    M,
    F
}

type Building record {|
    // We need to specify how bal/persist will generate the primary key. The default behaviour
    readonly string buildingCode;
    string city;
    string state;
    string country;
    string postalCode;

    // many-to-many relationship
    Department[] departments;

    Workspace[] workspaces;
|};

table<Building> key(buildingCode) buildings = table [];

// Expressing many-many relationship between
// depts and buildings
// [Department, Building][] department_buildings;

// Explicit many-to-many relationship with a join table
// Many-to-many becomes two one-to-many relationships
// No nested writes required with this approach. 
// type DepartmentsInBuildings record {|
//     readonly string deptNo;
//     readonly string buildingCode;
//     readonly time:Date fromDate;

//     Building building;
//     Department department;
// |};

// table<DepartmentsInBuildings> key(deptNo, buildingCode, fromDate) departmentsInBuildings = table [];


type Department record {|
    readonly string deptNo;
    string deptName;

    // One-to-many relationship
    Employee[] employees;

    // Many-to-many relationship
    Building[] buildings;
|};

table<Department> key(deptNo) departments = table []; 

type Employee record {|
    readonly string empNo;
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
    readonly string empNo;
    int salary;
    readonly time:Date fromDate;
    time:Date toDate;

    Employee employee;
|};

table<Salary> key(empNo, fromDate) salaries = table [];

type Title record {|
    readonly string empNo;
    readonly string title;
    readonly time:Date fromDate;
    time:Date toDate;

    Employee employee;
|};

table<Title> key(empNo, title, fromDate) titles = table [];

type Workspace record {|
    readonly string workspaceId;
    string workspaceType;

    Building location;
    Employee? employee;
|};

table<Workspace> key(workspaceId) workspaces = table [];


// TODO: Design an annotation on table variable to specify unique constranints, indexes, etc.
// TODO: Create issues for language-level constraints
//  2) Table 
// TODO: Create issues for compiler-level issues when using types with module-level visibility in the client class. 
// TODO: Design many-to-many relationships and the corresponding client API.
