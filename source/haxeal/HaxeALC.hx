package haxeal;

import haxeal.bindings.ALC;
import haxeal.bindings.BinderHelper.*; // Import all binder functions
import haxeal.ALObjects.ALDevice;
import haxeal.ALObjects.ALContext;
import haxeal.ALObjects.FunctionAddress;

/*@:buildXml('<include name="../builder.xml" />')
@:include('alc.h')*/
class HaxeALC {
    // Context creation and configuration
	public static function createContext(device:ALDevice, ?attributes:Array<Int>):ALContext {
		return ALC.createContext(device, attributes != null ? arrayInt_ToPtr(attributes) : null);
	}

	public static function makeContextCurrent(context:ALContext):Bool { return al_bool(ALC.makeContextCurrent(context)); }

	public static function getCurrentContext():ALContext { return ALC.getCurrentContext(); }

	//! UNTESTED
	public static function processContext(context:ALContext):Void { ALC.processContext(context); }

	//! UNTESTED
	public static function suspendContext(context:ALContext):Void { ALC.suspendContext(context); }

	public static function destroyContext(context:ALContext):Void { ALC.destroyContext(context); }

	// Device creation and configuration

	/**
	 * Gets the device related to the given context and returns it.
	 * @param context The context to get the device from.
	 */
	public static function getDeviceFromContext(context:ALContext):ALDevice { return ALC.getDeviceFromContext(context); }

	/**
	 * Opens a device by name and returns the created device.
	 * @param deviceName Name of the device you want to open (default device name can be gotten using `getString`)
	 */
	public static function openDevice(deviceName:String):ALDevice { return ALC.openDevice(deviceName); }

	/**
	 * Closes the given device and returns whether the operation was successful/valid or not.
	 * @param device Device you want to close.
	 */
	public static function closeDevice(device:ALDevice):Bool { return al_bool(ALC.closeDevice(device)); }

	// Extensions

	/**
	 * Returns true if an extension by the given name is available on the given device.
	 * @param device Extension related device, can be left as null if the extension isnt device specific.
	 * @param extName Name of the extension to check for.
	 */
	public static function isExtensionPresent(?device:ALDevice, extName:String):Bool { return ALC.isExtensionPresent(device, extName); }

	/**
	 * Advanced usage function, gets the pointer to a function by name and returns it.
	 * 
	 * The returned function address can be casted to a defined function.
	 * 
	 * The defined function then acts as a caller for the pointed to function.
	 * 
	 * This function hasn't been tested and might not work as expected.
	 * @param device Function related device, can be left as null if the extension isnt device specific.
	 * @param funcName Name of the function you want to get .
	 * @return FunctionAddress
	 */
	public static function getProcAddress(?device:ALDevice, funcName:String):FunctionAddress {
		return fromVoidPtr(ALC.getProcAddress(device, funcName));
	}

	/**
     * Retrieves an AL enum value (Integer) from the given name.
	 * @param device Enum related device, can be left as null if the enum isnt device specific.
     * @param enumName The enum value to get.
     */
	public static function getEnumValue(?device:ALDevice, enumName:String):Int return ALC.getEnumValue(device, enumName);

	// Other
	/**
	 * Gets the string value of the given parameter and returns it.
	 * 
	 * If `device` isnt null, a device parameter can be obtained.
	 * @param device The device to receive the parameter of, if the parameter is tied to a device. Leave null otherwise.
	 * @param param Integer parameter to get
	 */
	public static function getString(?device:ALDevice, param:Int):String { return ALC.getString(device, param); }

	// ? Probably works, requires further testing
    public static function getError(?device:ALDevice):Int { return ALC.getError(device); }

	// TODO
	public static function getIntegers(device:ALDevice, param:Int):Array<Int> {
        var array:Array<Int> = [];
        ALC.getIntegers(device, param, cpp.Stdlib.sizeof(Int), arrayInt_ToStar(array));
        return array;
    };
}