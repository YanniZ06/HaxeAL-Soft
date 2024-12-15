package haxeal.bindings;

import haxeal.ALObjects.ALSource;
import haxeal.ALObjects.ALBuffer;

@:build(haxeal.bindings.FunctionBuilder.buildFunctions())
@:headerCode('
    #include <alext.h>

    static LPALSOURCEPLAYATTIMESOFT alSourcePlayAtTimeSOFT;
    static LPALSOURCEPLAYATTIMEVSOFT alSourcePlayAtTimevSOFT;

    static LPALSOURCEDSOFT alSourcedSOFT;
    static LPALSOURCE3DSOFT alSource3dSOFT;
    static LPALSOURCEDVSOFT alSourcedvSOFT;
    static LPALGETSOURCEDSOFT alGetSourcedSOFT;
    static LPALGETSOURCE3DSOFT alGetSource3dSOFT;
    static LPALGETSOURCEDVSOFT alGetSourcedvSOFT;
    static LPALSOURCEI64SOFT alSourcei64SOFT;
    static LPALSOURCE3I64SOFT alSource3i64SOFT;
    static LPALSOURCEI64VSOFT alSourcei64vSOFT;
    static LPALGETSOURCEI64SOFT alGetSourcei64SOFT;
    static LPALGETSOURCE3I64SOFT alGetSource3i64SOFT;
    static LPALGETSOURCEI64VSOFT alGetSourcei64vSOFT;
') // Soft functions are done here as they would collide with the AL extern class
class ALSOFT {
    // AL_SOFT_source_start_delay
    @lpFunc("alSourcePlayAtTimeSOFT")
    static inline function sourcePlayAtTime(source:ALSource, start_time:cpp.Int64):Void {}

    @lpFunc("alSourcePlayAtTimevSOFT")
    static inline function sourcePlayAtTimev(size:Int, sources:Star<ALSource>, start_time:cpp.Int64):Void {}

    // AL_SOFT_source_latency

    // Double setting
    @lpFunc("alSourcedSOFT")
    static inline function sourced(source:ALSource, param:Int, value:cpp.Float64):Void {}

    @lpFunc("alSource3dSOFT")
    static inline function source3d(source:ALSource, param:Int, value1:cpp.Float64, value2:cpp.Float64, value3:cpp.Float64):Void {}

    @lpFunc("alSourcedvSOFT")
    static inline function sourcedv(source:ALSource, param:Int, values:Star<cpp.Float64>):Void {}

    // Double getting
    @lpFunc("alGetSourcedSOFT")
    static inline function getSourced(source:ALSource, param:Int, value:Star<cpp.Float64>):Void {}

    @lpFunc("alGetSource3dSOFT")
    static inline function getSource3d(source:ALSource, param:Int, value1:Star<cpp.Float64>, value2:Star<cpp.Float64>, value3:Star<cpp.Float64>):Void {}

    @lpFunc("alGetSourcedvSOFT")
    static inline function getSourcedv(source:ALSource, param:Int, values:Star<cpp.Float64>):Void {}

    // Long-int setting
    @lpFunc("alSourcei64SOFT")
    static inline function sourcei64(source:ALSource, param:Int, value:cpp.Int64):Void {}

    @lpFunc("alSource3i64SOFT")
    static inline function source3i64(source:ALSource, param:Int, value1:cpp.Int64, value2:cpp.Int64, value3:cpp.Int64):Void {}

    @lpFunc("alSourcei64vSOFT")
    static inline function sourcei64v(source:ALSource, param:Int, values:Star<cpp.Int64>):Void {}

    // Long-int getting
    @lpFunc("alGetSourcei64SOFT")
    static inline function getSourcei64(source:ALSource, param:Int, value:Star<cpp.Int64>):Void {}

    @lpFunc("alGetSource3i64SOFT")
    static inline function getSource3i64(source:ALSource, param:Int, value1:Star<cpp.Int64>, value2:Star<cpp.Int64>, value3:Star<cpp.Int64>):Void {}

    @lpFunc("alGetSourcei64vSOFT")
    static inline function getSourcei64v(source:ALSource, param:Int, values:Star<cpp.Int64>):Void {}
}