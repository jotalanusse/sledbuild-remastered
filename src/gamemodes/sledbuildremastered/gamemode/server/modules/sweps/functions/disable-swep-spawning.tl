require("types/sweps")
require("types/net")

-- DisableSwepSpawning: Disable SWEPs from being spawned
function SWEPS.DisableSwepSpawning(ply: PlayerType): boolean
  if (ply:IsAdmin()) then
    return true
  end

  NET.SendGamemodeMessage(ply, "SWEPs cannot be spawned.")

  return false
end
