import ballerina/time;

enum Gender {
    M,
    F
}

type Building record {|
    readonly string buildingCode;
    string city;
    string state;
    string country;
    string postalCode;

    Workspace[] workspaces;
    Department[] departments;
|};

// table<Building> key(buildingCode) buildings = table [];

type Department record {|
    readonly string deptNo;
    string deptName;

    Employee[] employees;
    Building[] buildings;
|};

// table<Department> key(deptNo) departments = table []; 

type Workspace record {|
    readonly string workspaceId;
    string workspaceType;

    Building location;
    Employee? employee;
|};

// table<Workspace> key(workspaceId) workspaces = table [];

type Employee record {|
    readonly string empNo;
    string firstName;
    string lastName;
    time:Date birthDate;
    Gender gender;
    time:Date hireDate;

    Department department;
    Workspace workspace;
    // Salary[] salaries;
    // Title[] titles;
|};

// table<Employee> key(empNo) employees = table[]; 

// type Salary record {|
//     // readonly string salaryId;
//     int salary;
//     time:Date fromDate;
//     time:Date? toDate;

//     // Employee employee;
// |};

// table<Salary> key(salaryId) salaries = table [];

// type Title record {|
//     readonly string titleId;
//     string title;
//     time:Date fromDate;
//     time:Date toDate;

//     // Employee employee;
// |};

// table<Title> key(titleId) titles = table [];