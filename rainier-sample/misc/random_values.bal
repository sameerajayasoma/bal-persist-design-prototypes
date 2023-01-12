import ballerina/random;
import ballerina/time;

string[] cities = ["New York", "Los Angeles", "Chicago", "Houston", "Philadelphia", "Phoenix", "San Antonio", "San Diego", "Dallas", "San Jose"];
string[] countries = ["USA", "USA", "USA", "USA", "USA", "USA", "USA", "USA", "USA", "USA"];
string[] states = ["NY", "CA", "TX", "FL", "IL", "PA", "OH", "GA", "NC", "MI"];
string[] postalCodes = ["10001", "10002", "10003", "10004", "10005", "10006", "10007", "10008", "10009", "10010"];

function randomCity() returns string|error {
    return cities[check random:createIntInRange(0, cities.length() - 1)];
}

function randomCountry() returns string|error {
    return countries[check random:createIntInRange(0, countries.length() - 1)];
}

function randomState() returns string|error {
    return states[check random:createIntInRange(0, states.length() - 1)];
}

function randomPostalCode() returns string|error {
    return postalCodes[check random:createIntInRange(0, postalCodes.length() - 1)];
}

function randomBuilding() returns BuildingInsert|error => {
    city: check randomCity(),
    country: check randomCountry(),
    state: check randomState(),
    postalCode: check randomPostalCode()
};

function getDepartmentNames() returns string[]|error => ["Finance", "Sales", "Marketing", "Human Resources", "Legal", "Operations", "IT"];

function randomEmployee(string[] depts) returns EmployeeInsert|error => {
    firstName: check randomFirstName(),
    lastName: check randomLastName(),
    birthDate: check randomBirthDate(),
    gender: check randomGender(),
    hireDate: check randomHireDate(),
    department: check randomDepartment(depts),
    workspace: {workspaceId: "WS-1"}
};

function randomDepartment(string[] departments) returns DepartmentInsertWithoutEmployees|error {
    return {deptName: departments[check random:createIntInRange(0, departments.length() - 1)] };
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
