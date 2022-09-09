PYS = {
  DEFAULT_COLLISION_GROUP = COLLISION_GROUP_WEAPON -- Doesn't collide with players and vehicles
}

-- StripLoadout: Remove the player's loadout completely
function PYS.StripLoadout(ply)
  -- TODO: Why is this not working?
  ply:StripWeapons()
  ply:StripAmmo()
end

-- GiveDefaultLoadout: Give the default loadout to the player
function PYS.GiveDefaultLoadout(ply)
  ply:Give("gmod_tool")
  ply:Give("weapon_physgun")
  ply:Give("weapon_physcannon")
  ply:Give("gmod_camera")
end

-- GiveAdminLoadout: Give the admin loadout to the player
function PYS.GiveAdminLoadout(ply)
  ply:GiveAmmo(24, "357", true)
  ply:Give("weapon_crowbar")
  ply:Give("weapon_357")
end

-- SetLoadout: Set the loadout for the player
function PYS.SetLoadout(ply)
  PYS.StripLoadout(ply)
  PYS.GiveDefaultLoadout(ply)

  -- And if the player is an admin we give them some toys
  if (ply:IsAdmin()) then
    PYS.GiveAdminLoadout(ply)
  end
end

-- SetDefaultCollision: Set the default collission for a player
function PYS.SetDefaultCollision(ply)
  ply:SetCollisionGroup(PYS.DEFAULT_COLLISION_GROUP) -- Doesn't collide with players and vehicles
end

-- Spawn: Called everytime a player spawns
function PYS.Spawn(ply)
  PYS.SetLoadout(ply)
  PYS.SetDefaultCollision(ply)

  ply:SelectWeapon("weapon_physgun")
  ply:SetTeam(TEAMS.BUILDING)
end

hook.Add("PlayerSpawn", "SBR.PYS.Spawn", PYS.Spawn)

-- InitialSpawn: Called when a player joins the server
function PYS.InitialSpawn(ply)
  PYS.Spawn(ply)

  -- Notify of a new player
  for k, v in pairs(player.GetAll()) do
    v:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. ply:Nick() .. " has joined the server!")
  end

  -- Check the map and warn the player, let him know our gamemode isn't the problem
  CHK.CheckMap(ply)
end

hook.Add("PlayerInitialSpawn", "SBR.PYS.InitialSpawn", PYS.InitialSpawn)

-- RestrictNoclip: Prevent the player from using noclip
function PYS.RestrictNoclip(ply, bool)
  if (ply:IsAdmin()) then
    return true
  end

  ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "Only admins may use noclip.")
  return false
end

hook.Add("PlayerNoClip", "SBR.PYS.RestrictNoclip", PYS.RestrictNoclip)

-- RemoveDeathSound: Remove the death sound of the player
function PYS.RemoveDeathSound()
  return true
end

hook.Add("PlayerDeathSound", "SBR.PYS.RemoveDeathSound", PYS.RemoveDeathSound)

-- TODO: Whah do this do???
-- TODO: Maybe find a way to not override this?
-- DoPlayerDeath: Handle the player's death
function GM:DoPlayerDeath(ply, attacker, dmginfo)
  ply:CreateRagdoll()
end
