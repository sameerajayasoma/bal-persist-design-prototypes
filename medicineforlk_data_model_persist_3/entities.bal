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
    @persist:AutoIncrement
    @persist:Id
    int supplierId;
    @persist:Unique
    string name;
    string shortName; 
    string email;
    string phoneNumber;

    Quotation[] quotations?;
|};

@persist:Entity
public type MedicalItem record {|
    @persist:AutoIncrement
    @persist:Id
    int itemId;
    @persist:Unique
    string name;
    @persist:Unique
    MedicalItemType 'type;
    string unit;

    Quotation[] quotations?;
    MedicalNeed[] medicalNeeds?;
|};

@persist:Entity
public type Beneficiary record {|
    @persist:AutoIncrement
    @persist:Id
    int beneficiaryId;
    @persist:Unique
    string name;
    string shortName;
    string email;
    string phoneNumber;

    MedicalNeed[] medicalNeeds?;
|};

@persist:Entity
public type Donar record {|
    @persist:AutoIncrement
    @persist:Id
    int donarId;
    @persist:Unique
    string orgName;
    string orgLink;
    string email;
    string phoneNumber;

    Pledge[] pledges?;
|};

@persist:Entity
public type MedicalNeed record {|
    @persist:AutoIncrement
    @persist:Id
    int needId;

    @persist:Unique
    int itemId;
    @persist:Unique
    int beneficiaryId;
    @persist:Unique
    time:Date period;

    int neededQuantity = 0;
    int remainingQuantity = 0;
    MedicalNeedUrgency urgency;

    @persist:Relation {fields: ["beneficiaryId"], referencedFields: ["beneficiaryId"]}
    Beneficiary beneficiary?;
    @persist:Relation {fields: ["itemId"], referencedFields: ["itemId"]}
    MedicalItem item?;

    AidPackageItem[] aidPackageItems?;
|};

@persist:Entity
public type Quotation record {|
    @persist:AutoIncrement
    @persist:Id
    int quotationId;

    @persist:Unique
    int supplierId;
    @persist:Unique
    int itemId;
    @persist:Unique
    time:Date period;

    string brandName;
    int availableQuantity = 0;
    time:Date expiryDate; 
    decimal unitPrice = 0.0;
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
    @persist:AutoIncrement
    @persist:Id
    int packageId;
    string name;
    string description;
    time:Civil datatime; 
    AidPackageStatus status;
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
    @persist:AutoIncrement
    @persist:Id
    int packageItemId;

    @persist:Unique
    int qoutationId;
    @persist:Unique
    int needId;
    @persist:Unique
    int packageId;

    int quantity = 0;
    int initialQuantity = 0;
    decimal totalAmount = 0.0; 

    @persist:Relation {fields: ["qoutationId"], referencedFields: ["qoutationId"]}
    Quotation quotation?;
    @persist:Relation {fields: ["needId"], referencedFields: ["needId"]}
    MedicalNeed medicalNeed?;
    @persist:Relation {fields: ["packageId"], referencedFields: ["packageId"]}
    AidPackage aidPackage?;
|};

@persist:Entity
public type AidPackageUpdate record {|
    @persist:AutoIncrement
    @persist:Id 
    int packageUpdateId;
    @persist:Unique
    int packageId;

    string updateComment;
    time:Civil datatime;

    @persist:Relation {fields: ["packageId"], referencedFields: ["packageId"]}
    AidPackage aidPackage?;
|};

@persist:Entity
public type Pledge record {|
    @persist:AutoIncrement
    @persist:Id
    int pledgeId;

    @persist:Unique
    int packageId;
    @persist:Unique
    int donarId;
    
    decimal amount = 0.0;
    string status;

    @persist:Relation {fields: ["packageId"], referencedFields: ["packageId"]}
    AidPackage aidPackage?;
    @persist:Relation {fields: ["donarId"], referencedFields: ["donarId"]}
    Donar donar?;

    PledgeUpdate[] pledgeUpdates?; // Verify this relation. Is it PledgeUpdate pledgeUpdate?;
|};

@persist:Entity
public type PledgeUpdate record {|
    @persist:AutoIncrement
    @persist:Id 
    int pledgeUpdateId;
    @persist:Unique
    int pledgeId;
    string updateComment;
    time:Civil datatime; 
    @persist:Relation {fields: ["pledgeId"], referencedFields: ["pledgeId"]}
    Pledge pledge?;
|};

@persist:Entity
public type MedicalNeedUpdate record {|
    @persist:AutoIncrement
    @persist:Id
    int updateId;

    time:Civil datatime;
    time:Civil lastUpdatedTIME;
|};