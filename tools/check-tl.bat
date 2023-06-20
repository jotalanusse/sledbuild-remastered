@echo off 
Rem This program checks for Teal language errors in the Teal files of the project

echo Going to root directory...
cd ..

echo Checking Teal files for errors...
tl.exe build -p

pause