package haxeal;

import haxeal.bindings.EFX;
import haxeal.bindings.BinderHelper.*; // Import all binder functions
import haxeal.ALObjects.ALAuxSlot;
import haxeal.ALObjects.ALEffect;
import haxeal.ALObjects.ALFilter;

/**
 * Class for handling the HaxeAL EFX extension.
 */
class HaxeEFX {
    // Constants

    // EFX Settings & Info (ALC Specific)
    public static inline final EXT_EFX_NAME:String = "EXT_EFX";
    public static inline final EFX_MAJOR_VERSION:Int = 0x20001;
    public static inline final EFX_MINOR_VERSION:Int = 0x20002;
    public static inline final MAX_AUXILIARY_SENDS:Int = 0x20003;

    // Extended Listener property
    public static inline final METERS_PER_UNIT:Int = 0x20004;

    // Extended Source properties
    public static inline final DIRECT_FILTER:Int = 0x20005; 
    public static inline final AUXILIARY_SEND_FILTER:Int = 0x20006;
    public static inline final AIR_ABSORPTION_FACTOR:Int = 0x20007;
    public static inline final ROOM_ROLLOFF_FACTOR:Int = 0x20008;
    public static inline final CONE_OUTER_GAINHF:Int = 0x20009;
    public static inline final DIRECT_FILTER_GAINHF_AUTO:Int = 0x2000A;
    public static inline final AUXILIARY_SEND_FILTER_GAIN_AUTO:Int = 0x2000B;
    public static inline final AUXILIARY_SEND_FILTER_GAINHF_AUTO:Int = 0x2000C;

    // Effects
    public static inline final EFFECT_FIRST_PARAMETER:Int = 0x0000;
    public static inline final EFFECT_LAST_PARAMETER:Int = 0x8000;
    public static inline final EFFECT_TYPE:Int = 0x8001;

    // Effect Types
    // NONE
    public static inline final EFFECT_NULL:Int = 0x0000;

    // EAXREVERB
    public static inline final EFFECT_EAXREVERB:Int = 0x8000;

    public static inline final EAXREVERB_DIFFUSION:Int = 0x0002;
    public static inline final EAXREVERB_GAIN:Int = 0x0003;
    public static inline final EAXREVERB_DENSITY:Int = 0x0001;
    public static inline final EAXREVERB_GAINHF:Int = 0x0004;
    public static inline final EAXREVERB_GAINLF:Int = 0x0005;
    public static inline final EAXREVERB_DECAY_TIME:Int = 0x0006;
    public static inline final EAXREVERB_DECAY_HFRATIO:Int = 0x0007;
    public static inline final EAXREVERB_DECAY_LFRATIO:Int = 0x0008;
    public static inline final EAXREVERB_REFLECTIONS_GAIN:Int = 0x0009;
    public static inline final EAXREVERB_REFLECTIONS_DELAY:Int = 0x000A;
    public static inline final EAXREVERB_REFLECTIONS_PAN:Int = 0x000B;
    public static inline final EAXREVERB_LATE_REVERB_GAIN:Int = 0x000C;
    public static inline final EAXREVERB_LATE_REVERB_DELAY:Int = 0x000D;
    public static inline final EAXREVERB_LATE_REVERB_PAN:Int = 0x000E;
    public static inline final EAXREVERB_ECHO_TIME:Int = 0x000F;
    public static inline final EAXREVERB_ECHO_DEPTH:Int = 0x0010;
    public static inline final EAXREVERB_MODULATION_TIME:Int = 0x0011;
    public static inline final EAXREVERB_MODULATION_DEPTH:Int = 0x0012;
    public static inline final EAXREVERB_AIR_ABSORPTION_GAINHF:Int = 0x0013;
    public static inline final EAXREVERB_HFREFERENCE:Int = 0x0014;
    public static inline final EAXREVERB_LFREFERENCE:Int = 0x0015;
    public static inline final EAXREVERB_ROOM_ROLLOFF_FACTOR:Int = 0x0016;
    public static inline final EAXREVERB_DECAY_HFLIMIT:Int = 0x0017;

