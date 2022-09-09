DSE = {}

-- EffectsDisableSpawning: Disable effects from being spawned
function DSE.EffectsDisableSpawning(ply)
  ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "Effects cannot be spawned.")
  return false
end

hook.Add("PlayerSpawnEffect", "SBR.DSE.EffectsDisableSpawning", DSE.EffectsDisableSpawning)

-- NPCDisableSpawning: Disable NPCs from being spawned
function DSE.NPCDisableSpawning(ply)
  ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "NPCs cannot be spawned.")
  return false
end

hook.Add("PlayerSpawnNPC", "SBR.DSE.NPCDisableSpawning", DSE.NPCDisableSpawning)

-- RagdollDisableSpawning: Disable ragdolls from being spawned
function DSE.RagdollDisableSpawning(ply)
  ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "Ragdolls cannot be spawned.")
  return false
end

hook.Add("PlayerSpawnRagdoll", "SBR.DSE.RagdollDisableSpawning", DSE.RagdollDisableSpawning)

-- SWEPDisableSpawning: Disable SWEPs from being spawned
function DSE.SWEPDisableSpawning(ply)
  ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "SWEPs cannot be spawned.")
  return false
end

hook.Add("PlayerSpawnSWEP", "SBR.DSE.SWEPDisableSpawning", DSE.SWEPDisableSpawning)
