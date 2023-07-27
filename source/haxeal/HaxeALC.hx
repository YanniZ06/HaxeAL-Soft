package haxeal;

import haxeal.bindings.ALC;
import haxeal.bindings.BinderHelper.*; // Import all binder functions
import haxeal.ALObjects.ALDevice;
import haxeal.ALObjects.ALContext;

/*@:buildXml('<include name="../builder.xml" />')
@:include('alc.h')*/
class HaxeALC {
    // Context creation and configuration
	public static function createContext(device:ALDevice, ?attributes:Array<Int>):ALContext {
		return ALC.createContext(device, attributes != null ? arrayInt_ToConstStar(attributes) : null);
	}

	public static function makeContextCurrent(context:ALContext):Bool { return al_bool(ALC.makeContextCurrent(context)); }

	public static function getCurrentContext():ALContext { return ALC.getCurrentContext(); }

	//! UNTESTED
	public static function processContext(context:ALContext):Void { ALC.processContext(context); }

	//! UNTESTED
	public static function suspendContext(context:ALContext):Void { ALC.suspendContext(context); }

	public static function destroyContext(context:ALContext):Void { ALC.destroyContext(context); }

	// Device creation and configuration

	public static function getDeviceFromContext(context:ALContext):ALDevice { return ALC.getDeviceFromContext(context); }

	/**
	 * Opens a device by name and returns the created device.
	 * @param deviceName Name of the device you want to open (default device name can be gotten using `getString`)
	 */
	public static function openDevice(deviceName:String):ALDevice { return ALC.openDevice(deviceName); }

	public static function closeDevice(device:ALDevice):Bool { return al_bool(ALC.closeDevice(device)); }

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

	/*




	// Device creation and configuration

	*/

	// TODO
	public static function getIntegers(device:ALDevice, param:Int):Array<Int> {
        var array:Array<Int> = [];
        ALC.getIntegers(device, param, cpp.Stdlib.sizeof(Int), arrayInt_ToStar(array));
        return array;
    };
}