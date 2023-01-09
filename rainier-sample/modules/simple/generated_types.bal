import ballerina/time;

// TODO: Remove "public" from the generated types
// I've added the "public" qualifier to get-rid of the several warnings in the client class
// TODO: Report an issue to the compiler team
public enum Gender {
    M,
    F
}

// Generated model types
public type Employee record {|
    readonly string empNo;
    string firstName;
    string lastName;
    time:Date birthDate;
    Gender gender;
    time:Date hireDate;

    string deptNo; // department primary key
    string workspaceId; // workspace primary key
|};

public type Department record {|
    readonly string deptNo;
    string deptName;
|};

public type Building record {|
    readonly string buildingCode;
    string city;
    string state;
    string country;
    string postalCode;
|};

// many-to-many (Department <-> Building) join table.
// we need client resource for the join table to support insert/update/select/delete
// no need separate records for insert and update.
public type DepartmentBuilding record {|
    string deptNo;
    string buildingCode;
|};

public type Salary record {|
    readonly string empNo; // Employee primary key
    int salary;
    readonly time:Date fromDate;
    time:Date toDate;
|};

public type Title record {|
    readonly string empNo;  // Employee primary key
    readonly string title;
    readonly time:Date fromDate;
    time:Date toDate;
|};

type Workspace record {|
    readonly string workspaceId;
    string workspaceType;

    string buildingCode; // Building primary key
|};

// Insert-related generated types ------ start ---------------

// Used to insert a single department
public type DepartmentInsert record {|
    string deptName;
|};

// Used to insert a single employee with a department foreign key
public type EmployeeInsert record {|
    string firstName;
    string lastName;
    time:Date birthDate;
    Gender gender;
    time:Date hireDate;

    // Existing department primary key. department record should exist with deptNo.
    string deptNo;
    // Existing workspace primary key. workspace record should exist with workspaceId.
    string workspaceId;
|};

public type BuildingInsert record {|
    string city;
    string state;
    string country;
    string postalCode;
|};

public type SalaryInsert record {|
    int salary;
    readonly time:Date fromDate;
    time:Date toDate;

    // Existing employee primary key. employee record should exist with empNo.
    string empNo;
|};

public type TitleInsert record {|
    readonly string title;
    readonly time:Date fromDate;
    time:Date toDate;

    // Existing employee primary key. employee record should exist with empNo.
    string empNo;
|};

public type WorkspaceInsert record {|
    string workspaceType;

    // Existing building primary key. building record should exist with buildingCode.
    string buildingCode;
|};

// Insert-related generated types ------ end ---------------

// Update-related generated types
public type DepartmentUpdate record {|
    string deptName?;
|};

public type EmployeeUpdate record {|
    string firstName?;
    string lastName?;
    time:Date birthDate?;
    Gender gender?;
    time:Date hireDate?;

    string deptNo?; // department primary key
    string workspaceId?; // workspace primary key
|};

public type BuildingUpdate record {|
    string city?;
    string state?;
    string country?;
    string postalCode?;
|};

public type SalaryUpdate record {|
    int salary?;
    time:Date toDate?;
|};

public type TitleUpdate record {|
    time:Date toDate?;
|};

type WorkspaceUpdate record {|
    string workspaceType?;

    string buildingCode?; // Building primary key
|};
