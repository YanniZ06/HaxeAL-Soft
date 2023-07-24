package haxeal.bindings;

@:unreflective @:keep
@:include("al.h")
extern class AL {
    @:native("alGetError")
    static function getError():Int;
}