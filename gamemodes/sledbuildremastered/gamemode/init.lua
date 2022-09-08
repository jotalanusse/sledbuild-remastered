-- Run LUA files
include('shared.lua')

-- Send LUA files
AddCSLuaFile("shared.lua")
-- AddCSLuaFile("cl_init.lua")


-- -- ############################## FUNCTIONS ############################## --
-- PlayerSpawn: Called everytime a player joins the server
local function PlayerSpawn(player)
  hook.Call("PlayerLoadout", GAMEMODE, player) -- Call item loadout function
  -- hook.Call("PlayerSetModel", GAMEMODE, player) -- Set player model

  player:SelectWeapon("weapon_physgun")
  player:SetTeam(TEAM_BUILDING)
end

hook.Add("PlayerSpawn", "SBRPlayerSpawn", PlayerSpawn)

-- PlayerLoadout: Set the player loadout
function GM:PlayerLoadout(player)
  -- First we remove all player weapons and ammo
  player:StripWeapons()
  player:StripAmmo()

  -- Then we give them the necessary tools
  player:Give("gmod_tool")
  player:Give("weapon_physgun")
  player:Give("weapon_physcannon")
  player:Give("gmod_camera")

  -- And if the player is an admin we give them some toys
  if player:IsAdmin() then
    player:GiveAmmo(24, "357", true)
    player:Give("weapon_crowbar")
    player:Give("weapon_357")
  end
end
