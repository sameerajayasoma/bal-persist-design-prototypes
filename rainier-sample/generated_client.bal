
isolated client class RainierClient {
    // Do we need these actions? selectFirst, selectLast, selectCount, selectDistinct
    isolated resource function selectMany buildings(BuildingTargetType targetType = <>) returns stream<targetType, error?> = external;
    isolated resource function selectUnique buildings(BuildingUniqueKey key, BuildingTargetType targetType = <>) returns targetType?|error = external;
    // We can use the above technique in following functions as well
    //     resource function insert buildings(BuildingInsert data, BuildingTargetType targetType = <>) returns targetType|error = external;
    isolated resource function insert buildings(BuildingInsert data) returns Building|error = external;
    isolated resource function insertMany buildings(BuildingInsert[] data) returns int|error = external;
    isolated resource function update buildings(BuildingUniqueKey uniqueKey, BuildingUpdate data) returns Building|error = external;
    isolated resource function delete buildings(BuildingUniqueKey uniqueKey) returns Building|error = external;

    isolated resource function selectMany departments(DepartmentTargetType targetType = <>) returns stream<targetType, error?>  = external;
    isolated resource function selectUnique departments(DepartmentUniqueKey key, DepartmentTargetType targetType = <>) returns targetType?|error = external;
    isolated resource function insert departments(DepartmentInsert data) returns Department|error = external;
    isolated resource function insertMany departments(DepartmentInsert[] data) returns int|error = external;
    // There can be more than one way to uniquely identify a department, hence the where clause to identify the department
    // resource function update departments(DepartmentUnique where, DepartmentUpdate data) returns Department|error {
    isolated resource function update departments(DepartmentUniqueKey uniqueKey, DepartmentUpdate data) returns Department|error = external;
    // Think of a better name for the uniqueKey parameter
    isolated resource function delete departments(DepartmentUniqueKey uniqueKey) returns Department|error = external;

    isolated resource function selectMany employees(EmployeeTargetType targetType = <>) returns stream<targetType, error?>  = external;
    isolated resource function selectUnique employees(EmployeeUniqueKey uniqueKey, EmployeeTargetType targetType = <>) returns targetType?|error = external;
    isolated resource function insert employees(EmployeeInsert data) returns Employee|error = external;
    isolated resource function insertMany employees(EmployeeInsert[] employeeInserts) returns int|error = external;
    isolated resource function update employees(EmployeeUniqueKey uniqueKey, EmployeeUpdate data) returns Employee|error = external;
    // TODO: resource function updateMany employees()
    isolated resource function delete employees(EmployeeUniqueKey uniqueKey) returns Employee|error = external;
    // TODO: resource function deleteMany employees(){

    isolated resource function selectMany salaries(SalaryTargetType targetType = <>) returns stream<targetType, error?> = external;
    isolated resource function selectUnique salaries(SalaryUniqueKey uniqueKey, SalaryTargetType targetType = <>) returns targetType?|error = external;
    isolated resource function insert salaries(SalaryInsert data) returns Salary|error = external;
    isolated resource function insertMany salaries(SalaryInsert[] data) returns int|error = external;
    isolated resource function update salaries(SalaryUniqueKey uniqueKey, SalaryUpdate data) returns Salary|error = external;
    isolated resource function delete salaries(SalaryUniqueKey uniqueKey) returns Salary|error = external;

    isolated resource function selectMany titles(TitleTargetType targetType = <>) returns stream<targetType, error?>  = external;
    isolated resource function selectUnique titles(TitleUniqueKey uniqueKey, TitleTargetType targetType = <>) returns targetType?|error = external;
    isolated resource function insert titles(TitleInsert data) returns Title|error = external;
    isolated resource function insertMany titles(TitleInsert[] data) returns int|error = external;
    isolated resource function update titles(TitleUniqueKey uniqueKey, TitleUpdate data) returns Title|error = external;
    isolated resource function delete titles(TitleUniqueKey uniqueKey) returns Title|error = external;

    isolated resource function selectMany workspaces(WorkspaceTargetType targetType = <>) returns stream<targetType, error?>  = external;
    isolated resource function selectUnique workspaces(WorkspaceUniqueKey uniqueKey, WorkspaceTargetType targetType = <>) returns targetType?|error = external;
    isolated resource function insert workspaces(WorkspaceInsert data) returns Workspace|error = external;
    isolated resource function insertMany workspaces(WorkspaceInsert[] data) returns int|error = external;
    isolated resource function update workspaces(WorkspaceUniqueKey uniqueKey, WorkspaceUpdate data) returns Workspace|error = external;
    isolated resource function delete workspaces(WorkspaceUniqueKey uniqueKey) returns Workspace|error = external;
}
