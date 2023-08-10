package haxeal.bindings;

import haxeal.ALObjects.ALSource;
import haxeal.ALObjects.ALBuffer;

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


    public static inline function arraySource_ToPtr(array:Array<ALSource>):Pointer<ALSource> return Pointer.ofArray(array);

    public static inline function arraySource_ToStar(array:Array<ALSource>):Star<ALSource> return Pointer.ofArray(array).ptr;

    public static inline function star_ToArraySource(str:Star<ALSource>, len:Int):Array<ALSource> return Pointer.fromStar(str).toUnmanagedArray(len);


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
}