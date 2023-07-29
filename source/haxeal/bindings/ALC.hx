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

	// Capture Device (Audio Recording)
	@:native("alcCaptureOpenDevice")
	static function openCaptureDevice(deviceName:ConstCharStar, captureFrequency:cpp.UInt32, captureFormat:Int, bufferSize:Int):Star<ALCdevice>;

	@:native("alcCaptureCloseDevice")
	static function closeCaptureDevice(device:Star<ALCdevice>):Char;

	@:native("alcCaptureStart")
	static function startCapture(device:Star<ALCdevice>):Void;

	@:native("alcCaptureStop")
	static function stopCapture(device:Star<ALCdevice>):Void;

	@:native("alcCaptureSamples")
	static function captureSamples(device:Star<ALCdevice>, buffer:Star<cpp.Void>, samples:Int):Void;

	// Extensions
	@:native("alcIsExtensionPresent")
	static function isExtensionPresent(device:Star<ALCdevice>, extName:ConstCharStar):Bool;

	@:native("alcGetProcAddress")
	static function getProcAddress(device:Star<ALCdevice>, funcName:ConstCharStar):Star<cpp.Void>;

	@:native("alcGetEnumValue")
	static function getEnumValue(device:Star<ALCdevice>, enumName:ConstCharStar):Int;

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