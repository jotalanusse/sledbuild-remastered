SWPS = {}

-- DisableSpawning: Disable SWEPs from being spawned
function SWPS.DisableSpawning(ply)
  if (ply:IsAdmin()) then
    return true
  end

  NET.SendGamemodeMessage(ply, "SWEPs cannot be spawned.")
  return false
end

hook.Add("PlayerSpawnSWEP", "SBR:SWPS:DisableSpawning", SWPS.DisableSpawning)
