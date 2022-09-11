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

-- AddPlayer: Adds a new player to the server list
function PLYS.AddPlayer(ply)
  PLYS.players[ply:SteamID()] = {
    ply = ply,
    roundsPlayed = 0,
    wins = 0,
    losses = 0,
    podiums = 0,
    topSpeed = 0,
    bestTime = nil, -- TODO: Should this be initialized in other value?
  }

  -- TODO: Add networking, inform clients
end

-- RemovePlayer: Removes a player from the server list
function PLYS.RemovePlayer(ply)
  PLYS.players[ply:SteamID()] = nil

  -- TODO: Add networking, inform clients
end

-- Teleport: Teleport a player to the specified target
function PLYS.Teleport(ply, target)
  -- The player could disappear at any time
  if (ply:IsValid()) then
    if ply:IsPlayer() then
      ply:GetPhysicsObject():SetVelocityInstantaneous(Vector(0, 0, 0))
      ply:SetCollisionGroup(PLYS.COLLISIONS.DEFAULT)
      ply:SetPos(target)
      ply:GetPhysicsObject():SetVelocityInstantaneous(Vector(0, 0, 0))
    end
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
  PLYS.Spawn(ply)

  -- Notify of a new player
  NET.BroadcastGamemodeMessage(ply:Nick() .. " has joined the server!") -- TODO: Costumize

  -- Check the map and warn the player, let him know our gamemode isn't the problem
  MCHK.CheckMap(ply)
end

hook.Add("PlayerInitialSpawn", "SBR.PLYS.InitialSpawn", PLYS.InitialSpawn)

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
