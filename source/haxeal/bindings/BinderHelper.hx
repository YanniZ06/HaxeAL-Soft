package haxeal.bindings;

import haxeal.ALObjects.ALSource;
import haxeal.ALObjects.ALBuffer;
import haxeal.ALObjects.ALAuxSlot;
import haxeal.ALObjects.ALEffect;
import haxeal.ALObjects.ALFilter;

class BinderHelper {
    /**
     * Turns an integer into a boolean value.
     * 0 is false, 1 is true
     */
    public static inline function al_bool(value:Int):Bool return value == 1;


    // ? FROM: https://github.com/leereilly/unreal.hx/blob/master/Haxe/Static/unreal/helpers/HaxeHelpers.hx
    public static function toVoidPtr(dyn:Dynamic):RawPointer<cpp.Void> {
        // there's no way to get a pointer to hxcpp's Dynamic struct
        // so we're using the undocumented GetPtr (defined in `include/hx/Object.h`)
        // this pointer should only be used in the stack - because this pointer will be
        // transparent to hxcpp - which might move the reference
        var dyn:Dynamic = dyn;
        return untyped __cpp__('{0}.GetPtr()', dyn);
    }

    public static function fromVoidPtr(ptr:RawPointer<cpp.Void>):Dynamic {        
        var dyn:Dynamic = untyped __cpp__('Dynamic( (hx::Object *) {0} )', ptr);
        return dyn;
    }
}