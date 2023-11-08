package haxeal;

/**
 * Represents a device that allows audio playback.
 */

typedef ALDevice = Star<haxeal.bindings.ALC.ALCdevice>;

/**
 * Unused, audio capture specific device.
 */
typedef ALCaptureDevice = ALDevice;

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