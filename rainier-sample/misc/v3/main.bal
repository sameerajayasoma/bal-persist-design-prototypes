import ballerina/time;
import ballerina/uuid;
import ballerina/io;

type EmployeeWithDepartment record {|
    *Employee;
    Department department;
|};

type EmployeeWithSalariesAndTitles record {|
    *Employee;
    Salary[] salaries;
    Title[] titles;
    Workspace workspace;
|};

public function queries() returns error? {
    RainierClient rc = new ();

    string employeeId = "40083df0-5a27-48a9-8e0d-6e70e0d6acbf";
    // Select just the employee 
    Employee? employee = check rc->/employees/[employeeId]();
    io:println(employee);

    // Select employee with department details
    EmployeeWithDepartment? employeeWithDepartment = check rc->/employees/[employeeId]();
    io:println(employeeWithDepartment);

    // Select employee with salaries and titles
    EmployeeWithSalariesAndTitles? employeeWithSalariesAndTitles = check rc->/employees/[employeeId]();
    io:println(employeeWithSalariesAndTitles);

    // Select employee first name, last name and birth date
    record {|
        string firstName;
        string lastName;
        time:Date birthDate;
    |}? empDetails = check rc->/employees/[employeeId]();
    io:println(empDetails);

    // Select all employees in a department
    stream<Employee, error?> empStream = rc->/employees();
    record{string firstName; string lastName;}[] empInDept = check from var emp in empStream
        where emp.deptNo == "d009"
        select { firstName: emp.firstName, lastName: emp.firstName };
    io:println(empInDept);

    // Select all employees male employee with department details
    stream<EmployeeWithDepartment, error?> empDeptStream = rc->/employees();
    EmployeeWithDepartment[] employees = check from var emp in empDeptStream
        where emp.gender == M && emp.birthDate.year > 1995
        select emp;
    io:println("Employees: ", employees);
}

public function inserts() returns error? {
    RainierClient rc = new ();

    // DepartmentInsert dept = ;
    _= check rc->/departments.post([{
        deptName: "Customer Service",
        buildingCodes: []
    }]);

    Employee newEmp = {
        empNo: uuid:createType4AsString(),
        firstName: "Jack",
        lastName: "Ryan",
        birthDate: {year: 1976, month: 4, day: 23},
        gender: M,
        hireDate: {year: 2019, month: 12, day: 23},
        deptNo: dept.deptName,
        workspaceId: "WS-1234"
    };
    _ = check rc->/employees.post([newEmp]);
}

public function updates() returns error? {
    RainierClient rc = new ();

    string employeeId = "40083df0-5a27-48a9-8e0d-6e70e0d6acbf";
    _ = check rc->/employees/[employeeId].put({deptNo: "d010"});
}
