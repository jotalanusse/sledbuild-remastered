PLYS = {
  COLLISIONS = {
    DEFAULT = COLLISION_GROUP_WEAPON -- Doesn't collide with players and vehicles
  },
  COLORS = {
    FIRST = Color(0, 255, 0),
    SECOND = Color(255, 255, 0),
    THIRD = Color(255, 0, 0),
    DEFAULT = Color(255, 255, 255)
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

-- AddNetworkVariables: Adds the required network variables to the player
function PLYS.AddNetworkVariables(ply)
  ply:SetNWInt("SBR:Rounds", 0)
  ply:SetNWInt("SBR:Wins", 0)
  ply:SetNWInt("SBR:Podiums", 0)
  ply:SetNWInt("SBR:Losses", 0)
  ply:SetNWFloat("SBR:CurrentSpeed", 0)
  ply:SetNWFloat("SBR:MaxSpeed", 0)
  ply:SetNWFloat("SBR:BestTime", 0)
end

-- Teleport: Teleport a player to the specified target
function PLYS.Teleport(ply, target)
  -- TODO: Should we check here if the player exists?

  if (ply:IsPlayer()) then
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

  for _, v in pairs(loadout) do
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
  ply:SetColor(PLYS.COLORS.DEFAULT)
end

-- ResetAllColors: Reset the color for all players
function PLYS.ResetAllColors()
  for _, v in pairs(player.GetAll()) do
    v:SetColor(PLYS.COLORS.DEFAULT)
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

hook.Add("PlayerSpawn", "SBR:PLYS:Spawn", PLYS.Spawn)

-- Death: Called everytime a player dies
function PLYS.Death(ply)
  -- Disqualify the player on death
  if (RND.IsPlayerRacing(ply)) then
    NET.SendGamemodeMessage(ply, "You have died while racing! What happened?", CONSOLE.COLORS.WARNING)
    RND.RemovePlayer(ply, RND.STATE.round)
  end

  -- We don't reset color because the round start already does that
  PLYS.SetTeam(ply, TEAMS.BUILDING)
end

hook.Add("PlayerDeath", "SBR:PLYS:Detah", PLYS.Death)

-- InitialSpawn: Called when a player joins the server
function PLYS.InitialSpawn(ply)
  PLYS.AddNetworkVariables(ply)
  PLYS.Spawn(ply)

  -- Notify of a new player
  NET.BroadcastGamemodeMessage(ply:Nick() .. " has joined the server!") -- TODO: Costumize

  -- Check the map and warn the player, let him know our gamemode isn't the problem
  MCHK.CheckMap(ply)
end

hook.Add("PlayerInitialSpawn", "SBR:PLYS:InitialSpawn", PLYS.InitialSpawn)

-- Disconnected: Called when a player leaves the server
function PLYS.Disconnected(ply)
  -- Remove the player from the race on disconnect
  if (RND.IsPlayerRacing(ply)) then
    RND.RemovePlayer(ply)
  end

  -- Notify of player leaving
  NET.BroadcastGamemodeMessage(ply:Nick() .. " has left the server.") -- TODO: Costumize
end

hook.Add("PlayerDisconnected", "SBR:PLYS:Disconnected", PLYS.Disconnected)

-- RestrictNoclip: Prevent the player from using noclip
function PLYS.RestrictNoclip(ply, bool)
  -- TODO: Enable after testing
  -- if (ply:IsAdmin()) then
  --   return true
  -- end

  NET.SendGamemodeMessage(ply, "Only admins may use noclip.")
  return false
end

hook.Add("PlayerNoClip", "SBR:PLYS:RestrictNoclip", PLYS.RestrictNoclip)

-- RemoveDeathSound: Remove the death sound of the player
function PLYS.RemoveDeathSound()
  return true
end

hook.Add("PlayerDeathSound", "SBR:PLYS:RemoveDeathSound", PLYS.RemoveDeathSound)

-- DoPlayerDeath: Handle the player's death
function GM:DoPlayerDeath(ply, attacker, dmginfo)
  ply:CreateRagdoll() -- Create a ragdooll for the memes
end
