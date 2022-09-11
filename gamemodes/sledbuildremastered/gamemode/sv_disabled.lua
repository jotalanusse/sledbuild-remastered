DSBE = {}

-- EffectsDisableSpawning: Disable effects from being spawned
function DSBE.EffectsDisableSpawning(ply)
  -- TODO: Enable after testing
  -- if (ply:IsAdmin()) then
  --   return true
  -- end

  NET.SendGamemodeMessage(ply, "Effects cannot be spawned.")
  return false
end

hook.Add("PlayerSpawnEffect", "SBR:DSBE:EffectsDisableSpawning", DSBE.EffectsDisableSpawning)

-- NPCDisableSpawning: Disable NPCs from being spawned
function DSBE.NPCDisableSpawning(ply)
  -- TODO: Enable after testing
  -- if (ply:IsAdmin()) then
  --   return true
  -- end

  NET.SendGamemodeMessage(ply, "NPCs cannot be spawned.")
  return false
end

hook.Add("PlayerSpawnNPC", "SBR:DSBE:NPCDisableSpawning", DSBE.NPCDisableSpawning)

-- RagdollDisableSpawning: Disable ragdolls from being spawned
function DSBE.RagdollDisableSpawning(ply)
  -- TODO: Enable after testing
  -- if (ply:IsAdmin()) then
  --   return true
  -- end

  NET.SendGamemodeMessage(ply, "Ragdolls cannot be spawned.")
  return false
end

hook.Add("PlayerSpawnRagdoll", "SBR:DSBE:RagdollDisableSpawning", DSBE.RagdollDisableSpawning)

-- SWEPDisableSpawning: Disable SWEPs from being spawned
function DSBE.SWEPDisableSpawning(ply)
  -- TODO: Enable after testing
  -- if (ply:IsAdmin()) then
  --   return true
  -- end

  NET.SendGamemodeMessage(ply, "SWEPs cannot be spawned.")
  return false
end

hook.Add("PlayerSpawnSWEP", "SBR:DSBE:SWEPDisableSpawning", DSBE.SWEPDisableSpawning)
