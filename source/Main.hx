package;

import haxeal.ALObjects.ALBuffer;
import haxeal.ALObjects.ALSource;
import haxeal.ALObjects.ALDevice;
import haxeal.ALObjects.ALContext;

import haxeal.*;
class Main {
    static var device:ALDevice;
	static var context:ALContext;

    static function main() {
        // trace(HaxeAL.getString(HaxeAL.VERSION));
		// HaxeAL.getErrorString(HaxeAL.getError());

        var name:String = HaxeALC.getString(null, HaxeALC.DEVICE_SPECIFIER);
		trace(name);
		device = HaxeALC.openDevice(name);
		if(device != null) {
            HaxeEFX.initEFX();

            final possibleDevices = HaxeALC.getString(HaxeALC.ALL_DEVICES_SPECIFIER);
            trace(possibleDevices);

            var efx_available = HaxeALC.isExtensionPresent("ALC_EXT_EFX");
            trace(efx_available);
			final attributes:Null<Array<Int>> = efx_available ? [HaxeEFX.MAX_AUXILIARY_SENDS, 15] : null; 

			context = HaxeALC.createContext(device, attributes);
			if(context != null) trace(HaxeALC.makeContextCurrent(context));

			final max_efx_per_sound = efx_available ? HaxeALC.getIntegers(device, HaxeEFX.MAX_AUXILIARY_SENDS, 1)[0] : 0;
			trace(max_efx_per_sound);

			HaxeAL.getErrorString(HaxeALC.getError(device));

			// ? EXPERIMENTAL
			//trace(haxeal.HaxeALC.getIntegers(device, HaxeALC.MINOR_VERSION, 2));
	
		}

		HaxeAL.listener3f(HaxeAL.POSITION, 0, 0, 2);
		trace(HaxeAL.getListenerfv(HaxeAL.POSITION));
		trace(HaxeAL.getListener3f(HaxeAL.POSITION));
		HaxeAL.getErrorString(HaxeAL.getError());
		HaxeAL.listenerf(HaxeAL.GAIN, 1);

		var src = HaxeAL.createSource();
		trace(HaxeAL.isSource(src));

		/*var buf = HaxeAL.createBuffer();
		trace(HaxeAL.isBuffer(buf));
		HaxeAL.getErrorString(HaxeAL.getError());*/

        trace(HaxeAL.getString(HaxeAL.VERSION));
		HaxeAL.getErrorString(HaxeAL.getError());

		// Mic Tests (Based off of example code at https://stackoverflow.com/questions/4087727/openal-how-to-create-simple-microphone-echo-programm for example!)
		
		// Retrieving the default capture device with default parameters
		var mic = HaxeALC.openCaptureDevice(HaxeALC.getString(null, HaxeALC.CAPTURE_DEFAULT_DEVICE_SPECIFIER));

		var bufs:Array<ALBuffer> = HaxeAL.createBuffers(16);



        /*trace("testing AL base components.");

        trace(HaxeAL.getString(HaxeAL.VERSION));
		HaxeAL.getErrorString(HaxeAL.getError());

        HaxeAL.getErrorString(HaxeALC.getError());

        var buf:ALBuffer = 0; buf = HaxeAL.createBuffer();
        trace(HaxeAL.isBuffer(buf));

        HaxeEFX.initEFX();*/
    }
}