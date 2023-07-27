package haxeal.bindings;

class BinderHelper {
    /**
     * Turns an array of integers into a const integer pointer (ConstStar<Int>)
     */
    public static inline function arrayInt_ToConstStar(array:Array<Int>):ConstStar<Int> {
        final asStar:Null<Star<Int>> = Pointer.ofArray(array).ptr;
        return cast asStar;
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