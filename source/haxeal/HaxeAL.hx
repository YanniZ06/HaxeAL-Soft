package haxeal;

import haxeal.bindings.AL;
import haxeal.bindings.BinderHelper.*; // Import all binder functions
import haxeal.ALObjects.ALSource;
import haxeal.ALObjects.ALBuffer;

/**
 * Main class for handling HaxeAL Soft operations such as playback.
 */
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

    @:noDoc public static var arrayVConstMappings:Map<Int, cpp.Int8> = [
        POSITION => 3,
        VELOCITY => 3,
        DIRECTION => 3,
        ORIENTATION => 6 // maybe  4???????? i really do not know, maybe this wont be used at all to begin with (pr with fix if you found out)
    ];

    /**
     * Gets the amount of elements an array needs to store the information about the given parameter.
     * 
     * Default is 1.
     */
    static inline function getParamMapping(param:Int):cpp.Int8 return arrayVConstMappings[param] ?? 1;

    // Renderer State Management
    /**
     * Enables the given capability.
     * @param capability Capability to enable.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function enable(capability:Int):Void { AL.enable(capability); }

    /**
     * Disables the given capability.
     * @param capability Capability to disable.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function disable(capability:Int):Void { AL.disable(capability); }

    /**
     * Checks if the given capability is enabled and returns `true` if so.
     * @param capability Capability to check.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function isEnabled(capability:Int):Bool { return al_bool(AL.isEnabled(capability)); }

    // Context State Setting
    /**
     * Sets the value for AL's doppler factor.
     * 
     * Range:   [0.0 - POSITIVE_INFINITY]
     * 
     * Default: 1.0
     * @param value The value to set the doppler factor to.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function dopplerFactor(value:Single):Void { AL.dopplerFactor(value); }

    /**
     * Sets the value for AL's (deprecated) doppler velocity.
     *
     * Acts as a multiplier applied to the Speed of Sound.
     * @param value The value to set the doppler velocity to.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function dopplerVelocity(value:Single):Void { AL.dopplerVelocity(value); }

    /**
     * Sets AL's speed of sound value, in units per second.
     * 
     * Range:   [0.0001 - POSITIVE_INFINITY]
     * 
     * Default: 343.3
     * @param value The value to set the speed of sound to.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function speedOfSound(value:Single):Void { AL.speedOfSound(value); }

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
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function distanceModel(distanceModel:DistanceModel):Void { AL.distanceModel(distanceModel); }

    // Context State Retrieval
    /**
     * Returns a string value from the given AL parameter.
     * @param param Parameter to get value of.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function getString(param:Int):String { return AL.getString(param); }

    /**
     * Returns a boolean value from the given AL parameter.
     * @param param Parameter to get value of.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function getBoolean(param:Int):Bool { return al_bool(AL.getBoolean(param)); }

    /**
     * Returns an integer value from the given AL parameter.
     * @param param Parameter to get value of.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function getInteger(param:Int):Int { return AL.getInteger(param); }

    /**
     * Returns a single precision floating point value from the given AL parameter. (Can be used as a regular Float aswell)
     * @param param Parameter to get value of.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function getFloat(param:Int):Single { return AL.getFloat(param); }

    /**
     * Returns a double precision floating point value from the given AL parameter.
     * @param param Parameter to get value of.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function getDouble(param:Int):Float { return AL.getDouble(param); }

    // I don't think these are necessary, at all, ever, I found 0 use for them, I'm not gonna do them right now.
    // If you really need them add them yourself, I already documented them. (or someone can make a pr idrc lol)
    /**
     * Returns an array of boolean values from the given AL parameter.
     * @param param Parameter to get values of.
     */
    //public static #if HAXEAL_INLINE_OPT_SMALL inline #end function getBooleanv(param:Int, values:Star<Char>):Void { }

    /**
     * Returns an array of integer values from the given AL parameter.
     * @param param Parameter to get values of.
     */
    //public static #if HAXEAL_INLINE_OPT_SMALL inline #end function getIntegerv(param:Int, values:Star<Int>):Void;

    /**
     * Returns an array of single precision floating point values from the given AL parameter.
     * @param param Parameter to get values of.
     */
    //public static #if HAXEAL_INLINE_OPT_SMALL inline #end function getFloatv(param:Int, values:Star<Float>):Void;

    /**
     * Returns an array of double precision floating point values from the given AL parameter.
     * @param param Parameter to get values of.
     */
    //public static #if HAXEAL_INLINE_OPT_SMALL inline #end function getDoublev(param:Int, values:Star<cpp.Float64>):Void;

    // Extensions
	/**
	 * Returns true if an extension by the given name is available on this context.
	 * @param extName Name of the extension to check for.
	 */
	public static #if HAXEAL_INLINE_OPT_SMALL inline #end function isExtensionPresent(extName:String):Bool { return AL.isExtensionPresent(extName); }

	/**
	 * Advanced usage function, gets the pointer to a function by name and returns it.
	 * 
	 * The returned function address can be casted to a defined function.
	 * 
	 * The defined function then acts as a caller for the pointed to function.
	 * 
	 * This function hasn't been tested and might not work as expected.
	 * @param funcName Name of the function you want to get. The function might be context specific.
	 */
	@:deprecated public static #if HAXEAL_INLINE_OPT_SMALL inline #end function getProcAddress(funcName:String):Dynamic { 
        return untyped __cpp__('alGetProcAddress ({0})', funcName);
        //return fromVoidPtr(AL.getProcAddress(funcName)); 
    }

    /**
     * Retrieves an AL enum value (Integer) from the given name.
     * @param enumName The enum value to get.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function getEnumValue(enumName:String):Int return AL.getEnumValue(enumName);

    // Listener Parameter Setting
    /**
     * Sets a float value for the given parameter of the current listener object.
     * @param param Parameter to set value of.
     * @param value New float value for the parameter.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function listenerf(param:Int, value:Float):Void { AL.listenerf(param, value); }

    /**
     * Sets three float values for the given parameter of the current listener object.
     * @param param Parameter to set values of.
     * @param value1 First float value for the parameter.
     * @param value2 Second float value for the parameter.
     * @param value3 Third float value for the parameter.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function listener3f(param:Int, value1:Float, value2:Float, value3:Float):Void { AL.listener3f(param, value1, value2, value3); }

    /**
     * Sets an array of float values for the given parameter of the current listener object.
     * @param param Parameter to set values of.
     * @param values New float values for the parameter as an array (array length should be the same as amount of values the parameter takes).
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function listenerfv(param:Int, values:Array<Float>):Void { AL.listenerfv(param, arrayFloat32_ToPtr(values)); }

    /**
     * Sets an integer value for the given parameter of the current listener object.
     * @param param Parameter to set value of.
     * @param value New integer value for the parameter.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function listeneri(param:Int, value:Int):Void { AL.listeneri(param, value); }

    /**
     * Sets three integer values for the given parameter of the current listener object.
     * @param param Parameter to set values of.
     * @param value1 First integer value for the parameter.
     * @param value2 Second integer value for the parameter.
     * @param value3 Third integer value for the parameter.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function listener3i(param:Int, value1:Int, value2:Int, value3:Int):Void { AL.listener3i(param, value1, value2, value3); }

    /**
     * Sets an array of integer values for the given parameter of the current listener object.
     * @param param Parameter to set values of.
     * @param values New integer values for the parameter as an array (array length should be the same as amount of values the parameter takes).
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function listeneriv(param:Int, values:Array<Int>):Void { AL.listeneriv(param, arrayInt_ToPtr(values)); }

    // Listener Parameter Getting
    /**
     * Returns the current float value of the given param.
     * @param param Param to get value of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getListenerf(param:Int):Float {
        var n:cpp.Float32 = 0.0123456789;
        var fstr:Pointer<cpp.Float32> = Pointer.addressOf(n);
        AL.getListenerf(param, fstr.ptr);
        return fstr.ref;
    }

    /**
     * Returns an array of three float values from the given param.
     * @param param Param to get value of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getListener3f(param:Int):Array<Float> {
        var n1:cpp.Float32 = 0.0123456789; var n2:cpp.Float32 = 0.0123456789; var n3:cpp.Float32 = 0.0123456789;
        untyped __cpp__('alGetListener3f(param, &n1, &n2, &n3)');

        return [n1, n2, n3];
    }

    /**
     * Returns an array of multiple float values from the given param.
     * 
     * The array size depends on the given param.
     * @param param Param to get values of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getListenerfv(param:Int):Array<Float> {
        var n:cpp.Float32 = 0.0123456789;
        var fstr:Pointer<cpp.Float32> = Pointer.addressOf(n);
        AL.getListenerfv(param, fstr.ptr);

        return star_ToArrayFloat32(fstr.ptr, getParamMapping(param));
    }

    /**
     * Returns the current integer value of the given param.
     * @param param Param to get value of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getListeneri(param:Int):Int {
        var n = 123456789;
        var istr:Pointer<Int> = Pointer.addressOf(n);
        AL.getListeneri(param, istr.ptr);
        return istr.ref;
    }

    /**
     * Returns an array of three integer values from the given param.
     * @param param Param to get value of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getListener3i(param:Int):Array<Int> {
        var n1:Int = 123456789; var n2:Int = 123456789; var n3:Int = 123456789;
        untyped __cpp__('alGetListener3i(param, &n1, &n2, &n3)');

        return [n1, n2, n3];
    }

    /**
     * Returns an array of multiple integer values from the given param.
     * 
     * The array size depends on the given param.
     * @param param Param to get values of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getListeneriv(param:Int, values:Star<Int>):Array<Int> {
        var n = 123456789;
        var istr:Pointer<Int> = Pointer.addressOf(n);
        AL.getListeneriv(param, istr.ptr);

        return star_ToArrayInt(istr.ptr, getParamMapping(param));
    }

    // Source Handling
    /**
     * Returns an array of ALSources.
     * @param num Amount of sources to return.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function createSources(num:Int):Array<ALSource> {
        var empty_sources:Array<ALSource> = [];
        var s_str:Pointer<ALSource> = Pointer.ofArray(empty_sources);
        AL.createSources(num, s_str.ptr);

        var sources:Array<ALSource> = star_ToArraySource(s_str.ptr, num);
        #if HAXEAL_DEBUG if(isSource(sources[0])) #end return sources;
        #if HAXEAL_DEBUG 
        trace("Warning: Sources may not have generated properly, returning array of potentially disfunctional sources");
        return sources;
        #end
    }

    /**
     * Creates a source and returns it.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function createSource():ALSource { return createSources(1)[0]; }

    /**
     * Deletes an array of ALSources.
     * @param sources Sources to delete.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function deleteSources(sources:Array<ALSource>):Void {
        AL.deleteSources(sources.length, arraySource_ToPtr(sources));
        #if HAXEAL_DEBUG trace('Deleted ${sources.length} sources properly: ${!isSource(sources[0])}'); #end
    }

    /**
     * Deletes a singular ALSource
     * @param source Source to delete.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function deleteSource(source:ALSource) { deleteSources([source]); }

    /**
     * Checks if the given source is a valid ALSource object.
     * @param source Source to check validity of.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function isSource(source:ALSource):Bool { return al_bool(AL.isSource(source)); }

    // Source Usage
    /**
     * Plays back audio from the sources buffer.
     * @param source Source to play audio from.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function sourcePlay(source:ALSource):Void { AL.sourcePlay(source); }

    /**
     * Completely stops audio-playback for the source and sets the sound position back to 0.
     * @param source Source to stop playback of.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function sourceStop(source:ALSource):Void { AL.sourceStop(source); }
    
    /**
     * Stops audio-playback for the source and sets its state to `HaxeAL.INITIAL`.
     * @param source Source to be rewound.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function sourceRewind(source:ALSource):Void { AL.sourceRewind(source); }
    
    /**
     * Pauses audio-playback for the source, keeping the sound position unchanged.
     * @param source Source to pause playback of.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function sourcePause(source:ALSource):Void { AL.sourcePause(source); }

    /**
     * Plays back audio from the sources' buffers.
     * @param sources Sources to play audio from.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function sourcePlayv(sources:Array<ALSource>):Void { AL.sourcePlayv(sources.length, Pointer.ofArray(sources)); }

    /**
     * Completely stops audio-playback for the sources and sets their sound position back to 0.
     * @param sources Sources to stop playback of.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function sourceStopv(sources:Array<ALSource>):Void { AL.sourceStopv(sources.length, Pointer.ofArray(sources)); }
    
    /**
     * Stops audio-playback for the sources and sets their state to `HaxeAL.INITIAL`.
     * @param sources Sources to be rewound.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function sourceRewindv(sources:Array<ALSource>):Void { AL.sourceRewindv(sources.length, Pointer.ofArray(sources)); }
    
    /**
     * Pauses audio-playback for the sources, keeping their sound position unchanged.
     * @param sources Sources to pause playback of.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function sourcePausev(sources:Array<ALSource>):Void { AL.sourcePausev(sources.length, Pointer.ofArray(sources)); }

    /**
     * Queues the buffers' data to be played chronologically 
     * once the data for the current buffer has finished playing back on the source.
     * @param source Source to queue buffers for.
     * @param buffers Buffers to be played back chronologically.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function sourceQueueBuffers(source:ALSource, buffers:Array<ALBuffer>):Void { AL.sourceQueueBuffers(source, buffers.length, Pointer.ofArray(buffers)); }

    /**
     * Unqueues the given number of processed buffers and returns the now available (unqueued) buffers.
     * 
     * If numBuffers is larger than the amount of processed buffers (the ones already played back) on the source 
     * (aquired using `getSourcei` with `BUFFERS_PROCESSED`) the operation will fail!
     * @param source Source to unqueue buffers of.
     * @param numBuffers The amount of buffers to unqueue.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function sourceUnqueueBuffers(source:ALSource, numBuffers:Int):Array<ALBuffer> { 
        var freeBuffers:Array<ALBuffer> = [];
        AL.sourceUnqueueBuffers(source, numBuffers, arrayBuffer_ToStar(freeBuffers));
        return freeBuffers;
    }

    // Source Parameter Setting
    /**
     * Sets the float value for the target parameter of the given source.
     * @param source Source to change parameter of.
     * @param param Param to set value of.
     * @param value New float value of the param.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function sourcef(source:ALSource, param:Int, value:Float):Void { AL.sourcef(source, param, value); }

    /**
     * Sets three float values for the target parameter of the given source.
     * @param source Source to change parameter of.
     * @param param Param to set values of.
     * @param value1 First new float value of the param.
     * @param value2 Second new float value of the param.
     * @param value3 Third new float value of the param.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function source3f(source:ALSource, param:Int, value1:Float, value2:Float, value3:Float):Void {AL.source3f(source, param, value1, value2, value3); }

    /**
     * Sets an array of float values for the target parameter of the given source.
     * @param source Source to change parameter of.
     * @param param Param to set values of.
     * @param value New float values of the param as an array (array length should be the same as amount of values the parameter takes).
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function sourcefv(source:ALSource, param:Int, values:Array<Float>):Void { AL.sourcefv(source, param, arrayFloat32_ToPtr(values)); }

    /**
     * Sets the integer value for the target parameter of the given source.
     * @param source Source to change parameter of.
     * @param param Param to set value of.
     * @param value New integer value of the param.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function sourcei(source:ALSource, param:Int, value:Null<Int>):Void {AL.sourcei(source, param, value); }

    /**
     * Sets three integer values for the target parameter of the given source.
     * @param source Source to change parameter of.
     * @param param Param to set values of.
     * @param value1 First new integer value of the param.
     * @param value2 Second new integer value of the param.
     * @param value3 Third new integer value of the param.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function source3i(source:ALSource, param:Int, value1:Int, value2:Int, value3:Int):Void {AL.source3i(source, param, value1, value2, value3); }

    /**
     * Sets an array of integer values for the target parameter of the given source.
     * @param source Source to change parameter of.
     * @param param Param to set values of.
     * @param value New integer values of the param as an array (array length should be the same as amount of values the parameter takes).
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function sourceiv(source:ALSource, param:Int, values:Array<Int>):Void {AL.sourceiv(source, param, arrayInt_ToPtr(values)); }


    /**
     * Gets the float value for the target parameter of the given source.
     * @param source Source to get parameter of.
     * @param param Param to get value of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getSourcef(source:ALSource, param:Int):Float {
        var n:cpp.Float32 = 0.0123456789;
        var fstr:Pointer<cpp.Float32> = Pointer.addressOf(n);
        AL.getSourcef(source, param, fstr.ptr);
        return fstr.ref;
    }

    /**
     * Returns an array of three float values for the target parameter of the given source.
     * @param source Source to get parameter of.
     * @param param Param to get values of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getSource3f(source:ALSource, param:Int):Array<Float> {
        var n1:cpp.Float32 = 0.0123456789; var n2:cpp.Float32 = 0.0123456789; var n3:cpp.Float32 = 0.0123456789;
        untyped __cpp__('alGetSource3f(source, param, &n1, &n2, &n3)');

        return [n1, n2, n3];
    }

     /**
     * Returns an array of multiple float values for the target parameter of the given source.
     * 
     * The array size depends on the given param.
     * @param source Source to get parameter of.
     * @param param Param to get values of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getSourcefv(source:ALSource, param:Int):Array<Float> {
        var n:cpp.Float32 = 0.0123456789;
        var fstr:Pointer<cpp.Float32> = Pointer.addressOf(n);
        AL.getSourcefv(source, param, fstr.ptr);

        return star_ToArrayFloat32(fstr.ptr, getParamMapping(param));
    }

    /**
     * Gets the integer value for the target parameter of the given source.
     * @param source Source to get parameter of.
     * @param param Param to get value of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getSourcei(source:ALSource, param:Int):Int {
        var n = 123456789;
        var istr:Pointer<Int> = Pointer.addressOf(n);
        AL.getSourcei(source, param, istr.ptr);
        return istr.ref;
    }

    /**
     * Returns an array of three integer values for the target parameter of the given source.
     * @param source Source to get parameter of.
     * @param param Param to get values of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getSource3i(source:ALSource, param:Int):Array<Int> {
        var n1:Int = 123456789; var n2:Int = 123456789; var n3:Int = 123456789;
        untyped __cpp__('alGetSource3i(source, param, &n1, &n2, &n3)');

        return [n1, n2, n3];
    }

    /**
     * Returns an array of multiple integer values for the target parameter of the given source.
     * 
     * The array size depends on the given param.
     * @param source Source to get parameter of.
     * @param param Param to get values of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getSourceiv(source:ALSource, param:Int):Array<Int> {
        var n = 123456789;
        var istr:Pointer<Int> = Pointer.addressOf(n);
        AL.getSourceiv(source, param, istr.ptr);
    
        return star_ToArrayInt(istr.ptr, getParamMapping(param));
    }

    // Buffer Handling
    /**
     * Returns an array of ALBuffers.
     * @param num Amount of buffers to return.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function createBuffers(num:Int):Array<ALBuffer> {
        var empty_buffers:Array<ALBuffer> = [];
        var s_str:Pointer<ALBuffer> = Pointer.ofArray(empty_buffers);
        AL.createBuffers(num, s_str.ptr);

        var buffers:Array<ALBuffer> = star_ToArrayBuffer(s_str.ptr, num);
        #if HAXEAL_DEBUG if(isBuffer(buffers[0])) #end return buffers;
        #if HAXEAL_DEBUG 
        trace("Warning: Buffers may not have generated properly, returning array of potentially disfunctional buffers");
        return buffers;
        #end
    }

    /**
     * Creates a buffer and returns it.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function createBuffer():ALBuffer { return createBuffers(1)[0]; }

    /**
     * Deletes an array of ALBuffers.
     * @param buffers Buffers to delete.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function deleteBuffers(buffers:Array<ALBuffer>):Void {
        AL.deleteBuffers(buffers.length, arrayBuffer_ToPtr(buffers));
        #if HAXEAL_DEBUG trace('Deleted ${buffers.length} buffers properly: ${!isBuffer(buffers[0])}'); #end
    }

    /**
     * Deletes a singular ALBuffer
     * @param buffer Buffer to delete.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function deleteBuffer(buffer:ALBuffer) { deleteBuffers([buffer]); }

    /**
     * Checks if the given buffer is a valid ALBuffer object.
     * @param buffer Buffer to check validity of.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function isBuffer(buffer:ALBuffer):Bool { return al_bool(AL.isBuffer(buffer)); }

    /**
     * Fills the given buffer with all information necessary for playback.
     * @param buffer The ALBuffer to fill with information.
     * @param format The AL format the data should be stored under (Ex: HaxeAL.FORMAT_STEREO16).
     * @param data The data to be fed as bytes.
     * @param size Size of the data to be fed.
     * @param sampleRate The samplerate the data should be played back at.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function bufferData(buffer:ALBuffer, format:Int, data:haxe.io.Bytes, size:Int, sampleRate:Int):Void {
        final bytesData:haxe.io.BytesData = data.getData();
        AL.bufferData(buffer, format, cast(cpp.Pointer.arrayElem(bytesData, 0).ptr, Star<cpp.Void>), size, sampleRate);
    }

    /**
     * Fills the given buffer with all information necessary for playback, used to handle raw PCM data.
     * @param buffer The ALBuffer to fill with information.
     * @param format The AL format the data should be stored under (Ex: HaxeAL.FORMAT_STEREO16).
     * @param data The data to be fed as raw pcm data in the form a raw cpp Void pointer.
     * @param size Size of the data to be fed.
     * @param sampleRate The samplerate the data should be played back at.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function bufferData_PCM(buffer:ALBuffer, format:Int, data:Star<cpp.Void>, size:Int, sampleRate:Int):Void {
        AL.bufferData(buffer, format, data, size, sampleRate);
    }

    // Buffer Parameter Setting
    /**
     * Sets the float value for the target parameter of the given buffer.
     * @param buffer Buffer to change parameter of.
     * @param param Param to set value of.
     * @param value New float value of the param.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function bufferf(buffer:ALBuffer, param:Int, value:Float):Void {AL.bufferf(buffer, param, value); }
    
    /**
     * Sets three float values for the target parameter of the given buffer.
     * @param buffer Buffer to change parameter of.
     * @param param Param to set values of.
     * @param value1 First new float value of the param.
     * @param value2 Second new float value of the param.
     * @param value3 Third new float value of the param.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function buffer3f(buffer:ALBuffer, param:Int, value1:Float, value2:Float, value3:Float):Void {AL.buffer3f(buffer, param, value1, value2, value3); }
    
    /**
     * Sets an array of float values for the target parameter of the given buffer.
     * @param buffer Buffer to change parameter of.
     * @param param Param to set values of.
     * @param value New float values of the param as an array (array length should be the same as amount of values the parameter takes).
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function bufferfv(buffer:ALBuffer, param:Int, values:Array<Float>):Void {AL.bufferfv(buffer, param, arrayFloat32_ToPtr(values)); }
    
    /**
     * Sets the integer value for the target parameter of the given buffer.
     * @param buffer Buffer to change parameter of.
     * @param param Param to set value of.
     * @param value New integer value of the param.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function bufferi(buffer:ALBuffer, param:Int, value:Int):Void {AL.bufferi(buffer, param, value); }

    /**
     * Sets three integer values for the target parameter of the given buffer.
     * @param buffer Buffer to change parameter of.
     * @param param Param to set values of.
     * @param value1 First new integer value of the param.
     * @param value2 Second new integer value of the param.
     * @param value3 Third new integer value of the param.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function buffer3i(buffer:ALBuffer, param:Int, value1:Int, value2:Int, value3:Int):Void {AL.buffer3i(buffer, param, value1, value2, value3); }

    /**
     * Sets an array of integer values for the target parameter of the given buffer.
     * @param buffer Buffer to change parameter of.
     * @param param Param to set values of.
     * @param value New integer values of the param as an array (array length should be the same as amount of values the parameter takes).
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function bufferiv(buffer:ALBuffer, param:Int, values:Array<Int>):Void {AL.bufferiv(buffer, param, arrayInt_ToPtr(values)); }

    // Buffer Parameter Getting
    /**
     * Gets the float value for the target parameter of the given buffer.
     * @param buffer Buffer to get parameter of.
     * @param param Param to get value of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getBufferf(buffer:ALBuffer, param:Int):Float {
        var n:cpp.Float32 = 0.0123456789;
        var fstr:Pointer<cpp.Float32> = Pointer.addressOf(n);
        AL.getBufferf(buffer, param, fstr.ptr);
        return fstr.ref;
    }

    /**
     * Returns an array of three float values for the target parameter of the given buffer.
     * @param buffer Buffer to get parameter of.
     * @param param Param to get values of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getBuffer3f(buffer:ALBuffer, param:Int):Array<Float> {
        var n1:cpp.Float32 = 0.0123456789; var n2:cpp.Float32 = 0.0123456789; var n3:cpp.Float32 = 0.0123456789;
        untyped __cpp__('alGetBuffer3f(buffer, param, &n1, &n2, &n3)');

        return [n1, n2, n3];
    }

     /**
     * Returns an array of multiple float values for the target parameter of the given buffer.
     * 
     * The array size depends on the given param.
     * @param buffer Buffer to get parameter of.
     * @param param Param to get values of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getBufferfv(buffer:ALBuffer, param:Int):Array<Float> {
        var n:cpp.Float32 = 0.0123456789;
        var fstr:Pointer<cpp.Float32> = Pointer.addressOf(n);
        AL.getBufferfv(buffer, param, fstr.ptr);

        return star_ToArrayFloat32(fstr.ptr, getParamMapping(param));
    }

    /**
     * Gets the integer value for the target parameter of the given buffer.
     * @param buffer Buffer to get parameter of.
     * @param param Param to get value of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getBufferi(buffer:ALBuffer, param:Int):Int {
        var n = 123456789;
        var istr:Pointer<Int> = Pointer.addressOf(n);
        AL.getBufferi(buffer, param, istr.ptr);
        return istr.ref;
    }

    /**
     * Returns an array of three integer values for the target parameter of the given buffer.
     * @param buffer Buffer to get parameter of.
     * @param param Param to get values of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getBuffer3i(buffer:ALBuffer, param:Int):Array<Int> {
        var n1:Int = 123456789; var n2:Int = 123456789; var n3:Int = 123456789;
        untyped __cpp__('alGetBuffer3i(buffer, param, &n1, &n2, &n3)');

        return [n1, n2, n3];
    }

    /**
     * Returns an array of multiple integer values for the target parameter of the given buffer.
     * 
     * The array size depends on the given param.
     * @param buffer Buffer to get parameter of.
     * @param param Param to get values of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getBufferiv(buffer:ALBuffer, param:Int):Array<Int> {
        var n = 123456789;
        var istr:Pointer<Int> = Pointer.addressOf(n);
        AL.getBufferiv(buffer, param, istr.ptr);
    
        return star_ToArrayInt(istr.ptr, getParamMapping(param));
    }

    //Error Getting Functions

    /**
     * Checks for any OpenAL errors and returns the ID of the error code.
     * 
     * The definition can be logged to the console using `getErrorString` or obtained as a variable using `getErrorDefinition`.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function getError():Int { return AL.getError(); }
    
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

@:noDoc enum abstract DistanceModel(Int) from Int to Int {
    public static inline final NONE:DistanceModel = 0;
    public static inline final INVERSE_DISTANCE:DistanceModel = 0xD001;
	public static inline final INVERSE_DISTANCE_CLAMPED:DistanceModel = 0xD002;
	public static inline final LINEAR_DISTANCE:DistanceModel = 0xD003;
	public static inline final LINEAR_DISTANCE_CLAMPED:DistanceModel = 0xD004;
	public static inline final EXPONENT_DISTANCE:DistanceModel = 0xD005;
	public static inline final EXPONENT_DISTANCE_CLAMPED:DistanceModel = 0xD006;
}