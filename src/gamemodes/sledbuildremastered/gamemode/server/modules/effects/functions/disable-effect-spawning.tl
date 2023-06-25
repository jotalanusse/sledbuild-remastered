require("server/modules/effects/types/effects")
require("server/modules/net/types/net")

-- DisableEffectSpawning: Disable effects from being spawned
function EFFECTS.DisableEffectSpawning(ply: PlayerType): boolean
  if (ply:IsAdmin()) then
    return true
  end

  NET.SendGamemodeMessage(ply, "Effects cannot be spawned.")

  return false
end
