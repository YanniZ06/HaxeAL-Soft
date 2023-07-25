package haxeal;

import haxeal.bindings.ALC as ALC_B;
import haxeal.bindings.BinderHelper;
import haxeal.ALObjects.ALDevice;
import haxeal.ALObjects.ALContext;

class ALC {
    // Context creation and configuration
	public static function createContext(device:ALDevice, ?attributes:Array<Int>):ALContext {
        return ALC_B.createContext(device, attributes != null ? BinderHelper.arrayInt_ToConstStar(attributes) : null);//attributes); //! WARNING, THIS WILL ERROR
    //return null;
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
	public static function getIntegers(device:ALDevice, param:Int):Array<Int> {
        /*var array:Array<Int> = [];
        ALC_B.getIntegers(device, param, cpp.Stdlib.sizeof(Int), BinderHelper.arrayInt_ToStar(array));
        return array;*/
		return null;
    };
}