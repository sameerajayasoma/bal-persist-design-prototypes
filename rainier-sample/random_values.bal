import ballerina/random;
import ballerina/time;

function getDepartmentNames() returns string[]|error => ["Finance", "Sales", "Marketing", "Human Resources", "Legal", "Operations", "IT"];

function randomEmployee(string[] depts) returns EmployeeInsert|error => {
    firstName: check randomFirstName(),
    lastName: check randomLastName(),
    birthDate: check randomBirthDate(),
    gender: check randomGender(),
    hireDate: check randomHireDate(),
    deptNo: check randomDepartment(depts)
};

function randomDepartment(string[] departments) returns string|error {
    return departments[check random:createIntInRange(0, departments.length() - 1)];
}

function randomBirthDate() returns time:Date|error => {
    year: check random:createIntInRange(1975, 2002),
    month: check random:createIntInRange(1, 12),
    day: check random:createIntInRange(1, 31)
};

function randomHireDate() returns time:Date|error => {
    year: check random:createIntInRange(2018, 2022),
    month: check random:createIntInRange(1, 12),
    day: check random:createIntInRange(1, 31)
};

function randomGender() returns Gender|error => let int randomInt = check random:createIntInRange(0, 1) in randomInt == 0 ? M : F;

function randomFirstName() returns string|error {
    string[] firstNames = ["Jack", "John", "Jennifer", "Alex", "Jane", "Mary", "Bob", "Mike", "Peter", "Paul"];
    return firstNames[check random:createIntInRange(0, firstNames.length() - 1)];
}

function randomLastName() returns string|error {
    string[] lastNames = ["Smith", "Ryan", "Alex", "Doe", "Williams", "Brown", "Jones", "Miller", "Davis", "Garcia"];
    return lastNames[check random:createIntInRange(0, lastNames.length() - 1)];
}
