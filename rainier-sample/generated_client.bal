import ballerina/uuid;
import ballerina/time;

client class RainierClient {
    private final table<Employee> key(empNo) employees = table [];
    private final table<Department> key(deptNo) departments = table [];
    private final table<Salary> key(empNo, fromDate) salaries = table [];
    private final table<Title> key(empNo, title, fromDate) titles = table [];

    resource function 'select employees() returns stream<Employee, error?> {
        return self.employees.toArray().toStream();
    }

    resource function insert employees(EmployeeInsert data) returns Employee|error {
        return self.insertEmployee(data);
    }

    resource function insertMany employees(EmployeeInsert[] employeeInserts) returns int|error {
        int count = 0;
        foreach EmployeeInsert data in employeeInserts {
            var _ = check self.insertEmployee(data);
            count += 1;
        }
        return count;
    }

    resource function update employees(EmployeeUniqueKey uniqueKey, EmployeeUpdate data) returns Employee|error {
        Employee? employee = self.employees[uniqueKey.empNo];
        if employee is () {
            return error("Update failed: Employee not found", empNo = uniqueKey.empNo);
        }

        string? deptNo = data.deptNo;
        if deptNo is string {
            Department? dept = self.departments[deptNo];
            if dept is () {
                return error("Update failed: Department not found", deptNo = deptNo);
            }
            employee.deptNo = deptNo;
        }

        string? firstName = data.firstName;
        if firstName is string {
            employee.firstName = firstName;
        }

        string? lastName = data.lastName;
        if lastName is string {
            employee.lastName = lastName;
        }

        time:Date? birthDate = data.birthDate;
        if birthDate is time:Date {
            employee.birthDate = birthDate;
        }

        Gender? gender = data.gender;
        if gender is Gender {
            employee.gender = gender;
        }

        time:Date? hireDate = data.hireDate;
        if hireDate is time:Date {
            employee.hireDate = hireDate;
        }

        return employee;
    }

    // resource function updateMany employees(){
    // }

    resource function delete employees(EmployeeUniqueKey uniqueKey) returns Employee|error {
        Employee? employee = self.employees.remove(uniqueKey.empNo);
        if employee is Employee {
            return employee;
        } else {
            return error("Delete failed: Employee not found", empNo = uniqueKey.empNo);
        }
    }

    // resource function deleteMany employees(){
    // }

    resource function 'select departments() returns stream<Department, error?> {
        return self.departments.toArray().toStream();
    }

    resource function insert departments(DepartmentInsert data) returns Department|error {
        // TODO: validate referential integrity
        Department dept = {deptNo: uuid:createType4AsString(), deptName: data.deptName};
        self.departments.add(dept);

        // TODO: insert employees if any
        return dept;
    }

    resource function insertMany departments(DepartmentInsert[] data) returns int|error {
        int count = 0;
        foreach DepartmentInsert deptInsert in data {
            self.departments.add({deptNo: uuid:createType4AsString(), deptName: deptInsert.deptName});
            count += 1;
        }
        return count;
    }

    // There can be more than one way to uniquely identify a department, hence the where clause to identify the department
    // resource function update departments(DepartmentUnique where, DepartmentUpdate data) returns Department|error {
    resource function update departments(DepartmentUniqueKey uniqueKey, DepartmentUpdate data) returns Department|error {
        Department? dept = self.departments[uniqueKey.deptNo];
        if dept is () {
            return error("Update failed: Department not found", deptNo = uniqueKey.deptNo);
        }

        string? deptName = data.deptName;
        if deptName is string {
            dept.deptName = deptName;
        }
        return dept;
    }

    // Think of a better name of the uniqueKey param name
    resource function delete departments(DepartmentUniqueKey uniqueKey) returns Department|error {
        Department? dept = self.departments.remove(uniqueKey.deptNo);
        if dept is Department {
            return dept;
        } else {
            return error("Delete failed: Department not found", deptNo = uniqueKey.deptNo);
        }
    }

    resource function 'select salaries() returns stream<Salary, error?> {
        return self.salaries.toArray().toStream();
    }

    resource function insert salaries(SalaryInsert data) returns Salary|error {
        string empNo;
        string|EmployeeInsertWithoutSalaries employee = data.employee;
        if employee is string {
            empNo = employee;
            if !self.employees.hasKey(empNo) {
                return error("Insert failed: Employee not found", empNo = empNo);
            }
        } else {
            Employee emp = check self.insertEmployee(employee);
            empNo = emp.empNo;
        }

        Salary salary = {empNo: empNo, salary: data.salary, fromDate: data.fromDate.cloneReadOnly(), toDate: data.toDate};
        self.salaries.add(salary);
        return salary;
    }

    resource function update salaries(SalaryUniqueKey uniqueKey, SalaryUpdate data) returns Salary|error {
        Salary? salary = self.salaries[uniqueKey.empNo, uniqueKey.fromDate];
        if salary is () {
            return error("Update failed: Salary not found", empNo = uniqueKey.empNo);
        }

        int? salaryValue = data.salary;
        if salaryValue is int {
            salary.salary = salaryValue;
        }

        time:Date? toDate = data.toDate;
        if toDate is time:Date {
            salary.toDate = toDate;
        }

        return salary;
    }

    resource function delete salaries(SalaryUniqueKey uniqueKey) returns Salary|error {
        Salary? salary = self.salaries.remove([uniqueKey.empNo, uniqueKey.fromDate]);
        if salary is Salary {
            return salary;
        } else {
            return error("Delete failed: Salary not found", salaryKey = uniqueKey);
        }
    }

    resource function 'select titles() returns stream<Title, error?> {
        return self.titles.toArray().toStream();
    }

    resource function insert titles(TitleInsert data) returns Title|error {
        string empNo;
        string|EmployeeInsertWithoutTitles employee = data.employee;
        if employee is string {
            empNo = employee;
            if !self.employees.hasKey(empNo) {
                return error("Insert failed: Employee not found", empNo = empNo);
            }
        } else {
            Employee emp = check self.insertEmployee(employee);
            empNo = emp.empNo;
        }

        Title title = {empNo: empNo, title: data.title, fromDate: data.fromDate.cloneReadOnly(), toDate: data.toDate};
        self.titles.add(title);
        return title;
    }

    resource function update titles(TitleUniqueKey uniqueKey, TitleUpdate data) returns Title|error {
        Title? title = self.titles[uniqueKey.empNo, uniqueKey.title, uniqueKey.fromDate];
        if title is () {
            return error("Update failed: Title not found", empNo = uniqueKey.empNo);
        }
        time:Date? toDate = data.toDate;
        if toDate is time:Date {
            title.toDate = toDate;
        }

        return title;
    }

    // Define type for the uniqueKey param type
    resource function delete titles(TitleUniqueKey uniqueKey) returns Title|error {
        Title? title = self.titles.remove([uniqueKey.empNo, uniqueKey.title, uniqueKey.fromDate]);
        if title is Title {
            return title;
        } else {
            return error("Delete failed: Title not found", titleKey = uniqueKey);
        }
    }

    private function insertEmployee(EmployeeInsert data) returns Employee|error {
        string deptNo;
        string|DepartmentInsertWithoutEmployees department = data.department;
        if department is string {
            deptNo = department;
            Department? dept = self.departments[department];
            if dept is () {
                return error("Insert failed: Department not found", deptNo = department);
            }

        } else {
            DepartmentInsertWithoutEmployees deptInsert = department;
            Department dept = {deptNo: uuid:createType4AsString(), ...deptInsert};
            self.departments.add(dept);
            deptNo = dept.deptNo;
        }

        Employee employee = {
            empNo: uuid:createType4AsString(),
            firstName: data.firstName,
            lastName: data.lastName,
            birthDate: data.birthDate,
            gender: data.gender,
            hireDate: data.hireDate,
            deptNo: deptNo
        };
        self.employees.add(employee);
        return employee;
    }
}
