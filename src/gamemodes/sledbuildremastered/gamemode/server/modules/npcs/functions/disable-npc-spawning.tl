require("server/modules/npcs/types/npcs")
require("server/modules/net/types/net")

-- DisableNpcSpawning: Disable npcs from being spawned
function NPCS.DisableNpcSpawning(ply: PlayerType): boolean
  if (ply:IsAdmin()) then
    return true
  end

  NET.SendGamemodeMessage(ply, "NPCs cannot be spawned.")

  return false
end
