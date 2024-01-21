# Changelog

The format of this changelog is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).

## [1.0.0] - 30.10.2023

### Added

- Everything, basically (check the github pages' features list)

## [1.0.1] - 30.12.2023

### Added

- Link to documentation

### Removed

- Unnecessary files for the haxelib release (.gitignore and such)

## [1.1.0] - 21.01.2024

### Added

- Options for defining inline behaviour within the library to optimize code via HAXEAL_INLINE_OPT_{SIZE} (Check README "Custom Flags" for more info)
- Flag to define where the OpenAL library, that is required in the application folder for it to run, should be exported to (Check README "Custom Flags" for more info)

### Changed

- AL constants to all be inlined now for better performance
- EFX bindings to be inlined so they function the same way all other bindings do too (directly importing the al function in cpp code)
- EFX initialization function to be inlined as it should not be used at run-time anyways

### Note 
The documentation for this version will not be updated, as no documentation changes have been made.