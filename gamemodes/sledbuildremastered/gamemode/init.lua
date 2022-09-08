-- Run LUA files
include('shared.lua')

-- Send LUA files
AddCSLuaFile("shared.lua")
-- AddCSLuaFile("cl_init.lua")


-- -- ############################## FUNCTIONS ############################## --
-- -- PlayerSpawn: Called everytime a player joins the server
-- local function PlayerSpawn(player)
-- 	hook.Call("PlayerLoadout", GAMEMODE, player) -- Call item loadout function
-- 	hook.Call("PlayerSetModel", GAMEMODE, player) -- Set player model

-- 	player:SelectWeapon("weapon_physgun")
-- 	player:SetTeam(TEAM_BUILDING)
-- end

-- hook.Add("PlayerSpawn", "SBRPlayerSpawn", PlayerSpawn)
