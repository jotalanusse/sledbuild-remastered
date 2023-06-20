@echo off 
Rem This program is to quickly compile the addon in my personal machine

echo Deleting old output folder...
rmdir /s /q "..\output"

echo Creating new output folder...
mkdir "..\output"

echo Compiling addon...
"D:\Software\Steam\steamapps\common\GarrysMod\bin\gmad.exe" create -folder "C:\Users\jotal\Documents\GitHub\sledbuild-remastered" -out "C:\Users\jotal\Documents\GitHub\sledbuild-remastered\output\sledbuild-remastered.gma"
pause