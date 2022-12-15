public type EntityConfig record {|
|};
 
public const annotation EntityConfig Entity on type;

public type AutoIncrementConfig record {|
    int startWith = 1;
    int incrementBy = 1;
|};

public const annotation AutoIncrementConfig AutoIncrement on source record field;

public enum SortOrder {
    ASC, DESC
}

// Should we make these open records to allow for future extensions?
public type IDConfig record {|
    SortOrder sort?;
|};

public const annotation IDConfig Id on record field;

public type UniqueConfig record {|
    string name?;
    SortOrder sort?;
|};

public const annotation UniqueConfig Unique on record field;

public enum ReferenceAction {
    RESTRICT,
    CASCADE,
    SET_NULL,
    NO_ACTION,
    SET_DEFAULT // MYSQL does not support this
}

# Defines a relationship between two entities.
#
# + name - specify the name of the relationship  
# + fields - a list of fields of the current record  
# + referencedFields - a list of fields of the referenced record  
# + onDelete - enforced referential action on delete  
# + onUpdate - enforced referential action on delete
public type RelationConfig record {|
    string name?;
    string[] fields?;
    string[] referencedFields?;
    ReferenceAction onDelete?;
    ReferenceAction onUpdate?;
|};

public const annotation RelationConfig Relation on source record field;
