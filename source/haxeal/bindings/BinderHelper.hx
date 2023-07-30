package haxeal.bindings;

class BinderHelper {
    /**
     * Turns an array of integers into a const integer pointer (ConstStar<Int>)
     */
    public static inline function arrayInt_ToConstStar(array:Array<Int>):ConstStar<Int> 
        return (cast Pointer.ofArray(array).ptr : ConstStar<Int>);

    public static inline function star_ToArrayInt(str:Star<Int>):Array<Int> {
        final length:Float = untyped __cpp__('sizeof({0}) / sizeof(*{0})', str);
        return Pointer.fromStar(str).toUnmanagedArray(Std.int(length)); //   .toUnmanagedArray(Std.int(length));
    }

    /**
     * Turns an array of integers into an integer pointer (Star<Int>)
     */
    public static inline function arrayInt_ToStar(array:Array<Int>):Star<Int> return Pointer.ofArray(array).ptr;

    /**
     * Turns an integer into a boolean value.
     * 0 is false, 1 is true
     */
    public static inline function al_bool(value:Int):Bool return value == 1;
}