    // REVERB
    public static inline final EFFECT_REVERB:Int = 0x0001;

    public static inline final REVERB_DENSITY:Int = 0x0001;
    public static inline final REVERB_DIFFUSION:Int = 0x0002;
    public static inline final REVERB_GAIN:Int = 0x0003;
    public static inline final REVERB_GAINHF:Int = 0x0004;
    public static inline final REVERB_DECAY_TIME:Int = 0x0005;
    public static inline final REVERB_DECAY_HFRATIO:Int = 0x0006;
    public static inline final REVERB_REFLECTIONS_GAIN:Int = 0x0007;
    public static inline final REVERB_REFLECTIONS_DELAY:Int = 0x0008;
    public static inline final REVERB_LATE_REVERB_GAIN:Int = 0x0009;
    public static inline final REVERB_LATE_REVERB_DELAY:Int = 0x000A;
    public static inline final REVERB_AIR_ABSORPTION_GAINHF:Int = 0x000B;
    public static inline final REVERB_ROOM_ROLLOFF_FACTOR:Int = 0x000C;
    public static inline final REVERB_DECAY_HFLIMIT:Int = 0x000D;

    // CHORUS
    public static inline final EFFECT_CHORUS:Int = 0x0002;

    public static inline final CHORUS_WAVEFORM:Int = 0x0001;
    public static inline final CHORUS_PHASE:Int = 0x0002;
    public static inline final CHORUS_RATE:Int = 0x0003;
    public static inline final CHORUS_DEPTH:Int = 0x0004;
    public static inline final CHORUS_FEEDBACK:Int = 0x0005;
    public static inline final CHORUS_DELAY:Int = 0x0006;
    
    // DISTORTION
    public static inline final EFFECT_DISTORTION:Int = 0x0003;

    public static inline final DISTORTION_EDGE:Int = 0x0001;
    public static inline final DISTORTION_GAIN:Int = 0x0002;
    public static inline final DISTORTION_LOWPASS_CUTOFF:Int = 0x0003;
    public static inline final DISTORTION_EQCENTER:Int = 0x0004;
    public static inline final DISTORTION_EQBANDWIDTH:Int = 0x0005;
    
    // ECHO
    public static inline final EFFECT_ECHO:Int = 0x0004;

    public static inline final ECHO_DELAY:Int = 0x0001;
    public static inline final ECHO_LRDELAY:Int = 0x0002;
    public static inline final ECHO_DAMPING:Int = 0x0003;
    public static inline final ECHO_FEEDBACK:Int = 0x0004;
    public static inline final ECHO_SPREAD:Int = 0x0005;
    
    // FLANGER
    public static inline final EFFECT_FLANGER:Int = 0x0005;

    public static inline final FLANGER_WAVEFORM:Int = 0x0001;
    public static inline final FLANGER_PHASE:Int = 0x0002;
    public static inline final FLANGER_RATE:Int = 0x0003;
    public static inline final FLANGER_DEPTH:Int = 0x0004;
    public static inline final FLANGER_FEEDBACK:Int = 0x0005;
    public static inline final FLANGER_DELAY:Int = 0x0006;
    
    // FREQUENCY SHIFTER
    public static inline final EFFECT_FREQUENCY_SHIFTER:Int = 0x0006;

    public static inline final FREQUENCY_SHIFTER_FREQUENCY:Int = 0x0001;
    public static inline final FREQUENCY_SHIFTER_LEFT_DIRECTION:Int = 0x0002;
    public static inline final FREQUENCY_SHIFTER_RIGHT_DIRECTION:Int = 0x0003;
    
    // VOCAL MORPHER
    public static inline final EFFECT_VOCAL_MORPHER:Int = 0x0007;

    public static inline final VOCAL_MORPHER_PHONEMEA:Int = 0x0001;
    public static inline final VOCAL_MORPHER_PHONEMEA_COARSE_TUNING:Int = 0x0002;
    public static inline final VOCAL_MORPHER_PHONEMEB:Int = 0x0003;
    public static inline final VOCAL_MORPHER_PHONEMEB_COARSE_TUNING:Int = 0x0004;
    public static inline final VOCAL_MORPHER_WAVEFORM:Int = 0x0005;
    public static inline final VOCAL_MORPHER_RATE:Int = 0x0006;

