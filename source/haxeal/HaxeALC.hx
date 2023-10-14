package haxeal;

import haxeal.bindings.ALC;
import haxeal.bindings.BinderHelper.*; // Import all binder functions
import haxeal.ALObjects.ALDevice;
import haxeal.ALObjects.ALBuffer;
import haxeal.ALObjects.ALCaptureDevice;
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

	public static function makeContextCurrent(context:ALContext):Bool { return al_bool(ALC.makeContextCurrent(context)); }

	public static function getCurrentContext():ALContext { return ALC.getCurrentContext(); }

	public static function processContext(context:ALContext):Void { ALC.processContext(context); }

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

	// Audio Record Extension

	/**
	 * Opens a device for OpenAL Audio Capture by name and returns the created device.
	 * @param deviceName Name of the device you want to open (default device name can be gotten using `getString`)
	 * @param captureFrequency Frequency you want your captured audio to be in. (44100 is recommended)
	 * @param captureFormat Format you want your captured audio to be in. (AL.FORMAT_MONO/STEREO8/16)
	 * @param sampleRate The sample rate you wanna capture in (Alternatively: Buffer size) 
	 */
	public static function openCaptureDevice(deviceName:String, captureFrequency:Int, captureFormat:Int, sampleRate:Int):ALCaptureDevice {
		return ALC.openCaptureDevice(deviceName, captureFrequency, captureFormat, sampleRate);
	}

	/**
	 * Closes an OpenAL Audio Capture device and returns true if the action was successful.
	 * @param device The device to close.
	 */
	public static function closeCaptureDevice(device:ALCaptureDevice):Bool { return al_bool(ALC.closeCaptureDevice(device)); }

	/**
	 * Starts a capture operation on the given device.
	 * @param device Device to start capturing audio on.
	 */
	public static function startCapture(device:ALCaptureDevice):Void { ALC.startCapture(device); }

	/**
	 * Stops a capture operation on the given device.
	 * @param device Device to stop capturing audio on.
	 */
	public static function stopCapture(device:ALCaptureDevice):Void { ALC.stopCapture(device); }

	/**
	 * This function completes a capture operation started by `startCapture`, and does not block.
	 * 
	 * Returns a buffer with `samples` amount of samples in the form of `haxe.io.BytesData`, which using `haxe.io.Bytes.ofData()` can be turned to listenable data.
	 * 
	 * @param device The device that is capturing the samples (must be specific capture device).
	 * @param samples Samples to load into the given buffer, check the CAPTURE_SAMPLES property of your capture device to check how many samples are up for capture. Max Amount is 1024
	 */
	public static function captureSamples(device:ALCaptureDevice, samples:Int):haxe.io.BytesData {
		final realsamples = Std.int(Math.min(1024, samples));

		var n:cpp.UInt8 = 123456789;
        var istr:Pointer<cpp.UInt8> = Pointer.addressOf(n);
        ALC.captureSamples(device, istr.ptr, realsamples);
        return star_ToArrayUInt8(istr.ptr, realsamples); //! Mess with sample length
	}

	/*
	@:functionCode('
		ALubyte* buf;
		alcCaptureSamples(dev, buf, samples);
		cout << "we live ";
		arr->setData(buf, samples);
		cout << "we love ";

		return arr;
	')
	private static function captureSampleExec(dev:ALCaptureDevice, samples:Int, arr:Array<cpp.UInt8>):haxe.io.BytesData {
		throw 'INVALID FUNCTIONCODE?';
	}*/

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

	public static function getIntegers(device:ALDevice, param:Int, argumentCount:Int):Array<Int> {
        var n = 123456789;
		var istr:Pointer<Int> = Pointer.addressOf(n);
        ALC.getIntegers(device, param, argumentCount, istr.ptr);
        return star_ToArrayInt(istr.ptr, argumentCount);
    };
}