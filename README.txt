
miniShark
=========

This is a little script that will do the following things
	-Download, patch and compile boost 1.55
	-Download and compile Shark from SVN (in release mode)
	-Open Visual Studio with an ready-to-compile example project 
		from the tutorials

For this, the package contains executables of cmake and svn
(please turn on your virus-scanner, I do not guarantee anything), 

The script currently needs Visual Studio 2013 or Visual Studio
2012 with .NET Framework v4.0.30319 (It will search for 
MSBuild.exe). If there is demand, a small adaptation to older 
Visual Studio versions might be possible.

Shark will be build in release mode and in debug mode, but
the example is release only (so press ctrl+f5 in Visual Studio  
to get the example solution running).

In order to use this in your own projects, you basically have to
mimic the settings of the solution. Basically you could extract
the whole archive into your project root and start the script
from there. Then boost and shark are local to your project.
Be aware, that shark depends on absolute paths (via cmake),
so once the script is finished, you cannot move the folder
around and recompile. You need to adapt pathes for that, 
by starting cmake by hand, or reextracting the archive and
rerunning the script. 


Prerequisites
=============

-Visual Studio 2013 OR
-Visual Studio 2012+.NET Framework v4.0.30319
-Internet connection
-5 GB of hard disk space


Usage
=====

1. Extract the .zip file into an empty folder
	(Alternatively, download the archive via git from
	https://github.com/sharkMLreports/miniShark)
2. Double-click the 'miniShark.bat' file.
3. Wait for a long time (45-60+ minutes)
4. When everything is finished, Visual Studio 
	will have been opened with an example tutorial solution.
5. Press CTRL+F5 to compile.

Note: The example solution only has Release configuration.
Debug is not supported for now.

