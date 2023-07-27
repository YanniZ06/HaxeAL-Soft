package haxeal.bindings;

//@:buildXml('<include name="../builder.xml" />')
@:unreflective @:keep
@:include("alc.h")
extern class ALC {
	// Context creation and configuration
	@:native("alcCreateContext")
	static function createContext(device:Star<ALCdevice>, attributes:ConstStar<Int>):Star<ALCcontext>;

	@:native("alcMakeContextCurrent")
	static function makeContextCurrent(context:Star<ALCcontext>):Char;

	@:native("alcDestroyContext")
	static function destroyContext(context:Star<ALCcontext>):Void;

	@:native("alcProcessContext") //! UNTESTED
	static function processContext(context:Star<ALCcontext>):Void;

	@:native("alcSuspendContext") //! UNTESTED
	static function suspendContext(context:Star<ALCcontext>):Void;

	@:native("alcGetCurrentContext")
	static function getCurrentContext():Star<ALCcontext>;

	// Device creation and configuration
	@:native("alcGetContextsDevice")
	static function getDeviceFromContext(context:Star<ALCcontext>):Star<ALCdevice>;

    @:native("alcGetError") // ? Probably works, requires further testing
    static function getError(device:Star<ALCdevice>):Int;

	@:native("alcOpenDevice")
	static function openDevice(deviceName:ConstCharStar):Star<ALCdevice>;

	@:native("alcCloseDevice")
	static function closeDevice(device:Star<ALCdevice>):Char;

	// Other
	@:native("alcGetString")
	static function getString(device:Star<ALCdevice>, param:Int):ConstCharStar;

	@:native("alcGetIntegerv") // TODO
	static function getIntegers(device:Star<ALCdevice>, param:Int, size:Int, values:Star<Int>):Void;
}

// Context related objects
@:unreflective @:keep
@:include("alc.h") @:structAccess @:native('ALCdevice')
extern class ALCdevice {}

@:unreflective @:keep
@:include("alc.h") @:structAccess @:native('ALCcontext')
extern class ALCcontext {}
// -