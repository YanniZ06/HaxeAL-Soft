package haxeal.bindings;

import haxeal.ALObjects;

/* @:unreflective @:keep
@:include("efx.h") 
extern class EFT {
    @:native('LPALGENEFFECTS')
    static function genEffects(n:Int, effects:Star<ALEffect>):Void;

    @:native('LPALISEFFECT')
    static function isEffect(effect:ALEffect):Char;
}*/

/*
@:headerCode('
    #include <efx.h>
')
class EFXT {
    @:functionCode('
        LPALGENEFFECTS alGenEffects = (LPALGENEFFECTS) alGetProcAddress("alGenEffects");
        alGenEffects(n, effects);
    ')
    public static function createEffects(n:Int, effects:Star<ALEffect>) {}

    @:functionCode('
        LPALISEFFECT alIsEffect = (LPALISEFFECT) alGetProcAddress("alIsEffect");
        return alIsEffect(effect);
    ')
    public static function isEffect(effect:ALEffect):cpp.Char { throw 'INVALID'; }
}*/