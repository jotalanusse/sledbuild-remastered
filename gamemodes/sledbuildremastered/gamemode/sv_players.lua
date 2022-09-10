PLYS = {
  COLLISIONS = {
    DEFAULT = COLLISION_GROUP_WEAPON -- Doesn't collide with players and vehicles
  }
}

-- StripLoadout: Remove the player's loadout completely
function PLYS.StripLoadout(ply)
  -- TODO: Why is this not working?
  ply:StripWeapons()
  ply:StripAmmo()
end

-- GiveDefaultLoadout: Give the default loadout to the player
function PLYS.GiveDefaultLoadout(ply)
  ply:Give("gmod_tool")
  ply:Give("weapon_physgun")
  ply:Give("weapon_physcannon")
  ply:Give("gmod_camera")
end

-- GiveAdminLoadout: Give the admin loadout to the player
function PLYS.GiveAdminLoadout(ply)
  ply:GiveAmmo(24, "357", true)
  ply:Give("weapon_crowbar")
  ply:Give("weapon_357")
end

-- SetLoadout: Set the loadout for the player
function PLYS.SetLoadout(ply)
  PLYS.StripLoadout(ply)
  PLYS.GiveDefaultLoadout(ply)

  -- And if the player is an admin we give them some toys
  if (ply:IsAdmin()) then
    PLYS.GiveAdminLoadout(ply)
  end
end

-- Teleport: Teleport a player to the specified target
function PLYS.Teleport(ply, target)
  if ply and ply:IsPlayer() then
    ply:GetPhysicsObject():SetVelocityInstantaneous(Vector(0, 0, 0))
    ply:SetCollisionGroup(PLYS.DEFAULT_COLLISION_GROUP)
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
  ply:SetCollisionGroup(PLYS.DEFAULT_COLLISION_GROUP) -- Doesn't collide with players and vehicles
end

-- Spawn: Called everytime a player spawns
function PLYS.Spawn(ply)
  PLYS.SetLoadout(ply)
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

-- TODO: Whah do this do???
-- TODO: Maybe find a way to not override this?
-- DoPlayerDeath: Handle the player's death
function GM:DoPlayerDeath(ply, attacker, dmginfo)
  ply:CreateRagdoll()
end
