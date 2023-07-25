package haxeal.bindings;

class BinderHelper {
    public static inline function arrayInt_ToConstStar(array:Array<Int>):ConstStar<Int> {
        final asStar:Null<Star<Int>> = Pointer.ofArray(array).ptr;
        return cast asStar;
    }

    public static inline function arrayInt_ToStar(array:Array<Int>):Star<Int> return Pointer.ofArray(array).ptr;
}