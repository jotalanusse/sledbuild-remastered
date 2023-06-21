@echo off 
Rem This program checks for Teal language errors in the Teal files of the project

echo Going to root directory...
cd ..


:loop

echo Checking Teal files for errors...
tl.exe build -p

pause

echo Clearing screen...
cls

echo Running it back...
goto loop