# @echo off 
Rem This program is to quickly test the addon in my personal machine

rmdir /s /q "G:\Software\Steam\steamapps\common\GarrysMod\garrysmod\addons\sledbuild-remastered"

mkdir "G:\Software\Steam\steamapps\common\GarrysMod\garrysmod\addons\sledbuild-remastered"

xcopy "C:\Users\jotal\Documents\GitHub\sledbuild-remastered" "G:\Software\Steam\steamapps\common\GarrysMod\garrysmod\addons\sledbuild-remastered" /E

"G:\Software\Steam\steamapps\common\GarrysMod\hl2.exe" +gamemode "sledbuildremastered" +map "sbr_example" -novid -windowed -noborder -dev -console -allowdebug -hijack -steam -insecure
