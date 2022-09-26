EFTS = {}

-- DisableSpawning: Disable effects from being spawned
function EFTS.DisableSpawning(ply)
  if (ply:IsAdmin()) then
    return true
  end

  NET.SendGamemodeMessage(ply, "Effects cannot be spawned.")
  return false
end

hook.Add("PlayerSpawnEffect", "SBR:EFTS:DisableSpawning", EFTS.DisableSpawning)
