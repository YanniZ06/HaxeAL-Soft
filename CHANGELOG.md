# Changelog

The format of this changelog is more or less based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
All dates are in DD.MM.YYYY format, sorted by newest to oldest.
Changes are usually listed by relevancy or effort (this is no guarantuee though).
Guarantueed breaking changes are only to be expected every major version change.
_Potentially_ breaking changes are marked with **(B)**, those usually not affecting anyone because they are internal.

## [1.2.2] "QOL Extensions & Even more important fixes" - 22.10.2024

### Warning
Despite being a patch, there are a few potentially breaking changes, specifically with `Array<Float>` type values.
Some functions expecting an `Array<Float>` or returning such may now expect or return an `Array<cpp.Float32>`.
The values of these arrays can be handled like regular `Float` values and passed in anywhere a value of type `Float` is expected.
The arrays themselves however are not cross compatible, meaning you cannot pass an `Array<Float>` where an `Array<cpp.Float32>` is expected.
In 99% of cases, this will not affect anyone, because you usually directly define the arrays inside the function call (`sourcefv(src, HaxeAL.POSITION, [2,3,2])`),
which forces them to be defined in the correct type. However, in the 1% of cases where this is not done you must loop over each element of your `Array<Float>`,
and place them into your `Array<cpp.Float32>` individually to be able to pass that new array into function calls.

Please understand that this was not avoidable, as even the lowest level conversion from an Array of 32-bit floats to 64-bit floats or vice versa only results in garbage output.

### Added

- 32bit support (on windows only?) (It suddenly started working, please report any issues you may get on 32bit builds, refer to `Building an application with HaxeAL-Soft` in README.md)
- Support for multiple extensions (their usage is in the documentation):
* AL_SOFT_direct_channels (HaxeAL)
* AL_SOFT_source_spatialize (HaxeAL)
* AL_SOFT_loop_points (HaxeAL)
* AL_SOFT_buffer_length_query (HaxeAL)
* AL_SOFT_effect_target (HaxeEFX)

- New flag "HAXEAL_DEBUG_SOFT_LOGLEVEL" for debugging (its usage is in the README.md file)

- `HaxeAL.bufferDataArray`, replacing `HaxeAL.bufferData_PCM` as a function to take in an array of unsigned 8bit integers

- Theoretical support for compiling on Linux, MacOS and Iphone (README.md for further compile instructions)
- Rough tests for most extensions in `Main.hx`

### Changed

- A few mentions of `Array<Float>` to `Array<cpp.Float32>` (**(B)** -> see warning)
- ReadMe usage instructions
- `cpp.Star<T>` to `Array<T>` conversions being stupidly costly, for ..iv and ..fv operations (internally)

### Fixed

- Giant memory leak when using `captureSamples` due to allocating buffers and never freeing them
- Various memory leaks when calling ..iv and ..fv functions due to not freeing pointers
- Input device opening function using const char * as first argument type instead of string
- tests/Main.hx example not filtering out the regular output mix (https://github.com/kcat/openal-soft/issues/1011)

### Removed
- `HaxeAL.bufferData_PCM`, replaced by `HaxeAL.bufferDataArray` (**(B)** -> you can still get the same effect by using `haxeal.bindings.AL.bufferData`)

### Note
This is presumeably the last actual update of sorts to this library, unless more features are explicitly requested or problems arise.
The only other update would be EFX presets and properly tested cross-platform compatibility (if requested).
Expect a potential patch for any found issues to still come if necessary ofc.

## [1.2.1] "Important Fixes" - 16.06.2024

### Fixed

- `bufferData` not casting correctly and always causing a crash (Haxe tried doing an odd cast, so now its done manually!)
- Library not compiling due to a mistake in extraParams.hxml


## [1.2.0] "The Input Update" - 14.06.2024

### Added

- The OpenAL recording API (found in HaxeALC), allowing you to record and use microphone input
- Thoroughly documented microphone usage example in `tests`
- `HaxeAL.bufferData_PCM` as a direct alternative to converting input argument data into `haxe.io.Bytes`
- Shutdown logic to the original usage example

### Fixed

- `bufferData` only being able to fully account for 8 bit audio (internally, see `Changed No.1`)
- `sourceUnqueueBuffers` implementation (old implementation was wrong due to misinterpretation of the official documentation)
- `createX` functions (sources, buffers, effects, etc.) being capped to generating 14 objects per function call, as any objects past that would be invalid due to insufficent memory allocation
- getListeneriv having a wrong & unnecessary second argument (due to misinterpretation of the official documentation)

### Changed

- `bufferData` data argument type from `cpp.Star<cpp.UInt8>` to `cpp.Star<cpp.Void>` **(B)**
- Logic for HaxeAL multiple argument functions (iv, fv)
- Debug logs for `createX` (Source, Buffer, EFX, etc.) functions to be more precise about which objects weren't created properly
- All instances of weird pointer creation to be more memory efficient and more clearly written
- Buffer queueing & dequeuing documentation 

### Note
The changelog format has changed since 1.1.0, the changes are now sorted properly.


## [1.1.0] "Configurables and Optimizations" - 21.01.2024

### Added

- Options for defining inline behaviour within the library to optimize code via `HAXEAL_INLINE_OPT_{SIZE}` (Check README "Custom Flags" for more info)
- Flag to define where the OpenAL library, that is required in the application folder for it to run, should be exported to (Check README "Custom Flags" for more info)

### Changed

- AL constants to all be inlined now for better performance
- EFX bindings to be inlined so they function the same way all other bindings do too (directly importing the al function in cpp code)
- EFX initialization function to be inlined as it should not be used at run-time anyways

### Note 
The documentation for this version will not be updated, as no documentation changes have been made.


## [1.0.1] "Working Documentation" - 30.12.2023

### Added

- Link to documentation

### Removed

- Unnecessary files for the haxelib release (.gitignore and such)


## [1.0.0] "Initial Release" - 30.10.2023

### Added

- Everything, basically (check the github pages' features list)