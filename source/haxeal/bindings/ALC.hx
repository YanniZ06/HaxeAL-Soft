package haxeal.bindings;

@:unreflective @:keep
@:include("alc.h")
extern class ALC {
	// Context creation and configuration
	@:native("alcCreateContext")
	static function createContext(device:Star<ALDevice>, attributes:ConstStar<Int>):Star<ALContext>;

	@:native("alcMakeContextCurrent")
	static function makeContextCurrent(context:Star<ALContext>):Char;

	@:native("alcDestroyContext")
	static function destroyContext(context:Star<ALContext>):Void;

	@:native("alcProcessContext") //! UNTESTED
	static function processContext(context:Star<ALContext>):Void;

	@:native("alcSuspendContext") //! UNTESTED
	static function suspendContext(context:Star<ALContext>):Void;

	@:native("alcGetCurrentContext")
	static function getCurrentContext():Star<ALContext>;

	// Device creation and configuration
	@:native("alcGetContextsDevice")
	static function getDeviceFromContext(context:Star<ALContext>):Star<ALDevice>;

    @:native("alcGetError") // ? Probably works, requires further testing
    static function getError(device:Star<ALDevice>):Int;

	@:native("alcOpenDevice")
	static function openDevice(deviceName:ConstCharStar):Star<ALDevice>;

	@:native("alcCloseDevice")
	static function closeDevice(device:Star<ALDevice>):Char;

	// Other
	@:native("alcGetString")
	static function getString(device:Star<ALDevice>, param:Int):ConstCharStar;

	@:native("alcGetIntegerv") // TODO
	static function getIntegers(device:Star<ALDevice>, param:Int, size:Int, values:Star<Int>):Void;
}

// Context related objects
@:unreflective @:keep
@:include("alc.h") @:structAccess @:native('ALCdevice')
extern class ALDevice {}

@:unreflective @:keep
@:include("alc.h") @:structAccess @:native('ALCcontext')
extern class ALContext {}
// -