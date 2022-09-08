-- PlayerStripLoadout: Remove the player's loadout completely
local function PlayerStripLoadout(pl)
  pl:StripWeapons()
  pl:StripAmmo()
end

-- PlayerGiveDefaultLoadout: Give the default loadout to the player
local function PlayerGiveDefaultLoadout(pl)
  pl:Give("gmod_tool")
  pl:Give("weapon_physgun")
  pl:Give("weapon_physcannon")
  pl:Give("gmod_camera")
end

-- PlayerGiveAdminLoadout: Give the admin loadout to the player
local function PlayerGiveAdminLoadout(pl)
  pl:GiveAmmo(24, "357", true)
  pl:Give("weapon_crowbar")
  pl:Give("weapon_357")
end

-- PlayerSetLoadout: Set the loadout for the player
local function PlayerSetLoadout(pl)
  PlayerStripLoadout(pl)
  PlayerGiveDefaultLoadout(pl)

  -- And if the player is an admin we give them some toys
  if pl:IsAdmin() then
    PlayerGiveAdminLoadout(pl)
  end
end

-- PlayerSetDefaultCollision: Set the default collission for a player
local function PlayerSetDefaultCollision(pl)
  pl:SetCollisionGroup(COLLISION_GROUP_WEAPON) -- Doesn't collide with players and vehicles
end

-- PlayerInitialSpawn: Called when a player joins the server
local function PlayerInitialSpawn(pl)
  	-- Notify of a new player
	for k, v in pairs(player.GetAll()) do
		v:PrintMessage(HUD_PRINTTALK, "[SledBuild Remastered] " .. pl:Nick() .. " has joined the server!")
	end
end

hook.Add("PlayerInitialSpawn", "SBRPlayerInitialSpawn", PlayerInitialSpawn)

-- PlayerSpawn: Called everytime a player spawns
local function PlayerSpawn(pl)
  PlayerSetLoadout(pl)
  PlayerSetDefaultCollision(pl)

  pl:SelectWeapon("weapon_physgun")
  pl:SetTeam(TEAM_BUILDING)
end

hook.Add("PlayerSpawn", "SBRPlayerSpawn", PlayerSpawn)
