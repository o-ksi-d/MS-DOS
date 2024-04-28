@echo OFF
goto STEP 

if exist "\devel\dos4" goto ABORT
:STEP

mkdir \devel\dos4



xcopy /E v4.0\*.* \devel\dos4\

xcopy tools_win32\*.* \devel\dos4\src\tools

xcopy dos4mods\*.* \devel\dos4\src\
cd \devel\dos4\src\

mkdir \devel\dos4dist

call setenv.bat
call doit.bat
call cpy.bat \devel\dos4dist\
call doit2.bat

pause
exit 0

:ABORT
echo abort
pause

