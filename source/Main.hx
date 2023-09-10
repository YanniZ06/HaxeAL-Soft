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

		trace('EFFECT TESTING!');
		trace(HaxeALC.isExtensionPresent(null, 'ALC_EXT_EFX'));
		var effect = 20;
		trace(effect);   

		effect = HaxeEFX.createEffect();
		trace(effect);
		trace('Generated effect is valid? ${HaxeEFX.isEffect(effect)}');

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

		//trace(HaxeAL.createSource());
		/*
		var arrayFunny:Array<Int> = [0,1,2,3,4,5,6,7,8];
		var starArray = BinderHelper.arrayInt_ToStar(arrayFunny);
		var dereferencedArray = BinderHelper.star_ToArrayInt(starArray, arrayFunny.length );
		trace(dereferencedArray);*/

		trace(context);
		//trace(ALC.getCurrentContext());
		//trace(AL.getError());
	}

	public static function createContext(device:ALDevice, ?attributes:Array<Int>):ALContext {
		return ALC.createContext(device, attributes != null ? haxeal.bindings.BinderHelper.arrayInt_ToPtr(attributes) : null);
	}
}