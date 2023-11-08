package haxeal;

import haxeal.bindings.ALC;
import haxeal.bindings.BinderHelper.*; // Import all binder functions
import haxeal.ALObjects.ALDevice;
import haxeal.ALObjects.ALContext;
import haxeal.ALObjects.FunctionAddress;

@:headerCode('
    #include <al.h>
	#include <hxcpp.h>
	#include <hx/CFFI.h>
	#include <hx/CFFIPrime.h>
	#include <Array.h>

	#include <iostream>
	using namespace std;
')
class HaxeALC {
	// Constants
	public static final FREQUENCY:Int = 0x1007;
	public static final REFRESH:Int = 0x1008;
	public static final SYNC:Int = 0x1009;
	public static final MONO_SOURCES:Int = 0x1010;
	public static final STEREO_SOURCES:Int = 0x1011;
	public static final MAJOR_VERSION:Int = 0x1000;
	public static final MINOR_VERSION:Int = 0x1001;
	public static final ATTRIBUTES_SIZE:Int = 0x1002;
	public static final ALL_ATTRIBUTES:Int = 0x1003;
	public static final DEFAULT_DEVICE_SPECIFIER:Int = 0x1004;
	public static final DEVICE_SPECIFIER:Int = 0x1005;
	public static final EXTENSIONS:Int = 0x1006;
	public static final EXT_CAPTURE:Int = 1;
	public static final CAPTURE_DEVICE_SPECIFIER:Int = 0x310;
	public static final CAPTURE_DEFAULT_DEVICE_SPECIFIER:Int = 0x311;
	public static final CAPTURE_SAMPLES:Int = 0x312;
	public static final ENUMERATE_ALL_EXT:Int = 1;
	public static final DEFAULT_ALL_DEVICES_SPECIFIER:Int = 0x1012;
	public static final ALL_DEVICES_SPECIFIER:Int = 0x1013;


    // Context creation and configuration
	/**
	 * Creates a context on the given device with the given attributes and returns it.
	 * @param device Device to create context on.
	 * @param attributes Attributes to set for the context (format: [ATTRIBUTE_PARAM, VALUE, ATTRIBUTE_PARAM2, VALUE2...])
	 */
	public static function createContext(device:ALDevice, ?attributes:Array<Int>):ALContext {
		return ALC.createContext(device, attributes != null ? arrayInt_ToPtr(attributes) : null);
	}

	/**
	 * Sets the given context as the current OpenAL context.
	 * 
	 * Returns whether this operation was successful or not.
	 * @param context Context to set as "current".
	 */
	public static function makeContextCurrent(context:ALContext):Bool { return al_bool(ALC.makeContextCurrent(context)); }

	/**
	 * Returns the current OpenAL context.
	 */
	public static function getCurrentContext():ALContext { return ALC.getCurrentContext(); }

	/**
	 * Tells the given context to begin processing. 
	 * @param context Context to start processing on.
	 */
	public static function processContext(context:ALContext):Void { ALC.processContext(context); }

	/**
	 * Suspends processing on the given context.
	 * @param context Context to suspend processing on.
	 */
	public static function suspendContext(context:ALContext):Void { ALC.suspendContext(context); }

	/**
	 * Destroys the given context.
	 * @param context Context to destroy.
	 */
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
	 * This function only works if called in raw cpp code (using `untyped __cpp__('alcGetProcAddress(device, "funcName")')` or `@:functionCode`)
	 * @param device Function related device, can be left as null if the extension isnt device specific.
	 * @param funcName Name of the function you want to get .
	 */
	//public static function getProcAddress(?device:ALDevice, funcName:String):FunctionAddress { return null; }

	/**
     * Retrieves an AL enum value (Integer) from the given name.
	 * @param device Enum related device, can be left as null if the enum isnt device specific.
     * @param enumName The enum value to get.
     */
	public static function getEnumValue(?device:ALDevice, enumName:String):Int return ALC.getEnumValue(device, enumName);

	// Use ALC.hx if you want to use the Audio Record Extension, as I haven't found a good way to port it

	// Other
	/**
	 * Gets the string value of the given parameter and returns it.
	 * 
	 * If `device` isnt null, a device parameter can be obtained.
	 * @param device The device to receive the parameter of, if the parameter is tied to a device. Leave null otherwise.
	 * @param param Parameter to get
	 */
	public static function getString(?device:ALDevice, param:Int):String { return ALC.getString(device, param); }

	/**
	 * Returns a device-specific error code, if there is any error.
	 * @param device Device to check on for errors.
	 */
	public static function getError(?device:ALDevice):Int { return ALC.getError(device); }

	/**
	 * Returns integers related to the given parameter of the current context for the `device` (or none if its not device specific).
	 * @param device Device for device specific integer values
	 * @param param Parameter to get values of
	 * @param argumentCount Amount of array objects you expect to return
	 */
	public static function getIntegers(device:ALDevice, param:Int, argumentCount:Int):Array<Int> {
        var n = 123456789;
		var istr:Pointer<Int> = Pointer.addressOf(n);
        ALC.getIntegers(device, param, argumentCount, istr.ptr);
        return star_ToArrayInt(istr.ptr, argumentCount);
    };
}