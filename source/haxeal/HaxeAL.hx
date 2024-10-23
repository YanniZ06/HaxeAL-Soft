package haxeal;

import cpp.Float32;
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
        ORIENTATION => 6
    ];

    //AL_SOFT_direct_channels extension
    /**
     * Passed into `HaxeAL.isExtensionPresent` AFTER a context has been created and made current, to allow direct channels for sources
     * 
     * Documentation on it's usage can be found here: https://github.com/Raulshc/OpenAL-EXT-Repository/blob/master/AL%20Extensions/AL_SOFT_direct_channels.txt
     */
    public static inline final EXT_DIRECT_CHANNELS_NAME:String = "AL_SOFT_direct_channels";
    /**
     * Parameter of: alSourcei, alSourceiv, alGetSourcei and alGetSourceiv
     */
    public static inline final DIRECTCHANNELS_SOFT:Int = 0x1033;

    //AL_SOFT_source_spatialize extension
    /**
     * Passed into `HaxeAL.isExtensionPresent` AFTER a context has been created and made current, to allow for 3D stereo channels by downmixing it to mono
     * NOTE: DO NOT USE THIS WITH DIRECT CHANNELS BECAUSE IT'LL CANCEL THE EFFECT OF THIS OUT
     * Documentation on it's usage can be found here: https://github.com/Raulshc/OpenAL-EXT-Repository/blob/master/AL%20Extensions/AL_SOFT_source_spatialize.txt
     */
    public static inline final EXT_SPATIALIZE_SOURCE_NAME:String = "AL_SOFT_source_spatialize";
    /**
     * Parameter of alSourcei, alSourceiv, alGetSourcei and alGetSourceiv
     */
    public static inline final SOURCE_SPATIALIZE_SOFT:Int = 0x1214; 

    //AL_SOFT_loop_points extension
    /**
     * Passed into `HaxeAL.isExtensionPresent` AFTER a context has been created and made current, allows for specifying loop points for a buffer (offset where a buffer loops)
     * 
     * Documentation on it's usage can be found here: https://github.com/Raulshc/OpenAL-EXT-Repository/blob/master/AL%20Extensions/AL_SOFT_loop_points.txt
     */
    public static inline final EXT_LOOP_POINTS_NAME:String = "AL_SOFT_loop_points";
    /**
     * Parameter of alBufferiv and alGetBufferiv
     */
    public static inline final LOOP_POINTS_SOFT:Int = 0x2015;

    //AL_SOFT_buffer_length_query extension
    /**
     * Passed into `HaxeAL.isExtensionPresent` AFTER a context has been created and made current, allows the user to query information from a buffer such as: length in bytes, samples and seconds.
     * 
     * Documentation on it's usage can be found here: https://github.com/Raulshc/OpenAL-EXT-Repository/blob/master/AL%20Extensions/AL_SOFT_buffer_length_query.txt
     */
    public static inline final EXT_BUFFER_LENGTH_QUERY_NAME:String = "AL_SOFT_buffer_length_query";
    /**
     * Accepted by the <paramName> parameter of alGetBufferi and alGetBufferiv
     */
    public static inline final BYTE_LENGTH_SOFT:Int = 0x2009;
    /**
     * Accepted by the <paramName> parameter of alGetBufferi and alGetBufferiv
     */
    public static inline final SAMPLE_LENGTH_SOFT:Int = 0x200A;
    /**
     * Accepted by the <paramName> parameter of alGetBufferf and alGetBufferfv
     */
    public static inline final SEC_LENGTH_SOFT:Int = 0x200B;

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
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function listenerfv(param:Int, values:Array<cpp.Float32>):Void { 
        AL.listenerfv(param, untyped __cpp__('reinterpret_cast<float*>({0}->getBase())', values)); 
    }

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
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function listeneriv(param:Int, values:Array<Int>):Void { 
        AL.listeneriv(param, untyped __cpp__('reinterpret_cast<int*>({0}->getBase())', values)); 
    }

    // Listener Parameter Getting
    /**
     * Returns the current float value of the given param.
     * @param param Param to get value of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getListenerf(param:Int):Float {
        var n:Float32 = 0.0123456789;
        AL.getListenerf(param, Native.addressOf(n));
        return n;
    }

    /**
     * Returns an array of three float values from the given param.
     * @param param Param to get value of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getListener3f(param:Int):Array<Float> {
        var n1:Float32 = 0.0123456789; var n2:Float32 = 0.0123456789; var n3:Float32 = 0.0123456789;
        untyped __cpp__('alGetListener3f(param, &n1, &n2, &n3)');

        return [n1, n2, n3];
    }

    /**
     * Returns an array of multiple float values from the given param.
     * 
     * The array size depends on the given param.
     * @param param Param to get values of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getListenerfv(param:Int):Array<cpp.Float32> {
        final argc = getParamMapping(param);

        var arr:Array<cpp.Float32> = untyped __cpp__('::Array<float>({0}, {0})', argc);
        AL.getListenerfv(param, untyped __cpp__('reinterpret_cast<float*>({0}->getBase())', arr));

        return arr;
    }

    /**
     * Returns the current integer value of the given param.
     * @param param Param to get value of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getListeneri(param:Int):Int {
        var n = 123456789;
        AL.getListeneri(param, Native.addressOf(n));
        return n;
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
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getListeneriv(param:Int):Array<Int> {
        final argc = getParamMapping(param);

        var arr:Array<Int> = untyped __cpp__('::Array<int>({0}, {0})', argc);
        AL.getListeneriv(param, untyped __cpp__('reinterpret_cast<int*>({0}->getBase())', arr));

        return arr;
    }

    // Source Handling
    /**
     * Returns an array of ALSources.
     * @param num Amount of sources to return.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function createSources(num:Int):Array<ALSource> {
        var sources:Array<ALSource> = untyped __cpp__('::Array<unsigned int>({0}, {0})', num);        
        AL.createSources(num, untyped __cpp__('reinterpret_cast<unsigned int*>({0}->getBase())', sources));

        #if HAXEAL_DEBUG
        for(i=>src in sources) {
            if(!isSource(src)) trace('Source $i is not a source, returning array with disfunctional source!');
        }
        #end
        return sources;
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
        AL.deleteSources(sources.length, untyped __cpp__('reinterpret_cast<unsigned int*>({0}->getBase())', sources));
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
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function sourcePlayv(sources:Array<ALSource>):Void { 
        AL.sourcePlayv(sources.length, untyped __cpp__('reinterpret_cast<unsigned int*>({0}->getBase())', sources)); 
    }

    /**
     * Completely stops audio-playback for the sources and sets their sound position back to 0.
     * @param sources Sources to stop playback of.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function sourceStopv(sources:Array<ALSource>):Void { 
        AL.sourceStopv(sources.length, untyped __cpp__('reinterpret_cast<unsigned int*>({0}->getBase())', sources)); 
    }
    
    /**
     * Stops audio-playback for the sources and sets their state to `HaxeAL.INITIAL`.
     * @param sources Sources to be rewound.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function sourceRewindv(sources:Array<ALSource>):Void { 
        AL.sourceRewindv(sources.length, untyped __cpp__('reinterpret_cast<unsigned int*>({0}->getBase())', sources)); 
    }
    
    /**
     * Pauses audio-playback for the sources, keeping their sound position unchanged.
     * @param sources Sources to pause playback of.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function sourcePausev(sources:Array<ALSource>):Void { 
        AL.sourcePausev(sources.length, untyped __cpp__('reinterpret_cast<unsigned int*>({0}->getBase())', sources)); 
    }

    /**
     * Queues the buffers' data to be played chronologically 
     * once the data for the current buffer has finished playing back on the source.
     * @param source Source to queue buffers for.
     * @param buffers Buffers to be played back chronologically.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function sourceQueueBuffers(source:ALSource, buffers:Array<ALBuffer>):Void { 
        AL.sourceQueueBuffers(source, buffers.length, untyped __cpp__('reinterpret_cast<unsigned int*>({0}->getBase())', buffers)); 
    }

    /**
     * Unqueues the given number of processed buffers and returns the now available (unqueued) buffers.
     * 
     * If numBuffers is larger than the amount of processed buffers (the ones already played back) on the source 
     * (aquired using `getSourcei` with `BUFFERS_PROCESSED`) the operation will fail!
     * @param source Source to unqueue buffers of.
     * @param numBuffers The amount of buffers to unqueue.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function sourceUnqueueBuffers(source:ALSource, numBuffers:Int):Array<ALBuffer> { 
        var buffers:Array<ALBuffer> = untyped __cpp__('::Array<unsigned int>({0}, {0})', numBuffers);        
        AL.sourceUnqueueBuffers(source, numBuffers, untyped __cpp__('reinterpret_cast<unsigned int*>({0}->getBase())', buffers));
        return buffers;
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
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function sourcefv(source:ALSource, param:Int, values:Array<cpp.Float32>):Void { 
        AL.sourcefv(source, param, untyped __cpp__('reinterpret_cast<float*>({0}->getBase())', values)); 
    }

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
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function sourceiv(source:ALSource, param:Int, values:Array<Int>):Void {
        AL.sourceiv(source, param, untyped __cpp__('reinterpret_cast<int*>({0}->getBase())', values)); 
    }

    /**
     * Gets the float value for the target parameter of the given source.
     * @param source Source to get parameter of.
     * @param param Param to get value of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getSourcef(source:ALSource, param:Int):Float {
        var n:Float32 = 0.0123456789;
        AL.getSourcef(source, param, Native.addressOf(n));
        return n;
    }

    /**
     * Returns an array of three float values for the target parameter of the given source.
     * @param source Source to get parameter of.
     * @param param Param to get values of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getSource3f(source:ALSource, param:Int):Array<Float> {
        var n1:Float32 = 0.0123456789; var n2:Float32 = 0.0123456789; var n3:Float32 = 0.0123456789;
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
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getSourcefv(source:ALSource, param:Int):Array<cpp.Float32> {
        final argc = getParamMapping(param);

        var arr:Array<cpp.Float32> = untyped __cpp__('::Array<float>({0}, {0})', argc);
        AL.getSourcefv(source, param, untyped __cpp__('reinterpret_cast<float*>({0}->getBase())', arr));

        return arr;
    }

    /**
     * Gets the integer value for the target parameter of the given source.
     * @param source Source to get parameter of.
     * @param param Param to get value of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getSourcei(source:ALSource, param:Int):Int {
        var n = 123456789;
        AL.getSourcei(source, param, Native.addressOf(n));
        return n;
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
        final argc = getParamMapping(param);

        var arr:Array<Int> = untyped __cpp__('::Array<int>({0}, {0})', argc);
        AL.getSourceiv(source, param, untyped __cpp__('reinterpret_cast<int*>({0}->getBase())', arr));
    
        return arr;
    }

    // Buffer Handling
    /**
     * Returns an array of ALBuffers.
     * @param num Amount of buffers to return.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function createBuffers(num:Int):Array<ALBuffer> {
        var buffers:Array<ALBuffer> = untyped __cpp__('::Array<unsigned int>({0}, {0})', num);        
        AL.createBuffers(num, untyped __cpp__('reinterpret_cast<unsigned int*>({0}->getBase())', buffers));

        #if HAXEAL_DEBUG
        for(i=>buf in buffers) {
            if(!isBuffer(buf)) trace('Buffer $i is not a buffer, returning array with disfunctional buffer!');
        }
        #end
        return buffers;
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
        AL.deleteBuffers(buffers.length, untyped __cpp__('reinterpret_cast<unsigned int*>({0}->getBase())', buffers));
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
     * @param size Size of the data to be fed, here this should be `data.length`. Only exists to stay true to the OpenAL spec.
     * @param sampleRate The samplerate the data should be played back at.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function bufferData(buffer:ALBuffer, format:Int, data:haxe.io.Bytes, size:Int, sampleRate:Int):Void {
        final bytesData:haxe.io.BytesData = data.getData();
        
        var rawData:cpp.Star<cpp.Void> = untyped __cpp__('reinterpret_cast<void*>(bytesData->getBase())'); // If we ever do a HL Impl, change this!!!!!!
        AL.bufferData(buffer, format, rawData, size, sampleRate);
    }

    /**
     * Fills the given buffer with all information necessary for playback, using an array of unsigned 8bit integers.
     * @param buffer The ALBuffer to fill with information.
     * @param format The AL format the data should be stored under (Ex: HaxeAL.FORMAT_STEREO16).
     * @param data The data to be fed as an Array<cpp.UInt8> (or haxe.io.BytesData).
     * @param sampleRate The samplerate the data should be played back at.
     */
    public static function bufferDataArray(buffer:ALBuffer, format:Int, data:Array<cpp.UInt8>, sampleRate:Int):Void {
        var rawData:cpp.Star<cpp.Void> = untyped __cpp__('reinterpret_cast<void*>(data->getBase())');
        AL.bufferData(buffer, format, rawData, data.length, sampleRate);
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
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function bufferfv(buffer:ALBuffer, param:Int, values:Array<cpp.Float32>):Void {
        AL.bufferfv(buffer, param, untyped __cpp__('reinterpret_cast<float*>({0}->getBase())', values)); 
    }
    
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
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function bufferiv(buffer:ALBuffer, param:Int, values:Array<Int>):Void {
        AL.bufferiv(buffer, param, untyped __cpp__('reinterpret_cast<int*>({0}->getBase())', values)); 
    }

    // Buffer Parameter Getting
    /**
     * Gets the float value for the target parameter of the given buffer.
     * @param buffer Buffer to get parameter of.
     * @param param Param to get value of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getBufferf(buffer:ALBuffer, param:Int):Float {
        var n:Float32 = 0.0123456789;
        AL.getBufferf(buffer, param, Native.addressOf(n));
        return n;
    }

    /**
     * Returns an array of three float values for the target parameter of the given buffer.
     * @param buffer Buffer to get parameter of.
     * @param param Param to get values of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getBuffer3f(buffer:ALBuffer, param:Int):Array<Float> {
        var n1:Float32 = 0.0123456789; var n2:Float32 = 0.0123456789; var n3:Float32 = 0.0123456789;
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
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getBufferfv(buffer:ALBuffer, param:Int):Array<cpp.Float32> {
        final argc = getParamMapping(param);

        var arr:Array<cpp.Float32> = untyped __cpp__('::Array<float>({0}, {0})', argc);
        AL.getBufferfv(buffer, param, untyped __cpp__('reinterpret_cast<float*>({0}->getBase())', arr));

        return arr;
    }

    /**
     * Gets the integer value for the target parameter of the given buffer.
     * @param buffer Buffer to get parameter of.
     * @param param Param to get value of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getBufferi(buffer:ALBuffer, param:Int):Int {
        var n = 123456789;
        AL.getBufferi(buffer, param, Native.addressOf(n));
        return n;
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
        final argc = getParamMapping(param);

        var arr:Array<Int> = untyped __cpp__('::Array<int>({0}, {0})', argc);
        AL.getBufferiv(buffer, param, untyped __cpp__('reinterpret_cast<int*>({0}->getBase())', arr));
    
        return arr;
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

// Why do you have to be so different?

@:noDoc enum abstract DistanceModel(Int) from Int to Int {
    public static inline final NONE:DistanceModel = 0;
    public static inline final INVERSE_DISTANCE:DistanceModel = 0xD001;
	public static inline final INVERSE_DISTANCE_CLAMPED:DistanceModel = 0xD002;
	public static inline final LINEAR_DISTANCE:DistanceModel = 0xD003;
	public static inline final LINEAR_DISTANCE_CLAMPED:DistanceModel = 0xD004;
	public static inline final EXPONENT_DISTANCE:DistanceModel = 0xD005;
	public static inline final EXPONENT_DISTANCE_CLAMPED:DistanceModel = 0xD006;
}