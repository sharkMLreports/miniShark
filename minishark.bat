:: small shark portable

@echo off
echo.
echo Portable Shark Windows v0.01 
echo ////////////////////////////
echo.
echo This will bootstrap a 'portable' boost version.
echo Please make sure that you have at LEAST 5 GB space on your hard drive.
echo You need to all this script only once. 
echo After that build only the example solution.
echo.
pause 


:TESTVS2013
:: check the visual studio version, for now we only compile with vs2013
reg query "HKEY_CLASSES_ROOT\VisualStudio.DTE.12.0" >> nul 2>&1
if %ERRORLEVEL% NEQ 0 (echo VS 2013 is not installed.
goto TESTVS2012) 

echo Found Visual Studio 2013. 
echo.
goto STARTVS2013


:TESTVS2012
reg query "HKEY_CLASSES_ROOT\VisualStudio.DTE.11.0" >> nul 2>&1
if %ERRORLEVEL% NEQ 0 (echo VS 2012 is not installed.
goto EXITNOTHINGFOUND) 


echo Found Visual Studio 2012. 
goto STARTVS2012




::STARTVS2013

:: obtain boost from internet. use 1.55
tools\SlikSvn\bin\svn.exe co https://svn.boost.org/svn/boost/tags/release/Boost_1_55_0 boost

:: but that needs patching. we have that patch here
copy /Y patch\visualc.hpp boost\boost\config\compiler\visualc.hpp
copy /Y patch\no_decltype_n3276_fail.cpp boost\libs\config\test\no_decltype_n3276_fail.cpp
copy /Y patch\no_decltype_n3276_pass.cpp boost\libs\config\test\no_decltype_n3276_pass.cpp
copy /Y patch\basic_text_iprimitive.cpp boost\libs\serialization\src\basic_text_iprimitive.cpp
copy /Y patch\basic_text_oprimitive.cpp boost\libs\serialization\src\basic_text_oprimitive.cpp
copy /Y patch\basic_text_wiprimitive.cpp boost\libs\serialization\src\basic_text_wiprimitive.cpp
copy /Y patch\basic_text_woprimitive.cpp boost\libs\serialization\src\basic_text_woprimitive.cpp
copy /Y patch\has_member_function_callable_with.hpp boost\boost\intrusive\detail\has_member_function_callable_with.hpp 

:: obtain shark from svn
tools\SlikSvn\bin\svn.exe co https://svn.code.sf.net/p/shark-project/code/trunk/Shark shark

:BOOST
:: generate boost
cd boost
CALL bootstrap.bat
b2
cd ..

:SHARK
:: generate visual studio solution
cd shark
..\tools\cmake\bin\cmake.exe -G "Visual Studio 12 2013" -DBOOST_INCLUDEDIR=..\boost -DBOOST_LIBRARYDIR=..\boost\stage\lib -DCMAKE_BUILD_TYPE=Release

:: compile shark
"C:\Program Files (x86)\MSBuild\12.0\Bin\MSBuild.exe" shark.sln /p:Configuration=Release
cd ..

:: start visual studio 2013 with our example project
"C:\Program Files (x86)\Microsoft Visual Studio 12.0\Common7\IDE\devenv.exe" .\example\CSvmTutorial.sln

goto EXIT




:STARTVS2012

IF EXIST C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe (
    echo Found .NET Framework v4.0.3019.
) else (
    echo Unable to find .NET Framework v4.0.3019. Please install, or fix the batch file.
    goto EXIT
)


:: obtain boost from internet. use 1.55
tools\SlikSvn\bin\svn.exe co https://svn.boost.org/svn/boost/tags/release/Boost_1_55_0 boost

:: but that needs patching. we have that patch here
copy /Y patch\visualc.hpp boost\boost\config\compiler\visualc.hpp
copy /Y patch\no_decltype_n3276_fail.cpp boost\libs\config\test\no_decltype_n3276_fail.cpp
copy /Y patch\no_decltype_n3276_pass.cpp boost\libs\config\test\no_decltype_n3276_pass.cpp
copy /Y patch\basic_text_iprimitive.cpp boost\libs\serialization\src\basic_text_iprimitive.cpp
copy /Y patch\basic_text_oprimitive.cpp boost\libs\serialization\src\basic_text_oprimitive.cpp
copy /Y patch\basic_text_wiprimitive.cpp boost\libs\serialization\src\basic_text_wiprimitive.cpp
copy /Y patch\basic_text_woprimitive.cpp boost\libs\serialization\src\basic_text_woprimitive.cpp
copy /Y patch\has_member_function_callable_with.hpp boost\boost\intrusive\detail\has_member_function_callable_with.hpp 

:: obtain shark from svn
tools\SlikSvn\bin\svn.exe co https://svn.code.sf.net/p/shark-project/code/trunk/Shark shark

:BOOST2012
:: generate boost
cd boost
CALL bootstrap.bat
b2
cd ..

:SHARK2012
:: generate visual studio solution
cd shark
..\tools\cmake\bin\cmake.exe -G "Visual Studio 11 2012" -DBOOST_INCLUDEDIR=..\boost -DBOOST_LIBRARYDIR=..\boost\stage\lib -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_FLAGS="/EHsc"

:: compile shark
"C:\Windows\Microsoft.NET\Framework\v4.0.30319\MSBuild.exe" shark.sln /p:Configuration=Release
cd ..

:: start visual studio 2012 with our example project
"C:\Program Files (x86)\Microsoft Visual Studio 11.0\Common7\IDE\devenv.exe" .\example\CSvmTutorial_vs2012.sln

goto EXIT



:EXITNOTHINGFOUND
echo No proper version of Visual Studio found. Exiting.
echo.
pause


:EXIT
