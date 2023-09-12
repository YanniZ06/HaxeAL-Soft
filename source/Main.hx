package;

//import haxeal.bindings.*;
import haxeal.bindings.ALC;
import haxeal.ALObjects;
import haxeal.HaxeALC;
import haxeal.HaxeEFX;
import haxeal.HaxeAL;

import haxeal.bindings.BinderHelper;

// These will be removed when the bindings are re-translated, for now they are necessary
import cpp.ConstCharStar;
//import cpp.ConstStar;
import cpp.Char;
import cpp.UInt8;
import cpp.Star;

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

		var effect = HaxeEFX.createEffect();
		HaxeEFX.effecti(effect, HaxeEFX.EFFECT_TYPE, HaxeEFX.EFFECT_REVERB);
		HaxeEFX.effectf(effect, HaxeEFX.REVERB_DECAY_TIME, 10); // 10 second decay time reverb is a good idea - nobody ever
		trace(effect);

		var aux = HaxeEFX.createAuxiliaryEffectSlot();
		HaxeEFX.auxiliaryEffectSloti(aux, HaxeEFX.EFFECTSLOT_EFFECT, effect); // Apply effect to the aux
		HaxeEFX.auxiliaryEffectSloti(aux, HaxeEFX.EFFECTSLOT_AUXILIARY_SEND_AUTO, HaxeAL.FALSE);
		HaxeAL.source3i(src, HaxeEFX.AUXILIARY_SEND_FILTER, aux, 0, HaxeEFX.FILTER_NULL);

		// Sound Playback
		sound_test.DataLoader.parseWAV('assets/testMono.wav', buf);
		HaxeAL.getErrorString(HaxeAL.getError());

		HaxeAL.sourcei(src, HaxeAL.BUFFER, buf);
		HaxeAL.sourcefv(src, HaxeAL.POSITION, [8, 0, 0]);
		HaxeAL.sourcePlay(src);
		HaxeAL.getErrorString(HaxeAL.getError());

		var stepper:Float = 8;
		//var decayTime = curTime + 7;
		var decayTime = 9;
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

		trace("ENDED!");

		trace(context);
	}

	public static function createContext(device:ALDevice, ?attributes:Array<Int>):ALContext {
		return ALC.createContext(device, attributes != null ? haxeal.bindings.BinderHelper.arrayInt_ToPtr(attributes) : null);
	}
}