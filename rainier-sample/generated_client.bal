import ballerina/uuid;
import ballerina/time;

// TODO: Remove "public" from the generated types
// I've added the "public" qualifier to get-rid of the several warnings in the client class
// TODO: Report an issue to the compiler team
public enum Gender {
    M,
    F
}

// Generated model types
public type Employee record {|
    readonly string empNo;
    string firstName;
    string lastName;
    time:Date birthDate;
    Gender gender;
    time:Date hireDate;

    string deptNo; // department primary key
|};

public type Department record {|
    readonly string deptNo;
    string deptName;
|};

// Insert-related generated types
public type DepartmentInsert record {|
    string deptName;
|};

public type EmployeeInsert record {|
    string firstName;
    string lastName;
    time:Date birthDate;
    Gender gender;
    time:Date hireDate;

    string deptNo; // department primary key
|};

// Update-related generated types
public type DepartmentUpdate record {|
    string deptName?;
|};

public type EmployeeUpdate record {|
    string firstName?;
    string lastName?;
    time:Date birthDate?;
    Gender gender?;
    time:Date hireDate?;

    string deptNo?; // department primary key
|};

client class RainierClient {
    private final table<Employee> key(empNo) employees = table [];
    private final table<Department> key(deptNo) departments = table [];

    resource function 'select employees() returns stream<Employee, error?> {
        return self.employees.toArray().toStream();
    }

    resource function insert employees(EmployeeInsert data) returns Employee|error {
        Department? dept = self.departments[data.deptNo];
        if dept is () {
            return error("Insert failed: Department not found", deptNo = data.deptNo);
        }

        Employee employee = {empNo: uuid:createType4AsString(), ...data};
        self.employees.add(employee);
        return employee;
    }

    resource function insertMany employees(EmployeeInsert[] employeeInserts) returns int|error {
        int count = 0;
        foreach EmployeeInsert data in employeeInserts {
            Department? dept = self.departments[data.deptNo];
            if dept is () {
                return error("Insert failed: Department not found", deptNo = data.deptNo);
            }

            Employee employee = {empNo: uuid:createType4AsString(), ...data};
            self.employees.add(employee);
            count += 1;
        }
        return count;
    }

    resource function update employees(string empNo, EmployeeUpdate data) returns Employee|error {
        Employee? employee = self.employees[empNo];
        if employee is () {
            return error("Update failed: Employee not found", empNo = empNo);
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
        if lastName is string  {
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

    resource function delete employees(string empNo) returns Employee|error {
        Employee? employee = self.employees.remove(empNo);
        if employee is Employee {
            return employee;
        } else {
            return error("Delete failed: Employee not found", empNo = empNo);
        }
    }

    // resource function deleteMany employees(){
    // }

    resource function 'select departments() returns stream<Department, error?> {
        return self.departments.toArray().toStream();
    }

    resource function insert departments(DepartmentInsert data) returns Department|error {
        // TODO: validate referential integrity
        Department dept = {deptNo: uuid:createType4AsString(), ...data};
        self.departments.add(dept);
        return dept;
    }

    resource function insertMany departments(DepartmentInsert[] data) returns int|error {
        int count = 0;
        foreach DepartmentInsert deptInsert in data {
            self.departments.add({deptNo: uuid:createType4AsString(), ...deptInsert});
            count += 1;
        }
        return count;
    }


    resource function update departments(string deptNo, DepartmentUpdate data) returns Department|error {
        Department? dept = self.departments[deptNo];
        if dept is () {
            return error("Update failed: Department not found", deptNo = deptNo);
        }

        string? deptName = data.deptName;
        if deptName is string {
            dept.deptName = deptName;
        }
        return dept;
    }

    resource function delete departments(string deptNo) returns Department|error {
        Department? dept = self.departments.remove(deptNo);
        if dept is Department {
            return dept;
        } else {
            return error("Delete failed: Department not found", deptNo = deptNo);
        }
    }
}
