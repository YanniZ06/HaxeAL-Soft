package haxeal;

/**
 * Represents a device that allows audio playback.
 */
typedef ALDevice = Star<haxeal.bindings.ALC.ALCdevice>;

/**
 * Audio capture specific device.
 */
typedef ALCaptureDevice = ALDevice;

// TODO: maybe add support for other array types (for 16 bit for example) / use template "<T>"
/**
 * A buffer specifically for handling captured audio.
 * 
 * Also owns an ALBuffer that is retrievable via `get_ALBuffer`.
 * Created with `HaxeALC.createCaptureBuffer()`
 */
@:allow(haxeal.HaxeALC)
class ALCaptureBuffer {
    private static var al_to_capture_buffer_mapping:Map<ALBuffer, ALCaptureBuffer> = [];
    var ptr:cpp.Star<cpp.Void>; // Pointer to the elements of arr
    var arr:Array<cpp.UInt8>;
    var al_buffer:ALBuffer;
    /**
     * The amount of samples this capture buffer collects.
     * After the capture buffer has been created this value cannot be changed and is read-only.
     */
    public var samples(default, null):Int;

    public function new(actualArray:Array<cpp.UInt8>, in_samples:Int) {
        arr = actualArray;
        samples = in_samples;
    }

    /**
     * Returns a capture buffer tied to the assigned ALBuffer.
     * 
     * Useful for feeding capture buffers back into a queue based on dequeued ALBuffers.
     * 
     * If there was no capture buffer found that is tied to the ALBuffer, null is returned.
     * @param al_buffer The ALBuffer tied to the capture buffer. Only input results from an ALCaptureBuffer instances' `get_ALBuffer()` function.
     */
    public static #if HAXEAL_INLINE_OPT_SMALL inline #end function getCaptureBuffer_fromALBuffer(al_buffer:ALBuffer):Null<ALCaptureBuffer> {
        return al_to_capture_buffer_mapping[al_buffer];
    }

    public function destroy() {
        al_to_capture_buffer_mapping.remove(al_buffer);

        ptr = null;
        arr = [];
        HaxeAL.deleteBuffer(al_buffer);

    }

    /**
     * Returns the assigned ALBuffer.
     * 
     * This buffer is just for convenience to store data conveniently inside of a capture buffer.
     * 
     * The buffer is not filled with data automatically since this buffer may not always be used.
     * You should instead do so by using `HaxeAL.bufferDataArray()` and inputting the result of `HaxeALC.captureBufferSamples(recordingDevice, this)`
     * for the input `data` argument .
     */
    public #if HAXEAL_INLINE_OPT_SMALL inline #end function get_ALBuffer():ALBuffer {
        return al_buffer;
    }

    /**
     * Returns the data collected by this buffer from the latest `HaxeALC.captureBufferSamples(recordingDevice, this)` call.
     * @return Array<cpp.UInt8>
     */
    #if HAXEAL_INLINE_OPT_SMALL inline #end public function get_Data():Array<cpp.UInt8> {
        return arr;
    }

    // These are only used internally in HaxeALC
    private function setPtr(arrayPointer:cpp.Star<cpp.Void>):ALCaptureBuffer {
        this.ptr = arrayPointer;
        return this;
    }

    private function assignBuffer(inputBuffer:ALBuffer):ALCaptureBuffer {
        this.al_buffer = inputBuffer;
        al_to_capture_buffer_mapping[inputBuffer] = this;
        return this;
    }
}

 // As the name suggests, unused. This would automatically handle some recording properties but ultimately it takes away too much from the original OpenAL library,
 // which we do not want. We want to stay about as true to the original as we can get, that means only modifying what really needs it!
/*@:structInit class UnusedAutoALCaptureDevice {
    public function new(device:ALDevice, bl:cpp.Int8) {
        alObj = device;
        byteLength = bl;
    }
    public var alObj:ALDevice;

    public var byteLength:cpp.Int8 = 1;
};*/

/**
 * Represents an OpenAL Context.
 */
typedef ALContext = Star<haxeal.bindings.ALC.ALCcontext>;

/**
 * Unused, represents a function address pointer
 */
typedef FunctionAddress = Dynamic;

/**
 * Represents a source audio can be played from using a buffer.
 * 
 * Set to 0 to mark as `null`.
 */
typedef ALSource = cpp.UInt32;

/**
 * Represents a buffer audio data can be stored on to be played back on a source.
 * 
 * Set to 0 to mark as `null`.
 */
typedef ALBuffer = cpp.UInt32;

/**
 * Represents an EFX-Extension filter.
 * 
 * Set to 0 to mark as `null`.
 */
typedef ALFilter = cpp.UInt32;

/**
 * Represents an EFX-Extension effect.
 * 
 * Set to 0 to mark as `null`.
 */
typedef ALEffect = cpp.UInt32;

/**
 * Represents an EFX-Extension auxiliary effect slot.
 * 
 * Set to 0 to mark as `null`.
 */
typedef ALAuxSlot = cpp.UInt32;