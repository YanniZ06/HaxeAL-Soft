package haxeal;

import haxeal.ALObjects.ALCaptureDevice;
import haxeal.bindings.ALC;
import haxeal.bindings.BinderHelper.*; // Import all binder functions
import haxeal.ALObjects.ALDevice;
import haxeal.ALObjects.ALContext;
import haxeal.ALObjects.FunctionAddress;

/**
 * Class for handling the HaxeAL Context. 
 */
@:headerCode('
    #include <al.h>
	#include <hxcpp.h>
	#include <Array.h>

	#include <iostream>
	using namespace std;
')
class HaxeALC {
	// Constants
	public static inline final FREQUENCY:Int = 0x1007;
	public static inline final REFRESH:Int = 0x1008;
	public static inline final SYNC:Int = 0x1009;
	public static inline final MONO_SOURCES:Int = 0x1010;
	public static inline final STEREO_SOURCES:Int = 0x1011;
	public static inline final MAJOR_VERSION:Int = 0x1000;
	public static inline final MINOR_VERSION:Int = 0x1001;
	public static inline final ATTRIBUTES_SIZE:Int = 0x1002;
	public static inline final ALL_ATTRIBUTES:Int = 0x1003;
	public static inline final DEFAULT_DEVICE_SPECIFIER:Int = 0x1004;
	public static inline final DEVICE_SPECIFIER:Int = 0x1005;
	public static inline final EXTENSIONS:Int = 0x1006;
	public static inline final EXT_CAPTURE:Int = 1;
	public static inline final CAPTURE_DEVICE_SPECIFIER:Int = 0x310;
	public static inline final CAPTURE_DEFAULT_DEVICE_SPECIFIER:Int = 0x311;
	public static inline final CAPTURE_SAMPLES:Int = 0x312;
	public static inline final ENUMERATE_ALL_EXT:Int = 1;
	public static inline final DEFAULT_ALL_DEVICES_SPECIFIER:Int = 0x1012;
	public static inline final ALL_DEVICES_SPECIFIER:Int = 0x1013;


    // Context creation and configuration
	/**
	 * Creates a context on the given device with the given attributes and returns it.
	 * @param device Device to create context on.
	 * @param attributes Attributes to set for the context (format: [ATTRIBUTE_PARAM, VALUE, ATTRIBUTE_PARAM2, VALUE2...])
	 */
	public static #if HAXEAL_INLINE_OPT_SMALL inline #end function createContext(device:ALDevice, ?attributes:Array<Int>):ALContext {
		return ALC.createContext(device, attributes != null ? untyped __cpp__('reinterpret_cast<int*>({0}->getBase())', attributes) : null);
	}

	/**
	 * Sets the given context as the current OpenAL context.
	 * 
	 * Returns whether this operation was successful or not.
	 * @param context Context to set as "current".
	 */
	public static #if HAXEAL_INLINE_OPT_SMALL inline #end function makeContextCurrent(context:ALContext):Bool { return al_bool(ALC.makeContextCurrent(context)); }

	/**
	 * Returns the current OpenAL context.
	 */
	public static #if HAXEAL_INLINE_OPT_SMALL inline #end function getCurrentContext():ALContext { return ALC.getCurrentContext(); }

	/**
	 * Tells the given context to begin processing. 
	 * @param context Context to start processing on.
	 */
	public static #if HAXEAL_INLINE_OPT_SMALL inline #end function processContext(context:ALContext):Void { ALC.processContext(context); }

	/**
	 * Suspends processing on the given context.
	 * @param context Context to suspend processing on.
	 */
	public static #if HAXEAL_INLINE_OPT_SMALL inline #end function suspendContext(context:ALContext):Void { ALC.suspendContext(context); }

	/**
	 * Destroys the given context.
	 * @param context Context to destroy.
	 */
	public static #if HAXEAL_INLINE_OPT_SMALL inline #end function destroyContext(context:ALContext):Void { ALC.destroyContext(context); }

	// Device creation and configuration

	/**
	 * Gets the device related to the given context and returns it.
	 * @param context The context to get the device from.
	 */
	public static #if HAXEAL_INLINE_OPT_SMALL inline #end function getDeviceFromContext(context:ALContext):ALDevice { return ALC.getDeviceFromContext(context); }

	/**
	 * Opens a device by name and returns the created device.
	 * @param deviceName Name of the device you want to open (default device name can be gotten using `getString`)
	 */
	public static #if HAXEAL_INLINE_OPT_SMALL inline #end function openDevice(deviceName:String):ALDevice { return ALC.openDevice(deviceName); }

	/**
	 * Closes the given device and returns whether the operation was successful/valid or not.
	 * @param device Device you want to close.
	 */
	public static #if HAXEAL_INLINE_OPT_SMALL inline #end function closeDevice(device:ALDevice):Bool { return al_bool(ALC.closeDevice(device)); }

	// Extensions

	/**
	 * Returns true if an extension by the given name is available on the given device.
	 * @param device Extension related device, can be left as null if the extension isnt device specific.
	 * @param extName Name of the extension to check for.
	 */
	public static #if HAXEAL_INLINE_OPT_SMALL inline #end function isExtensionPresent(?device:ALDevice, extName:String):Bool { return ALC.isExtensionPresent(device, extName); }

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
	//public static #if HAXEAL_INLINE_OPT_SMALL inline #end function getProcAddress(?device:ALDevice, funcName:String):FunctionAddress { return null; }

	/**
     * Retrieves an AL enum value (Integer) from the given name.
	 * @param device Enum related device, can be left as null if the enum isnt device specific.
     * @param enumName The enum value to get.
     */
	public static #if HAXEAL_INLINE_OPT_SMALL inline #end function getEnumValue(?device:ALDevice, enumName:String):Int return ALC.getEnumValue(device, enumName);

	// Audio Record Extension
	/**
	 * Opens a device dedicated to audio recording by name with the given recording properties and returns it.
	 * @param deviceName Name of the recording device you want to open 
	 * (default device name can be gotten using `getString` with argument `CAPTURE_DEFAULT_DEVICE_SPECIFIER`).
	 * @param captureFrequency The frequency at which to capture audio, standard is 44100.
	 * @param captureFormat The format at which to capture audio, standard is 16 bit mono.
	 * @param bufferSize The size of the recording buffer, in which recorded data will be stored (until retrieved via `captureSamples`).
	 * The default is 22050, half of the standard frequency, so in this case half a second.
	 */
	public static #if HAXEAL_INLINE_OPT_SMALL inline #end 
	function openCaptureDevice(deviceName:String, captureFrequency:Int = 44100, captureFormat:Int = HaxeAL.FORMAT_MONO16, bufferSize:Int = 22050):ALCaptureDevice {
		return ALC.openCaptureDevice(deviceName, captureFrequency, captureFormat, bufferSize);
	}

	/**
	 * Closes the given audio recording device and returns whether the operation was successful/valid or not.
	 * @param device Device you want to close.
	 */
	public static #if HAXEAL_INLINE_OPT_SMALL inline #end function closeCaptureDevice(device:ALCaptureDevice):Bool {
		return al_bool(ALC.closeCaptureDevice(device));
	}

	/**
	 * Starts capturing audio samples on the given device.
	 * @param device Device to start capturing on.
	 */
	public static #if HAXEAL_INLINE_OPT_SMALL inline #end function startCapture(device:ALCaptureDevice):Void { ALC.startCapture(device); }

	/**
	 * Stops capturing audio samples on the given device.
	 * @param device Device to stop capturing on.
	 */
	public static #if HAXEAL_INLINE_OPT_SMALL inline #end function stopCapture(device:ALCaptureDevice):Void { ALC.stopCapture(device); }

	/**
	 * Collects captured data from a devices' capture buffer and returns it as an array of bytes (use `HaxeAL.bufferDataArray` with this data).
	 * @param device Device to retrieve audio from.
	 * @param samples The amount of samples to retrieve. This amount should not be higher than `getIntegers(device, ALC_CAPTURE_SAMPLES, 1)`.
	 * The amount of time that a block of samples represents is relatives to the input devices' capturing frequency (22050 samples to retrieve at 44100hz would be 0.5 seconds)
	 * @param byteLength By default this value is 1 (FORMAT_MONO8).
     * If your format is stereo (2 channel), you should multiply this value by 2.
     * If your format is 16 bit, you should multiply the value by 2 again.
     * These multiplications stack, meaning with a `STEREO16` format your byteLength should be `4`.
	 */
	@:functionCode('
		int size = samples * byteLength;
		Array<uint8_t> output = ::Array<uint8_t>(size, size);
		void* ptr = reinterpret_cast<void*>(output->getBase());
	
		alcCaptureSamples(device, ptr, samples);
	
		return output;
	')
	public static function captureSamples(device:ALCaptureDevice, samples:Int, byteLength:Int):Array<cpp.UInt8> {
		return [0];
	}

	// Other
	/**
	 * Gets the string value of the given parameter and returns it.
	 * 
	 * If `device` isnt null, a device parameter can be obtained.
	 * @param device The device to receive the parameter of, if the parameter is tied to a device. Leave null otherwise.
	 * @param param Parameter to get
	 */
	public static #if HAXEAL_INLINE_OPT_SMALL inline #end function getString(?device:ALDevice, param:Int):String { return ALC.getString(device, param); }

	/**
	 * Returns a device-specific error code, if there is any error.
	 * @param device Device to check on for errors.
	 */
	public static #if HAXEAL_INLINE_OPT_SMALL inline #end function getError(?device:ALDevice):Int { return ALC.getError(device); }

	/**
	 * Returns integers related to the given parameter of the current context for the `device` (or none if its not device specific).
	 * @param device Device for device specific integer values
	 * @param param Parameter to get values of
	 * @param argumentCount Amount of array objects you expect to return
	 */
	public static #if HAXEAL_INLINE_OPT_BIG inline #end function getIntegers(device:ALDevice, param:Int, argumentCount:Int):Array<Int> {
		var arr:Array<Int> = untyped __cpp__('::Array<int>({0}, {0})', argumentCount);
        ALC.getIntegers(device, param, argumentCount, untyped __cpp__('reinterpret_cast<int*>({0}->getBase())', arr));
		
        return arr;
    };
}