    // VOCAL MORPHER EXTRA CONSTANTS (?)
    public static inline final VOCAL_MORPHER_PHONEME_A:Int = 0;
    public static inline final VOCAL_MORPHER_PHONEME_E:Int = 1;
    public static inline final VOCAL_MORPHER_PHONEME_I:Int = 2;
    public static inline final VOCAL_MORPHER_PHONEME_O:Int = 3;
    public static inline final VOCAL_MORPHER_PHONEME_U:Int = 4;
    public static inline final VOCAL_MORPHER_PHONEME_AA:Int = 5;
    public static inline final VOCAL_MORPHER_PHONEME_AE:Int = 6;
    public static inline final VOCAL_MORPHER_PHONEME_AH:Int = 7;
    public static inline final VOCAL_MORPHER_PHONEME_AO:Int = 8;
    public static inline final VOCAL_MORPHER_PHONEME_EH:Int = 9;
    public static inline final VOCAL_MORPHER_PHONEME_ER:Int = 10;
    public static inline final VOCAL_MORPHER_PHONEME_IH:Int = 11;
    public static inline final VOCAL_MORPHER_PHONEME_IY:Int = 12;
    public static inline final VOCAL_MORPHER_PHONEME_UH:Int = 13;
    public static inline final VOCAL_MORPHER_PHONEME_UW:Int = 14;
    public static inline final VOCAL_MORPHER_PHONEME_B:Int = 15;
    public static inline final VOCAL_MORPHER_PHONEME_D:Int = 16;
    public static inline final VOCAL_MORPHER_PHONEME_F:Int = 17;
    public static inline final VOCAL_MORPHER_PHONEME_G:Int = 18;
    public static inline final VOCAL_MORPHER_PHONEME_J:Int = 19;
    public static inline final VOCAL_MORPHER_PHONEME_K:Int = 20;
    public static inline final VOCAL_MORPHER_PHONEME_L:Int = 21;
    public static inline final VOCAL_MORPHER_PHONEME_M:Int = 22;
    public static inline final VOCAL_MORPHER_PHONEME_N:Int = 23;
    public static inline final VOCAL_MORPHER_PHONEME_P:Int = 24;
    public static inline final VOCAL_MORPHER_PHONEME_R:Int = 25;
    public static inline final VOCAL_MORPHER_PHONEME_S:Int = 26;
    public static inline final VOCAL_MORPHER_PHONEME_T:Int = 27;
    public static inline final VOCAL_MORPHER_PHONEME_V:Int = 28;
    public static inline final VOCAL_MORPHER_PHONEME_Z:Int = 29;

    public static inline final VOCAL_MORPHER_WAVEFORM_SINUSOID:Int = 0;
    public static inline final VOCAL_MORPHER_WAVEFORM_TRIANGLE:Int = 1;
    public static inline final VOCAL_MORPHER_WAVEFORM_SAWTOOTH:Int = 2;
    
    // PITCH SHIFTER
    public static inline final EFFECT_PITCH_SHIFTER:Int = 0x0008;

    public static inline final PITCH_SHIFTER_COARSE_TUNE:Int = 0x0001;
    public static inline final PITCH_SHIFTER_FINE_TUNE:Int = 0x0002;
    
    // RING MODULATOR
    public static inline final EFFECT_RING_MODULATOR:Int = 0x0009;

    public static inline final RING_MODULATOR_FREQUENCY:Int = 0x0001;
    public static inline final RING_MODULATOR_HIGHPASS_CUTOFF:Int = 0x0002;
    public static inline final RING_MODULATOR_WAVEFORM:Int = 0x0003;
    
    // AUTOWAH
    public static inline final EFFECT_AUTOWAH:Int = 0x000A;

