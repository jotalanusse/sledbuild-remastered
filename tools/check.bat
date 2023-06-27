@echo off 
Rem This program checks the addon's Teal files in a loop

:loop

echo Removing old build folder...
rmdir /s /q "..\build"

echo Building Teal files...
..\tl.exe build

pause

echo Clearing screen...
cls

echo Running it back...
goto loop
