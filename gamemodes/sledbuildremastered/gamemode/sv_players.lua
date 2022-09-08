-- PlayerStripLoadout: Remove the player's loadout completely
local function PlayerStripLoadout(ply)
  -- TODO: Why is this not working?
  ply:StripWeapons()
  ply:StripAmmo()
end

-- PlayerGiveDefaultLoadout: Give the default loadout to the player
local function PlayerGiveDefaultLoadout(ply)
  ply:Give("gmod_tool")
  ply:Give("weapon_physgun")
  ply:Give("weapon_physcannon")
  ply:Give("gmod_camera")
end

-- PlayerGiveAdminLoadout: Give the admin loadout to the player
local function PlayerGiveAdminLoadout(ply)
  ply:GiveAmmo(24, "357", true)
  ply:Give("weapon_crowbar")
  ply:Give("weapon_357")
end

-- PlayerSetLoadout: Set the loadout for the player
local function PlayerSetLoadout(ply)
  PlayerStripLoadout(ply)
  PlayerGiveDefaultLoadout(ply)

  -- And if the player is an admin we give them some toys
  if (ply:IsAdmin()) then
    PlayerGiveAdminLoadout(ply)
  end
end

-- PlayerSetDefaultCollision: Set the default collission for a player
local function PlayerSetDefaultCollision(ply)
  ply:SetCollisionGroup(COLLISION_GROUP_WEAPON) -- Doesn't collide with players and vehicles
end

-- PlayerSpawn: Called everytime a player spawns
local function PlayerSpawn(ply)
  PlayerSetLoadout(ply)
  PlayerSetDefaultCollision(ply)

  ply:SelectWeapon("weapon_physgun")
  ply:SetTeam(TEAM_BUILDING)
end

hook.Add("PlayerSpawn", "SBRPlayerSpawn", PlayerSpawn)

-- PlayerInitialSpawn: Called when a player joins the server
local function PlayerInitialSpawn(ply)
  PlayerSpawn(ply)

  -- Notify of a new player
  for k, v in pairs(player.GetAll()) do
    v:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. ply:Nick() .. " has joined the server!")
  end
end

hook.Add("PlayerInitialSpawn", "SBRPlayerInitialSpawn", PlayerInitialSpawn)

-- PlayerRestrictNoclip: Only enable noclip on Admins
function PlayerRestrictNoclip(ply, bool)
  if (ply:IsAdmin()) then
    return true
  end

  ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "Only admins may use noclip.")
  return false
end

hook.Add("PlayerNoClip", "SBRPlayerRestrictNoclip", PlayerRestrictNoclip)

-- PlayerRemoveDeathSound: Remove the death sound of the player
function PlayerRemoveDeathSound()
  return true
end

hook.Add("PlayerDeathSound", "SBRPlayerRemoveDeathSound", PlayerRemoveDeathSound)

-- TODO: Whah do this do???
-- TODO: Maybe find a way to not override this?
-- DoPlayerDeath: Handle the player's death
function GM:DoPlayerDeath(ply, attacker, dmginfo)
  ply:CreateRagdoll()
end
