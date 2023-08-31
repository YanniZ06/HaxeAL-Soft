package haxeal;

import haxeal.bindings.EFX;
import haxeal.bindings.BinderHelper.*; // Import all binder functions
import haxeal.ALObjects.ALAuxSlot;
import haxeal.ALObjects.ALEffect;
import haxeal.ALObjects.ALFilter;

class HaxeEFX {
    // Constants
    // Effects
    public static final EFFECT_FIRST_PARAMETER:Int = 0x0000;
    public static final EFFECT_LAST_PARAMETER:Int = 0x8000;
    public static final EFFECT_TYPE:Int = 0x8001;

    // Effect Types
    // None
    public static final EFFECT_NULL:Int = 0x0000;

    // EAXREVERB
    public static final EFFECT_EAXREVERB:Int = 0x8000;

    public static final EAXREVERB_REFLECTIONS_PAN:Int = 0x000B;
    public static final EAXREVERB_LATE_REVERB_PAN:Int = 0x000E;

    // REVERB
    public static final EFFECT_REVERB:Int = 0x0001;

    // CHORUS
    public static final EFFECT_CHORUS:Int = 0x0002;
    
    // DISTORTION
    public static final EFFECT_DISTORTION:Int = 0x0003;
    
    // ECHO
    public static final EFFECT_ECHO:Int = 0x0004;
    
    // FLANGER
    public static final EFFECT_FLANGER:Int = 0x0005;
    
    // FREQUENCY SHIFTER
    public static final EFFECT_FREQUENCY_SHIFTER:Int = 0x0006;
    
    // VOCAL MORPHER
    public static final EFFECT_VOCAL_MORPHER:Int = 0x0007;
    
    // PITCH SHIFTER
    public static final EFFECT_PITCH_SHIFTER:Int = 0x0008;
    
    // RING MODULATOR
    public static final EFFECT_RING_MODULATOR:Int = 0x0009;
    
    // AUTOWAH
    public static final EFFECT_AUTOWAH:Int = 0x000A;
    
    // COMPRESSOR
    public static final EFFECT_COMPRESSOR:Int = 0x000B;
    
    // EQUALIZER
    public static final EFFECT_EQUALIZER:Int = 0x000C;

    // FILTERS
    public static final FILTER_FIRST_PARAMETER:Int = 0x0000;
    public static final FILTER_LAST_PARAMETER:Int = 0x8000;
    public static final FILTER_TYPE:Int = 0x8001;

    // Utility

    static final fxMap:Map<Int, Map<Int, Int>> = [ // Effect Type -> Effect Param -> Array Length Value
        EFFECT_EAXREVERB => [ // Only EAXREVERB has parameters that specifically give out vectors/arrays
            EAXREVERB_REFLECTIONS_PAN => 3,
            EAXREVERB_LATE_REVERB_PAN => 3
        ]
    ];
    public static inline function getFXParamMapping(type:Int, param:Int):Int return fxMap[type][param] ?? 1;
    // Effect Management
    
    /**
     * Returns an array of ALEffects.
     * @param num Amount of effects to return.
     */
    public static function createEffects(num:Int):Array<ALEffect> {
        var empty_effects:Array<ALEffect> = [];
        var s_str:Pointer<ALEffect> = Pointer.ofArray(empty_effects);
        EFX.createEffects(num, s_str.ptr);

        var effects:Array<ALEffect> = star_ToArrayEffect(s_str.ptr, num);
        #if HAXEAL_DEBUG if(isEffect(effects[0])) #end return effects;
        #if HAXEAL_DEBUG 
        trace("Warning: Effects may not have generated properly, returning array of potentially disfunctional effects");
        return effects;
        #end
    }

    /**
     * Creates a effect and returns it.
     */
    public static function createEffect():ALEffect { return createEffects(1)[0]; }

