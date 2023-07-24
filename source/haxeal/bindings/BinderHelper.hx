package haxeal.bindings;

class BinderHelper {
    public static inline function arrayToConstStar<T>(objOfType:T, array:Array<T>):ConstStar<T> {
        final asStar:Null<Star<T>> = Pointer.ofArray(array).ptr;
        return cast asStar;
    }

    public static inline function arrayToStar<T>(objOfType:T, array:Array<T>):Star<T> return Pointer.ofArray(array).ptr;
}