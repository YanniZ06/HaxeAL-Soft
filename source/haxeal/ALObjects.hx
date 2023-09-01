package haxeal;

typedef ALDevice = Star<haxeal.bindings.ALC.ALCdevice>;
typedef ALCaptureDevice = ALDevice;
typedef ALContext = Star<haxeal.bindings.ALC.ALCcontext>;
typedef FunctionAddress = Dynamic;

typedef ALSource = cpp.UInt32;
typedef ALBuffer = cpp.UInt32;

typedef ALFilter = cpp.UInt32;
typedef ALEffect = cpp.UInt32;
typedef ALAuxSlot = cpp.UInt32;