Currently, this is the code repository for housing the AlternSector CC3D library, which is a continuous collision detection framework currently targeting Alternativa3D/Flash at the moment.

There are 2 FlashDevelop projects.

CC3DExample.as3proj (The AS3 applcation output. For Flash developers)
--------------------
Example 'Alternativa3DCC3D.swf' compile under Flash/Alternativa3D using the current "alternsector_cc3d.swc" & "Alternativa3D 7.6.0.swc" libraries under "lib" folder.


AlternSector_CC3D_Haxe.hxproj (The core Haxe-compiled SWC library codebase)
-------------------------------
Test '_haxebuild.swf' compile and development platform on the core SWC library codebase under src "alternsector". To compile "alternsector_cc3d.swc", run the "altern_cc3d_swc.hxml" file in the "src" folder (this requires Haxe to be installed). 

Tip: One way of being able to compile both the Haxe-code-base's SWC and compile the AS3 final output at the same time (instead of running the hxml prior to compiling), is to add a Pre-Build Command Line in any FlashDevelop AS3 project like:
"haxe -swf9 C:/pathToWorkingFolder/lib/alternsector_cc3d.swc -swf-version 10 -cp C:\pathToWorkingFolder\src -main alternsector.AlternSector" together with other compile-time flags that you may wish to use for a partiucular project, matching the hxml perhaps.
This would allow pre-compiling of the SWC library via Haxe prior to compiling/previewing your main Actionscript application which uses that library. You'd use this if you're testing new features on the Haxe-code-base on a particulartarget platform.

What is the "portal" package under the src folder?
--------------------------------------------------
Basically, a package containing a mix of Hx externs and As classes. Currently, it has 2 classes of the same name (Sector.hx, Sector.as), which is a Haxe extern and Flash-based AS file respectively. The Haxe extern defines the bare interface for the final output compile, but the Flash-based Sector.as file can contain any "extra" information specific to Flash and your application. 

Why use Haxe?
-------------
I guess it's the flexibility/performance in coding stuff with the ability to inline method calls without having to write everything out manually line-by-line. Additionally, the code-base can be recompiled with different compile-macro directives/flags, to allow for different settings/features to fit specific application needs. Alchemy op-codes are also readily available in Haxe. 

However, I still find that Haxe has it's limitations with it's (rather bad) use of code-generated Boot.constructor calls for classes containing constructor code, so I avoid this by adopting the "Empty" constructor approach for core cc3d classes, relying instead on static method calls with inlined code to initialize the properties of a newly instantiated object. This also allows for class-based  pooling collectors and thus, re-using of instances. Beyond Haxe, the final output platform is still delivered and compiled in Flash. With a Haxe code-base, it's still possible in the future to have a code-base that allows for targetting different platforms (which may be none-Flash based as well.)

Roadmap:
-----------
There's still a lot of missing features and bugs, so this library is by no means production ready. So, this is just a preview and a repository which can be forked/used.