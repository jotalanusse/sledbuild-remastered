@echo off 
Rem This program builds the addon's Teal files

echo Removing old build folder...
rmdir /s /q "..\build"

echo Copying additional files...
xcopy "..\src\" "..\build\" /E /I /EXCLUDE:exclude.txt

echo Building Teal files...
..\tl.exe build

echo Going to root directory...
cd ..

echo Running post compile scripts...
tl.exe run tools/scripts/post-compile.tl

echo Going back to tools directory...
cd tools
