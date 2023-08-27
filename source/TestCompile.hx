package;

import sys.FileSystem;
import haxe.Serializer;

//! REMINDER TO EXCLUDE THIS FROM THE HAXELIB

using DateTools;
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
                if(!FileSystem.exists('$targetPath/$file') || compareDates(lastBuild, fileStat.mtime) != lastBuild) {
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

    static function compareDates(d1:Date, d2:Date):Null<Date> {
        final v1:Array<Int> = [d1.getFullYear(), d1.getMonth(), d1.getDate(), d1.getHours(), d1.getMinutes(), d1.getSeconds()];
        final v2:Array<Int> = [d2.getFullYear(), d2.getMonth(), d2.getDate(), d2.getHours(), d2.getMinutes(), d2.getSeconds()];
        for(compNum in 0...6) {
            // Go through the array, starting at year comparison and ending at seconds comparison.
            // If the two things compared arent the same, check which is larger and return the date belonging to the larger value
            if(v1[compNum] != v2[compNum]) return v1[compNum] > v2[compNum] ? d1 : d2;
        }

        return null;
    }
}