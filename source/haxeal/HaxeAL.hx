package haxeal;
import haxeal.bindings.AL;
class HaxeAL {
    //Error Getting Functions

    /**
     * Checks for any OpenAL errors and returns the ID of the error code.
     * 
     * The definition can be logged to the console using `getErrorString` or obtained as a variable using `getErrorDefinition`.
     */
    public static function getError():Int { return AL.getError(); }
    
    /**
     * Logs the definition of an error code to the console.
     * 
     * The created log is only a more tidy version of tracing `getErrorDefinition`.
     * @param error Error code obtained through `getError`
     */
    public static inline function getErrorString(error:Int):Void { 
        final errorDef = getErrorDefinition(error);
        trace('${errorDef.name}\n${errorDef.description}');
    }

    /**
     * Gets the definition of an error code and returns it.
     * @param error Error code obtained through `getError`
     */
    public static inline function getErrorDefinition(error:Int):ALError.ALErrorDef { return ALError.get(error); }
}