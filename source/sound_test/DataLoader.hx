package sound_test;

import haxeal.ALObjects.ALBuffer;
import haxeal.HaxeAL;

enum ForceMode {
    NONE;
    MONO;
    STEREO;
}
class DataLoader {
    /*public static function loadWav(bytes:haxe.io.Bytes, buffer:ALBuffer):ALBuffer {
        var input = new haxe.io.BytesInput(bytes);
		// Get all our infos from the WAV file
		// All position skips are skipping over values we dont need, refer to this site as to what we're reading (and skipping): https://docs.fileformat.com/audio/wav/
		input.position += 22;

		final channels = input.readInt16();
		final samplingRate = input.readInt32();

		input.position += 6;

		final bitsPerSample = input.readInt16();
		input.position += 4; // should be data marker
		final len = input.readInt32();
		final rawData = input.read(len);

        final format = resolveFormat(bitsPerSample, channels);
		trace(format);
        HaxeAL.bufferData(buffer, format, rawData, rawData.length, samplingRate);

        return buffer;
    }*/

	public static function parseWAV(file:String, buf:ALBuffer, forceMode:ForceMode = NONE):ALBuffer {
        var fileBytes:sys.io.FileInput = sys.io.File.read(file);
        try {
            final chunkID:String = fileBytes.readString(4);
            //chunkSize
            fileBytes.readInt32();
            final format:String = fileBytes.readString(4);
            if (chunkID != "RIFF" || format != "WAVE")
                throw "Invalid RIFF or WAVE Header.";

            var subChunkID:String = fileBytes.readString(4);
            while(subChunkID != "fmt "){
                switch(subChunkID){
                    case "JUNK" | "bext":
                        var len:Int = fileBytes.readInt32();
                        fileBytes.read(len);
                        subChunkID = fileBytes.readString(4);
                    default: break;
                }
            }

            final subChunkSize = fileBytes.readInt32();
            //audioformat
            fileBytes.readUInt16();
            final numChannels:Int = fileBytes.readUInt16();
            final frequency:Int = fileBytes.readInt32();
            final bitRate:Int = fileBytes.readInt32();
            //blockalign
            fileBytes.readUInt16();
            final bitsPerSample:Int = fileBytes.readUInt16();

            if (subChunkID != "fmt ")
                throw "Invalid Wave format.";

            if (subChunkSize > 16)
                fileBytes.seek(cpp.Stdlib.sizeof(Int), sys.io.FileSeek.SeekCur);

            var subChunkID2:String = fileBytes.readString(4);
            /**read past other chunks**/
            while(subChunkID2 != "data"){
                fileBytes.read(fileBytes.readInt32());
                subChunkID2 = fileBytes.readString(4);
            }
            final size:Int = fileBytes.readInt32();

            if(subChunkID2 != "data")
                throw "Invalid Wave data.";

            final targetChannelCount:Int = switch(forceMode) { case NONE: numChannels; case MONO: 1; case STEREO: 2; };
            var modulator:Float = 1;
            if(targetChannelCount != numChannels) modulator = targetChannelCount > numChannels ? 0.5 : 2; //if we need

            final fixedFreq:Int = Std.int(frequency * modulator);
            final format:Int = resolveFormat(bitsPerSample, targetChannelCount);

            final bytes:haxe.io.Bytes = fileBytes.readAll();

            fileBytes.close();
            fileBytes = null;
			cpp.vm.Gc.run(true);
			cpp.vm.Gc.compact();

            // var arr:Array<Dynamic> = ['numChannels: $numChannels, targetChannels: $targetChannelCount', format, bytes, bytes.length, fixedFreq];
            // for(o in arr) trace(o);
			HaxeAL.bufferData(buf, format, bytes, bytes.length, fixedFreq);
        } catch(e) {
			trace("Failed to load buffer data!");
            trace(e.details());
            fileBytes.close();
            fileBytes = null;
        }

		return buf;
	}

    public static function wavBytes(file:String, forceMode:ForceMode = NONE):haxe.io.Bytes {
        var fileBytes:sys.io.FileInput = sys.io.File.read(file);
        try {
            final chunkID:String = fileBytes.readString(4);
            //chunkSize
            fileBytes.readInt32();
            final format:String = fileBytes.readString(4);
            if (chunkID != "RIFF" || format != "WAVE")
                throw "Invalid RIFF or WAVE Header.";

            var subChunkID:String = fileBytes.readString(4);
            while(subChunkID != "fmt "){
                switch(subChunkID){
                    case "JUNK" | "bext":
                        var len:Int = fileBytes.readInt32();
                        fileBytes.read(len);
                        subChunkID = fileBytes.readString(4);
                    default: break;
                }
            }

            final subChunkSize = fileBytes.readInt32();
            //audioformat
            fileBytes.readUInt16();
            final numChannels:Int = fileBytes.readUInt16();
            final frequency:Int = fileBytes.readInt32();
            final bitRate:Int = fileBytes.readInt32();
            //blockalign
            fileBytes.readUInt16();
            final bitsPerSample:Int = fileBytes.readUInt16();

            if (subChunkID != "fmt ")
                throw "Invalid Wave format.";

            if (subChunkSize > 16)
                fileBytes.seek(cpp.Stdlib.sizeof(Int), sys.io.FileSeek.SeekCur);

            var subChunkID2:String = fileBytes.readString(4);
            /**read past other chunks**/
            while(subChunkID2 != "data"){
                fileBytes.read(fileBytes.readInt32());
                subChunkID2 = fileBytes.readString(4);
            }
            final size:Int = fileBytes.readInt32();

            if(subChunkID2 != "data")
                throw "Invalid Wave data.";

            final targetChannelCount:Int = switch(forceMode) { case NONE: numChannels; case MONO: 1; case STEREO: 2; };
            var modulator:Float = 1;
            if(targetChannelCount != numChannels) modulator = targetChannelCount > numChannels ? 0.5 : 2; //if we need

            final fixedFreq:Int = Std.int(frequency * modulator);
            final format:Int = resolveFormat(bitsPerSample, targetChannelCount);

            final bytes:haxe.io.Bytes = fileBytes.readAll();

            fileBytes.close();
            fileBytes = null;
			cpp.vm.Gc.run(true);
			cpp.vm.Gc.compact();

            return bytes;

        } catch(e) {
			trace("Failed to load buffer data!");
            trace(e.details());
            fileBytes.close();
            fileBytes = null;
        }

		return null;
	}

    static final formats8 = [HaxeAL.FORMAT_MONO8, HaxeAL.FORMAT_STEREO8];
	static final formats16 = [HaxeAL.FORMAT_MONO16, HaxeAL.FORMAT_STEREO16];
	private static inline function resolveFormat(bitsPerSample:Int, channels:Int):Int
		return bitsPerSample <= 8 ? formats8[channels - 1] : formats16[channels - 1];
}