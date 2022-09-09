DSBE = {}

-- EffectsDisableSpawning: Disable effects from being spawned
function DSBE.EffectsDisableSpawning(ply)
  ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "Effects cannot be spawned.")
  return false
end

hook.Add("PlayerSpawnEffect", "SBR.DSBE.EffectsDisableSpawning", DSBE.EffectsDisableSpawning)

-- NPCDisableSpawning: Disable NPCs from being spawned
function DSBE.NPCDisableSpawning(ply)
  ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "NPCs cannot be spawned.")
  return false
end

hook.Add("PlayerSpawnNPC", "SBR.DSBE.NPCDisableSpawning", DSBE.NPCDisableSpawning)

-- RagdollDisableSpawning: Disable ragdolls from being spawned
function DSBE.RagdollDisableSpawning(ply)
  ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "Ragdolls cannot be spawned.")
  return false
end

hook.Add("PlayerSpawnRagdoll", "SBR.DSBE.RagdollDisableSpawning", DSBE.RagdollDisableSpawning)

-- SWEPDisableSpawning: Disable SWEPs from being spawned
function DSBE.SWEPDisableSpawning(ply)
  ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "SWEPs cannot be spawned.")
  return false
end

hook.Add("PlayerSpawnSWEP", "SBR.DSBE.SWEPDisableSpawning", DSBE.SWEPDisableSpawning)
