
miniShark
=========

This is a little script that will do the following things
	-Download, patch and compile boost 1.55
	-Download and compile Shark from SVN (in release mode)
	-Open VS2013 with an ready-to-compile example project 
		from the tutorials

For this, the package contains executables of cmake and svn
(please turn on your virus-scanner, I do not guarantee anything), 

The script currently needs Visual Studio 2013, if there is
demand, a small adaptation to older Visual Studio versions is
possible.

Shark will be build in release mode and in debug mode, but
the example is release only (so press ctrl+f5 in visual Studio 2013 
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


