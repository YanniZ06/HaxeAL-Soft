package haxeal.bindings;

#if !macro
import haxeal.ALObjects.ALAuxSlot;
import haxeal.ALObjects.ALEffect;
import haxeal.ALObjects.ALFilter;
#end

@:buildXml('<include name="${haxelib:HaxeAL-Soft}/builder.xml" />')
@:build(haxeal.bindings.FunctionBuilder.buildFunctions())
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
    @lpFunc("alGenEffects")
    static inline function createEffects(n:Int, effects:Star<ALEffect>):Void {}

    @lpFunc("alDeleteEffects")
    static inline function deleteEffects(n:Int, effects:Star<ALEffect>):Void {}

    @lpFunc("alIsEffect")
    static inline function isEffect(effect:ALEffect):Char { throw 'INVALID'; }

    @lpFunc("alEffecti")
    static inline function effecti(effect:ALEffect, param:Int, value:Int):Void {}
    
    @lpFunc("alEffectiv")
    static inline function effectiv(effect:ALEffect, param:Int, values:Star<Int>):Void {}
    
    @lpFunc("alEffectf")
    static inline function effectf(effect:ALEffect, param:Int, value:cpp.Float32):Void {}
    
    @lpFunc("alEffectfv")
    static inline function effectfv(effect:ALEffect, param:Int, values:Star<cpp.Float32>):Void {}
    
    @lpFunc("alGetEffecti")
    static inline function getEffecti(effect:ALEffect, param:Int, value:Star<Int>):Void {}
    
    @lpFunc("alGetEffectiv")
    static inline function getEffectiv(effect:ALEffect, param:Int, values:Star<Int>):Void {}
    
    @lpFunc("alGetEffectf")
    static inline function getEffectf(effect:ALEffect, param:Int, value:Star<cpp.Float32>):Void {}
    
    @lpFunc("alGetEffectfv")
    static inline function getEffectfv(effect:ALEffect, param:Int, values:Star<cpp.Float32>):Void {}

    // Filter Management
    @lpFunc("alGenFilters")
    static inline function createFilters(n:Int, filters:Star<ALFilter>):Void {}

    @lpFunc("alDeleteFilters")
    static inline function deleteFilters(n:Int, filters:Star<ALFilter>):Void {}

    @lpFunc("alIsFilter")
    static inline function isFilter(filter:ALFilter):Char { throw 'INVALID'; }

    @lpFunc("alFilteri")
    static inline function filteri(filter:ALFilter, param:Int, value:Int):Void {}
    
    @lpFunc("alFilteriv")
    static inline function filteriv(filter:ALFilter, param:Int, values:Star<Int>):Void {}
    
    @lpFunc("alFilterf")
    static inline function filterf(filter:ALFilter, param:Int, value:cpp.Float32):Void {}
    
    @lpFunc("alFilterfv")
    static inline function filterfv(filter:ALFilter, param:Int, values:Star<cpp.Float32>):Void {}
    
    @lpFunc("alGetFilteri")
    static inline function getFilteri(filter:ALFilter, param:Int, value:Star<Int>):Void {}
    
    @lpFunc("alGetFilteriv")
    static inline function getFilteriv(filter:ALFilter, param:Int, values:Star<Int>):Void {}
    
    @lpFunc("alGetFilterf")
    static inline function getFilterf(filter:ALFilter, param:Int, value:Star<cpp.Float32>):Void {}
    
    @lpFunc("alGetFilterfv")
    static inline function getFilterfv(filter:ALFilter, param:Int, values:Star<cpp.Float32>):Void {}

    // AuxSlot Management
    @lpFunc("alGenAuxiliaryEffectSlots")
    static inline function createAuxiliaryEffectSlots(n:Int, effectslots:Star<ALAuxSlot>):Void {}

    @lpFunc("alDeleteAuxiliaryEffectSlots")
    static inline function deleteAuxiliaryEffectSlots(n:Int, effectslots:Star<ALAuxSlot>):Void {}

    @lpFunc("alIsAuxiliaryEffectSlot")
    static inline function isAuxiliaryEffectSlot(effectslot:ALAuxSlot):Char { throw 'INVALID'; }

    @lpFunc("alAuxiliaryEffectSloti")
    static inline function auxiliaryEffectSloti(effectslot:ALAuxSlot, param:Int, value:Int):Void {}
    
    @lpFunc("alAuxiliaryEffectSlotiv")
    static inline function auxiliaryEffectSlotiv(effectslot:ALAuxSlot, param:Int, values:Star<Int>):Void {}
    
    @lpFunc("alAuxiliaryEffectSlotf")
    static inline function auxiliaryEffectSlotf(effectslot:ALAuxSlot, param:Int, value:cpp.Float32):Void {}
    
    @lpFunc("alAuxiliaryEffectSlotfv")
    static inline function auxiliaryEffectSlotfv(effectslot:ALAuxSlot, param:Int, values:Star<cpp.Float32>):Void {}
    
    @lpFunc("alGetAuxiliaryEffectSloti")
    static inline function getAuxiliaryEffectSloti(effectslot:ALAuxSlot, param:Int, value:Star<Int>):Void {}
    
    @lpFunc("alGetAuxiliaryEffectSlotiv")
    static inline function getAuxiliaryEffectSlotiv(effectslot:ALAuxSlot, param:Int, values:Star<Int>):Void {}
    
    @lpFunc("alGetAuxiliaryEffectSlotf")
    static inline function getAuxiliaryEffectSlotf(effectslot:ALAuxSlot, param:Int, value:Star<cpp.Float32>):Void {}
    
    @lpFunc("alGetAuxiliaryEffectSlotfv")
    static inline function getAuxiliaryEffectSlotfv(effectslot:ALAuxSlot, param:Int, values:Star<cpp.Float32>):Void {}
}