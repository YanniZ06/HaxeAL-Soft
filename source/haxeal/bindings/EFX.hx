package haxeal.bindings;

import haxeal.ALObjects.ALAuxSlot;
import haxeal.ALObjects.ALEffect;
import haxeal.ALObjects.ALFilter;


@:build(haxeal.bindings.EFXBuilder.buildFunctions())
class EFX {
    /*
    fuck it im replacing all the @:native with @efxFunc and then just making a macro to define the functions as the ones gotten using getProcAddress
    as in:

    i generate seperate variables with the same function name on compile time and force the functions with the annotated @efxFunc expression to call 
    said variables that then act as function callers

    make sure to force inline all of these aswell and replace the ; with {} (since a function body is necessary)
    */


    // Effect Management
    @efxFunc("alGenEffects")
    static function createEffects(n:Int, effects:Star<ALEffect>):Void {}

    @efxFunc("alDeleteEffects")
    static function deleteEffects(n:Int, effects:Pointer<ALEffect>):Void {}

    @efxFunc("alIsEffect")
    static function isEffect(effect:ALEffect):Char {}

    @efxFunc("alEffecti")
    static function effecti(effect:ALEffect, param:Int, value:Int):Void {}
    
    @efxFunc("alEffectiv")
    static function effectiv(effect:ALEffect, param:Int, values:Pointer<Int>):Void {}
    
    @efxFunc("alEffectf")
    static function effectf(effect:ALEffect, param:Int, value:cpp.Float32):Void {}
    
    @efxFunc("alEffectfv")
    static function effectfv(effect:ALEffect, param:Int, values:Pointer<cpp.Float32>):Void {}
    
    @efxFunc("alGetEffecti")
    static function getEffecti(effect:ALEffect, param:Int, value:Star<Int>):Void {}
    
    @efxFunc("alGetEffectiv")
    static function getEffectiv(effect:ALEffect, param:Int, values:Star<Int>):Void {}
    
    @efxFunc("alGetEffectf")
    static function getEffectf(effect:ALEffect, param:Int, value:Star<cpp.Float32>):Void {}
    
    @efxFunc("alGetEffectfv")
    static function getEffectfv(effect:ALEffect, param:Int, values:Star<cpp.Float32>):Void {}

    // Filter Management
    @efxFunc("alGenFilters")
    static function createFilters(n:Int, filters:Star<ALFilter>):Void {}

    @efxFunc("alDeleteFilters")
    static function deleteFilters(n:Int, filters:Pointer<ALFilter>):Void {}

    @efxFunc("alIsFilter")
    static function isFilter(filter:ALFilter):Char {}

    @efxFunc("alFilteri")
    static function filteri(filter:ALFilter, param:Int, value:Int):Void {}
    
    @efxFunc("alFilteriv")
    static function filteriv(filter:ALFilter, param:Int, values:Pointer<Int>):Void {}
    
    @efxFunc("alFilterf")
    static function filterf(filter:ALFilter, param:Int, value:cpp.Float32):Void {}
    
    @efxFunc("alFilterfv")
    static function filterfv(filter:ALFilter, param:Int, values:Pointer<cpp.Float32>):Void {}
    
    @efxFunc("alGetFilteri")
    static function getFilteri(filter:ALFilter, param:Int, value:Star<Int>):Void {}
    
    @efxFunc("alGetFilteriv")
    static function getFilteriv(filter:ALFilter, param:Int, values:Star<Int>):Void {}
    
    @efxFunc("alGetFilterf")
    static function getFilterf(filter:ALFilter, param:Int, value:Star<cpp.Float32>):Void {}
    
    @efxFunc("alGetFilterfv")
    static function getFilterfv(filter:ALFilter, param:Int, values:Star<cpp.Float32>):Void {}

    // AuxSlot Management
    @efxFunc("alGenAuxiliaryEffectSlots")
    static function createAuxiliaryEffectSlots(n:Int, effectslots:Star<ALAuxiliaryEffectSlot>):Void {}

    @efxFunc("alDeleteAuxiliaryEffectSlots")
    static function deleteAuxiliaryEffectSlots(n:Int, effectslots:Pointer<ALAuxiliaryEffectSlot>):Void {}

    @efxFunc("alIsAuxiliaryEffectSlot")
    static function isAuxiliaryEffectSlot(effectslot:ALAuxiliaryEffectSlot):Char {}

    @efxFunc("alAuxiliaryEffectSloti")
    static function auxiliaryEffectSloti(effectslot:ALAuxiliaryEffectSlot, param:Int, value:Int):Void {}
    
    @efxFunc("alAuxiliaryEffectSlotiv")
    static function auxiliaryEffectSlotiv(effectslot:ALAuxiliaryEffectSlot, param:Int, values:Pointer<Int>):Void {}
    
    @efxFunc("alAuxiliaryEffectSlotf")
    static function auxiliaryEffectSlotf(effectslot:ALAuxiliaryEffectSlot, param:Int, value:cpp.Float32):Void {}
    
    @efxFunc("alAuxiliaryEffectSlotfv")
    static function auxiliaryEffectSlotfv(effectslot:ALAuxiliaryEffectSlot, param:Int, values:Pointer<cpp.Float32>):Void {}
    
    @efxFunc("alGetAuxiliaryEffectSloti")
    static function getAuxiliaryEffectSloti(effectslot:ALAuxiliaryEffectSlot, param:Int, value:Star<Int>):Void {}
    
    @efxFunc("alGetAuxiliaryEffectSlotiv")
    static function getAuxiliaryEffectSlotiv(effectslot:ALAuxiliaryEffectSlot, param:Int, values:Star<Int>):Void {}
    
    @efxFunc("alGetAuxiliaryEffectSlotf")
    static function getAuxiliaryEffectSlotf(effectslot:ALAuxiliaryEffectSlot, param:Int, value:Star<cpp.Float32>):Void {}
    
    @efxFunc("alGetAuxiliaryEffectSlotfv")
    static function getAuxiliaryEffectSlotfv(effectslot:ALAuxiliaryEffectSlot, param:Int, values:Star<cpp.Float32>):Void {}
}

typedef ALAuxiliaryEffectSlot = ALAuxSlot;