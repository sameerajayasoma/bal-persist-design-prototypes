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

public type Department record {|  //Relation owner (Department <-> Employee)
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
// TODO: Add support for inserting a single department with a list of employees
//    i.e. a department with a list of employees ids or a list of employees records 
public type DepartmentInsert record {|
    string deptName;
    EmployeeInsertWithoutDepartment[] employees?;

    BuildingInsertWithoutDepartment[] buildings?;
|};

public type DepartmentInsertWithoutBuildings record {|
    string deptName;
    EmployeeInsertWithoutDepartment[] employees?;
|};

public type WorkspaceInsertWithoutBuildings record {|
    string workspaceType;
|};

public type BuildingInsert record {|
    readonly string buildingCode;
    string city;
    string state;
    string country;
    string postalCode;

    WorkspaceInsertWithoutBuildings[] workspaces?;
    DepartmentInsertWithoutBuildings[] departments?;
|};

public type BuildingInsertWithoutDepartment record {|
    readonly string buildingCode;
    string city;
    string state;
    string country;
    string postalCode;
|};

// Used to insert a single employee with a department foreign key
// TODO: Add support for inserting a single employee with a department record
public type EmployeeInsert record {|
    string firstName;
    string lastName;
    time:Date birthDate;
    Gender gender;
    time:Date hireDate;

    // Always provide an existing department key. can't create because employee not the owner.
    string department;
    // Always provide an existing workspace key. can't create because employee not the owner.
    string workspaceId;
    SalaryInsertWithoutEmployee[] salaries?;
    TitleInsertWithoutEmployee[] titles?;
|};

// Used when creating a department with a list of new employees records
public type EmployeeInsertWithoutDepartment record {|
    string firstName;
    string lastName;
    time:Date birthDate;
    Gender gender;
    time:Date hireDate;

    // Always provide an existing workspace key. can't create because employee not the owner.
    string workspaceId;

    SalaryInsertWithoutEmployee[] salaries?;
    TitleInsertWithoutEmployee[] titles?;
|};

public type EmployeeInsertWithoutWorkspace record {|
    string firstName;
    string lastName;
    time:Date birthDate;
    Gender gender;
    time:Date hireDate;

    SalaryInsertWithoutEmployee[] salaries?;
    TitleInsertWithoutEmployee[] titles?;
|};


public type SalaryInsert record {|
    int salary;
    time:Date fromDate;
    time:Date toDate;
    // Always provide an existing employee key. can't create because salary not the owner.
    string empNo;
|};

public type SalaryInsertWithoutEmployee record {|
    int salary;
    time:Date fromDate;
    time:Date toDate;
|};

public type TitleInsert record {|
    string title;
    time:Date fromDate;
    time:Date toDate;

    // Always provide an existing employee key. can't create because title not the owner.
    string empNo;
|};

public type TitleInsertWithoutEmployee record {|
    string title;
    time:Date fromDate;
    time:Date toDate;
|};

public type WorkspaceInsert record {|
    string workspaceType;

    // Existing building primary key. building record should exist with buildingCode.
    string buildingCode;

    EmployeeInsertWithoutWorkspace employee;
|};



// Insert-related generated types ------ end ---------------

// Update-related generated types
// TODO: Add support for updating a single department with a list of employees
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
|};

public type SalaryUpdate record {|
    int salary?;
    time:Date toDate?;
|};

public type TitleUpdate record {|
    time:Date toDate?;
|};

public type EmployeeUniqueKey readonly & record {|
    string empNo;
|};

public type DepartmentUniqueKey readonly & record {|
    string deptNo;
|};

public type BuildingUniqueKey readonly & record {|
    string buildingCode;
|};

public type SalaryUniqueKey readonly & record {|
    string empNo;
    time:Date fromDate;
|};

public type TitleUniqueKey readonly & record {|
    string empNo;
    string title;
    time:Date fromDate;
|};

public type WorkspaceUniqueKey readonly & record {|
    string workspaceId;
|};
