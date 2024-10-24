package haxeal.bindings;

import sys.io.Process;
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

    static var curHaxelibPath:String = '';

    public static macro function checkFlags() {
        final cwd = Sys.getCwd();
        if(!FileSystem.exists(cwd + Compiler.getOutput())) {
            trace("\n(HAXEAL-SOFT NOTICE) Please rebuild after your first compilation has finished for HaxeAL-Soft to properly initialize!\n\n");
            Sys.sleep(2.5);
            return macro null;
        }

        final process = new sys.io.Process('haxelib libpath HaxeAL-Soft', null);
        curHaxelibPath = process.stdout.readLine();
        process.close();

        // I could use Sys.systemName but id rather get the direct compiler flag that has been set
        var system:String = 'unknown';
        if(Context.definedValue('windows') != null) system = 'windows';
        if(Context.definedValue('linux') != null) system = 'linux';
        if(Context.definedValue('macos') != null || Context.definedValue('iphoneos') != null || Context.definedValue('iphonesim') != null) system = 'apple_sys';
        if(system == 'unknown') system = Sys.systemName();


        final optBig:Bool = acceptedBools[Context.definedValue('HAXEAL_INLINE_OPT_BIG') ?? '0'];
        final optSmall:Bool = acceptedBools[Context.definedValue('HAXEAL_INLINE_OPT_SMALL') ?? '0'];
        
        if(optBig && !optSmall) Compiler.define('HAXEAL_INLINE_OPT_SMALL', '1');

        var appPath:String = Context.definedValue('HAXEAL_APP_PATH') ?? Compiler.getOutput(); // If no path is set, get default output
        if(Context.definedValue('HAXEAL_APP_PATH') == null) 
            trace('\n(HAXEAL-SOFT WARNING): HAXEAL_APP_PATH IS NOT DEFINED\nUSING DEFAULT OUTPUT PATH $appPath & DEFAULT OUTPUT FILE "Main.exe"\n');

        if(appPath.charAt(appPath.length) != '/') appPath += '/';

        var oldFolderGrp = cwd.substr(0, cwd.length-1); // Make sure we dont keep the trailing "/"
        var folderDepth:Int = 0;
        var appFile:String = 'Main.exe';
        var gotFile:Bool = false;
        for(folder in appPath.split('/')) { // Retrieve our path information
            if(folder == null || folder == '') continue; // Skip empty folder
            if(!FileSystem.isDirectory(oldFolderGrp + '/$folder')) { // We got an executeable file
                appFile = folder;
                gotFile = true;
                break;
            }

            oldFolderGrp += '/$folder';
            
            folderDepth++;
            if(!FileSystem.exists(oldFolderGrp)) FileSystem.createDirectory(oldFolderGrp);
        }
        final binaryFolder = oldFolderGrp;
        if(binaryFolder == cwd) {
            trace("Received cwd: " + cwd);
            trace("Tried copying HaxeAL-Soft files into source directory, aborting.");
            return macro null;
        }

        var processorType:String = Context.definedValue('HXCPP_M32') != null ? 'x86' : 'x64';
        trace("Processor type is: " + processorType);

        switch(system) {
            case 'windows':
                File.copy('$curHaxelibPath/source/openal/libs/$processorType/OpenAL32.dll', binaryFolder + '/OpenAL32.dll');
            case 'linux':
                Compiler.define('NO_PRECOMPILED_HEADERS', '1');
                trace('(HAXEAL-SOFT NOTICE): Linux build recognized, not copying windows binary and defining "NO_PRECOMPILED_HEADERS".');
                trace('If errors like "hxcpp.h not found" come up, try setting the flag yourself (-D NO_PRECOMPILED_HEADERS)');
            case 'apple_sys':
                trace('(HAXEAL-SOFT NOTICE): Apple build recognized, not copying windows binary as system pre-installed should be used.');
            default: // Sys.systemName() or unknown 
                var systemCheck:String = system.toLowerCase();
                switch(systemCheck) {
                    case 'windows' | 'linux' | 'mac':
                        if(systemCheck == 'mac') systemCheck = 'macos';

                        trace('(HAXEAL-SOFT WARNING): System $systemCheck recognized by HaxeAL, missing defined flag (-D windows, -D linux, -D macos)?');
                        trace('Setting flag manually, errors might occur!');
                        Compiler.define(systemCheck);
                    case 'bsd':
                        trace('(HAXEAL-SOFT CRITICAL ERROR): BSD is not supported.');
                        trace('The library will not compile properly.');
                    case 'unknown':
                        trace('(HAXEAL-SOFT CRITICAL ERROR): Could not find compiling system, missing defined flag (-D windows, -D linux, -D macos)?');
                        trace('The library will not compile properly.');
                }
        }

        var debug:String = Context.definedValue('HAXEAL_DEBUG_SOFT_LOGLEVEL');
        var logLevel:Null<Int> = debug == null ? 0 : Std.parseInt(debug);
        if(logLevel == null || logLevel < 0 || logLevel > 3) return macro null;

        var valOutFile = Context.definedValue('HAXE_OUTPUT_FILE');
        if(!gotFile) {
            if(valOutFile != null) appFile = valOutFile;
            trace('(HAXEAL-SOFT WARNING): NO EXECUTEABLE FILE FOUND IN "HAXEAL_APP_PATH", USING DEFAULT/FOUND "$appFile"\nDEBUG LOG RUN SCRIPTS MAY FUNCTION IMPROPERLY.\nDEFINE YOUR PATH LIKE "output/ExecName.exe"!\n');
        }
        final execExtList:Array<String> = ['.exe', '.com', '.bin', '.elf'];
        final appFileTail:String = appFile.substr(appFile.length-4, appFile.length);
        for(ext in execExtList) {
            if(ext != appFileTail) continue;

            appFile = appFile.substr(0, appFile.length-4); // Remove filename
            break;
        }
        File.saveContent(binaryFolder + '/releaseWinLogRun.bat', 'set ALSOFT_LOGLEVEL=$logLevel\nset ALSOFT_LOGFILE=openal_log.txt\n$appFile');
        File.saveContent(binaryFolder + '/debugWinLogRun.bat', 'set ALSOFT_LOGLEVEL=$logLevel\nset ALSOFT_LOGFILE=openal_log.txt\n$appFile-debug');
        
        File.saveContent(binaryFolder + '/releaseUnixLogRun.sh', 'export ALSOFT_LOGLEVEL="$logLevel"\nexport ALSOFT_LOGFILE="openal_log.txt"\n./$appFile');
        File.saveContent(binaryFolder + '/debugUnixLogRun.sh', 'export ALSOFT_LOGLEVEL="$logLevel"\nexport ALSOFT_LOGFILE="openal_log.txt"\n./$appFile-debug');

        return macro null;
    }
}