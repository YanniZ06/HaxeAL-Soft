package haxeal;

typedef ALErrorDef = {
    var name:String;
    var description:String;
}
class ALError {
    public static var NO_ERROR:ALErrorDef = {name:"No Error", description:"There was no error"};
    public static var INVALID_NAME :ALErrorDef = {name:"Invalid Name", description:"Invalid name (ID) passed to an AL call"};
    public static var INVALID_ENUM:ALErrorDef = {name:"Invalid Enum", description:"Invalid enumeration passed to AL call"};
    public static var INVALID_VALUE:ALErrorDef = {name:"Invalid Value", description:"Invalid value passed to AL call"};
    public static var INVALID_OPERATION:ALErrorDef = {name:"Invalid Operation", description:"Illegal AL call"};
    public static var OUT_OF_MEMORY:ALErrorDef = {name:"Out of Memory", description:"Not enough memory to execute the AL call"};

    static var errorMap:Map<Int, ALErrorDef> = [
        0 => NO_ERROR,
        0xA001 => INVALID_NAME,
        0xA002 => INVALID_ENUM,
        0xA003 => INVALID_VALUE,
        0xA004 => INVALID_OPERATION,
        0xA005 => OUT_OF_MEMORY
    ];

    /**
     * Gets the error definition assigned to the given ID.
     * 
     * Returns null if theres no assigned definition
     * @param id ID to get definition for.
     */
    public static function get(id:Int):ALErrorDef return errorMap[id];
}