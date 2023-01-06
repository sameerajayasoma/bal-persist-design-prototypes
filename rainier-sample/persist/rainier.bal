import ballerina/time;

enum Gender {
    M,
    F
}

type Building record {|
    // We need to specify how bal/persist will generate the primary key.
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

type Department record {|
    readonly string deptNo;
    string deptName;

    // One-to-many relationship
    Employee[] employees;
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

    // One-to-one relationship
    Workspace workspace;
|};

table<Employee> key(empNo) employees = table[]; 

type Salary record {|
    readonly string empNo;
    int salary;
    readonly time:Date fromDate;
    time:Date toDate;

    Employee employee; // empNo is a foreign key, which is also part of composite primary key
|};

table<Salary> key(empNo, fromDate) salaries = table [];

type Title record {|
    readonly string empNo;
    readonly string title;
    readonly time:Date fromDate;
    time:Date toDate;

    Employee employee; // empNo is a foreign key, which is also part of composite primary key
|};

table<Title> key(empNo, title, fromDate) titles = table [];

type Workspace record {|
    readonly string workspaceId = uuid:createType4AsString();
    string workspaceType;

    Building location;
    Employee employee;
|};

table<Workspace> key(workspaceId) workspaces = table [];
