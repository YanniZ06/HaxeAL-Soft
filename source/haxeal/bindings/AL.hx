package haxeal.bindings;

import haxeal.ALObjects.ALSource;
import haxeal.ALObjects.ALBuffer;

//@:buildXml('<include name="../builder.xml" />')
@:unreflective @:keep
@:include("al.h")
extern class AL {
    // Renderer State Management (Ported!)
    @:native("alEnable")
    static function enable(capability:Int):Void;

    @:native("alDisable")
    static function disable(capability:Int):Void;

    @:native("alIsEnabled")
    static function isEnabled(capability:Int):Char;

    // Context State Setting (Ported!)
    @:native("alDopplerFactor")
    static function dopplerFactor(value:cpp.Float32):Void;

    @:native("alDopplerVelocity")
    static function dopplerVelocity(value:cpp.Float32):Void;

    @:native("alSpeedOfSound")
    static function speedOfSound(value:cpp.Float32):Void;

    @:native("alDistanceModel")
    static function distanceModel(distanceModel:Int):Void;

    // Context State Retrieval (Ported!)
    @:native("alGetString")
    static function getString(param:Int):ConstCharStar;

    @:native("alGetBoolean")
    static function getBoolean(param:Int):Char;

    @:native("alGetInteger")
    static function getInteger(param:Int):Int;

    @:native("alGetFloat")
    static function getFloat(param:Int):cpp.Float32;

    @:native("alGetDouble")
    static function getDouble(param:Int):cpp.Float64;

    // Context State Retrieval as Arrays (Won't port, pr if you need it)
    @:native("alGetBooleanv")
    static function getBooleanv(param:Int, values:Star<Char>):Void;

    @:native("alGetIntegerv")
    static function getIntegerv(param:Int, values:Star<Int>):Void;

    @:native("alGetFloatv")
    static function getFloatv(param:Int, values:Star<cpp.Float32>):Void;

    @:native("alGetDoublev")
    static function getDoublev(param:Int, values:Star<cpp.Float64>):Void;

    // Extensions (Ported!)
    @:native("alIsExtensionPresent")
	static function isExtensionPresent(extName:ConstCharStar):Bool;

	@:native("alGetProcAddress")
	static function getProcAddress(funcName:ConstCharStar):Star<cpp.Void>;

	@:native("alGetEnumValue")
	static function getEnumValue(enumName:ConstCharStar):Int;

    // Listener Parameter Setting (Ported!)
    @:native("alListenerf")
    static function listenerf(param:Int, value:cpp.Float32):Void;

    @:native("alListener3f")
    static function listener3f(param:Int, value1:cpp.Float32, value2:cpp.Float32, value3:cpp.Float32):Void;

    @:native("alListenerfv")
    static function listenerfv(param:Int, values:Pointer<cpp.Float32>):Void;

    @:native("alListeneri")
    static function listeneri(param:Int, value:Int):Void;

    @:native("alListener3i")
    static function listener3i(param:Int, value1:Int, value2:Int, value3:Int):Void;

    @:native("alListeneriv")
    static function listeneriv(param:Int, values:Pointer<Int>):Void;
    // Listener Parameter Getting (Ported!)
    @:native("alGetListenerf")
    static function getListenerf(param:Int, value:Star<cpp.Float32>):Void;

    @:native("alGetListener3f")
    static function getListener3f(param:Int, value1:Star<cpp.Float32>, value2:Star<cpp.Float32>, value3:Star<cpp.Float32>):Void;

    @:native("alGetListenerfv")
    static function getListenerfv(param:Int, values:Star<cpp.Float32>):Void;

    @:native("alGetListeneri")
    static function getListeneri(param:Int, value:Star<Int>):Void;

    @:native("alGetListener3i")
    static function getListener3i(param:Int, value1:Star<Int>, value2:Star<Int>, value3:Star<Int>):Void;

    @:native("alGetListeneriv")
    static function getListeneriv(param:Int, values:Star<Int>):Void;

    // Todo: Source Handling (In Progress)
    @:native("alGenSources")
    static function createSources(num:Int, sources:Star<ALSource>):Void;

    @:native("alDeleteSources")
    static function deleteSources(num:Int, sources:Pointer<ALSource>):Void;

    @:native("alIsSource")
    static function isSource(source:ALSource):Char;

    // Source Parameter Setting (Ported!)
    @:native("alSourcef")
    static function sourcef(source:ALSource, param:Int, value:cpp.Float32):Void;

    @:native("alSource3f")
    static function source3f(source:ALSource, param:Int, value1:cpp.Float32, value2:cpp.Float32, value3:cpp.Float32):Void;

    @:native("alSourcefv")
    static function sourcefv(source:ALSource, param:Int, values:Pointer<cpp.Float32>):Void;

    @:native("alSourcei")
    static function sourcei(source:ALSource, param:Int, value:Int):Void;

    @:native("alSource3i")
    static function source3i(source:ALSource, param:Int, value1:Int, value2:Int, value3:Int):Void;

    @:native("alSourceiv")
    static function sourceiv(source:ALSource, param:Int, values:Pointer<Int>):Void;
    // Source Parameter Getting (Ported!)
    @:native("alGetSourcef")
    static function getSourcef(source:ALSource, param:Int, value:Star<cpp.Float32>):Void;

    @:native("alGetSource3f")
    static function getSource3f(source:ALSource, param:Int, value1:Star<cpp.Float32>, value2:Star<cpp.Float32>, value3:Star<cpp.Float32>):Void;

    @:native("alGetSourcefv")
    static function getSourcefv(source:ALSource, param:Int, values:Star<cpp.Float32>):Void;

    @:native("alGetSourcei")
    static function getSourcei(source:ALSource, param:Int, value:Star<Int>):Void;

    @:native("alGetSource3i")
    static function getSource3i(source:ALSource, param:Int, value1:Star<Int>, value2:Star<Int>, value3:Star<Int>):Void;

    @:native("alGetSourceiv")
    static function getSourceiv(source:ALSource, param:Int, values:Star<Int>):Void;

    // Source Usage
    @:native("alSourcePlay")
    static function sourcePlay(source:ALSource):Void;

    @:native("alSourceStop")
    static function sourceStop(source:ALSource):Void;
    
    @:native("alSourceRewind")
    static function sourceRewind(source:ALSource):Void;
    
    @:native("alSourcePause")
    static function sourcePause(source:ALSource):Void;

    @:native("alSourcePlayv")
    static function sourcePlayv(num:Int, sources:Pointer<ALSource>):Void;

    @:native("alSourceStopv")
    static function sourceStopv(num:Int, sources:Pointer<ALSource>):Void;

    @:native("alSourceRewindv")
    static function sourceRewindv(num:Int, sources:Pointer<ALSource>):Void;

    @:native("alSourcePausev")
    static function sourcePausev(num:Int, sources:Pointer<ALSource>):Void;

    @:native("alSourceQueueBuffers")
    static function sourceQueueBuffers(source:ALSource, numBuffers:Int, buffers:Pointer<ALBuffer>):Void;

    @:native("alSourceUnqueueBuffers")
    static function sourceUnqueueBuffers(source:ALSource, numBuffers:Int, buffers:Star<ALBuffer>):Void;

    // Buffer Handling
    @:native("alGenBuffers")
    static function createBuffers(num:Int, buffers:Star<ALBuffer>):Void;

    @:native("alDeleteBuffers")
    static function deleteBuffers(num:Int, buffers:Pointer<ALBuffer>):Void;

    @:native("alIsBuffer")
    static function isBuffer(buffer:ALBuffer):Char;

    @:native("alBufferData")
    static function bufferData(buffer:ALBuffer, format:Int, data:Star<cpp.UInt8>, size:Int, sampleRate:Int):Void;

    // Buffer Parameter Setting (Ported!)
    @:native("alBufferf")
    static function bufferf(buffer:ALBuffer, param:Int, value:cpp.Float32):Void;

    @:native("alBuffer3f")
    static function buffer3f(buffer:ALBuffer, param:Int, value1:cpp.Float32, value2:cpp.Float32, value3:cpp.Float32):Void;

    @:native("alBufferfv")
    static function bufferfv(buffer:ALBuffer, param:Int, values:Pointer<cpp.Float32>):Void;

    @:native("alBufferi")
    static function bufferi(buffer:ALBuffer, param:Int, value:Int):Void;

    @:native("alBuffer3i")
    static function buffer3i(buffer:ALBuffer, param:Int, value1:Int, value2:Int, value3:Int):Void;

    @:native("alBufferiv")
    static function bufferiv(buffer:ALBuffer, param:Int, values:Pointer<Int>):Void;
    // Buffer Parameter Getting (Ported!)
    @:native("alGetBufferf")
    static function getBufferf(buffer:ALBuffer, param:Int, value:Star<cpp.Float32>):Void;

    @:native("alGetBuffer3f")
    static function getBuffer3f(buffer:ALBuffer, param:Int, value1:Star<cpp.Float32>, value2:Star<cpp.Float32>, value3:Star<cpp.Float32>):Void;

    @:native("alGetBufferfv")
    static function getBufferfv(buffer:ALBuffer, param:Int, values:Star<cpp.Float32>):Void;

    @:native("alGetBufferi")
    static function getBufferi(buffer:ALBuffer, param:Int, value:Star<Int>):Void;

    @:native("alGetBuffer3i")
    static function getBuffer3i(buffer:ALBuffer, param:Int, value1:Star<Int>, value2:Star<Int>, value3:Star<Int>):Void;

    @:native("alGetBufferiv")
    static function getBufferiv(buffer:ALBuffer, param:Int, values:Star<Int>):Void;

    // Other (Ported!)
    @:native("alGetError")
    static function getError():Int;
}