    /**
     * Deletes an array of ALEffects.
     * @param effects Effects to delete.
     */
    public static function deleteEffects(effects:Array<ALEffect>):Void {
        EFX.deleteEffects(effects.length, arrayEffect_ToPtr(effects));
        #if HAXEAL_DEBUG trace('Deleted ${effects.length} effects properly: ${!isEffect(effects[0])}'); #end
    }

    /**
     * Deletes a singular ALEffect
     * @param effect Effect to delete.
     */
    public static function deleteEffect(effect:ALEffect) { deleteEffects([effect]); }

    /**
     * Checks if the given effect is a valid ALEffect object.
     * @param effect Effect to check validity of.
     */
    public static function isEffect(effect:ALEffect):Bool { return al_bool(EFX.isEffect(effect)); }
    
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
    public static function effectfv(effect:ALEffect, param:Int, values:Array<Float>):Void { EFX.effectfv(effect, param, arrayFloat32_ToPtr(values)); }

    /**
     * Gets the integer value for the target parameter of the given effect.
     * @param effect Effect to get parameter of.
     * @param param Param to get value of.
     */
    public static function getEffecti(effect:ALEffect, param:Int):Int {
        var n = 123456789;
        var istr:Pointer<Int> = Pointer.addressOf(n);
        EFX.getEffecti(param, param, istr.ptr);
        return istr.ref;
    }

    /**
     * Returns an array of multiple integer values for the target parameter of the given effect.
     * 
     * The array size depends on the given param.
     * @param effect Effect to get parameter of.
     * @param param Param to get values of.
     */
    public static function getEffectiv(effect:ALEffect, param:Int):Array<Int> {
        var n = 123456789;
        var istr:Pointer<Int> = Pointer.addressOf(n);
        EFX.getEffectiv(effect, param, istr.ptr);

        return star_ToArrayInt(istr.ptr, getFXParamMapping(getEffecti(effect, EFFECT_TYPE), param));
    }

    /**
     * Gets the float value for the target parameter of the given effect.
     * @param effect Effect to get parameter of.
     * @param param Param to get value of.
     */
    public static function getEffectf(effect:ALEffect, param:Int):Float {
        var n:cpp.Float32 = 0.0123456789;
        var fstr:Pointer<cpp.Float32> = Pointer.addressOf(n);
        EFX.getEffectf(effect, param, fstr.ptr);
        return fstr.ref;
    }

    /**
     * Returns an array of multiple float values for the target parameter of the given effect.
     * 
     * The array size depends on the given param.
     * @param effect Effect to get parameter of.
     * @param param Param to get values of.
     */
    public static function getEffectfv(effect:ALEffect, param:Int):Array<Float> {
        var n:cpp.Float32 = 0.0123456789;
        var fstr:Pointer<cpp.Float32> = Pointer.addressOf(n);
        EFX.getEffectfv(effect, param, fstr.ptr);

        return star_ToArrayFloat32(fstr.ptr, getFXParamMapping(getEffecti(effect, EFFECT_TYPE), param));
    }

    // Filter Management 
    /**
     * Returns an array of ALFilters.
     * @param num Amount of filters to return.
     */
    public static function createFilters(num:Int):Array<ALFilter> {
        var empty_filters:Array<ALFilter> = [];
        var s_str:Pointer<ALFilter> = Pointer.ofArray(empty_filters);
        EFX.createFilters(num, s_str.ptr);

        var filters:Array<ALFilter> = star_ToArrayFilter(s_str.ptr, num);
        #if HAXEAL_DEBUG if(isFilter(filters[0])) #end return filters;
        #if HAXEAL_DEBUG 
        trace("Warning: Filters may not have generated properly, returning array of potentially disfunctional filters");
        return filters;
        #end
    }

    /**
     * Creates a filter and returns it.
     */
    public static function createFilter():ALFilter { return createFilters(1)[0]; }

    /**
     * Deletes an array of ALFilters.
     * @param filters Filters to delete.
     */
    public static function deleteFilters(filters:Array<ALFilter>):Void {
        EFX.deleteFilters(filters.length, arrayFilter_ToPtr(filters));
        #if HAXEAL_DEBUG trace('Deleted ${filters.length} filters properly: ${!isFilter(filters[0])}'); #end
    }

