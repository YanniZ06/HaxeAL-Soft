package source.haxeal.bindings;

import sys.io.File;
import sys.FileSystem;
import haxe.macro.Context;
import haxe.macro.Compiler;

using haxe.macro.Tools;
#if !macro
using StringTools;
#end

// HAXEAL_INLINE_OPT_SMALL
// HAXEAL_INLINE_OPT_BIG
// HAXEAL_APP_PATH
@:noDoc
class FlagChecker {
    static final acceptedBools:Map<String, Bool> = [
        'true' => true,
        '1' => true,
        'false' => false,
        '0' => false
    ];

    public static macro function checkFlags() {
        final optBig:Bool = acceptedBools[Context.definedValue('HAXEAL_INLINE_OPT_BIG') ?? '0'];
        final optSmall:Bool = acceptedBools[Context.definedValue('HAXEAL_INLINE_OPT_SMALL') ?? '0'];
        
        if(optBig && !optSmall) Compiler.define('HAXEAL_INLINE_OPT_SMALL', '1');

        var appPath:String = Context.definedValue('HAXEAL_APP_PATH'); 
        if(appPath != null) {
            if(appPath.charAt(appPath.length) != '/') appPath += '/';
            final cwd = Sys.getCwd();

            var oldFolderGrp = cwd.substr(0, cwd.length-1);
            for(folder in appPath.split('/')) {
                oldFolderGrp += '/$folder';
                if(folder != null && folder != '' && !FileSystem.exists(oldFolderGrp)) FileSystem.createDirectory(oldFolderGrp);
            }
            File.copy(cwd + 'source/openal/libs/x64/OpenAL32.dll', oldFolderGrp + 'OpenAL32.dll');
        }

        return macro null;
    }
}