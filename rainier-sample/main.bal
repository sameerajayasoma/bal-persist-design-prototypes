import ballerina/io;

public function main() returns error? {
    RainierClient rainier = new ();

    // Inserts
    Department engeeringDept = check rainier->/departments.insert({deptName: "Engineering"});
    io:println("Inserted department: ", engeeringDept);

    // Inserting an employee with a reference to the deptNo 
    // Inserting an employee with a non-existing department is not yet supported.
    // Similarly, inserting a department with references to non-existing employees is not yet supported.
    _ = check rainier->/employees.insert({
        firstName: "Jack",
        lastName: "Ryan",
        birthDate: {year: 1976, month: 4, day: 23},
        gender: M,
        hireDate: {year: 2019, month: 12, day: 23},
        department: engeeringDept.deptNo
    });

    // Insert many 
    string[] departmentNames = check getDepartmentNames();
    DepartmentInsert[] deptInserts = from string deptName in departmentNames
        select {deptName: deptName};

    int count = check rainier->/departments.insertMany(deptInserts);
    io:println(string `Inserted ${count} departments`);

    // Projection
    string[] deptNos = check from var dept in rainier->/departments.'select()
        select dept.deptNo;

    // Inserting 100 employees
    EmployeeInsert[] empInserts = from var _ in 1 ... 100
        select check randomEmployee(deptNos);
    count = check rainier->/employees.insertMany(empInserts);
    io:println(string `Inserted ${count} employees`);

    // Select
    Department[] departments = check from var dept in rainier->/departments.'select()
        select dept;
    io:println("Departments: ", departments);

    Employee[] employees = check from var emp in rainier->/employees.'select()
        where emp.gender == M && emp.birthDate.year > 1995
        select emp;
    io:println("Employees: ", employees);

    if employees.length() > 0 {
        // Update
        Employee emp = employees[0];
        Employee updatedEmp = check rainier->/employees.update(uniqueKey = {empNo: emp.empNo}, data = {lastName: "Doe"});
        io:println("Updated employee: ", updatedEmp);

        // Delete
        Employee deletedEmp = check rainier->/employees.delete(uniqueKey = {empNo: emp.empNo});
        io:println("Deleted employee: ", deletedEmp);
    }
}