    /**
     * Deletes a singular ALFilter
     * @param filter Filter to delete.
     */
    public static function deleteFilter(filter:ALFilter) { deleteFilters([filter]); }

    /**
     * Checks if the given filter is a valid ALFilter object.
     * @param filter Filter to check validity of.
     */
    public static function isFilter(filter:ALFilter):Bool { return al_bool(EFX.isFilter(filter)); }
    
    /**
     * Sets the integer value for the target parameter of the given filter.
     * @param filter Filter to change parameter of.
     * @param param Param to set value of.
     * @param value New integer value of the param.
     */
    public static function filteri(filter:ALFilter, param:Int, value:Int):Void { EFX.filteri(filter, param, value); }

    /**
     * Sets an array of integer values for the target parameter of the given filter.
     * @param filter Filter to change parameter of.
     * @param param Param to set values of.
     * @param value New integer values of the param as an array (array length should be the same as amount of values the parameter takes).
     */
    public static function filteriv(filter:ALFilter, param:Int, values:Array<Int>):Void { EFX.filteriv(filter, param, arrayInt_ToPtr(values)); }

    /**
     * Sets the float value for the target parameter of the given filter.
     * @param filter Filter to change parameter of.
     * @param param Param to set value of.
     * @param value New float value of the param.
     */
    public static function filterf(filter:ALFilter, param:Int, value:Float):Void { EFX.filterf(filter, param, value); }

    /**
     * Sets an array of float values for the target parameter of the given filter.
     * @param filter Filter to change parameter of.
     * @param param Param to set values of.
     * @param value New float values of the param as an array (array length should be the same as amount of values the parameter takes).
     */
    public static function filterfv(filter:ALFilter, param:Int, values:Array<Float>):Void { EFX.filterfv(filter, param, arrayFloat32_ToPtr(values)); }

    /**
     * Gets the integer value for the target parameter of the given filter.
     * @param filter Filter to get parameter of.
     * @param param Param to get value of.
     */
    public static function getFilteri(filter:ALFilter, param:Int):Int {
        var n = 123456789;
        var istr:Pointer<Int> = Pointer.addressOf(n);
        EFX.getFilteri(param, param, istr.ptr);
        return istr.ref;
    }

    /**
     * Returns an array of multiple integer values for the target parameter of the given filter.
     * 
     * The array size depends on the given param.
     * @param filter Filter to get parameter of.
     * @param param Param to get values of.
     */
    public static function getFilteriv(filter:ALFilter, param:Int):Array<Int> {
        var n = 123456789;
        var istr:Pointer<Int> = Pointer.addressOf(n);
        EFX.getFilteriv(filter, param, istr.ptr);

        return star_ToArrayInt(istr.ptr, getFXParamMapping(getFilteri(filter, FILTER_TYPE), param));
    }

    /**
     * Gets the float value for the target parameter of the given filter.
     * @param filter Filter to get parameter of.
     * @param param Param to get value of.
     */
    public static function getFilterf(filter:ALFilter, param:Int):Float {
        var n:cpp.Float32 = 0.0123456789;
        var fstr:Pointer<cpp.Float32> = Pointer.addressOf(n);
        EFX.getFilterf(filter, param, fstr.ptr);
        return fstr.ref;
    }

    /**
     * Returns an array of multiple float values for the target parameter of the given filter.
     * 
     * The array size depends on the given param.
     * @param filter Filter to get parameter of.
     * @param param Param to get values of.
     */
    public static function getFilterfv(filter:ALFilter, param:Int):Array<Float> {
        var n:cpp.Float32 = 0.0123456789;
        var fstr:Pointer<cpp.Float32> = Pointer.addressOf(n);
        EFX.getFilterfv(filter, param, fstr.ptr);

        return star_ToArrayFloat32(fstr.ptr, getFXParamMapping(getFilteri(filter, FILTER_TYPE), param));
    }
}