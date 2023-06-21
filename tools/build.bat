@echo off 
Rem This program checks builds the Teal files of the project

echo Going to root directory...
cd ..


:loop

echo Building Teal files...
tl.exe build

pause

echo Clearing screen...
cls

echo Running it back...
goto loop