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

// Insert-related generated types ------ start ---------------

// Used to insert a single department
// TODO: Add support for inserting a single department with a list of employees
//    i.e. a department with a list of employees ids or a list of employees records 
public type DepartmentInsert record {|
    string deptName;
    EmployeeInsertWithoutDepartment[] employees?;
|};

// Used when creating an Employee with a new Department record
public type DepartmentInsertWithoutEmployees record {|
    string deptName;
|};

// Used to insert a single employee with a department foreign key
// TODO: Add support for inserting a single employee with a department record
public type EmployeeInsert record {|
    string firstName;
    string lastName;
    time:Date birthDate;
    Gender gender;
    time:Date hireDate;

    // Existing department primary key or a new department record
    // TODO: Should we create a record type for the department foreign key?
    string|DepartmentInsertWithoutEmployees department;
    SalaryInsertWithoutEmployee[] salaries?;
    TitleInsertWithoutEmployee[] titles?;
|};

// Used when creating a department with a list of new employees records
public type EmployeeInsertWithoutDepartment record {|
    string firstName;
    string lastName;
    time:Date birthDate;
    Gender gender;
    time:Date hireDate;

    SalaryInsertWithoutEmployee[] salaries?;
    TitleInsertWithoutEmployee[] titles?;
|};

// Used when creating a salary entry with a new employee record
public type EmployeeInsertWithoutSalaries record {|
    string firstName;
    string lastName;
    time:Date birthDate;
    Gender gender;
    time:Date hireDate;

    string|DepartmentInsertWithoutEmployees department;
    TitleInsertWithoutEmployee[] titles?;
|};

public type EmployeeInsertWithoutTitles record {|
    string firstName;
    string lastName;
    time:Date birthDate;
    Gender gender;
    time:Date hireDate;

    string|DepartmentInsertWithoutEmployees department;
    SalaryInsertWithoutEmployee[] salaries?;
|};

public type SalaryInsert record {|
    int salary;
    time:Date fromDate;
    time:Date toDate;

    string|EmployeeInsertWithoutSalaries employee;
|};

public type SalaryInsertWithoutEmployee record {|
    int salary;
    time:Date fromDate;
    time:Date toDate;
|};

public type TitleInsert record {|
    string title;
    time:Date fromDate;
    time:Date toDate;

    string|EmployeeInsertWithoutTitles employee;
|};

public type TitleInsertWithoutEmployee record {|
    string title;
    time:Date fromDate;
    time:Date toDate;
|};

// Insert-related generated types ------ end ---------------

// Update-related generated types
// TODO: Add support for updating a single department with a list of employees
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

public type EmployeeUniqueKey record {|
    string empNo;
|};

public type DepartmentUniqueKey record {|
    string deptNo;
|};

public type TitleUniqueKey readonly & record {|
    string empNo;
    string title;
    time:Date fromDate;
|};

