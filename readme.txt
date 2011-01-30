Currently, this is the code repository for housing the AlternSector CC3D library, which is a continuous collision detection framework currently targeting Alternativa3D/Flash at the moment.

There are 2 FlashDevelop projects.

CC3DExample.as3proj 
--------------------
The AS3 applcation output. For Flash developers targeting Alternativa3D platform


AlternSector_CC3D_Haxe.hxproj 
-------------------------------
The core Haxe-compiled SWC library codebase


What is the "portal" package under the src folder?
--------------------------------------------------
Basically, a package containing a mix of Hx externs and As classes. Currently, it has 2 classes of the same name (Sector.hx, Sector.as), which is a Haxe extern and Flash-based AS file respectively. The Haxe extern defines the bare interface for the final output compile, but the Flash-based Sector.as file can contain any "extra" information (or extend any class for that matter) specific to Flash and your application. 


What's with the .hx extern classes under "alternativa" package?
---------------------------------------------------------------
These are some extern stub codes generated out from Alternativa3D's current SWC api structure, to allow a Haxe library code-base to work with part of Alternativa3D's codebase. Take note though that many of the outputted variables are readily not usable or available in Haxe as they actually exist under the Flash alternativa3d namespace. Currently, the Haxe-code-base uses the main public variables from Alternativa3D's core classes, such as Object3D's position & EllipsoidCollider, to handle basic interaction between both libraries.

___________________________________

To recompile the CC3D library in Haxe:
-----------------------------------
Haxe needs to be installed. Run the altern_cc3d_swc.hxml directly, which will recompile the SWC. Or, a command line like: "haxe -swf9 C:/workingPath/lib/alternsector_cc3d.swc -swf-version 10 -cp C:\workingPath\src -main alternsector.AlternSector" together with other compile-flag directives can be used. This can be also used as a pre-built command line for running prior to building/previewing the main target platform application under AS3. For example, in FlashDevelop, one could use a pre-build command line mentioned above to compile both the Flash application and SWC at the same time instead of having to manually execute the "altern_cc3d_swc.hxml" file everytime.

Why use Haxe?
-------------
I guess it's the flexibility/performance in coding stuff with the ability to inline method calls without having to write everything out manually line-by-line. Additionally, the code-base can be recompiled with different compile-macro directives/flags, to allow for different settings/features to fit specific application needs. This allow for specific behaviour to be hard-coded into the library rather than rely on "need-to-check" settings. Alchemy op-codes are also readily available in Haxe, which also allows for much faster storing/retrieval of raw integer/float data.

However, I still find that Haxe has it's limitations with it's (rather bad) use of code-generated Boot.constructor calls for classes containing constructor code, so I avoid this by adopting the "Empty" constructor approach for core cc3d classes, relying instead on static method calls with inlined code to initialize the properties of a newly instantiated object. This also allows for class-based  pooling collectors and thus, re-using of instances. Beyond Haxe, the final output platform is still delivered and compiled in Flash. With a Haxe code-base, it's still possible in the future to have a code-base that allows for targetting different platforms (which may be none-Flash based as well.)

Roadmap:
-----------
There's still a lot of missing features and bugs, so this library is by no means production ready. So, this is just a preview and a repository which can be forked/used.