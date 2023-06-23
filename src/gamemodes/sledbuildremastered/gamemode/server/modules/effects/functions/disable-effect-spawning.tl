require("types/effects")
require("types/net")

-- DisableEffectSpawning: Disable effects from being spawned
function EFFECTS.DisableEffectSpawning(ply: Player): boolean
  if (ply:IsAdmin()) then
    return true
  end

  NET.SendGamemodeMessage(ply, "Effects cannot be spawned.")

  return false
end
