package haxeal;

import haxeal.bindings.AL;
import haxeal.bindings.BinderHelper.*; // Import all binder functions

class HaxeAL {
    public static inline final NONE:Int = 0;
	public static inline final FALSE:Int = 0;
	public static inline final TRUE:Int = 1;
	public static inline final SOURCE_RELATIVE:Int = 0x202;
	public static inline final CONE_INNER_ANGLE:Int = 0x1001;
	public static inline final CONE_OUTER_ANGLE:Int = 0x1002;
	public static inline final PITCH:Int = 0x1003;
	public static inline final POSITION:Int = 0x1004;
	public static inline final DIRECTION:Int = 0x1005;
	public static inline final VELOCITY:Int = 0x1006;
	public static inline final LOOPING:Int = 0x1007;
	public static inline final BUFFER:Int = 0x1009;
	public static inline final GAIN:Int = 0x100A;
	public static inline final MIN_GAIN:Int = 0x100D;
	public static inline final MAX_GAIN:Int = 0x100E;
	public static inline final ORIENTATION:Int = 0x100F;
	public static inline final SOURCE_STATE:Int = 0x1010;
	public static inline final INITIAL:Int = 0x1011;
	public static inline final PLAYING:Int = 0x1012;
	public static inline final PAUSED:Int = 0x1013;
	public static inline final STOPPED:Int = 0x1014;
	public static inline final BUFFERS_QUEUED:Int = 0x1015;
	public static inline final BUFFERS_PROCESSED:Int = 0x1016;
	public static inline final REFERENCE_DISTANCE:Int = 0x1020;
	public static inline final ROLLOFF_FACTOR:Int = 0x1021;
	public static inline final CONE_OUTER_GAIN:Int = 0x1022;
	public static inline final MAX_DISTANCE:Int = 0x1023;
	public static inline final SEC_OFFSET:Int = 0x1024;
	public static inline final SAMPLE_OFFSET:Int = 0x1025;
	public static inline final BYTE_OFFSET:Int = 0x1026;
	public static inline final SOURCE_TYPE:Int = 0x1027;
	public static inline final STATIC:Int = 0x1028;
	public static inline final STREAMING:Int = 0x1029;
	public static inline final UNDETERMINED:Int = 0x1030;
	public static inline final FORMAT_MONO8:Int = 0x1100;
	public static inline final FORMAT_MONO16:Int = 0x1101;
	public static inline final FORMAT_STEREO8:Int = 0x1102;
	public static inline final FORMAT_STEREO16:Int = 0x1103;
	public static inline final FREQUENCY:Int = 0x2001;
	public static inline final BITS:Int = 0x2002;
	public static inline final CHANNELS:Int = 0x2003;
	public static inline final SIZE:Int = 0x2004;
	public static inline final UNUSED:Int = 0x2010;
	public static inline final PENDING:Int = 0x2011;
	public static inline final PROCESSED:Int = 0x2012;
	public static inline final VENDOR:Int = 0xB001;
	public static inline final VERSION:Int = 0xB002;
	public static inline final RENDERER:Int = 0xB003;
	public static inline final EXTENSIONS:Int = 0xB004;
	public static inline final DOPPLER_FACTOR:Int = 0xC000;
	public static inline final DOPPLER_VELOCITY:Int = 0xC001;
	public static inline final SPEED_OF_SOUND:Int = 0xC003;

	public static inline final DISTANCE_MODEL:Int = 0xD000;

	public static inline final INVERSE_DISTANCE:Int = 0xD001;
	public static inline final INVERSE_DISTANCE_CLAMPED:Int = 0xD002;
	public static inline final LINEAR_DISTANCE:Int = 0xD003;
	public static inline final LINEAR_DISTANCE_CLAMPED:Int = 0xD004;
	public static inline final EXPONENT_DISTANCE:Int = 0xD005;
	public static inline final EXPONENT_DISTANCE_CLAMPED:Int = 0xD006;

    public static var arrayVConstMappings:Map<Null<Int>, Int> = [
        null => 1,
        POSITION => 3,
        VELOCITY => 3,
        DIRECTION => 3,
        ORIENTATION => 2
    ];

    // Renderer State Management
    /**
     * Enables the given capability.
     * @param capability Capability to enable.
     */
    public static function enable(capability:Int):Void { AL.enable(capability); }

    /**
     * Disables the given capability.
     * @param capability Capability to disable.
     */
    public static function disable(capability:Int):Void { AL.disable(capability); }

