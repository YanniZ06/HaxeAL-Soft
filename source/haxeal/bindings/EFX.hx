package haxeal.bindings;

import haxeal.ALObjects.ALAuxSlot;
import haxeal.ALObjects.ALEffect;
import haxeal.ALObjects.ALFilter;

@:unreflective @:keep
@:include("efx.h")
extern class EFX {
    /*
    fuck it im replacing all the @:native with @efxFunc and then just making a macro to define the functions as the ones gotten using getProcAddress
    as in:

    i generate seperate variables with the same function name on compile time and force the functions with the annotated @efxFunc expression to call 
    said variables that then act as function callers

    make sure to force inline all of these aswell and replace the ; with {} (since a function body is necessary)
    */

    // Effect Management
    @:native("alGenEffects")
    static function createEffects(n:Int, effects:Star<ALEffect>):Void;

    @:native("alDeleteEffects")
    static function deleteEffects(n:Int, effects:Pointer<ALEffect>):Void;

    @:native("alIsEffect")
    static function isEffect(effect:ALEffect):Char;

    @:native("alEffecti")
    static function effecti(effect:ALEffect, param:Int, value:Int):Void;
    
    @:native("alEffectiv")
    static function effectiv(effect:ALEffect, param:Int, values:Pointer<Int>):Void;
    
    @:native("alEffectf")
    static function effectf(effect:ALEffect, param:Int, value:cpp.Float32):Void;
    
    @:native("alEffectfv")
    static function effectfv(effect:ALEffect, param:Int, values:Pointer<cpp.Float32>):Void;
    
    @:native("alGetEffecti")
    static function getEffecti(effect:ALEffect, param:Int, value:Star<Int>):Void;
    
    @:native("alGetEffectiv")
    static function getEffectiv(effect:ALEffect, param:Int, values:Star<Int>):Void;
    
    @:native("alGetEffectf")
    static function getEffectf(effect:ALEffect, param:Int, value:Star<cpp.Float32>):Void;
    
    @:native("alGetEffectfv")
    static function getEffectfv(effect:ALEffect, param:Int, values:Star<cpp.Float32>):Void;

    // Filter Management
    @:native("alGenFilters")
    static function createFilters(n:Int, filters:Star<ALFilter>):Void;

    @:native("alDeleteFilters")
    static function deleteFilters(n:Int, filters:Pointer<ALFilter>):Void;

    @:native("alIsFilter")
    static function isFilter(filter:ALFilter):Char;

    @:native("alFilteri")
    static function filteri(filter:ALFilter, param:Int, value:Int):Void;
    
    @:native("alFilteriv")
    static function filteriv(filter:ALFilter, param:Int, values:Pointer<Int>):Void;
    
    @:native("alFilterf")
    static function filterf(filter:ALFilter, param:Int, value:cpp.Float32):Void;
    
    @:native("alFilterfv")
    static function filterfv(filter:ALFilter, param:Int, values:Pointer<cpp.Float32>):Void;
    
    @:native("alGetFilteri")
    static function getFilteri(filter:ALFilter, param:Int, value:Star<Int>):Void;
    
    @:native("alGetFilteriv")
    static function getFilteriv(filter:ALFilter, param:Int, values:Star<Int>):Void;
    
    @:native("alGetFilterf")
    static function getFilterf(filter:ALFilter, param:Int, value:Star<cpp.Float32>):Void;
    
    @:native("alGetFilterfv")
    static function getFilterfv(filter:ALFilter, param:Int, values:Star<cpp.Float32>):Void;

    // AuxSlot Management
    @:native("alGenAuxiliaryEffectSlots")
    static function createAuxiliaryEffectSlots(n:Int, effectslots:Star<ALAuxiliaryEffectSlot>):Void;

    @:native("alDeleteAuxiliaryEffectSlots")
    static function deleteAuxiliaryEffectSlots(n:Int, effectslots:Pointer<ALAuxiliaryEffectSlot>):Void;

    @:native("alIsAuxiliaryEffectSlot")
    static function isAuxiliaryEffectSlot(effectslot:ALAuxiliaryEffectSlot):Char;

    @:native("alAuxiliaryEffectSloti")
    static function auxiliaryEffectSloti(effectslot:ALAuxiliaryEffectSlot, param:Int, value:Int):Void;
    
    @:native("alAuxiliaryEffectSlotiv")
    static function auxiliaryEffectSlotiv(effectslot:ALAuxiliaryEffectSlot, param:Int, values:Pointer<Int>):Void;
    
    @:native("alAuxiliaryEffectSlotf")
    static function auxiliaryEffectSlotf(effectslot:ALAuxiliaryEffectSlot, param:Int, value:cpp.Float32):Void;
    
    @:native("alAuxiliaryEffectSlotfv")
    static function auxiliaryEffectSlotfv(effectslot:ALAuxiliaryEffectSlot, param:Int, values:Pointer<cpp.Float32>):Void;
    
    @:native("alGetAuxiliaryEffectSloti")
    static function getAuxiliaryEffectSloti(effectslot:ALAuxiliaryEffectSlot, param:Int, value:Star<Int>):Void;
    
    @:native("alGetAuxiliaryEffectSlotiv")
    static function getAuxiliaryEffectSlotiv(effectslot:ALAuxiliaryEffectSlot, param:Int, values:Star<Int>):Void;
    
    @:native("alGetAuxiliaryEffectSlotf")
    static function getAuxiliaryEffectSlotf(effectslot:ALAuxiliaryEffectSlot, param:Int, value:Star<cpp.Float32>):Void;
    
    @:native("alGetAuxiliaryEffectSlotfv")
    static function getAuxiliaryEffectSlotfv(effectslot:ALAuxiliaryEffectSlot, param:Int, values:Star<cpp.Float32>):Void;
}

typedef ALAuxiliaryEffectSlot = ALAuxSlot;