package;

import cpp.ConstCharStar;
import cpp.ConstStar;
import cpp.Char;
import cpp.UInt8;
import cpp.Star;

using cpp.Native;
@:buildXml('<include name="../builder.xml" />')
class Main { //0x1005
	static var device:Star<ALDevice>;
	static var context:Star<ALContext>;

	static function main() {
		var name:String = ALC.getString(null, 0x1005);
		device = ALC.openDevice(name);
		if(device != null) {
			context = ALC.createContext(device, null);

			if(context != null) ALC.makeContextCurrent(context);
			trace(ALC.getError(device));

			// ? EXPERIMENTAL
			/*var array:Star<Int> = 0; 
			ALC.getIntegers(device, 0x1001, cpp.Stdlib.sizeof(Int), array);
			final arrayTrue:Array<Int> = cpp.Pointer.fromStar(array).toUnmanagedArray(1);
			trace(arrayTrue);*/
		}

		trace("eat my ass!");
		//trace(ALFunctions.getError());
	}
}

@:unreflective @:keep
@:include("al.h")
extern class ALFunctions {
    @:native("alGetError")
    static function getError():Int;
}

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

	@:native("alcProcessContext")
	static function processContext(context:Star<ALContext>):Void;

	@:native("alcSuspendContext")
	static function suspendContext(context:Star<ALContext>):Void;

	@:native("alcGetCurrentContext")
	static function getCurrentContext():Star<ALContext>;

	// Device creation and configuration
	@:native("alcGetContextsDevice")
	static function getDeviceFromContext(context:Star<ALContext>):Star<ALDevice>;

    @:native("alcGetError")
    static function getError(device:Star<ALDevice>):Int;

	@:native("alcOpenDevice")
	static function openDevice(deviceName:ConstCharStar):Star<ALDevice>;

	@:native("alcCloseDevice")
	static function closeDevice(device:Star<ALDevice>):Char;

	// Other
	@:native("alcGetString")
	static function getString(device:Star<ALDevice>, param:Int):ConstCharStar;

	@:native("alcGetIntegerv")
	static function getIntegers(device:Star<ALDevice>, param:Int, size:Int, values:Star<Int>):Void;
}
@:unreflective @:keep
@:include("alc.h") @:structAccess @:native('ALCdevice')
extern class ALDevice {}

@:unreflective @:keep
@:include("alc.h") @:structAccess @:native('ALCcontext')
extern class ALContext {}

class AL {

}