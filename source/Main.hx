package;

//import haxeal.bindings.*;
//import haxeal.bindings.ALC.*;
import haxeal.ALObjects.ALContext;
import haxeal.ALObjects.ALDevice;

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
		var name:String = haxeal.bindings.ALC.getString(null, 0x1005);
		haxeal.AL.getErrorString(haxeal.AL.getError());
		device = haxeal.bindings.ALC.openDevice(name);
		if(device != null) {
			context = haxeal.ALC.createContext(device, null); //! USE haxeal.bindings.ALC.createContext to make it NOT error :)

			if(context != null) haxeal.bindings.ALC.makeContextCurrent(context);
			haxeal.AL.getErrorString(haxeal.bindings.ALC.getError(device));

			// ? EXPERIMENTAL
			//trace(haxeal.ALC.getIntegers(device, 0x1001));
		}

		trace(context);
		//trace(haxeal.bindings.ALC.getCurrentContext());
		//trace(AL.getError());
	}
}