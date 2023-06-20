@echo off 
Rem This program is to quickly test the addon in my personal machine

echo Deleting old addon folder...
rmdir /s /q "D:\Software\Steam\steamapps\common\GarrysMod\garrysmod\addons\sledbuild-remastered"

echo Creating new addon folder...
mkdir "D:\Software\Steam\steamapps\common\GarrysMod\garrysmod\addons\sledbuild-remastered"

echo Copying addon files...
xcopy "C:\Users\jotal\Documents\GitHub\sledbuild-remastered" "D:\Software\Steam\steamapps\common\GarrysMod\garrysmod\addons\sledbuild-remastered" /E

echo Running Garry's Mod...
"D:\Software\Steam\steamapps\common\GarrysMod\hl2.exe" +gamemode "sledbuildremastered" +map "sbr_example" -novid -windowed -noborder -dev -console -allowdebug -hijack -steam -insecure