    /**
     * Checks if the given capability is enabled and returns `true` if so.
     * @param capability Capability to check.
     */
    public static function isEnabled(capability:Int):Bool { return al_bool(AL.isEnabled(capability)); }

    // Context State Setting
    /**
     * Sets the value for AL's doppler factor.
     * 
     * Range:   [0.0 - POSITIVE_INFINITY]
     * 
     * Default: 1.0
     * @param value The value to set the doppler factor to.
     */
    public static function dopplerFactor(value:Single):Void { AL.dopplerFactor(value); }

    /**
     * Sets the value for AL's (deprecated) doppler velocity.
     *
     * Acts as a multiplier applied to the Speed of Sound.
     * @param value The value to set the doppler velocity to.
     */
    public static function dopplerVelocity(value:Single):Void { AL.dopplerVelocity(value); }

    /**
     * Sets AL's speed of sound value, in units per second.
     * 
     * Range:   [0.0001 - POSITIVE_INFINITY]
     * 
     * Default: 343.3
     * @param value The value to set the speed of sound to.
     */
    public static function speedOfSound(value:Single):Void { AL.speedOfSound(value); }

    /**
     * Sets AL's distance attenuation model.
     *
     * Range:   [NONE, INVERSE_DISTANCE, INVERSE_DISTANCE_CLAMPED,
     *           LINEAR_DISTANCE, LINEAR_DISTANCE_CLAMPED,
     *           EXPONENT_DISTANCE, EXPONENT_DISTANCE_CLAMPED]
     * 
     * Default: INVERSE_DISTANCE_CLAMPED
     *
     * The model by which sources attenuate with distance.
     *
     * None     - No distance attenuation.
     * 
     * Inverse  - Doubling the distance halves the source gain.
     * 
     * Linear   - Linear gain scaling between the reference and max distances.
     * 
     * Exponent - Exponential gain dropoff.
     *
     * Clamped variations work like the non-clamped counterparts, except the
     * distance calculated is clamped between the reference and max distances.
     */
    public static function distanceModel(distanceModel:DistanceModel):Void { AL.distanceModel(distanceModel); }

    // Context State Retrieval
    /**
     * Returns a string value from the given AL parameter.
     * @param param Parameter to get value of.
     */
    public static function getString(param:Int):String { return AL.getString(param); }

    /**
     * Returns a boolean value from the given AL parameter.
     * @param param Parameter to get value of.
     */
    public static function getBoolean(param:Int):Bool { return al_bool(AL.getBoolean(param)); }

    /**
     * Returns an integer value from the given AL parameter.
     * @param param Parameter to get value of.
     */
    public static function getInteger(param:Int):Int { return AL.getInteger(param); }

    /**
     * Returns a single precision floating point value from the given AL parameter. (Can be used as a regular Float aswell)
     * @param param Parameter to get value of.
     */
    public static function getFloat(param:Int):Single { return AL.getFloat(param); }

    /**
     * Returns a double precision floating point value from the given AL parameter.
     * @param param Parameter to get value of.
     */
    public static function getDouble(param:Int):Float { return AL.getDouble(param); }

    /**
     * Returns an array of boolean values from the given AL parameter.
     * @param param Parameter to get values of.
     */
    //public static function getBooleanv(param:Int, values:Star<Char>):Void { }

    /**
     * Returns an array of integer values from the given AL parameter.
     * @param param Parameter to get values of.
     */
    //public static function getIntegerv(param:Int, values:Star<Int>):Void;

    /**
     * Returns an array of single precision floating point values from the given AL parameter.
     * @param param Parameter to get values of.
     */
    //public static function getFloatv(param:Int, values:Star<Float>):Void;

    /**
     * Returns an array of double precision floating point values from the given AL parameter.
     * @param param Parameter to get values of.
     */
    //public static function getDoublev(param:Int, values:Star<cpp.Float64>):Void;

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

enum abstract DistanceModel(Int) from Int to Int {
    public static inline final NONE:DistanceModel = 0;
    public static inline final INVERSE_DISTANCE:DistanceModel = 0xD001;
	public static inline final INVERSE_DISTANCE_CLAMPED:DistanceModel = 0xD002;
	public static inline final LINEAR_DISTANCE:DistanceModel = 0xD003;
	public static inline final LINEAR_DISTANCE_CLAMPED:DistanceModel = 0xD004;
	public static inline final EXPONENT_DISTANCE:DistanceModel = 0xD005;
	public static inline final EXPONENT_DISTANCE_CLAMPED:DistanceModel = 0xD006;
}