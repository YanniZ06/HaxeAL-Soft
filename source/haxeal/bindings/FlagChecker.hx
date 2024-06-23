package haxeal.bindings;

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
// HAXEAL_DEBUG_SOFT
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

        var appPath:String = Context.definedValue('HAXEAL_APP_PATH') ?? Compiler.getOutput(); // If no path is set, get default output
        if(appPath.charAt(appPath.length) != '/') appPath += '/';
        final cwd = Sys.getCwd();

        var oldFolderGrp = cwd.substr(0, cwd.length-1); // Make sure we dont keep the trailing "/"
        var folderDepth:Int = 0;
        for(folder in appPath.split('/')) { // We do this to ensure all folders specified in the path exist
            oldFolderGrp += '/$folder';
            if(folder == null || folder == '') continue; // Skip empty folder
            
            folderDepth++;
            if(!FileSystem.exists(oldFolderGrp)) FileSystem.createDirectory(oldFolderGrp);
        }
        final binaryFolder = oldFolderGrp;
        File.copy(cwd + 'source/openal/libs/x64/OpenAL32.dll', binaryFolder + 'OpenAL32.dll');

        var debug:String = Context.definedValue('HAXEAL_DEBUG_SOFT_LOGLEVEL');
        var logLevel:Null<Int> = debug == null ? 0 : Std.parseInt(debug);
        if(logLevel == null || logLevel < 0 || logLevel > 3) return macro null;

        final cmd = 'cd ' + appPath.substr(0, appPath.length-1);
        trace(cmd);

        // todo: get this to WORK damn it! currently only doing these commands in the windows cmd on the output directory works
        // ? https://github.com/kcat/openal-soft/blob/master/docs/env-vars.txt
        Sys.command(cmd);
        Sys.command('set ALSOFT_LOGLEVEL=' + logLevel);
        Sys.command('set ALSOFT_LOGFILE=openal_log.txt');
        for(i in 0...folderDepth) {
            Sys.command('cd ..');
            trace("Went back folder");
        }

        return macro null;
    }
}