    public static inline final AUTOWAH_ATTACK_TIME:Int = 0x0001;
    public static inline final AUTOWAH_RELEASE_TIME:Int = 0x0002;
    public static inline final AUTOWAH_RESONANCE:Int = 0x0003;
    public static inline final AUTOWAH_PEAK_GAIN:Int = 0x0004;
    
    // COMPRESSOR
    public static inline final EFFECT_COMPRESSOR:Int = 0x000B;
    public static inline final COMPRESSOR_ONOFF:Int = 0x0001;
    
    // EQUALIZER
    public static inline final EFFECT_EQUALIZER:Int = 0x000C;

    public static inline final EQUALIZER_LOW_GAIN:Int = 0x0001;
    public static inline final EQUALIZER_LOW_CUTOFF:Int = 0x0002;
    public static inline final EQUALIZER_MID1_GAIN:Int = 0x0003;
    public static inline final EQUALIZER_MID1_CENTER:Int = 0x0004;
    public static inline final EQUALIZER_MID1_WIDTH:Int = 0x0005;
    public static inline final EQUALIZER_MID2_GAIN:Int = 0x0006;
    public static inline final EQUALIZER_MID2_CENTER:Int = 0x0007;
    public static inline final EQUALIZER_MID2_WIDTH:Int = 0x0008;
    public static inline final EQUALIZER_HIGH_GAIN:Int = 0x0009;
    public static inline final EQUALIZER_HIGH_CUTOFF:Int = 0x000A;

    // Filters
    public static inline final FILTER_FIRST_PARAMETER:Int = 0x0000;
    public static inline final FILTER_LAST_PARAMETER:Int = 0x8000;
    public static inline final FILTER_TYPE:Int = 0x8001;

    // Filter Types
    // NONE
    public static inline final FILTER_NULL:Int = 0x0000;

    // LOWPASS
    public static inline final FILTER_LOWPASS:Int = 0x0001;
    
    public static inline final LOWPASS_GAIN:Int = 0x0001;
    public static inline final LOWPASS_GAINHF:Int = 0x0002;
    
    // HIGHPASS
    public static inline final FILTER_HIGHPASS:Int = 0x0002;
    
    public static inline final HIGHPASS_GAIN:Int = 0x0001;
    public static inline final HIGHPASS_GAINLF:Int = 0x0002;
    
    // BANDPASS
    public static inline final FILTER_BANDPASS:Int = 0x0003;
    
    public static inline final BANDPASS_GAIN:Int = 0x0001;
    public static inline final BANDPASS_GAINLF:Int = 0x0002;
    public static inline final BANDPASS_GAINHF:Int = 0x0003;

    // Auxiliary Effect Slots
    public static inline final EFFECTSLOT_EFFECT:Int = 0x0001;
    public static inline final EFFECTSLOT_GAIN:Int = 0x0002;
    public static inline final EFFECTSLOT_AUXILIARY_SEND_AUTO:Int = 0x0003;
    public static inline final EFFECTSLOT_NULL:Int = 0x0000; // Used to disable source send

    // Utility
    static final fxMap:Map<Int, Map<Int, Int>> = [ // Effect Type -> Effect Param -> Array Length Value
        EFFECT_EAXREVERB => [ // Only EAXREVERB has parameters that specifically give out vectors/arrays
            EAXREVERB_REFLECTIONS_PAN => 3,
            EAXREVERB_LATE_REVERB_PAN => 3
        ]
    ];
    static inline function getFXParamMapping(type:Int, param:Int):Int return fxMap[type][param] ?? 1;

    /**
     * Initializes the EFX extension.
     * 
     * The EFX extension will not work before this function is called once.
     */
    public static inline function initEFX() { EFX.initEFX(); }
    
