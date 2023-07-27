package haxeal.bindings;

//@:buildXml('<include name="../builder.xml" />')
@:unreflective @:keep
@:include("al.h")
extern class AL {
    @:native("alGetError")
    static function getError():Int;
}