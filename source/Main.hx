package;

//import haxeal.bindings.*;
import haxeal.bindings.ALC;
import haxeal.ALObjects.ALContext;
import haxeal.ALObjects.ALDevice;
import haxeal.HaxeALC;
import haxeal.HaxeAL;

import haxeal.bindings.BinderHelper;

// These will be removed when the bindings are re-translated, for now they are necessary
import cpp.ConstCharStar;
import cpp.ConstStar;
import cpp.Char;
import cpp.UInt8;
import cpp.Star;

using cpp.Native;

@:buildXml('<include name="../builder.xml" />')
class Main {
	static var device:ALDevice;
	static var context:ALContext;

	static function main() {
		var name:String = ALC.getString(null, 0x1005);
		HaxeAL.getErrorString(HaxeAL.getError());
		trace(name);
		device = ALC.openDevice(name);
		if(device != null) {
			context = HaxeALC.createContext(device); //! USE ALC.createContext to make it NOT error :)

			if(context != null) trace(HaxeALC.makeContextCurrent(context));
			HaxeAL.getErrorString(HaxeALC.getError(device));

			// ? EXPERIMENTAL
			//trace(haxeal.ALC.getIntegers(device, 0x1001));
		}
		
		var arrayFunny:Array<Int> = [0,1,2];
		var starArray = BinderHelper.arrayInt_ToStar(arrayFunny);
		var dereferencedArray = BinderHelper.star_ToArrayInt(starArray);
		trace(dereferencedArray);

		trace(context);
		//trace(ALC.getCurrentContext());
		//trace(AL.getError());
	}

	public static function createContext(device:ALDevice, ?attributes:Array<Int>):ALContext {
		return ALC.createContext(device, attributes != null ? haxeal.bindings.BinderHelper.arrayInt_ToConstStar(attributes) : null);
	}
}