package;

import sys.FileSystem;
import haxe.Serializer;

//! REMINDER TO EXCLUDE THIS FROM THE HAXELIB
class TestCompile {
    public static macro function importAssets() {
        final assPath:String = Sys.getCwd() + 'assets';
        final targetPath:String = Sys.getCwd() + 'output/assets';
        final buildInfo:String = Sys.getCwd() + 'lastBuild.txt';

        var lastBuild:Date = null;
        if(!FileSystem.exists(buildInfo)) {
            lastBuild = Date.now();
            sys.io.File.saveContent(buildInfo, Serializer.run(lastBuild));
            //Sys.command('msg', ["Yanni", "new date set: " + lastBuild]);
            trace("got first new date");
        }
        else lastBuild = haxe.Unserializer.run(sys.io.File.getContent(buildInfo));
        trace("Last build at: " + lastBuild.toString());

        if(!FileSystem.exists(targetPath)) {
            trace("Creating first time asset path");

            FileSystem.createDirectory(targetPath);
            for(file in FileSystem.readDirectory(assPath)) {
                sys.io.File.saveBytes('$targetPath/$file', sys.io.File.getBytes('$assPath/$file'));
                trace(file);
            }
        }
        else {
            for(file in FileSystem.readDirectory(assPath)) {
                var fileStat = FileSystem.stat('$assPath/$file');
                if(!FileSystem.exists('$targetPath/$file') || lastBuild.toString() < fileStat.mtime.toString()) {
                    trace("Replacing: " + file);
                    sys.io.File.saveBytes('$targetPath/$file', sys.io.File.getBytes('$assPath/$file'));
                    continue;
                }
                trace("Skipping: " + file);
            }
        }
        lastBuild = Date.now();
        sys.io.File.saveContent(Sys.getCwd() + 'lastBuild.txt', Serializer.run(lastBuild));

        trace("Current build at: " + lastBuild.toString());

        return macro null;
    }
}