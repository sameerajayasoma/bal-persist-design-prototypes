import ballerina/uuid;
import ballerina/io;

public function queries() returns error? {
    RainierClient rc = new ();

    string employeeId = "40083df0-5a27-48a9-8e0d-6e70e0d6acbf";
    // Select just the employee 
    Employee? employee = check rc->/employees/[employeeId]();
    io:println(employee);

    // Select all employees in a department
    stream<Employee, error?> empStream = rc->/employees();
    record {string firstName; string lastName;}[] empInDept = check from var emp in empStream
        where emp.deptNo == "d009"
        select {firstName: emp.firstName, lastName: emp.firstName};
    io:println(empInDept);
}

public function inserts() returns error? {
    RainierClient rc = new ();

    // DepartmentInsert dept = ;
    Department dept = check rc->/departments.post({
        deptNo: "d010",
        deptName: "Customer Service"
    });

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
    Employee emp = check rc->/employees.post(newEmp);
    io:println(emp);
}

public function updates() returns error? {
    RainierClient rc = new ();

    string employeeId = "40083df0-5a27-48a9-8e0d-6e70e0d6acbf";
    _ = check rc->/employees/[employeeId].put({deptNo: "d010"});
}
