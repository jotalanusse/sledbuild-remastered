-- EffectsDisableSpawning: Disable effects from being spawned
function EffectsDisableSpawning(ply)
  ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "Effects cannot be spawned.")
  return false
end

hook.Add("PlayerSpawnEffect", "SBREffectsDisableSpawning", EffectsDisableSpawning)

-- NPCDisableSpawning: Disable NPCs from being spawned
function NPCDisableSpawning(ply)
  ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "NPCs cannot be spawned.")
  return false
end

hook.Add("PlayerSpawnNPC", "SBRNPCDisableSpawning", NPCDisableSpawning)

-- RagdollDisableSpawning: Disable ragdolls from being spawned
function RagdollDisableSpawning(ply)
  ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "Ragdolls cannot be spawned.")
  return false
end

hook.Add("PlayerSpawnRagdoll", "SBRRagdollDisableSpawning", RagdollDisableSpawning)

-- SWEPDisableSpawning: Disable SWEPs from being spawned
function SWEPDisableSpawning(ply)
  ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "SWEPs cannot be spawned.")
  return false
end

hook.Add("PlayerSpawnSWEP", "SBRSWEPDisableSpawning", SWEPDisableSpawning)
