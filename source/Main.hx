@:buildXml('<include name="../builder.xml" />')
class Main {
	static function main() {
		trace("eat my ass!");
		trace(ALFunctions.getError());
	}
}

@:unreflective @:keep
@:include("al.h")
extern class ALFunctions {
    @:native("alGetError")
    static function getError():Int;
}

class AL {

}