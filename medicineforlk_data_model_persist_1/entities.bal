import ballerina/time;
import medicineforlk_data_model_persist_1.persist;

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

@persist:Entity
public type Supplier record {|
    //@autoIncrement TODO Define this as a separate annotation
    @persist:Unique
    int supplierId;
    @persist:Id
    string name; // VARCHAR (255)
    string shortName; // VARCHAR (25)
    string email; // VARCHAR (50)
    string phoneNumber; // VARCHAR (20)

    Quotation[] quotations?;
|};

@persist:Entity
public type MedicalItem record {|
    //@autoIncrement
    @persist:Unique
    int itemId;
    @persist:Id // Composite key
    string name;
    @persist:Id // Composite key
    MedicalItemType 'type; // `TYPE` ENUM('Device', 'Medicine'),
    string unit;

    Quotation[] quotations?;
    MedicalNeed[] medicalNeeds?;
|};

@persist:Entity
public type Beneficiary record {|
    //@autoIncrement
    @persist:Unique
    int beneficiaryId;
    @persist:Id
    string name;
    string shortName;
    string email;
    string phoneNumber;

    MedicalNeed[] medicalNeeds?;
|};

@persist:Entity
public type Donar record {|
    //@autoIncrement
    @persist:Unique
    int donarId;
    @persist:Id
    string orgName;
    string orgLink;
    string email;
    string phoneNumber;

    Pledge[] pledges?;
|};

@persist:Entity
public type MedicalNeed record {|
    //@autoIncrement
    @persist:Unique
    int needId;

    @persist:Id
    int itemId;
    @persist:Id
    int beneficiaryId;
    @persist:Id
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

@persist:Entity
public type Quotation record {|
    //@autoIncrement
    @persist:Unique
    int quotationId;

    @persist:Id
    int supplierId;
    @persist:Id
    int itemId;
    @persist:Id
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

@persist:Entity
public type AidPackage record {|
    //@autoIncrement
    @persist:Id
    // @persist:Unique This exists in the SQL schema. But it is not needed.
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

@persist:Entity
public type AidPackageItem record {|
    //@autoIncrement
    @persist:Unique
    int packageItemId;

    @persist:Id
    int qoutationId;
    @persist:Id
    int needId;
    @persist:Id
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

@persist:Entity
public type AidPackageUpdate record {|
    @persist:Id
    int packageId;
    //@autoIncrement
    @persist:Id // packageUpdateId has been declared as a primary key as well as a unique key in the SQL schema. But it is not needed.
    @persist:Unique
    int packageUpdateId;

    string updateComment;
    time:Civil datatime; // DATETIME

    @persist:Relation {fields: ["packageId"], referencedFields: ["packageId"]}
    AidPackage aidPackage?;
|};

@persist:Entity
public type Pledge record {|
    //@autoIncrement
    @persist:Unique
    int pledgeId;

    @persist:Id
    int packageId;
    @persist:Id
    int donarId;
    
    decimal amount = 0.0; // DECIMAL(15, 2)
    string status; // ENUM('Pledged', 'Payment Initiated', 'Payment Confirmed'),

    @persist:Relation {fields: ["packageId"], referencedFields: ["packageId"]}
    AidPackage aidPackage?;
    @persist:Relation {fields: ["donarId"], referencedFields: ["donarId"]}
    Donar donar?;

    PledgeUpdate[] pledgeUpdates?; // Verify this relation. Is it PledgeUpdate pledgeUpdate?;
|};

@persist:Entity
public type PledgeUpdate record {|
    @persist:Id
    int pledgeId;
    //@autoIncrement
    @persist:Id // pledgeUpdateId has been declared as a primary key as well as a unique key in the SQL schema. But it is not needed.
    @persist:Unique
    int pledgeUpdateId;

    string updateComment;
    time:Civil datatime; // DATETIME
   
    @persist:Relation {fields: ["pledgeId"], referencedFields: ["pledgeId"]}
    Pledge pledge?;
|};

@persist:Entity
public type MedicalNeedUpdate record {|
    @persist:Id
    //@autoIncrement
    int updateId;

    time:Civil datatime; // DATETIME
    time:Civil lastUpdatedTIME; // DATETIME
|};