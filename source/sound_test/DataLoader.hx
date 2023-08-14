package sound_test;

import haxeal.ALObjects.ALBuffer;
import haxeal.HaxeAL;

class DataLoader {
    public static function loadWav(bytes:haxe.io.Bytes, buffer:ALBuffer):ALBuffer {
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
        HaxeAL.bufferData(buffer, format, bytes, bytes.length, samplingRate);

        return buffer;
    }

    static final formats8 = [HaxeAL.FORMAT_MONO8, HaxeAL.FORMAT_STEREO8];
	static final formats16 = [HaxeAL.FORMAT_MONO16, HaxeAL.FORMAT_STEREO16];
	private static inline function resolveFormat(bitsPerSample:Int, channels:Int):Int
		return bitsPerSample <= 8 ? formats8[channels - 1] : formats16[channels - 1];
}