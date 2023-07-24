package haxeal;

import haxeal.bindings.ALC as ALC_B;
import haxeal.bindings.BinderHelper;
import haxeal.ALObjects.ALDevice;
import haxeal.ALObjects.ALContext;

class ALC {
    // Context creation and configuration
	static function createContext(device:ALDevice, ?attributes:Array<Int>):ALContext {
        return ALC_B.createContext(device, attributes != null ? BinderHelper.arrayToConstStar(attributes[0], attributes) : null);//attributes);
    }

	/*static function makeContextCurrent(context:ALContext):Char;

	static function destroyContext(context:ALContext):Void;

	//! UNTESTED
	static function processContext(context:ALContext):Void;

	//! UNTESTED
	static function suspendContext(context:ALContext):Void;

	static function getCurrentContext():ALContext;

	// Device creation and configuration
	static function getDeviceFromContext(context:ALContext):Star<ALDevice>;

    // ? Probably works, requires further testing
    static function getError(device:Star<ALDevice>):Int;

	static function openDevice(deviceName:ConstCharStar):Star<ALDevice>;

	static function closeDevice(device:Star<ALDevice>):Char;

	// Other
	static function getString(device:Star<ALDevice>, param:Int):ConstCharStar;*/

	// TODO
	static function getIntegers(device:ALDevice, param:Int):Array<Int> {
        var array:Array<Int> = [];
        ALC_B.getIntegers(device, param, cpp.Stdlib.sizeof(Int), BinderHelper.arrayToStar(1, array));
        return array;
    };
}