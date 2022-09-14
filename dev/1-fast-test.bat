# @echo off 
Rem This program is to quickly test the addon in my personal machine

rmdir /s /q "D:\Software\Steam\steamapps\common\GarrysMod\garrysmod\addons\sledbuild-remastered"

mkdir "D:\Software\Steam\steamapps\common\GarrysMod\garrysmod\addons\sledbuild-remastered"

xcopy "C:\Users\jotal\Documents\GitHub\sledbuild-remastered" "D:\Software\Steam\steamapps\common\GarrysMod\garrysmod\addons\sledbuild-remastered" /E

"D:\Software\Steam\steamapps\common\GarrysMod\hl2.exe" +gamemode "sledbuildremastered" +map "sbr_marsopa_v1" -novid -windowed -noborder -dev -console -allowdebug -hijack -steam -insecure
