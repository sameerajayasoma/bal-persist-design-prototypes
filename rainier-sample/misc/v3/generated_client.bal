import ballerina/http;

isolated client class RainierClient {
    isolated resource function get buildings(BuildingTargetType targetType = <>) returns stream<targetType, error?> = external;
    // TODO: How to handle the cases with composite keys? e.g. time:Date
    isolated resource function get buildings/[string buildingCode](BuildingTargetType targetType = <>) returns targetType?|error = external;
    // Inserting one employee vs multiple employees?
    isolated resource function post buildings(Building[] data) returns int|error = external;
    // isolated resource function post buildings/[string buildingCode](Building data) returns Building|error = external;

    isolated resource function put buildings/[string buildingCode](BuildingUpdate data) returns Building|error = external;
    isolated resource function put buildings(BuildingUpdate[] data) returns int|error = external;
    isolated resource function delete buildings/[string buildingCode]() returns Building|error = external;

    isolated resource function get departments(DepartmentTargetType targetType = <>) returns stream<targetType, error?> = external;
    // TODO: How to handle the cases with composite keys? e.g. time:Date
    isolated resource function get departments/[string deptNo](DepartmentTargetType targetType = <>) returns targetType?|error = external;
    isolated resource function post departments(DepartmentInsert[] data) returns int|error = external;
    isolated resource function put departments/[string deptNo](DepartmentUpdate data) returns Department|error = external;
    isolated resource function delete departments/[string deptNo]() returns Department|error = external;

    isolated resource function get employees(EmployeeTargetType targetType = <>) returns stream<targetType, error?> = external;
    // TODO: How to handle the cases with composite keys? e.g. time:Date
    isolated resource function get employees/[string empNo](EmployeeTargetType targetType = <>) returns targetType?|error = external;
    isolated resource function post employees(Employee[] data) returns int|error = external;
    isolated resource function put employees/[string empNo](EmployeeUpdate data) returns Employee|error = external;
    isolated resource function delete employees/[string empNo]() returns Employee|error = external;



    // isolated resource function selectMany employees(EmployeeTargetType targetType = <>) returns stream<targetType, error?>  = external;
    // isolated resource function selectUnique employees(EmployeeUniqueKey uniqueKey, EmployeeTargetType targetType = <>) returns targetType?|error = external;
    // isolated resource function insert employees(EmployeeInsert data) returns Employee|error = external;
    // isolated resource function insertMany employees(EmployeeInsert[] employeeInserts) returns int|error = external;
    // isolated resource function update employees(EmployeeUniqueKey uniqueKey, EmployeeUpdate data) returns Employee|error = external;
    // // TODO: resource function updateMany employees()
    // isolated resource function delete employees(EmployeeUniqueKey uniqueKey) returns Employee|error = external;
    // // TODO: resource function deleteMany employees(){
}
