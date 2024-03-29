![](https://github.com/YanniZ06/HaxeAL-Soft/blob/main/git_images/HaxeAL_Logo.png)

# About HaxeAL-Soft
HaxeAL Soft is a haxe 4.3.0 library including native c++ bindings for openal-soft 1.23.1.

It incorporates nearly every feature OpenAL Soft offers, from EFX-Extension handlers and their pre-defined presets to full 3D environmental audio support (and theoretically, audio recording)!

As its a native c++ library it will also naturally **only** work on **c++ targets**.

You can download it as a haxelib here: https://lib.haxe.org/p/HaxeAL-Soft/

Alternatively, you can easily build HaxeAL Soft yourself by cloning the repo and following the given instructions.

Documentation on the library can be found here: https://yanniz06.github.io/HaxeAL-Soft/

# Implemented Features
- Full ALC and AL Integration
- Full EFX Integration
- Extension support (albeit only properly accessible using untyped `__cpp__` expressions, refer to `haxeal.bindings.EFXBuilder.hx` for example usage)
- Flags for "customization" of the library

# Left-out Features
- Audio Recording: Simply didn't work properly no matter what I tried, you can still access the bindings over the `haxeal.bindings.ALC.hx` file. (If you get a way to make it work PROPERLY, send a pull request PLEASE!!)
- Soft/ALEXT Functions: Didn't find any use for them, if some people really want them added I can add them in, otherwise I'm sparing myself the effort

# Custom Flags
- HAXEAL_DEBUG: Enables multiple debug traces on certain functions (deletion and creation to be exact).
- HAXEAL_INLINE_OPT_SMALL: Enables inlining for all HaxeAL operations that dont increase compiled code size, which reduces performance cost but does not allow those operations to be called at runtime using Reflect.
- HAXEAL_INLINE_OPT_BIG: Enables inlining for ALL HaxeAL operations, which reduces performance cost but may increase compiled code size and disallows those operations from being called at runtime using Reflect.
- HAXEAL_APP_PATH: If set, drops the OpenAL32.dll file in the defined directory, otherwise only drops it in the standard cpp output folder. This is useful/necessary if your application doesn't go into the default folder but instead a custom made one (in the case of flixel that export folder for example). This flag needs to be set with a value pointing to the folder your application executeable is located in, with the folders being seperated by a '/'. The path starts at your project root folder (the one in which your build.hxml or Project.xml resides) and should ideally end with the folder your application files are exported to. If said folder does not exist, it will be created on its own.

# Requirements (both for application user and programmer)
- Computer must work on 64-Bit 
- OpenAL MIGHT need to be installed on the Computer if the local app-specific OpenAL-Soft installation does not work (via the https://www.openal.org/downloads/ OpenAL 1.1 Windows Installer for example, however this should not be a problem if HAXEAL_APP_PATH is configured correctly.)

# Building HaxeAL-Soft
Building HaxeAL Soft is just as simple as building any other haxe application.

1. Open the folder you cloned the repo to in any shell or commandline
2. Run `haxe build.hxml` in the application you have the folder opened in
3. If compiled with no errors, make sure the output folder has been generated
4. To run the HaxeAL Soft build, move into the generated output directory (by doing `cd output` for example) and run `./Main.exe`

Congrats, you have built and ran HaxeAL-Soft!!

# Regarding Issues
If you happen to find any issues while compiling builds, please set up an Issue under the Issues tab.

The information the issue should contain is given in the setup issue template.

# Regarding Pull Requests
Pull requests are *greatly* appreciated, so long as they follow a similar structure to the rest of the project (however suggestions for different structuring are also welcome).

Please mark your PR's appropiately to keep management easy.

In short its only really important to differentiate between issue/bugfixes, improvement suggestions and the adding of new features.

# The Code Structure
This segment will define the intended code structure for this library.

## File Placement
Having good folder and file management is certainly not unimportant while making a nice and easy to work with library.


**C(++) to Haxe Native Binding Files** all go into the `haxeal/bindings` folder, under the name of the header file they are creating bindings for.


**Native Hx to regular std-type Hx Files** all go into the `haxeal` folder, under the same name of their `bindings` folder counterparts with a "Haxe" prefix.
Example: Context -> HaxeContext


**Testing and everything else** goes into the tests folder. Make sure to not submit any PR's that contain output directories!

## Differentiating between Native Binding and Regular Std-Type Hx Files

### Native Binding Files

These are the files that create the native C++ bindings between OpenAL-Soft and Haxe.

Every binding file is an extern and makes use of the `@:native` and `@:include` compiler metadata.

The bindings are oriented towards the respective header (.h) files in the `openal/includes` folder.

#### Binding Example
If you wanted to bind the `alcCreateContext` function, you would first locate the header file its located in (`alc.h`).

If an extern class for this header file doesnt already exist, you create one using the following syntax:

```hx
@:unreflective @:keep // makes sure dce doesnt remove it
@:include("alc.h") // we want our extern to bind functions from alc (which also has our createContext function)
extern class ALC {}
```

Now that we have told the compiler to include alc.h into our extern ALC class, we can create our bind for alcCreateContext in it.

```hx
@:unreflective @:keep
@:include("alc.h")
extern class ALC {
 //Since we included alc.h, the compiler knows our native refers to the alcCreateContext function defined in alc.h
	@:native("alcCreateContext")
	static function createContext(?):?;
}
```

---

To find out what the arguments and return type are we need a tiny bit of c++ knowledge, but dont worry its really simple actually.
```cpp
ALC_API ALCcontext* ALC_APIENTRY alcCreateContext(ALCdevice *device, const ALCint *attrlist) ALC_API_NOEXCEPT;
```
We can safely ignore `ALC_API, ALC_APIENTRY and ALC_API_NOEXCEPT` here and shorten it down to:
```cpp
ALCcontext* alcCreateContext(ALCdevice *device, const ALCint *attrlist);
```
Which now just reads as:
```cpp
ReturnType functionName(ArgumentType argumentName);
```

---

Now that we can dissect the function we just need to fill everything in.

Every type that is followed by a * translates into `cpp.Star<Type>`, meaning that `ALCcontext*` translates into `cpp.Star<ALCcontext>`.

Our problem now is that we dont have ALCcontext defined as a class yet, so we will quickly do that and name it ALContext for ease of use.

---
![image](https://github.com/YanniZ06/HaxeAL-Soft/assets/102467588/e1aaea51-5438-4b65-8065-bcf27a896e96)

ALCcontext is defined as a structure in `alc.h`, so we include it.

To make sure the compiler properly parses interactions with our ALContext class, we also append the `@:structAccess` metadata (necessary for structures).

Finally, we append the `@:native` metadata with the argument 'ALCcontext', which works the same way as getting a function from an included file, just that we are now getting a type.

The result should look like this:

```hx
@:unreflective @:keep
@:include("alc.h") @:structAccess @:native('ALCcontext')
extern class ALContext {}
```

Now we can use `ALContext` as an argument whenever the native c++ code expects an argument or return value of type `ALCcontext`.

---

The first argument is of type `ALCdevice`, which is the same deal as ALCcontext.

ALCdevice is defined inside of alc.h aswell so we can repeat the same procedure and just change up the names.

Now we have the second argument, which is of type `ALCint` and defined as a `const` argument.

If we search `ALCint` in alc.h, we can find it defined as a regular Int:

![image](https://github.com/YanniZ06/HaxeAL-Soft/assets/102467588/edc898fe-b9c9-442d-81b7-b4e0a62446c8)

Hence, the representative type is also an Int.

The haxe Type representing a star const argument is `cpp.ConstStar<T>`, however as that has remained hard to work with we will use cpp.Pointer<T> instead.

---

Now we finally have all our types figured out.

The first argument is of type `Star<ALDevice>` (we define ALCdevice as ALDevice for ease of use), the second of type `Pointer<Int>`, and the return value is of type `Star<ALContext>`.

This process can be repeated for every other function in every other header aswell and always work in the same way, minus few exceptions like a const argument with a star of type Char being a standalone `cpp.ConstCharStar`.

The binding with all our correct haxe types should now look like this:
```hx
	@:native("alcCreateContext")
	static function createContext(device:Star<ALDevice>, attributes:Pointer<Int>):Star<ALContext>;
```

### Regular Std-Type Hx Files

These are the files that users of the library will use to make interacting with our binds easier.

These are regular classes that contain the same functions as their extern counterparts, however their class name (and the file name aswell) have "Haxe" appended before,
which is crucial to keeping compatibility with the extern generated file by the same name (it doesnt matter what package it is in, it will try to replace it nonetheless and will throw a
dozen of cpp errors at you about wrong syntax despite everything being right).

The arguments and return types for these functions should not contain any cpp package objects, and instead make use of easy to use non cpp objects.

For example every instance of `cpp.Star<Int>` inside of a function argument or return type should be switched to just `Int`, while the actual function body handles turning the `Int` handed in into a `cpp.Star<Int>` for the bind to work with.

```hx
@:unreflective @:keep
@:include('intExamp.h')
extern class IntExamp {
 @:native('exampGetInt')
 static function getInt(myInt:Star<Int>):Star<Int> {};
}

//...

import bindings.IntExamp as IntImp;
class HaxeIntExamp {
 /**
 * Returns the proper Integer value of ´myInt´
 * @param myInt The Int you want to get the proper value of.
 */
 public static function getInt(myInt:cpp.Reference<Int>):Int {
  return Native.get(IntImp.getInt(Native.addressOf(myInt)));
 }
}
```

These files may also include bonus functions to make usage easier, for example while the extern AL class may not include a function called "getErrorString" as its not included in the al.h class, the Regular Std-Type Hx file may freely do so and have the content be whatever it fits (in this case return a readable string version of the error code `getError` returns), as long as they are suited for that class contextually (ALC handling functions shouldnt go into the AL Regular but instead the ALC Regular).

## Code documentation

It is recommended to have the vscode codedox extension by wiggin77 installed.

All Regular Std-Type Hx Files and their functions should be documented as seen in this example, short and concise but enough to let the user of the library know how most of the things work.
![image](https://github.com/YanniZ06/HaxeAL-Soft/assets/102467588/7e8569b2-722f-49ec-b652-892a211b38eb)

That is about all the rules set up for documentation, you're not *forced* to document functions you implement because I'll gladly take care of it, but it could of course be helpful!
