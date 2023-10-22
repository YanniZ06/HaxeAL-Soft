package;

//import haxeal.bindings.*;
import haxe.io.Bytes;
import cpp.Pointer;
import haxe.io.BytesBuffer;
import sys.io.FileOutput;
import haxe.Int32;
import haxeal.bindings.ALC;
import haxeal.ALObjects;
import haxeal.HaxeALC;
import haxeal.HaxeEFX;
import haxeal.HaxeAL;

import haxeal.bindings.BinderHelper;

// These will be removed when the bindings are re-translated, for now they are necessary
import cpp.ConstCharStar;
import haxe.io.BytesData;
//import cpp.ConstStar;
import cpp.Char;
import cpp.UInt8;
import cpp.Star;

typedef Recorder = {
	var device:ALCaptureDevice;
	var fileBytes:FileOutput;
	var dataSizeOffset:Int;
	var dataSize:Int;
	var rectime:Float;
	var channels:cpp.UInt32;
	var bits:cpp.UInt32;
	var sampleRate:cpp.UInt32;
	var frameSize:cpp.UInt32;
	var buffer:Array<cpp.UInt8>;
	var bufferSize:Int32;
};

@:buildXml('<include name="../builder.xml" />')
class Main {
	static var device:ALDevice;
	static var context:ALContext;

