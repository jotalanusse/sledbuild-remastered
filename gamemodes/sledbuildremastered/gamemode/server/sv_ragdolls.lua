RGDS = {}

-- DisableSpawning: Disable ragdolls from being spawned
function RGDS.DisableSpawning(ply)
  if (ply:IsAdmin()) then
    return true
  end

  NET.SendGamemodeMessage(ply, "Ragdolls cannot be spawned.")
  return false
end

hook.Add("PlayerSpawnRagdoll", "SBR:RGDS:DisableSpawning", RGDS.DisableSpawning)
