package;

import haxeal.bindings.FlagChecker;
import haxeal.ALObjects.ALAuxSlot;
import haxeal.ALObjects.ALAuxSlot;
import haxeal.ALObjects.ALEffect;
import cpp.UInt8;
import sys.thread.Thread;
import haxeal.ALObjects.ALBuffer;
import haxeal.ALObjects.ALSource;
import haxeal.ALObjects.ALDevice;
import haxeal.ALObjects.ALContext;

import haxeal.*;

/**
 * This is an example class!
 * 
 * To test me locally, move this file into the source folder and the `build.hxml` file outside of it.
 */
class Main {
    static var device:ALDevice;
	static var context:ALContext;

    static function main() {
		// todo: try sys.io.Process here, try setting current working directory to exact path file was started in then setting env variables, 
		// ! done: sys command, sys put env & process on init macro (did nothing)
		// ! done here: sys command seperate, sys command combined, env put regular
		//Sys.putEnv('ALSOFT_LOGLEVEL', '3');
		//Sys.putEnv('ALSOFT_LOGFILE', 'openal_log.txt');
		Sys.command('cd');
		Sys.command('cd output && set ALSOFT_LOGLEVEL=3 && set ALSOFT_LOGFILE=openal_log.txt');
		Sys.command('cd');
		Sys.command('set ALSOFT_LOGLEVEL=' + Std.string('3'));
        Sys.command('set ALSOFT_LOGFILE=openal_log.txt');
        // trace(HaxeAL.getString(HaxeAL.VERSION));
		// HaxeAL.getErrorString(HaxeAL.getError());

		// Initialize OpenAL and check for EFX
        var name:String = HaxeALC.getString(null, HaxeALC.DEVICE_SPECIFIER);
		var efx_available:Bool = false;
		var efx_target_available:Bool = false;
		
		trace("Found Audio device: " + name);
		device = HaxeALC.openDevice(name);
		if(device == null) {
			HaxeAL.getErrorString(HaxeALC.getError(null));
			throw 'Could not load example, device couldnt be accessed.';
		}

		HaxeEFX.initEFX();

		final possibleDevices = HaxeALC.getString(HaxeALC.ALL_DEVICES_SPECIFIER);
		trace("Possible devices are: " + possibleDevices);

		efx_available = HaxeALC.isExtensionPresent(device, "ALC_EXT_EFX");
		HaxeAL.getErrorString(HaxeALC.getError());
		trace("EFX is available: " + efx_available);

		final attributes:Null<Array<Int>> = efx_available ? [HaxeEFX.MAX_AUXILIARY_SENDS, 15] : null; 

		context = HaxeALC.createContext(device, attributes);
		if(context == null || !HaxeALC.makeContextCurrent(context)) {
			HaxeAL.getErrorString(HaxeALC.getError(null));
			throw 'Could not load example, context couldnt be configured properly.';
		}

		final direct_channels_available = HaxeAL.isExtensionPresent(HaxeAL.EXT_DIRECT_CHANNELS_NAME);
		trace("Direct channels are available: " + direct_channels_available);

		final audio_spatialize_available = HaxeAL.isExtensionPresent(HaxeAL.EXT_SPATIALIZE_SOURCE_NAME);
		trace("Audio spatialization is available: " + audio_spatialize_available);

		final max_efx_per_sound = efx_available ? HaxeALC.getIntegers(device, HaxeEFX.MAX_AUXILIARY_SENDS, 1)[0] : 0;
		trace("Max amount of efx/aux slots per sound: " + max_efx_per_sound);

		efx_target_available = HaxeAL.isExtensionPresent("AL_SOFT_effect_target");
		trace("AL_SOFT_effect_target is available: " + efx_target_available);



		// Setting up a basic source with a reverb effect (unless EFX is not supported)
		var src = HaxeAL.createSource();
		
		if (audio_spatialize_available)
			HaxeAL.sourcei(src, HaxeAL.SOURCE_SPATIALIZE_SOFT, HaxeAL.TRUE);

		HaxeAL.source3f(src, HaxeAL.POSITION, 0, 0, 0);
		trace(HaxeAL.getSource3f(src, HaxeAL.POSITION));

		var effect:ALEffect = 0;
		var effect2:ALEffect = 0;
		var aux:ALAuxSlot = 0;
		var aux2:ALAuxSlot = 0;
		if(efx_available) {
			effect = HaxeEFX.createEffect();
			HaxeEFX.effecti(effect, HaxeEFX.EFFECT_TYPE, HaxeEFX.EFFECT_PITCH_SHIFTER);
			//HaxeEFX.effectf(effect, HaxeEFX.PITCH_SHIFTER_COARSE_TUNE, -12);

			effect2 = HaxeEFX.createEffect();
			HaxeEFX.effecti(effect2, HaxeEFX.EFFECT_TYPE, HaxeEFX.EFFECT_ECHO);

			aux = HaxeEFX.createAuxiliaryEffectSlot();
			HaxeEFX.auxiliaryEffectSloti(aux, HaxeEFX.EFFECTSLOT_EFFECT, effect);
			//HaxeEFX.auxiliaryEffectSloti(aux, HaxeEFX.EFFECTSLOT_AUXILIARY_SEND_AUTO, HaxeAL.FALSE);

			aux2 = HaxeEFX.createAuxiliaryEffectSlot();
			HaxeEFX.auxiliaryEffectSloti(aux2, HaxeEFX.EFFECTSLOT_EFFECT, effect2);
			//HaxeEFX.auxiliaryEffectSloti(aux2, HaxeEFX.EFFECTSLOT_AUXILIARY_SEND_AUTO, HaxeAL.FALSE);

			// Apply effect
			HaxeAL.source3i(src, HaxeEFX.AUXILIARY_SEND_FILTER, aux, 0, HaxeEFX.FILTER_NULL);
			HaxeAL.source3i(src, HaxeEFX.AUXILIARY_SEND_FILTER, aux2, 1, HaxeEFX.FILTER_NULL);
		}

		final reroute:Bool = true; // Whether to use the extension or not (to test the differences)
		if(efx_target_available && reroute) {
			HaxeAL.source3i(src, HaxeEFX.AUXILIARY_SEND_FILTER, 0, 1, HaxeEFX.FILTER_NULL);

			HaxeEFX.auxiliaryEffectSloti(aux, HaxeEFX.EFFECTSLOT_TARGET_SOFT, aux2);
		}

		//? Microphone direct playback example!
		// (Based off of example code at https://stackoverflow.com/questions/4087727/openal-how-to-create-simple-microphone-echo-programm for example!)
		
		// Retrieving the default capture device with default parameters
		var defDevice = HaxeALC.getString(null, HaxeALC.CAPTURE_DEFAULT_DEVICE_SPECIFIER);
		trace("Default Mic: " + defDevice);

		// Setting up the capturing format
		final format = HaxeAL.FORMAT_MONO8;

		var sizeMultiplier = 1; // Automatically set depending on the format
		if(format > HaxeAL.FORMAT_MONO8) sizeMultiplier *= 2;
		if(format > HaxeAL.FORMAT_STEREO8) sizeMultiplier *= 2;

		// Finally open the microphone
		var mic = HaxeALC.openCaptureDevice(defDevice, 44100, format);
		HaxeAL.getErrorString(HaxeALC.getError(mic));

		// Making a list of reuseable buffers (we need to use a list because an array creates reference problems!)
		var al_bufs:haxe.ds.List<ALBuffer> = new haxe.ds.List<ALBuffer>();
		var genBufs:Array<ALBuffer> = HaxeAL.createBuffers(16); // We define this seperately so we can clean it up faster later
		for(buf in genBufs) al_bufs.push(buf);

		// Properties for our recording loop
		var micData:cpp.Star<cpp.Void>; // Buffer to hold one batch of recorded samples temporarily until we feed it to one of our al buffers


		// Samples to capture at a time. When this value becomes larger, the delay between when your voice is played back becomes too!
		// Its recommended to keep this value relatively low in most cases like here, where we want to almost directly play back or generally handle audio.
		// In a different example where we'd just want to record a lot of data and handle it later we can set this to a large number 
		// (In that case we also wouldnt need to use a buffer queue)
		final captureSize:Int = 1024;
		var bufsProcessed:Int = 0; // The amount of buffers our source finished using so we can recover them using unqueue
		
		var time = haxe.Timer.stamp();
		var finished:Bool = false;
		var traced:Bool = false;

		HaxeALC.startCapture(mic);
		trace("Starting capture!");
		while(true) {
			if(haxe.Timer.stamp() - time > 10) break;

			Sys.sleep(0.01); // Prevent CPU over-usage

			// Check how many buffers the source has finished playing back so we can put them back into the reuseable buffer list
			bufsProcessed = HaxeAL.getSourcei(src, HaxeAL.BUFFERS_PROCESSED);
			if(bufsProcessed > 0) {
				for(buf in HaxeAL.sourceUnqueueBuffers(src, bufsProcessed)) { al_bufs.push(buf); }
			}
			final samples = HaxeALC.getIntegers(mic, HaxeALC.CAPTURE_SAMPLES, 1)[0];
			if(samples < captureSize) continue; // Not sufficent data available to fill a buffer, restarting the loop
			
			micData = HaxeALC.captureSamples(mic, captureSize, sizeMultiplier);
			
			// After 2 seconds we log back one viewable sample batch for testing
			if(!traced && haxe.Timer.stamp() - time > 2) {
				traced = true;

				var cMicData:cpp.Star<UInt8> = cast micData;
				Thread.create(() -> {
					trace(cpp.Pointer.fromStar(cMicData).toUnmanagedArray(captureSize));
				});
			}
			
			if(al_bufs.length == 0) continue; // If there are no reuseable buffers available right now we skip this sample batch
			var dataBuf:ALBuffer = al_bufs.last();
			al_bufs.remove(dataBuf); // We want to make sure our buffer isnt reused before the source is done using it!

			// Now we feed the raw recorded PCM data into our obtained buffer
			HaxeAL.bufferData_PCM(dataBuf, format, micData, captureSize * sizeMultiplier, 44100);
			HaxeAL.sourceQueueBuffers(src, [dataBuf]);

			if(HaxeAL.getSourcei(src, HaxeAL.SOURCE_STATE) != HaxeAL.PLAYING) {
				HaxeAL.sourcePlay(src); // Finally, we play back your beautiful, echoed voice :)
			}
		}
		trace("Ending capture!");
		HaxeALC.stopCapture(mic);
		HaxeALC.closeCaptureDevice(mic);

		// If you want the recorded audio to finish playing and not abruptly end, use this.
		/*
		var bufsQueued = HaxeAL.getSourcei(src, HaxeAL.BUFFERS_QUEUED);
		while(bufsQueued > 0) {
			Sys.sleep(0.2);
			bufsProcessed = HaxeAL.getSourcei(src, HaxeAL.BUFFERS_PROCESSED);
			if(bufsProcessed > 0) {
				for(buf in HaxeAL.sourceUnqueueBuffers(src, bufsProcessed)) { 
					al_bufs.push(buf); 
					bufsQueued--;
				}
			}
		}
		*/
		HaxeAL.sourceStop(src);
		
		// Bare in mind you should only clean-up what you dont need anymore!!
		if(efx_available) {
			HaxeEFX.auxiliaryEffectSloti(aux, HaxeEFX.EFFECTSLOT_EFFECT, 0); // Unbind effect from aux slot
			HaxeAL.source3i(src, HaxeEFX.AUXILIARY_SEND_FILTER, 0, 0, HaxeEFX.FILTER_NULL); // Unbind aux slot from source

			HaxeEFX.auxiliaryEffectSloti(aux2, HaxeEFX.EFFECTSLOT_EFFECT, 0); // Unbind effect from aux slot
			if(!efx_target_available || !reroute) HaxeAL.source3i(src, HaxeEFX.AUXILIARY_SEND_FILTER, 0, 1, HaxeEFX.FILTER_NULL); // Unbind aux slot from source
			else HaxeEFX.auxiliaryEffectSloti(aux, HaxeEFX.EFFECTSLOT_TARGET_SOFT, 0); // Unbind aux 2 from aux 1

			// Delete both
			HaxeEFX.deleteAuxiliaryEffectSlots([aux, aux2]);
			HaxeEFX.deleteEffects([effect, effect2]);
		}
		HaxeAL.sourcei(src, HaxeAL.BUFFER, 0); // We unbind the buffers so we can delete it along with the source (unbound buffers cannot be deleted!)
		HaxeAL.deleteSource(src);
		trace(genBufs);
		HaxeAL.deleteBuffers(genBufs);
		HaxeAL.getErrorString(HaxeAL.getError());

		trace(Sys.getEnv('ALSOFT_LOGLEVEL'));
		trace(Sys.getEnv('ALSOFT_LOGFILE'));
		
		// Exit context and close audio playback device (Only necessary when we shutdown the app or do anything else)
		HaxeALC.makeContextCurrent(null); // Also unbind context before destroying it
		HaxeALC.destroyContext(context);
		HaxeALC.closeDevice(device);
		Sys.sleep(2);
    }
}