package haxeal.bindings;

class BinderHelper {
    /**
     * Turns an array of integers into a const integer pointer (ConstStar<Int>)
     */
    /*public static inline function arrayInt_ToConstStar(array:Array<Int>):ConstStar<Int> 
        return (cast Pointer.ofArray(array).ptr : ConstStar<Int>);*/

    public static inline function int_ToPtr(obj:Int):Pointer<Int> return Pointer.addressOf(obj);

    public static inline function arrayInt_ToPtr(array:Array<Int>):Pointer<Int> return Pointer.ofArray(array);

    /**
     * Turns an array of integers into an integer pointer (Star<Int>)
     */
    public static inline function arrayInt_ToStar(array:Array<Int>):Star<Int> return Pointer.ofArray(array).ptr;

    public static inline function float_ToPtr(f:Float):Pointer<Float> return Pointer.addressOf(f);

    public static inline function arrayFloat_ToPtr(array:Array<Float>):Pointer<Float> return Pointer.ofArray(array);

    public static inline function star_ToArrayFloat(str:Star<Float>, len:Int):Array<Float> return Pointer.fromStar(str).toUnmanagedArray(len);

    public static inline function star_ToArrayInt(str:Star<Int>, len:Int):Array<Int> {
        return Pointer.fromStar(str).toUnmanagedArray(len); //   .toUnmanagedArray(Std.int(length));
    }

    /**
     * Turns an integer into a boolean value.
     * 0 is false, 1 is true
     */
    public static inline function al_bool(value:Int):Bool return value == 1;
}