package;

import haxeal.bindings.*;
//import haxeal.bindings.ALC.*;

// These will be removed when the bindings are re-translated, for now they are necessary
import cpp.ConstCharStar;
import cpp.ConstStar;
import cpp.Char;
import cpp.UInt8;
import cpp.Star;

using cpp.Native;

@:buildXml('<include name="../builder.xml" />')
class Main {
	static var device:Star<ALC.ALDevice>;
	static var context:Star<ALC.ALContext>;

	static function main() {
		var name:String = ALC.getString(null, 0x1005);
		device = ALC.openDevice(name);
		if(device != null) {
			context = ALC.createContext(device, null);

			if(context != null) ALC.makeContextCurrent(context);
			trace(ALC.getError(device));

			// ? EXPERIMENTAL
			/*var array:Star<Int> = 0; 
			ALC.getIntegers(device, 0x1001, cpp.Stdlib.sizeof(Int), array);
			final arrayTrue:Array<Int> = cpp.Pointer.fromStar(array).toUnmanagedArray(1);
			trace(arrayTrue);*/
		}

		trace(context);
		trace(ALC.getCurrentContext());
		//trace(AL.getError());
	}
}