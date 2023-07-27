package haxeal;

import haxeal.bindings.ALC;
import haxeal.bindings.BinderHelper;
import haxeal.ALObjects.ALDevice;
import haxeal.ALObjects.ALContext;

/*@:buildXml('<include name="../builder.xml" />')
@:include('alc.h')*/
class HaxeALC {
    // Context creation and configuration
	public static function createContext(device:ALDevice, ?attributes:Array<Int>):ALContext {
		return ALC.createContext(device, attributes != null ? BinderHelper.arrayInt_ToConstStar(attributes) : null);
	}

	/**
	 * Opens a device by name and returns the created device.
	 * @param deviceName Name of the device you want to open (default device name can be gotten using `getString`)
	 */
	public static function openDevice(deviceName:String):ALDevice { return ALC.openDevice(deviceName); }

	// Other
	/**
	 * Gets the string value of the given parameter and returns it.
	 * 
	 * If `device` isnt null, a device parameter can be obtained.
	 * @param device The device to receive the parameter of, if the parameter is tied to a device. Leave null otherwise.
	 * @param param Integer parameter to get
	 */
	public static function getString(?device:ALDevice, param:Int):String { return ALC.getString(device != null ? device : null, param); }

	// ? Probably works, requires further testing
    public static function getError(?device:ALDevice):Int { return ALC.getError(device != null ? device : null); }

	/*static function makeContextCurrent(context:ALContext):Char;

	static function destroyContext(context:ALContext):Void;

	//! UNTESTED
	static function processContext(context:ALContext):Void;

	//! UNTESTED
	static function suspendContext(context:ALContext):Void;

	static function getCurrentContext():ALContext;

	// Device creation and configuration
	static function getDeviceFromContext(context:ALContext):Star<ALDevice>;


	static function closeDevice(device:Star<ALDevice>):Char;

	*/

	// TODO
	public static function getIntegers(device:ALDevice, param:Int):Array<Int> {
        /*var array:Array<Int> = [];
        ALC_B.getIntegers(device.ref, param, cpp.Stdlib.sizeof(Int), BinderHelper.arrayInt_ToStar(array));
        return array;*/
		return null;
    };
}