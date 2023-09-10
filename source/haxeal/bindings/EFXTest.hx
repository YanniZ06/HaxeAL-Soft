package haxeal.bindings;

import haxeal.ALObjects;

/*@:unreflective @:keep
@:include("efx.h") 
extern class EFT {
    @:native('LPALGENEFFECTS')
    static function genEffects(n:Int, effects:Star<ALEffect>):Void;

    @:native('LPALISEFFECT')
    static function isEffect(effect:ALEffect):Char;
}*/

@:unreflective @:keep
@:include("efx.h") @:structAccess @:native('LPALGENEFFECTS')
extern class GenEffectsPtr {}

@:unreflective @:keep
@:include("efx.h") @:structAccess @:native('LPALISEFFECT')
extern class IsEffectPtr {}