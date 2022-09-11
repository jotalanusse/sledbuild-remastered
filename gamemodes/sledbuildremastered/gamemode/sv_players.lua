PLYS = {
  players = {},
  COLLISIONS = {
    DEFAULT = COLLISION_GROUP_WEAPON -- Doesn't collide with players and vehicles
  },
  LOADOUTS = {
    DEFAULT = {
      "gmod_tool",
      "weapon_physgun",
      "weapon_physcannon",
      "gmod_camera",
    },
    ADMIN = {
      "gmod_tool",
      "weapon_physgun",
      "weapon_physcannon",
      "gmod_camera",
      "weapon_crowbar",
      "weapon_357",
    },
  }
}

-- Add: Adds a new player to the server list
function PLYS.Add(ply)
  PLYS.players[ply:SteamID()] = {
    ply = ply,
    rounds = 0, -- TODO: SHould i rename to "roundsPlayed"?
    wins = 0,
    losses = 0,
    podiums = 0,
    topSpeed = 0,
    bestTime = nil, -- TODO: Should this be initialized in other value?
  }

  -- TODO: Add networking, inform clients
end

-- Remove: Removes a player from the server list
function PLYS.Remove(ply)
  PLYS.players[ply:SteamID()] = nil

  -- TODO: Add networking, inform clients
end

-- Teleport: Teleport a player to the specified target
function PLYS.Teleport(ply, target)
  -- TODO: Should we check here if the player exists?

  if ply:IsPlayer() then
    ply:GetPhysicsObject():SetVelocityInstantaneous(Vector(0, 0, 0))
    ply:SetCollisionGroup(PLYS.COLLISIONS.DEFAULT)
    ply:SetPos(target)
    ply:GetPhysicsObject():SetVelocityInstantaneous(Vector(0, 0, 0))
  end
end

-- StripLoadout: Remove the player's loadout completely
function PLYS.StripLoadout(ply)
  -- TODO: Why is this not working?
  ply:StripWeapons()
  ply:StripAmmo()
end

-- SetLoadout: Set the loadout for the player
function PLYS.SetLoadout(ply, loadout)
  PLYS.StripLoadout(ply)

  for k, v in pairs(loadout) do
    ply:Give(v)
  end
end

-- SetTeam: Set the team for the player
function PLYS.SetTeam(ply, team)
  ply:SetTeam(team)
end

-- SetColor: Set the color for the player
function PLYS.SetColor(ply, color)
  ply:SetColor(color)
end

-- ResetColor: Reset the color for the player
function PLYS.ResetColor(ply)
  ply:SetColor(Color(255, 255, 255, 255))
end

-- ResetAllColors: Reset the color for all players
function PLYS.ResetAllColors()
  for k, v in pairs(player.GetAll()) do
    v:SetColor(Color(255, 255, 255, 255))
  end
end

-- SetDefaultCollision: Set the default collission for a player
function PLYS.SetDefaultCollision(ply)
  ply:SetCollisionGroup(PLYS.COLLISIONS.DEFAULT) -- Doesn't collide with players and vehicles
end

-- Spawn: Called everytime a player spawns
function PLYS.Spawn(ply)
  if (ply:IsAdmin()) then
    PLYS.SetLoadout(ply, PLYS.LOADOUTS.ADMIN)
  else
    PLYS.SetLoadout(ply, PLYS.LOADOUTS.DEFAULT)
  end

  PLYS.SetDefaultCollision(ply)

  ply:SelectWeapon("weapon_physgun")
  PLYS.SetTeam(ply, TEAMS.BUILDING)
end

hook.Add("PlayerSpawn", "SBR.PLYS.Spawn", PLYS.Spawn)

-- InitialSpawn: Called when a player joins the server
function PLYS.InitialSpawn(ply)
  PLYS.Add(ply)
  PLYS.Spawn(ply)

  -- Notify of a new player
  NET.BroadcastGamemodeMessage(ply:Nick() .. " has joined the server!") -- TODO: Costumize

  -- Check the map and warn the player, let him know our gamemode isn't the problem
  MCHK.CheckMap(ply)
end

hook.Add("PlayerInitialSpawn", "SBR.PLYS.InitialSpawn", PLYS.InitialSpawn)

-- Disconnected: Called when a player leaves the server
function PLYS.Disconnected(ply)
  PLYS.Remove(ply)

  -- Notify of player leaving
  NET.BroadcastGamemodeMessage(ply:Nick() .. " has left the server.") -- TODO: Costumize
end

hook.Add("PlayerDisconnected", "SBR.PLYS.Disconnected", PLYS.Disconnected)

-- RestrictNoclip: Prevent the player from using noclip
function PLYS.RestrictNoclip(ply, bool)
  -- TODO: Enable after testing
  -- if (ply:IsAdmin()) then
  --   return true
  -- end

  NET.SendGamemodeMessage(ply, "Only admins may use noclip.")
  return false
end

hook.Add("PlayerNoClip", "SBR.PLYS.RestrictNoclip", PLYS.RestrictNoclip)

-- RemoveDeathSound: Remove the death sound of the player
function PLYS.RemoveDeathSound()
  return true
end

hook.Add("PlayerDeathSound", "SBR.PLYS.RemoveDeathSound", PLYS.RemoveDeathSound)

-- DoPlayerDeath: Handle the player's death
function GM:DoPlayerDeath(ply, attacker, dmginfo)
  ply:CreateRagdoll() -- Create a ragdooll for the memes
end
