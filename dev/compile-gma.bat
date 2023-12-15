# @echo off 
Rem This program is to quickly compile the addon in my personal machine

rmdir /s /q "..\output"

mkdir "..\output"

"G:\Software\Steam\steamapps\common\GarrysMod\bin\gmad.exe" create -folder "C:\Users\jotal\Documents\GitHub\sledbuild-remastered" -out "C:\Users\jotal\Documents\GitHub\sledbuild-remastered\output\sledbuild-remastered.gma"
pause