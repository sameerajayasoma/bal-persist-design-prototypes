import ballerina/time;

// TODO: Remove "public" from the generated types
// I've added the "public" qualifier to get-rid of the several warnings in the client class
public enum Gender {
    M,
    F
}

// Generated model types
// TODO: Make all these model types readonly
//  I didn't make them readonly because of the following issue TODO: Add issue link
public type Building readonly & record {|
    readonly string buildingCode;
    string city;
    string state;
    string country;
    string postalCode;
|};

public type Workspace record {|
    readonly string workspaceId;
    string workspaceType;
|};

public type Department record {|
    readonly string deptNo;
    string deptName;
|};

public type Employee record {|
    readonly string empNo;
    string firstName;
    string lastName;
    time:Date birthDate;
    Gender gender;
    time:Date hireDate;

    string deptNo;
    string workspaceId;
|};

public type Salary record {|
    readonly string empNo;
    int salary;
    readonly time:Date fromDate;
    time:Date toDate;
|};

public type Title record {|
    readonly string empNo;
    readonly string title;
    readonly time:Date fromDate;
    time:Date toDate;
|};


// Insert-related generated types ------ start ---------------
public type BuildingInsert record {|
    string city;
    string state;
    string country;
    string postalCode;

    // TODO: Following two record types can be ambiguous in some cases. Need to fix this.
    (DepartmentUniqueKey|DepartmentInsertWithoutBuilding)[] departments?;
    WorkspaceInsertWithoutBuilding[] workspaces?;
|};

public type BuildingInsertWithoutDepartments record {|
    string city;
    string state;
    string country;
    string postalCode;

    WorkspaceInsertWithoutBuilding[] workspaces?;
|};

public type WorkspaceInsert record {|
    string workspaceType;

    string buildingCode;
    EmployeeInsertWithoutWorkspace employee?;
|};

public type WorkspaceInsertWithoutBuilding record {|
    string workspaceType;

    EmployeeInsertWithoutWorkspace employee?;
|};

public type DepartmentInsert record {|
    string deptName;
    EmployeeInsertWithoutDepartment[] employees?;
    // TODO: Following two record types can be ambiguous in some cases. Need to fix this.
    (BuildingUniqueKey|BuildingInsertWithoutDepartments)[] buildings?;
|};

public type DepartmentInsertWithoutBuilding record {|
    string deptName;
    EmployeeInsertWithoutDepartment[] employees?;
|};

public type EmployeeInsert record {|
    string firstName;
    string lastName;
    time:Date birthDate;
    Gender gender;
    time:Date hireDate;

    string deptNo;
    string workspaceId;

    SalaryInsertWithoutEmployee[] salaries?;
    TitleInsertWithoutEmployee[] titles?;
|};


public type EmployeeInsertWithoutDepartment record {|
    string firstName;
    string lastName;
    time:Date birthDate;
    Gender gender;
    time:Date hireDate;

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

    string deptNo;

    SalaryInsertWithoutEmployee[] salaries?;
    TitleInsertWithoutEmployee[] titles?;
|};

public type SalaryInsert record {|
    string empNo;
    int salary;
    time:Date fromDate;
    time:Date toDate;
|};

public type SalaryInsertWithoutEmployee record {|
    int salary;
    time:Date fromDate;
    time:Date toDate;
|};

public type TitleInsert record {|
    string empNo;
    string title;
    time:Date fromDate;
    time:Date toDate;
|};

public type TitleInsertWithoutEmployee record {|
    string title;
    time:Date fromDate;
    time:Date toDate;
|};

// Insert-related generated types ------ end ---------------

// Update-related generated types
// TODO: Add support for updating a single department with a list of employees
public type BuildingUpdate record {|
    string city?;
    string state?;
    string country?;
    string postalCode?;
|};

public type WorkspaceUpdate record {|
    string workspaceType?;

    string buildingCode?;
|};

public type DepartmentUpdate record {|
    string deptName?;
|};

public type EmployeeUpdate record {|
    string firstName?;
    string lastName?;
    time:Date birthDate?;
    Gender gender?;
    time:Date hireDate?;

    string deptNo?; 
    string workspaceId?;
|};

public type SalaryUpdate record {|
    int salary?;
    time:Date toDate?;
|};

public type TitleUpdate record {|
    time:Date toDate?;
|};


public type BuildingUniqueKey readonly & record {|
    string buildingCode;
|};

public type DepartmentUniqueKey readonly & record {|
    string deptNo;
|};

public type EmployeeUniqueKey readonly & record {|
    string empNo;
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

// Scratch area

public type BuildingTargetType typedesc<BuildingWithRelations>;

public type BuildingWithRelations record {|
    readonly string buildingCode?;
    string city?;
    string state?;
    string country?;
    string postalCode?;

    DepartmentSelect[] departments?;
    WorkspaceSelect[] workspaces?;
|};

public type DepartmentTargetType typedesc<DepartmentWithRelations>;

public type DepartmentWithRelations record {|
    readonly string deptNo?;
    string deptName?;

    string buildingCode?;

    EmployeeSelect[] employees?;
    BuildingSelect[] buildings?;
|};

public type EmployeeTargetType typedesc<EmployeeWithRelations>;

public type EmployeeWithRelations record {|
    readonly string empNo;
    string firstName;
    string lastName;
    time:Date birthDate;
    Gender gender;
    time:Date hireDate;

    string deptNo;
    string workspaceId;

    DepartmentSelect department?;
    SalarySelect[] salaries?;
    TitleSelect[] titles?;
    WorkspaceSelect workspace?;
|};

public type TitleTargetType typedesc<TitleWithRelations>;

public type TitleWithRelations record {|
    readonly string empNo?;
    readonly string title?;
    readonly time:Date fromDate?;
    time:Date toDate?;

    EmployeeSelect employee?;
|};

public type SalaryTargetType typedesc<SalaryWithRelations>;

public type SalaryWithRelations record {|
    readonly string empNo?;
    int salary?;
    readonly time:Date fromDate?;
    time:Date toDate?;

    EmployeeSelect employee?;
|};

public type WorkspaceTargetType typedesc<WorkspaceWithRelations>;

public type WorkspaceWithRelations record {|
    readonly string workspaceId?;
    string workspaceType?;

    BuildingSelect building?;
    EmployeeSelect employee?;
|};

public type BuildingSelect record {|
    // *Building?
    readonly string buildingCode?;
    string city?;
    string state?;
    string country?;
    string postalCode?;
|};

public type WorkspaceSelect record {|
    readonly string workspaceId?;
    string workspaceType?;

    string buildingCode?;
|};

public type EmployeeSelect record {|
    readonly string empNo?;
    string firstName?;
    string lastName?;
    time:Date birthDate?;
    Gender gender?;
    time:Date hireDate?;

    string deptNo?;
    string workspaceId?;
|};

public type DepartmentSelect record {|
    readonly string deptNo?;
    string deptName?;

    string buildingCode?;
|};

public type TitleSelect record {|
    readonly string empNo?;
    readonly string title?;
    readonly time:Date fromDate?;
    time:Date toDate?;
|};

public type SalarySelect record {|
    readonly string empNo?;
    int salary?;
    readonly time:Date fromDate?;
    time:Date toDate?;
|};

