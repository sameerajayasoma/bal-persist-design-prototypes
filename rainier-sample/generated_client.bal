
// We need a similar distinct client class to identity generated client class
// TODO: Move this to bal/persist package
isolated distinct client class PersistClient {
}

isolated client class RainierClient {
    *PersistClient;
    isolated resource function get buildings(BuildingTargetType targetType = <>) returns stream<targetType, error?> = external;
    isolated resource function get buildings/[string buildingCode](BuildingTargetType targetType = <>) returns targetType?|error = external;
    isolated resource function post buildings(BuildingInsert[] data) returns string[]|error = external;
    isolated resource function put buildings/[string buildingCode](BuildingUpdate data) returns Building|error = external;
    isolated resource function delete buildings/[string buildingCode]() returns Building|error = external;

    isolated resource function get departments(DepartmentTargetType targetType = <>) returns stream<targetType, error?> = external;
    isolated resource function get departments/[string deptNo](DepartmentTargetType targetType = <>) returns targetType?|error = external;
    isolated resource function post departments(DepartmentInsert data) returns Department|error = external;
    isolated resource function put departments/[string deptNo](DepartmentUpdate data) returns Department|error = external;
    isolated resource function delete departments/[string deptNo]() returns Department|error = external;

    isolated resource function get workspaces(WorkspaceTargetType targetType = <>) returns stream<targetType, error?> = external;
    isolated resource function get workspaces/[string workspaceId](WorkspaceTargetType targetType = <>) returns targetType?|error = external;
    isolated resource function post workspaces(WorkspaceInsert data) returns Workspace|error = external;
    isolated resource function put workspaces/[string workspaceId](WorkspaceUpdate data) returns Workspace|error = external;
    isolated resource function delete workspaces/[string workspaceId]() returns Workspace|error = external;

    // TODO: Since the following functions have external bodies they have a java implementation. 
    //  The jar file with those java implementations must be delcared in the Ballerina.toml file. (With the current pakcage native library support)
    isolated resource function get employees(EmployeeTargetType targetType = <>) returns stream<targetType, error?> = external;
    isolated resource function get employees/[string empNo](EmployeeTargetType targetType = <>) returns targetType?|error = external;
    isolated resource function post employees(EmployeeInsert data) returns Employee|error = external;
    isolated resource function put employees/[string empNo](EmployeeUpdate data) returns Employee|error = external;
    isolated resource function delete employees/[string empNo]() returns Employee|error = external;
}
