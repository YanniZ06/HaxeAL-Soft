package haxeal.bindings;

import haxeal.ALObjects.ALAuxSlot;
import haxeal.ALObjects.ALEffect;
import haxeal.ALObjects.ALFilter;


@:build(haxeal.bindings.EFXBuilder.buildFunctions())
@:headerCode('
    #include <efx.h>

    static LPALGENEFFECTS alGenEffects;
    static LPALDELETEEFFECTS alDeleteEffects;
    static LPALISEFFECT alIsEffect;
    static LPALEFFECTI alEffecti;
    static LPALEFFECTIV alEffectiv;
    static LPALEFFECTF alEffectf;
    static LPALEFFECTFV alEffectfv;
    static LPALGETEFFECTI alGetEffecti;
    static LPALGETEFFECTIV alGetEffectiv;
    static LPALGETEFFECTF alGetEffectf;
    static LPALGETEFFECTFV alGetEffectfv;
    static LPALGENFILTERS alGenFilters;
    static LPALDELETEFILTERS alDeleteFilters;
    static LPALISFILTER alIsFilter;
    static LPALFILTERI alFilteri;
    static LPALFILTERIV alFilteriv;
    static LPALFILTERF alFilterf;
    static LPALFILTERFV alFilterfv;
    static LPALGETFILTERI alGetFilteri;
    static LPALGETFILTERIV alGetFilteriv;
    static LPALGETFILTERF alGetFilterf;
    static LPALGETFILTERFV alGetFilterfv;
    static LPALGENAUXILIARYEFFECTSLOTS alGenAuxiliaryEffectSlots;
    static LPALDELETEAUXILIARYEFFECTSLOTS alDeleteAuxiliaryEffectSlots;
    static LPALISAUXILIARYEFFECTSLOT alIsAuxiliaryEffectSlot;
    static LPALAUXILIARYEFFECTSLOTI alAuxiliaryEffectSloti;
    static LPALAUXILIARYEFFECTSLOTIV alAuxiliaryEffectSlotiv;
    static LPALAUXILIARYEFFECTSLOTF alAuxiliaryEffectSlotf;
    static LPALAUXILIARYEFFECTSLOTFV alAuxiliaryEffectSlotfv;
    static LPALGETAUXILIARYEFFECTSLOTI alGetAuxiliaryEffectSloti;
    static LPALGETAUXILIARYEFFECTSLOTIV alGetAuxiliaryEffectSlotiv;
    static LPALGETAUXILIARYEFFECTSLOTF alGetAuxiliaryEffectSlotf;
    static LPALGETAUXILIARYEFFECTSLOTFV alGetAuxiliaryEffectSlotfv;
') // Defining these in the header for our new EFX init method
class EFX {
    // Effect Management
    @efxFunc("alGenEffects")
    static function createEffects(n:Int, effects:Star<ALEffect>):Void {}

    @efxFunc("alDeleteEffects")
    static function deleteEffects(n:Int, effects:Pointer<ALEffect>):Void {}

    @efxFunc("alIsEffect")
    static function isEffect(effect:ALEffect):Char { throw 'INVALID'; }

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
    static function isFilter(filter:ALFilter):Char { throw 'INVALID'; }

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
    static function isAuxiliaryEffectSlot(effectslot:ALAuxiliaryEffectSlot):Char { throw 'INVALID'; }

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