import ballerina/uuid;
import ballerina/time;

enum Gender {
    M,
    F
}

type Department record {|
    readonly string deptNo = uuid:createType4AsString();
    string deptName;

    // One-to-many relationship
    @persist:Relation{name:"dept_emp"}
    Employee[] employees?;
|};

table<Department> key(deptNo) departments = table []; 

type Employee record {|
    readonly string empNo = uuid:createType4AsString();
    string firstName;
    string lastName;
    time:Date birthDate;
    Gender gender;
    time:Date hireDate;

    @persist:Relation{name:"dept_emp", fields:["deptNo"]}
    Department department?;
    string deptNo;
|};

table<Employee> key(empNo) employees = table[]; 