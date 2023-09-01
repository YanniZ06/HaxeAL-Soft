package haxeal.bindings;

import haxeal.ALObjects.ALSource;
import haxeal.ALObjects.ALBuffer;
import haxeal.ALObjects.ALAuxSlot;
import haxeal.ALObjects.ALEffect;
import haxeal.ALObjects.ALFilter;

class BinderHelper {
    /**
     * Turns an array of integers into a const integer pointer (ConstStar<Int>)
     */
    /*public static inline function arrayInt_ToConstStar(array:Array<Int>):ConstStar<Int> 
        return (cast Pointer.ofArray(array).ptr : ConstStar<Int>);*/

    /**
     * Turns an integer into an integer pointer (Pointer<Int>)
     */
    public static inline function int_ToPtr(obj:Int):Pointer<Int> return Pointer.addressOf(obj);

    /**
     * Turns an array of integers into an integer pointer (Pointer<Int>)
     */
    public static inline function arrayInt_ToPtr(array:Array<Int>):Pointer<Int> return Pointer.ofArray(array);

    /**
     * Turns an array of integers into an integer pointer (Star<Int>)
     */
    public static inline function arrayInt_ToStar(array:Array<Int>):Star<Int> return Pointer.ofArray(array).ptr;


    public static inline function float_ToPtr(f:Float):Pointer<Float> return Pointer.addressOf(f);

    public static inline function arrayFloat32_ToPtr(array:Array<Float>):Pointer<cpp.Float32> {
        var c_arr:Array<cpp.Float32> = [];
        for(f in array) c_arr.push(f);

        return Pointer.ofArray(c_arr);
    }
    public static inline function arrayFloat64_ToPtr(array:Array<Float>):Pointer<cpp.Float64> {
        var c_arr:Array<cpp.Float64> = [];
        for(f in array) c_arr.push(f);

        return Pointer.ofArray(c_arr);
    }

    public static inline function arrayFloat_ToStar(array:Array<Float>):Star<Float> return Pointer.ofArray(array).ptr;


    // I wish i could just use <T> but quite frankly hxcpp shits itself and these functions are all inlined anyways so it really doesnt matter
    
    public static inline function arraySource_ToPtr(array:Array<ALSource>):Pointer<ALSource> return Pointer.ofArray(array);

    public static inline function arraySource_ToStar(array:Array<ALSource>):Star<ALSource> return Pointer.ofArray(array).ptr;

    public static inline function star_ToArraySource(str:Star<ALSource>, len:Int):Array<ALSource> return Pointer.fromStar(str).toUnmanagedArray(len);


    public static inline function arrayEffect_ToPtr(array:Array<ALEffect>):Pointer<ALEffect> return Pointer.ofArray(array);

    public static inline function arrayEffect_ToStar(array:Array<ALEffect>):Star<ALEffect> return Pointer.ofArray(array).ptr;

    public static inline function star_ToArrayEffect(str:Star<ALEffect>, len:Int):Array<ALEffect> return Pointer.fromStar(str).toUnmanagedArray(len);


    public static inline function arrayFilter_ToPtr(array:Array<ALFilter>):Pointer<ALFilter> return Pointer.ofArray(array);

    public static inline function arrayFilter_ToStar(array:Array<ALFilter>):Star<ALFilter> return Pointer.ofArray(array).ptr;

    public static inline function star_ToArrayFilter(str:Star<ALFilter>, len:Int):Array<ALFilter> return Pointer.fromStar(str).toUnmanagedArray(len);


    public static inline function arrayAuxiliaryEffectSlot_ToPtr(array:Array<ALAuxSlot>):Pointer<ALAuxSlot> return Pointer.ofArray(array);

    public static inline function arrayAuxiliaryEffectSlot_ToStar(array:Array<ALAuxSlot>):Star<ALAuxSlot> return Pointer.ofArray(array).ptr;

    public static inline function star_ToArrayAuxiliaryEffectSlot(str:Star<ALAuxSlot>, len:Int):Array<ALAuxSlot> return Pointer.fromStar(str).toUnmanagedArray(len);


    public static inline function arrayBuffer_ToPtr(array:Array<ALBuffer>):Pointer<ALBuffer> return Pointer.ofArray(array);

    public static inline function arrayBuffer_ToStar(array:Array<ALBuffer>):Star<ALBuffer> return Pointer.ofArray(array).ptr;

    public static inline function star_ToArrayBuffer(str:Star<ALBuffer>, len:Int):Array<ALBuffer> return Pointer.fromStar(str).toUnmanagedArray(len);


    public static inline function star_ToArrayFloat32(str:Star<cpp.Float32>, len:Int):Array<Float> {
        var c_arr:Array<cpp.Float32> = Pointer.fromStar(str).toUnmanagedArray(len);
        var array:Array<Float> = [];
        for(f in c_arr) array.push(f);

        return array;
    }

    public static inline function star_ToArrayInt(str:Star<Int>, len:Int):Array<Int> {
        return Pointer.fromStar(str).toUnmanagedArray(len); //   .toUnmanagedArray(Std.int(length));
    }

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