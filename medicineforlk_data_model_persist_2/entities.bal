import ballerina/time;
import medicineforlk_data_model_persist_2.persist;

public enum MedicalItemType {
    DEVICE = "Device",
    MEDICINE = "Medicine"
}

public enum MedicalNeedUrgency {
    NORMAL = "Normal",
    CRITICAL = "Critical",
    URGENT = "Urgent"
}

public enum AidPackageStatus {
    DRAFT = "Draft",
    PUBLISHED = "Published",
    AWAITING_PAYMENT = "Awaiting Payment",
    ORDERED = "Ordered",
    SHIPPED = "Shipped",
    RECEIVED_AT_MOH = "Received at MoH",
    DELIVERED = "Delivered"
}

public enum PledgeStatus {
    PLEDGED = "Pledged",
    PAYMENT_INITIATED = "Payment Initiated",
    PAYMENT_CONFIRMED = "Payment Confirmed"
}

@persist:Entity {
    id: ["name"],
    unique: ["supplierId"]
}
public type Supplier record {|
    @persist:AutoIncrement
    int supplierId;
    string name; // VARCHAR (255)
    string shortName; // VARCHAR (25)
    string email; // VARCHAR (50)
    string phoneNumber; // VARCHAR (20)

    Quotation[] quotations?;
|};

@persist:Entity {
    id: ["name", "type"],
    unique: ["itemId"]
}
public type MedicalItem record {|
    @persist:AutoIncrement
    int itemId;
    string name;
    MedicalItemType 'type; // `TYPE` ENUM('Device', 'Medicine'),
    string unit;

    Quotation[] quotations?;
    MedicalNeed[] medicalNeeds?;
|};

@persist:Entity {
    id: ["name"],
    unique: ["beneficiaryId"]
}
public type Beneficiary record {|
    @persist:AutoIncrement
    int beneficiaryId;
    string name;
    string shortName;
    string email;
    string phoneNumber;

    MedicalNeed[] medicalNeeds?;
|};

@persist:Entity {
    id: ["orgName"],
    unique: ["donarId"]
}
public type Donar record {|
    @persist:AutoIncrement
    int donarId;
    string orgName;
    string orgLink;
    string email;
    string phoneNumber;

    Pledge[] pledges?;
|};

@persist:Entity {
    id: ["itemId", "beneficiaryId", "period"],
    unique: ["needId"]
}
public type MedicalNeed record {|
    @persist:AutoIncrement
    int needId;
    int itemId;
    int beneficiaryId;
    time:Date period;

    int neededQuantity = 0;
    int remainingQuantity = 0;
    MedicalNeedUrgency urgency; // URGENCY ENUM('Normal', 'Critical', 'Urgent'),

    @persist:Relation {fields: ["beneficiaryId"], referencedFields: ["beneficiaryId"]}
    Beneficiary beneficiary?;
    @persist:Relation {fields: ["itemId"], referencedFields: ["itemId"]}
    MedicalItem item?;

    AidPackageItem[] aidPackageItems?;
|};

@persist:Entity {
    id: ["supplierId", "itemId", "period"],
    unique: ["quotationId"]
}
public type Quotation record {|
    @persist:AutoIncrement
    int quotationId;
    int supplierId;
    int itemId;
    time:Date period; // DATE

    string brandName;
    int availableQuantity = 0;
    time:Date expiryDate; // DATE
    decimal unitPrice = 0.0; // DECIMAL(15, 2)
    string regulatoryInfo;
    int remainingQuantity = 0;

    @persist:Relation {fields: ["supplierId"], referencedFields: ["supplierId"]}
    Supplier supplier?;
    @persist:Relation {fields: ["itemId"], referencedFields: ["itemId"]}
    MedicalItem medicalItem?;

    AidPackageItem[] aidPackageItems?;
|};

@persist:Entity {
    id: ["packageId"],
    unique: ["packageId"] // This exists in the SQL schema. But it is not needed.
}
public type AidPackage record {|
    @persist:AutoIncrement
    int packageId;

    string name;
    string description;
    time:Civil datatime; // DATETIME
    AidPackageStatus status; // ENUM('Draft', 'Published', 'Awaiting Payment', 'Ordered', 'Shipped', 'Received at MoH', 'Delivered'),
    string createdBy;
    string donorId;
    string thumbnail;
    string banner;

    Pledge[] pledges?;
    AidPackageItem[] aidPackageItems?;
    AidPackageUpdate[] aidPackageUpdates?; // Verify this
|};

@persist:Entity {
    id: ["qoutationId", "needId", "packageId"],
    unique: ["packageItemId"]
}
public type AidPackageItem record {|
    @persist:AutoIncrement
    int packageItemId;
    int qoutationId;
    int needId;
    int packageId;

    int quantity = 0;
    int initialQuantity = 0;
    decimal totalAmount = 0.0; // DECIMAL(15, 2)

    @persist:Relation {fields: ["qoutationId"], referencedFields: ["qoutationId"]}
    Quotation quotation?;
    @persist:Relation {fields: ["needId"], referencedFields: ["needId"]}
    MedicalNeed medicalNeed?;
    @persist:Relation {fields: ["packageId"], referencedFields: ["packageId"]}
    AidPackage aidPackage?;
|};

@persist:Entity {
    id: ["packageId", "packageUpdateId"],
    unique: ["packageUpdateId"]
}
public type AidPackageUpdate record {|
    @persist:AutoIncrement
    int packageUpdateId;
    int packageId;

    string updateComment;
    time:Civil datatime; // DATETIME

    @persist:Relation {fields: ["packageId"], referencedFields: ["packageId"]}
    AidPackage aidPackage?;
|};

@persist:Entity {
    id: ["packageId", "donarId"],
    unique: ["pledgeId"]
}
public type Pledge record {|
    @persist:AutoIncrement
    int pledgeId;
    int packageId;
    int donarId;

    decimal amount = 0.0; // DECIMAL(15, 2)
    string status; // ENUM('Pledged', 'Payment Initiated', 'Payment Confirmed'),

    @persist:Relation {fields: ["packageId"], referencedFields: ["packageId"]}
    AidPackage aidPackage?;
    @persist:Relation {fields: ["donarId"], referencedFields: ["donarId"]}
    Donar donar?;

    PledgeUpdate[] pledgeUpdates?; // Verify this relation. Is it PledgeUpdate pledgeUpdate?;
|};

@persist:Entity {
    id: ["pledgeId", "pledgeUpdateId"],
    unique: ["pledgeUpdateId"]
}
public type PledgeUpdate record {|
    @persist:AutoIncrement
    int pledgeUpdateId;
    int pledgeId;

    string updateComment;
    time:Civil datatime; // DATETIME

    @persist:Relation {fields: ["pledgeId"], referencedFields: ["pledgeId"]}
    Pledge pledge?;
|};

@persist:Entity {
    id: ["updateId"]
}
public type MedicalNeedUpdate record {|
    @persist:AutoIncrement
    int updateId;

    time:Civil datatime; // DATETIME
    time:Civil lastUpdatedTIME; // DATETIME
|};
