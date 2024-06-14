# Changelog

The format of this changelog is more or less based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
All dates are in DD.MM.YYYY format, sorted by newest to oldest.
Changes are usually listed by relevancy or effort (this is no guarantuee though).
Guarantueed breaking changes are only to be expected every major version change.
_Potentially_ breaking changes are marked with **(B)**, those usually not affecting anyone because they are internal.


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
- `AL.hx bufferData()` data argument type from `cpp.Star<cpp.UInt8>` to `cpp.Star<cpp.Void>` **(B)**
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