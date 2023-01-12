import ballerina/uuid;
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

    string[] deptNos;
|};

public type Department record {|
    readonly string deptNo;
    string deptName;

    string[] buildingCodes;
|};

public type DepartmentInsert record {|
    readonly string deptNo = uuid:createType4AsString();
    string deptName;

    string[] buildingCodes;
|};

public type DepartmentsInBuildings record {|
    readonly string deptNo;
    readonly string buildingCode;
|};

public type Workspace record {|
    readonly string workspaceId;
    string workspaceType;

    string buildingCode;
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

// Suggestion from James
// public type Employee record {|
//     readonly string empNo;
//     string firstName;
//     string lastName;
//     time:Date birthDate;
//     Gender gender;
//     time:Date hireDate;

//     Department|ProxyDepartment department = PROXY;
//     Workspace|ProxyWorkspace workspace = PROXY;
// |};

// type ProxyDepartment object {
//     function get() returns Department|error;
// }

// type ResolvedEmployee Employee & anydata;


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

// Update-related generated types
public type BuildingUpdate record {|
    string city?;
    string state?;
    string country?;
    string postalCode?;

    string[] deptNos?; 
|};

public type DepartmentUpdate record {|
    string deptName?;

    string[] buildingCodes?;
|};

public type WorkspaceUpdate record {|
    string workspaceType?;
    string buildingCode?;
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



public type BuildingTargetType typedesc<BuildingWithRelations>;

public type BuildingWithRelations record {|
    readonly string buildingCode?;
    string city?;
    string state?;
    string country?;
    string postalCode?;

    DepartmentOptionalized[] departments?;
    WorkspaceOptionalized[] workspaces?;
|};

public type DepartmentTargetType typedesc<DepartmentWithRelations>;

public type DepartmentWithRelations record {|
    readonly string deptNo?;
    string deptName?;

    string buildingCode?;

    EmployeeOptionalized[] employees?;
    BuildingOptionalized[] buildings?;
|};

public type EmployeeTargetType typedesc<EmployeeWithRelations>;

public type EmployeeWithRelations record {|
    readonly string empNo?;
    string firstName?;
    string lastName?;
    time:Date birthDate?;
    Gender gender?;
    time:Date hireDate?;

    string deptNo?;
    string workspaceId?;

    DepartmentOptionalized department?;
    SalaryOptionalized[] salaries?;
    TitleOptionalized[] titles?;
    WorkspaceOptionalized workspace?;
|};

public type TitleTargetType typedesc<TitleWithRelations>;

public type TitleWithRelations record {|
    readonly string empNo?;
    readonly string title?;
    readonly time:Date fromDate?;
    time:Date toDate?;

    EmployeeOptionalized employee?;
|};

public type SalaryTargetType typedesc<SalaryWithRelations>;

public type SalaryWithRelations record {|
    readonly string empNo?;
    int salary?;
    readonly time:Date fromDate?;
    time:Date toDate?;

    EmployeeOptionalized employee?;
|};

public type WorkspaceTargetType typedesc<WorkspaceWithRelations>;

public type WorkspaceWithRelations record {|
    readonly string workspaceId?;
    string workspaceType?;

    BuildingOptionalized building?;
    EmployeeOptionalized employee?;
|};

public type BuildingOptionalized record {|
    // *Building?
    readonly string buildingCode?;
    string city?;
    string state?;
    string country?;
    string postalCode?;
|};

public type WorkspaceOptionalized record {|
    readonly string workspaceId?;
    string workspaceType?;

    string buildingCode?;
|};

public type EmployeeOptionalized record {|
    readonly string empNo?;
    string firstName?;
    string lastName?;
    time:Date birthDate?;
    Gender gender?;
    time:Date hireDate?;

    string deptNo?;
    string workspaceId?;
|};

public type DepartmentOptionalized record {|
    readonly string deptNo?;
    string deptName?;

    string buildingCode?;
|};

public type TitleOptionalized record {|
    readonly string empNo?;
    readonly string title?;
    readonly time:Date fromDate?;
    time:Date toDate?;
|};

public type SalaryOptionalized record {|
    readonly string empNo?;
    int salary?;
    readonly time:Date fromDate?;
    time:Date toDate?;
|};


public type BuildingRef readonly & record {|
    string buildingCode;
|};

public type DepartmentRef readonly & record {|
    string deptNo;
|};

public type DepartmentsInBuildingsRef readonly & record {|
    string deptNo;
    string buildingCode;
    time:Date fromDate;
|};

public type WorkspaceRef readonly & record {|
    string workspaceId;
|};

public type EmployeeRef readonly & record {|
    string empNo;
|};

public type SalaryRef readonly & record {|
    string empNo;
    time:Date fromDate;
|};

public type TitleRef readonly & record {|
    string empNo;
    string title;
    time:Date fromDate;
|};


