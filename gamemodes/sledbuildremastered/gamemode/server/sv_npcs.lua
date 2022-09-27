NPCS = {}

-- DisableSpawning: Disable NPCs from being spawned
function NPCS.DisableSpawning(ply)
  if (ply:IsAdmin()) then
    return true
  end

  NET.SendGamemodeMessage(ply, "NPCs cannot be spawned.")
  return false
end

hook.Add("PlayerSpawnNPC", "SBR:NPCS:DisableSpawning", NPCS.DisableSpawning)
