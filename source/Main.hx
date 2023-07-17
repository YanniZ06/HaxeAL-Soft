@:buildXml('<include name="../source/openal/builder.xml" />')
class Main {
	static function main() {
		trace(ALFunctions.getError());
	}
}

@:unreflective @:keep
@:include("al.h")
extern class ALFunctions {
    @:native("alGetError")
    static function getError():Int;
}