	static function main() {
		var name:String = ALC.getString(null, 0x1005);
		trace(name);
		device = ALC.openDevice(name);
		if(device != null) {
			var efx_available = HaxeAL.isExtensionPresent("ALC_EXT_EFX");
			final attributes:Null<Array<Int>> = efx_available ? [HaxeEFX.MAX_AUXILIARY_SENDS, 15] : null; 

			context = HaxeALC.createContext(device, attributes);
			if(context != null) trace(HaxeALC.makeContextCurrent(context));
			final max_efx_per_sound = efx_available ? HaxeALC.getIntegers(device, HaxeEFX.MAX_AUXILIARY_SENDS, 1)[0] : 0;
			trace(max_efx_per_sound);

			HaxeAL.getErrorString(HaxeALC.getError(device));

			// ? EXPERIMENTAL
			//trace(haxeal.HaxeALC.getIntegers(device, HaxeALC.MINOR_VERSION, 2));
	
		}
		
		/*HaxeAL.listenerfv(HaxeAL.ORIENTATION, [
			1, 0, 0,
			0, 1, 0
		]);*/
		var voidptr = BinderHelper.toVoidPtr("Hello from Void Pointer!");
		trace(BinderHelper.fromVoidPtr(voidptr));

		HaxeAL.listener3f(HaxeAL.POSITION, 0, 0, 2);
		trace(HaxeAL.getListenerfv(HaxeAL.POSITION));
		trace(HaxeAL.getListener3f(HaxeAL.POSITION));
		HaxeAL.getErrorString(HaxeAL.getError());
		HaxeAL.listenerf(HaxeAL.GAIN, 1);

		var src = HaxeAL.createSource();
		trace(HaxeAL.isSource(src));

		var buf = HaxeAL.createBuffer();
		trace(HaxeAL.isBuffer(buf));
		HaxeAL.getErrorString(HaxeAL.getError());

		trace('EFFECT TESTING!');
		trace(HaxeALC.isExtensionPresent(null, 'ALC_EXT_EFX')); 

		HaxeEFX.initEFX();

		trace("effects have been initialized");

		/*
		var effect = HaxeEFX.createEffect();
		HaxeEFX.effecti(effect, HaxeEFX.EFFECT_TYPE, HaxeEFX.EFFECT_REVERB);
		HaxeEFX.effectf(effect, HaxeEFX.REVERB_DECAY_TIME, 10); // 10 second decay time reverb is a good idea - nobody ever
		trace(effect);

		var aux = HaxeEFX.createAuxiliaryEffectSlot();
		HaxeEFX.auxiliaryEffectSloti(aux, HaxeEFX.EFFECTSLOT_EFFECT, effect); // Apply effect to the aux
		HaxeEFX.auxiliaryEffectSloti(aux, HaxeEFX.EFFECTSLOT_AUXILIARY_SEND_AUTO, HaxeAL.FALSE);
		HaxeAL.source3i(src, HaxeEFX.AUXILIARY_SEND_FILTER, aux, 1, HaxeEFX.FILTER_NULL);*/

		// Sound Playback
		/* sound_test.DataLoader.parseWAV('assets/testMono.wav', buf);
		HaxeAL.getErrorString(HaxeAL.getError());

		HaxeAL.sourcei(src, HaxeAL.BUFFER, buf);
		HaxeAL.sourcefv(src, HaxeAL.POSITION, [8, 0, 0]);
		HaxeAL.sourcePlay(src);
		*/
		/*var bytes = sound_test.DataLoader.wavBytes('assets/testMono.wav');
		var byte_arr = bytes.getData();
		var byteArrays:Array<Array<cpp.UInt8>> = [];
		var lengthPerArr = Math.ceil(byte_arr.length / 10);
		trace(lengthPerArr);
		for(i in 0...10) {
			byteArrays.push(byte_arr.slice(lengthPerArr * i, lengthPerArr * (i+1)));
			trace(i);
		}

		var byteOutput:haxe.io.BytesOutput = new haxe.io.BytesOutput();
		for(i in 0...10) {
			byteOutput.write(haxe.io.Bytes.ofData(byteArrays[i]));
			//trace(byteOutput.getBytes());

			trace(i);
		}

		var bytey = byteOutput.getBytes();
		HaxeAL.bufferData(buf, HaxeAL.FORMAT_STEREO16, bytey, bytey.length, 44100);
		HaxeAL.getErrorString(HaxeAL.getError());

		HaxeAL.sourcei(src, HaxeAL.BUFFER, buf);
		HaxeAL.sourcefv(src, HaxeAL.POSITION, [8, 0, 0]);
		HaxeAL.sourcePlay(src);*/


		// Audio Recording
		
		var mic = HaxeALC.openCaptureDevice(HaxeALC.getString(null, HaxeALC.CAPTURE_DEFAULT_DEVICE_SPECIFIER), 44100, HaxeAL.FORMAT_STEREO16, 44100);
		trace("Setup Mic: " + HaxeALC.getString(null, HaxeALC.CAPTURE_DEFAULT_DEVICE_SPECIFIER));
		HaxeALC.startCapture(mic);

		//sys.thread.Thread.create(() -> {
		var sampleSum:Int = 0;
		final reqData:Int = 44100 * 5; // 5 Seconds of audio

		var byteOutput:haxe.io.BytesOutput = new haxe.io.BytesOutput();

		trace("Recording audio for 5 seconds..");
		while(sampleSum < reqData) {
			trace("loop start");
			final samplesNum = HaxeALC.getIntegers(mic, HaxeALC.CAPTURE_SAMPLES, 1)[0];
			if(samplesNum < 1) continue;
			//if(rowLoops > 0) trace('WOAH $rowLoops LOOPS IN A ROW??');
			//rowLoops++;
			trace("Captured samples!");
			sampleSum += samplesNum;
			trace('Sample sum is $sampleSum');

			var samples = HaxeALC.captureSamples(mic, samplesNum);
			//trace(samples);
			var bytesToWrite = haxe.io.Bytes.ofData(samples);
			byteOutput.write(bytesToWrite); //.write(bytesToWrite);

			trace("written");
			//Sys.sleep(0.025);
			//trace(byteOutput.getBytes());

		}
		trace("Audio recorded!");

		HaxeALC.stopCapture(mic);
		HaxeALC.closeCaptureDevice(mic);
		//});

		// Mic Audio Playback
		var bytes = byteOutput.getBytes();
		HaxeAL.bufferData(buf, HaxeAL.FORMAT_STEREO16, bytes, bytes.length, 22500);
		HaxeAL.getErrorString(HaxeAL.getError());

		HaxeAL.sourcei(src, HaxeAL.BUFFER, buf);
		HaxeAL.sourcefv(src, HaxeAL.POSITION, [8, 0, 0]);
		HaxeAL.sourcePlay(src);
		trace("Playing back recorded audio!");


		var stepper:Float = 8;
		//var decayTime = curTime + 7;
		var decayTime = 6; // 18 for reverb ig
		var timeStep:Float = 0;
		trace(HaxeAL.getSourcef(src, HaxeAL.BYTE_OFFSET));
		while(true) {
			HaxeAL.sourcefv(src, HaxeAL.POSITION, [stepper, 0, 0]);
			stepper -= 0.1;
			timeStep += 0.1;
			Sys.sleep(0.075);
			if(timeStep > decayTime) break;
		}
		trace(stepper);
		trace(HaxeAL.getSourcef(src, HaxeAL.BYTE_OFFSET));

		HaxeAL.sourceStop(src);
		HaxeAL.sourcei(src, HaxeAL.BUFFER, HaxeAL.NONE);

		HaxeAL.deleteBuffer(buf);
		HaxeAL.deleteSource(src);
		

		//? Ziads Code
		/*
		var str:String = "record.wav";
		var deviceName:String = null;
		var recorder:Recorder = {device: null, fileBytes: null, dataSizeOffset: 0, dataSize: 0, rectime: 4.0, channels: 1, bits: 16, sampleRate: 44100, frameSize: 2, buffer: null, bufferSize: 0};
		var totalSize:Int = 0;
		var format:Int = 0x1101;
		
		recorder.device = HaxeALC.openCaptureDevice(HaxeALC.getString(null, HaxeALC.CAPTURE_DEFAULT_DEVICE_SPECIFIER), 44100, format, 32768);
		trace("open device");
		recorder.fileBytes = sys.io.File.write(str, true);
		recorder.fileBytes.writeString("RIFF");
		recorder.fileBytes.writeInt32(0xFFFFFFFF);
		recorder.fileBytes.writeString("WAVE");
		recorder.fileBytes.writeString("fmt ");
		recorder.fileBytes.writeInt32(18);
		recorder.fileBytes.writeUInt16(0x0001);
		recorder.fileBytes.writeUInt16(1);
		recorder.fileBytes.writeInt32(44100);
		recorder.fileBytes.writeInt32(recorder.sampleRate*recorder.frameSize);
		recorder.fileBytes.writeUInt16(recorder.frameSize);
		recorder.fileBytes.writeUInt16(recorder.bits);
		recorder.fileBytes.writeUInt16(0);
		recorder.fileBytes.writeString("data");
		recorder.fileBytes.writeInt32(0xFFFFFFFF);
		trace("starting capture rn");
		recorder.dataSizeOffset = recorder.fileBytes.tell() - 4;
		HaxeALC.startCapture(recorder.device);
		while(recorder.dataSize/recorder.sampleRate < recorder.rectime){
			final count = HaxeALC.getIntegers(recorder.device, HaxeALC.CAPTURE_SAMPLES, 1)[0];
			trace(count);
			//if (count > recorder.bufferSize){
			//	@:privateAccess
			//	final bytes:haxe.io.Bytes = new haxe.io.Bytes(count, recorder.frameSize);
			//	recorder.buffer = null;
			//	recorder.buffer = cast(bytes.getData());
			//	recorder.bufferSize = count;
			//}
			if (count > recorder.bufferSize){
				recorder.buffer = null;
				trace("got rid of you");
				recorder.buffer = HaxeALC.captureSamples(recorder.device, count);
				trace("new");
				recorder.bufferSize = count;
				trace("b");
				
				for (i in 0...count*recorder.channels){
					//trace(recorder.buffer.length);
					//trace(i*2);
					var b:cpp.UInt8 = recorder.buffer[i*2 + 0];
					recorder.buffer[i*2 + 0] = recorder.buffer[i*2 + 1];
					recorder.buffer[i*2 + 1] = b;
				}
				trace("trying to make of data");
				trace(recorder.buffer);
				final data:Bytes = Bytes.ofData(recorder.buffer);
				trace("done");
				recorder.dataSize += recorder.buffer.length;
				trace(recorder.dataSize);
				//it crashes on 236
				//the writing is what crashes for whatever reason not the data itself
				recorder.fileBytes.write(data);
				trace("done again");
			}
		}

		HaxeALC.stopCapture(recorder.device);

		HaxeALC.closeCaptureDevice(recorder.device);
		
		recorder.fileBytes.seek(recorder.dataSizeOffset, SeekBegin);

		recorder.fileBytes.writeInt32(recorder.dataSize * recorder.frameSize);

		recorder.fileBytes.seek(4, SeekBegin);
		recorder.fileBytes.writeInt32(recorder.fileBytes.tell() - 8);
		
		recorder.fileBytes.flush();
		recorder.fileBytes.close();*/

		trace("ENDED!");

		trace(context);
	}

	public static function createContext(device:ALDevice, ?attributes:Array<Int>):ALContext {
		return ALC.createContext(device, attributes != null ? haxeal.bindings.BinderHelper.arrayInt_ToPtr(attributes) : null);
	}
}