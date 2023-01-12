
isolated client class RainierClient {
    isolated resource function get buildings() returns stream<Building, error?> = external;
    isolated resource function get buildings/[string buildingCode]() returns Building?|error = external;
    isolated resource function post buildings(BuildingInsert data) returns Building|error = external;
    isolated resource function put buildings/[string buildingCode](BuildingUpdate data) returns Building|error = external;
    isolated resource function delete buildings/[string buildingCode]() returns Building|error = external;

    isolated resource function get departments() returns stream<Department, error?> = external;
    isolated resource function get departments/[string deptNo]() returns Department?|error = external;
    isolated resource function post departments(DepartmentInsert data) returns Department|error = external;
    isolated resource function put departments/[string deptNo](DepartmentUpdate data) returns Department|error = external;
    isolated resource function delete departments/[string deptNo]() returns Department|error = external;

    isolated resource function get workspaces() returns stream<Workspace, error?> = external;
    isolated resource function get workspaces/[string workspaceId]() returns Workspace?|error = external;
    isolated resource function post workspaces(WorkspaceInsert data) returns Workspace|error = external;
    isolated resource function put workspaces/[string workspaceId](WorkspaceUpdate data) returns Workspace|error = external;
    isolated resource function delete workspaces/[string workspaceId]() returns Workspace|error = external;

    isolated resource function get employees() returns stream<Employee, error?> = external;
    isolated resource function get employees/[string empNo]() returns Employee?|error = external;
    isolated resource function post employees(EmployeeInsert data) returns Employee|error = external;
    isolated resource function put employees/[string empNo](EmployeeUpdate data) returns Employee|error = external;
    isolated resource function delete employees/[string empNo]() returns Employee|error = external;
}
