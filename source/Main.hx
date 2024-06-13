package;

import haxe.display.Server.ModuleId;
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

		/*HaxeAL.listener3f(HaxeAL.POSITION, 0, 0, 2);
		trace(HaxeAL.getListenerfv(HaxeAL.POSITION));
		trace(HaxeAL.getListener3f(HaxeAL.POSITION));
		HaxeAL.getErrorString(HaxeAL.getError());
		HaxeAL.listenerf(HaxeAL.GAIN, 1);*/

		var src = HaxeAL.createSource();
		trace(HaxeAL.isSource(src));
		
		var effect = HaxeEFX.createEffect();
		HaxeEFX.effecti(effect, HaxeEFX.EFFECT_TYPE, HaxeEFX.EFFECT_EAXREVERB);

		var aux = HaxeEFX.createAuxiliaryEffectSlot();
		HaxeEFX.auxiliaryEffectSloti(aux, HaxeEFX.EFFECTSLOT_EFFECT, effect);
		HaxeEFX.auxiliaryEffectSloti(aux, HaxeEFX.EFFECTSLOT_AUXILIARY_SEND_AUTO, HaxeAL.FALSE);

		// Apply effect
		HaxeAL.source3i(src, HaxeEFX.AUXILIARY_SEND_FILTER, aux, 0, HaxeEFX.FILTER_NULL);

		//HaxeAL.sourcei(src, HaxeEFX.AUXI)

		/*var buf = HaxeAL.createBuffer();
		trace(HaxeAL.isBuffer(buf));
		HaxeAL.getErrorString(HaxeAL.getError());*/

        trace(HaxeAL.getString(HaxeAL.VERSION));
		HaxeAL.getErrorString(HaxeAL.getError());

		// Mic Tests (Based off of example code at https://stackoverflow.com/questions/4087727/openal-how-to-create-simple-microphone-echo-programm for example!)
		
		// Retrieving the default capture device with default parameters
		var defDevice = HaxeALC.getString(null, HaxeALC.CAPTURE_DEFAULT_DEVICE_SPECIFIER);
		trace("Default Mic: " + defDevice);
		var mic = HaxeALC.openCaptureDevice(defDevice);
		HaxeAL.getErrorString(HaxeALC.getError(mic));

		var al_bufs:haxe.ds.List<ALBuffer> = new haxe.ds.List<ALBuffer>();
		for(buf in HaxeAL.createBuffers(16)) al_bufs.push(buf);

		final captureSize:Int = 2048; // Samples to capture at a time
		var micData:cpp.Star<cpp.Void>;
		var bufsProcessed:Int = 0; // Buffers to be recovered
		var time = haxe.Timer.stamp();
		var finished:Bool = false;

		HaxeALC.startCapture(mic);
		trace("Starting capture!");
		while(true) {
			if(haxe.Timer.stamp() - time > 10) break;

			Sys.sleep(0.01); // Prevent CPU over-usage
			bufsProcessed = HaxeAL.getSourcei(src, HaxeAL.BUFFERS_PROCESSED);
			if(bufsProcessed > 0) {
				for(buf in HaxeAL.sourceUnqueueBuffers(src, bufsProcessed)) { al_bufs.push(buf); }
			}
			final samples = HaxeALC.getIntegers(mic, HaxeALC.CAPTURE_SAMPLES, 1)[0];
			if(samples < captureSize) continue; // Not sufficent data available
			
			micData = HaxeALC.captureSamples(mic, captureSize);
			//var cMicData:cpp.Star<cpp.Int16> = cast micData;
			// trace(cpp.Pointer.fromStar(cMicData).toUnmanagedArray(captureSize));
			
			if(al_bufs.length == 0) continue; // Drop data if no buffer can hold it :(
			var dataBuf:ALBuffer = al_bufs.last();
			al_bufs.remove(dataBuf);

			HaxeAL.bufferData_PCM(dataBuf, HaxeAL.FORMAT_MONO16, micData, captureSize * 2, 44100);
			HaxeAL.sourceQueueBuffers(src, [dataBuf]);

			if(HaxeAL.getSourcei(src, HaxeAL.SOURCE_STATE) != HaxeAL.PLAYING) {
				HaxeAL.sourcePlay(src); // Play back distorted voice
			}
		}
		trace("Ending capture!");
		HaxeALC.stopCapture(mic);
		HaxeALC.closeCaptureDevice(mic);
		HaxeAL.sourceStop(src);



        /*trace("testing AL base components.");

        trace(HaxeAL.getString(HaxeAL.VERSION));
		HaxeAL.getErrorString(HaxeAL.getError());

        HaxeAL.getErrorString(HaxeALC.getError());

        var buf:ALBuffer = 0; buf = HaxeAL.createBuffer();
        trace(HaxeAL.isBuffer(buf));

        HaxeEFX.initEFX();*/
    }
}