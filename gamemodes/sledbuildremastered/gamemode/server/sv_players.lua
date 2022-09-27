PLYS = {
  -- Set the different collisions used by the players
  COLLISIONS = {
    DEFAULT = COLLISION_GROUP_WEAPON -- Doesn't collide with players and vehicles
  },

  -- Default colors
  COLORS = {
    FIRST = Color(0, 255, 0),
    SECOND = Color(255, 255, 0),
    THIRD = Color(255, 0, 0),
    DEFAULT = Color(255, 255, 255)
  },
}

-- AddNetworkVariables: Adds the required network variables to the player
function PLYS.AddNetworkVariables(ply)
  ply:SetNWInt("SBR:Rounds", 0)
  ply:SetNWInt("SBR:Wins", 0)
  ply:SetNWInt("SBR:Podiums", 0)
  ply:SetNWInt("SBR:Losses", 0)
  ply:SetNWFloat("SBR:Speed", 0)
  ply:SetNWFloat("SBR:TopSpeed", 0)
  ply:SetNWFloat("SBR:BestTime", 0)
end

-- Teleport: Teleport a player to the specified target
function PLYS.Teleport(ply, target)
  -- Just in case check that the vehicle is valid
  if (not ply:IsValid()) then
    return
  end

  if (ply:IsPlayer()) then
    ply:GetPhysicsObject():SetVelocityInstantaneous(Vector(0, 0, 0))
    ply:SetCollisionGroup(PLYS.COLLISIONS.DEFAULT)
    ply:SetPos(target)
    ply:GetPhysicsObject():SetVelocityInstantaneous(Vector(0, 0, 0))
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

-- SetDefaultCollision: Set the default collision for a player
function PLYS.SetDefaultCollision(ply)
  ply:SetCollisionGroup(PLYS.COLLISIONS.DEFAULT) -- Doesn't collide with players and vehicles
end

-- Spawn: Called every time a player spawns
function PLYS.Spawn(ply)
  -- Set the default player collision
  PLYS.SetDefaultCollision(ply)

  -- Set the player's team
  PLYS.SetTeam(ply, TEAMS.BUILDING)

  -- Admins get the juicy stuff :)
  if (ply:IsAdmin()) then
    WPNS.SetLoadout(ply, WPNS.LOADOUTS.ADMIN)
  else
    WPNS.SetLoadout(ply, WPNS.LOADOUTS.DEFAULT)
  end

  ply:SelectWeapon("weapon_physgun")
end

hook.Add("PlayerSpawn", "SBR:PLYS:Spawn", PLYS.Spawn)

-- Death: Called every time a player dies
function PLYS.Death(ply)
  -- Disqualify the player from the race on death
  if (RND.IsPlayerRacing(ply)) then
    NET.SendGamemodeMessage(ply, "You have died while racing! What happened?", COLORS.WARNING)

    RND.RemovePlayer(ply, RND.round)
  end

  -- We don't reset color because the round start already does that
  PLYS.SetTeam(ply, TEAMS.BUILDING)
end

hook.Add("PlayerDeath", "SBR:PLYS:Death", PLYS.Death)

-- InitialSpawn: Called when a player joins the server
function PLYS.InitialSpawn(ply)
  PLYS.AddNetworkVariables(ply)
  PLYS.Spawn(ply)

  -- Notify of a new player
  NET.BroadcastGamemodeMessage(ply:Nick() .. " has joined the server!")

  -- Check the map and warn the player, let him know our gamemode isn't the problem
  MCHK.WarnPlayer(ply)
end

hook.Add("PlayerInitialSpawn", "SBR:PLYS:InitialSpawn", PLYS.InitialSpawn)

-- Disconnected: Called when a player leaves the server
function PLYS.Disconnected(ply)
  -- Remove the player from the race on disconnect
  if (RND.IsPlayerRacing(ply)) then
    -- Update the player stats
    ply:SetNWInt("SBR:Rounds", ply:GetNWInt("SBR:Rounds") + 1)
    ply:SetNWInt("SBR:Losses", ply:GetNWInt("SBR:Losses") + 1)

    -- TODO: Save player stats

    RND.RemovePlayer(ply)
  end

  -- Notify of player leaving
  NET.BroadcastGamemodeMessage(ply:Nick() .. " has left the server.")
end

hook.Add("PlayerDisconnected", "SBR:PLYS:Disconnected", PLYS.Disconnected)

-- RestrictNoclip: Prevent the player from using noclip
function PLYS.RestrictNoclip(ply, bool)
  if (ply:IsAdmin()) then
    return true
  end

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
  -- Create a ragdoll for the memes
  ply:CreateRagdoll()
end