    // Effect Management
    /**
     * Returns an array of ALEffects.
     * @param num Amount of effects to return.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function createEffects(num:Int):Array<ALEffect> {
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
     * Creates an effect and returns it.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function createEffect():ALEffect { return createEffects(1)[0]; }

    /**
     * Deletes an array of ALEffects.
     * @param effects Effects to delete.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function deleteEffects(effects:Array<ALEffect>):Void {
        EFX.deleteEffects(effects.length, arrayEffect_ToPtr(effects));
        #if HAXEAL_DEBUG trace('Deleted ${effects.length} effects properly: ${!isEffect(effects[0])}'); #end
    }

    /**
     * Deletes a singular ALEffect
     * @param effect Effect to delete.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function deleteEffect(effect:ALEffect) { deleteEffects([effect]); }

    /**
     * Checks if the given effect is a valid ALEffect object.
     * @param effect Effect to check validity of.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function isEffect(effect:ALEffect):Bool return al_bool(EFX.isEffect(effect));
    
    /**
     * Sets the integer value for the target parameter of the given effect.
     * @param effect Effect to change parameter of.
     * @param param Param to set value of.
     * @param value New integer value of the param.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function effecti(effect:ALEffect, param:Int, value:Int):Void { EFX.effecti(effect, param, value); }

    /**
     * Sets an array of integer values for the target parameter of the given effect.
     * @param effect Effect to change parameter of.
     * @param param Param to set values of.
     * @param value New integer values of the param as an array (array length should be the same as amount of values the parameter takes).
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function effectiv(effect:ALEffect, param:Int, values:Array<Int>):Void { EFX.effectiv(effect, param, arrayInt_ToPtr(values)); }

    /**
     * Sets the float value for the target parameter of the given effect.
     * @param effect Effect to change parameter of.
     * @param param Param to set value of.
     * @param value New float value of the param.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function effectf(effect:ALEffect, param:Int, value:Float):Void { EFX.effectf(effect, param, value); }

    /**
     * Sets an array of float values for the target parameter of the given effect.
     * @param effect Effect to change parameter of.
     * @param param Param to set values of.
     * @param value New float values of the param as an array (array length should be the same as amount of values the parameter takes).
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function effectfv(effect:ALEffect, param:Int, values:Array<Float>):Void { EFX.effectfv(effect, param, arrayFloat32_ToPtr(values)); }

    /**
     * Gets the integer value for the target parameter of the given effect.
     * @param effect Effect to get parameter of.
     * @param param Param to get value of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getEffecti(effect:ALEffect, param:Int):Int {
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
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getEffectiv(effect:ALEffect, param:Int):Array<Int> {
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
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getEffectf(effect:ALEffect, param:Int):Float {
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
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getEffectfv(effect:ALEffect, param:Int):Array<Float> {
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
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function createFilters(num:Int):Array<ALFilter> {
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
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function createFilter():ALFilter { return createFilters(1)[0]; }

    /**
     * Deletes an array of ALFilters.
     * @param filters Filters to delete.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function deleteFilters(filters:Array<ALFilter>):Void {
        EFX.deleteFilters(filters.length, arrayFilter_ToPtr(filters));
        #if HAXEAL_DEBUG trace('Deleted ${filters.length} filters properly: ${!isFilter(filters[0])}'); #end
    }

    /**
     * Deletes a singular ALFilter
     * @param filter Filter to delete.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function deleteFilter(filter:ALFilter) { deleteFilters([filter]); }

    /**
     * Checks if the given filter is a valid ALFilter object.
     * @param filter Filter to check validity of.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function isFilter(filter:ALFilter):Bool { return al_bool(EFX.isFilter(filter)); }
    
    /**
     * Sets the integer value for the target parameter of the given filter.
     * @param filter Filter to change parameter of.
     * @param param Param to set value of.
     * @param value New integer value of the param.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function filteri(filter:ALFilter, param:Int, value:Null<Int>):Void { EFX.filteri(filter, param, value); }

    /**
     * Sets an array of integer values for the target parameter of the given filter.
     * @param filter Filter to change parameter of.
     * @param param Param to set values of.
     * @param value New integer values of the param as an array (array length should be the same as amount of values the parameter takes).
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function filteriv(filter:ALFilter, param:Int, values:Array<Int>):Void { EFX.filteriv(filter, param, arrayInt_ToPtr(values)); }

    /**
     * Sets the float value for the target parameter of the given filter.
     * @param filter Filter to change parameter of.
     * @param param Param to set value of.
     * @param value New float value of the param.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function filterf(filter:ALFilter, param:Int, value:Float):Void { EFX.filterf(filter, param, value); }

    /**
     * Sets an array of float values for the target parameter of the given filter.
     * @param filter Filter to change parameter of.
     * @param param Param to set values of.
     * @param value New float values of the param as an array (array length should be the same as amount of values the parameter takes).
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function filterfv(filter:ALFilter, param:Int, values:Array<Float>):Void { EFX.filterfv(filter, param, arrayFloat32_ToPtr(values)); }

    /**
     * Gets the integer value for the target parameter of the given filter.
     * @param filter Filter to get parameter of.
     * @param param Param to get value of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getFilteri(filter:ALFilter, param:Int):Int {
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
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getFilteriv(filter:ALFilter, param:Int):Array<Int> {
        var n = 123456789;
        var istr:Pointer<Int> = Pointer.addressOf(n);
        EFX.getFilteriv(filter, param, istr.ptr);

        return star_ToArrayInt(istr.ptr, 1);
    }

    /**
     * Gets the float value for the target parameter of the given filter.
     * @param filter Filter to get parameter of.
     * @param param Param to get value of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getFilterf(filter:ALFilter, param:Int):Float {
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
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getFilterfv(filter:ALFilter, param:Int):Array<Float> {
        var n:cpp.Float32 = 0.0123456789;
        var fstr:Pointer<cpp.Float32> = Pointer.addressOf(n);
        EFX.getFilterfv(filter, param, fstr.ptr);

        return star_ToArrayFloat32(fstr.ptr, 1);
    }

    // AuxSlot Management 
    /**
     * Returns an array of Auxiliary Effect Slots.
     * @param num Amount of slots to return.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function createAuxiliaryEffectSlots(num:Int):Array<ALAuxSlot> {
        var empty_auxslots:Array<ALAuxSlot> = [];
        var s_str:Pointer<ALAuxSlot> = Pointer.ofArray(empty_auxslots);
        EFX.createAuxiliaryEffectSlots(num, s_str.ptr);

        var auxslots:Array<ALAuxSlot> = star_ToArrayAuxiliaryEffectSlot(s_str.ptr, num);
        #if HAXEAL_DEBUG if(isAuxiliaryEffectSlot(auxslots[0])) #end return auxslots;
        #if HAXEAL_DEBUG 
        trace("Warning: Auxiliary Effect Slots may not have generated properly, returning array of potentially disfunctional slots");
        return auxslots;
        #end
    }

    /**
     * Creates an auxslot and returns it.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function createAuxiliaryEffectSlot():ALAuxSlot { return createAuxiliaryEffectSlots(1)[0]; }

    /**
     * Deletes an array of Auxiliary Effect Slots.
     * @param auxslots Auxiliary Effect Slots to delete.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function deleteAuxiliaryEffectSlots(auxslots:Array<ALAuxSlot>):Void {
        EFX.deleteAuxiliaryEffectSlots(auxslots.length, arrayAuxiliaryEffectSlot_ToPtr(auxslots));
        #if HAXEAL_DEBUG trace('Deleted ${auxslots.length} slots properly: ${!isAuxiliaryEffectSlot(auxslots[0])}'); #end
    }

    /**
     * Deletes a singular ALAuxSlot
     * @param auxslot Auxiliary Effect Slot to delete.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function deleteAuxiliaryEffectSlot(auxslot:ALAuxSlot) { deleteAuxiliaryEffectSlots([auxslot]); }

    /**
     * Checks if the given slot is a valid ALAuxSlot object.
     * @param auxslot Auxiliary Effect Slot to check validity of.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function isAuxiliaryEffectSlot(auxslot:ALAuxSlot):Bool { return al_bool(EFX.isAuxiliaryEffectSlot(auxslot)); }
    
    /**
     * Sets the integer value for the target parameter of the given auxslot.
     * @param auxslot Auxiliary Effect Slot to change parameter of.
     * @param param Param to set value of.
     * @param value New integer value of the param.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function auxiliaryEffectSloti(auxslot:ALAuxSlot, param:Int, value:Null<Int>):Void { EFX.auxiliaryEffectSloti(auxslot, param, value); }

    /**
     * Sets an array of integer values for the target parameter of the given Auxiliary Effect Slot.
     * @param auxslot Auxiliary Effect Slot to change parameter of.
     * @param param Param to set values of.
     * @param value New integer values of the param as an array (array length should be the same as amount of values the parameter takes).
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function auxiliaryEffectSlotiv(auxslot:ALAuxSlot, param:Int, values:Array<Int>):Void { EFX.auxiliaryEffectSlotiv(auxslot, param, arrayInt_ToPtr(values)); }

    /**
     * Sets the float value for the target parameter of the given Auxiliary Effect Slot.
     * @param auxslot Auxiliary Effect Slot to change parameter of.
     * @param param Param to set value of.
     * @param value New float value of the param.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function auxiliaryEffectSlotf(auxslot:ALAuxSlot, param:Int, value:Float):Void { EFX.auxiliaryEffectSlotf(auxslot, param, value); }

    /**
     * Sets an array of float values for the target parameter of the given Auxiliary Effect Slot.
     * @param auxslot Auxiliary Effect Slot to change parameter of.
     * @param param Param to set values of.
     * @param value New float values of the param as an array (array length should be the same as amount of values the parameter takes).
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function auxiliaryEffectSlotfv(auxslot:ALAuxSlot, param:Int, values:Array<Float>):Void { EFX.auxiliaryEffectSlotfv(auxslot, param, arrayFloat32_ToPtr(values)); }

    /**
     * Gets the integer value for the target parameter of the given Auxiliary Effect Slot.
     * @param auxslot Auxiliary Effect Slot to get parameter of.
     * @param param Param to get value of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getAuxiliaryEffectSloti(auxslot:ALAuxSlot, param:Int):Int {
        var n = 123456789;
        var istr:Pointer<Int> = Pointer.addressOf(n);
        EFX.getAuxiliaryEffectSloti(param, param, istr.ptr);
        return istr.ref;
    }

    /**
     * Returns an array of multiple integer values for the target parameter of the given Auxiliary Effect Slot.
     * 
     * The array size depends on the given param.
     * @param auxslot Auxiliary Effect Slot to get parameter of.
     * @param param Param to get values of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getAuxiliaryEffectSlotiv(auxslot:ALAuxSlot, param:Int):Array<Int> {
        var n = 123456789;
        var istr:Pointer<Int> = Pointer.addressOf(n);
        EFX.getAuxiliaryEffectSlotiv(auxslot, param, istr.ptr);

        return star_ToArrayInt(istr.ptr, 1);
    }

    /**
     * Gets the float value for the target parameter of the given Auxiliary Effect Slot.
     * @param auxslot Auxiliary Effect Slot to get parameter of.
     * @param param Param to get value of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getAuxiliaryEffectSlotf(auxslot:ALAuxSlot, param:Int):Float {
        var n:cpp.Float32 = 0.0123456789;
        var fstr:Pointer<cpp.Float32> = Pointer.addressOf(n);
        EFX.getAuxiliaryEffectSlotf(auxslot, param, fstr.ptr);
        return fstr.ref;
    }

    /**
     * Returns an array of multiple float values for the target parameter of the given Auxiliary Effect Slot.
     * 
     * The array size depends on the given param.
     * @param auxslot Auxiliary Effect Slot to get parameter of.
     * @param param Param to get values of.
     */
    public static #if HAXEAL_INLINE_OPT_BIG inline #end function getAuxiliaryEffectSlotfv(auxslot:ALAuxSlot, param:Int):Array<Float> {
        var n:cpp.Float32 = 0.0123456789;
        var fstr:Pointer<cpp.Float32> = Pointer.addressOf(n);
        EFX.getAuxiliaryEffectSlotfv(auxslot, param, fstr.ptr);

        return star_ToArrayFloat32(fstr.ptr, 1);
    }
}