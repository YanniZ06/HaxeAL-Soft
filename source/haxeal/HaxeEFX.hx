package haxeal;

import haxeal.bindings.EFX;
import haxeal.ALObjects.ALAuxSlot;
import haxeal.ALObjects.ALEffect;
import haxeal.ALObjects.ALFilter;

class HaxeEFX {
    // Effect Management
    
    // TODO: GENEFFECT(S), DELETEEFFECT(S), ISEFFECT
    
    /**
     * Sets the integer value for the target parameter of the given effect.
     * @param effect Effect to change parameter of.
     * @param param Param to set value of.
     * @param value New integer value of the param.
     */
    public static function effecti(effect:ALEffect, param:Int, value:Int):Void { EFX.effecti(effect, param, value); }

    /**
     * Sets an array of integer values for the target parameter of the given effect.
     * @param effect Effect to change parameter of.
     * @param param Param to set values of.
     * @param value New integer values of the param as an array (array length should be the same as amount of values the parameter takes).
     */
    public static function effectiv(effect:ALEffect, param:Int, values:Array<Int>):Void { EFX.effectiv(effect, param, arrayInt_ToPtr(values)); }

    /**
     * Sets the float value for the target parameter of the given effect.
     * @param effect Effect to change parameter of.
     * @param param Param to set value of.
     * @param value New float value of the param.
     */
    public static function effectf(effect:ALEffect, param:Int, value:Float):Void { EFX.effectf(effect, param, value); }

    /**
     * Sets an array of float values for the target parameter of the given effect.
     * @param effect Effect to change parameter of.
     * @param param Param to set values of.
     * @param value New float values of the param as an array (array length should be the same as amount of values the parameter takes).
     */
    public static function effectfv(effect:ALEffect, param:Int, values:Array<Float>):Void { EFX.sourcefv(effect, param, arrayFloat32_ToPtr(values)); }

    // TODO: FINISH GET..IV AND GET..FV LOL TOO TIRED TO DO THIS RIGHT NOW
    /**
     * Gets the integer value for the target parameter of the given effect.
     * @param effect Effect to get parameter of.
     * @param param Param to get value of.
     */
    public static function getEffecti(effect:ALEffect, param:Int):Int {
        var n = 123456789;
        var istr:Pointer<Int> = Pointer.addressOf(n);
        EFX.getEffecti(param, istr.ptr);
        return istr.ref;
    }

    /**
     * Gets the float value for the target parameter of the given effect.
     * @param effect Effect to get parameter of.
     * @param param Param to get value of.
     */
    public static function getEffectf(effect:ALEffect, param:Int):Float {
        var n:cpp.Float32 = 0.0123456789;
        var fstr:Pointer<cpp.Float32> = Pointer.addressOf(n);
        AL.getEffectf(effect, param, fstr.ptr);
        return fstr.ref;
    }
}