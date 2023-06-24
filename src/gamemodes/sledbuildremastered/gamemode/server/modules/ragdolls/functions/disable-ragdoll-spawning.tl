require("types/ragdolls")
require("types/net")

-- DisableRagdollSpawning: Disable ragdolls from being spawned
function RAGDOLLS.DisableRagdollSpawning(ply: PlayerType): boolean
  if (ply:IsAdmin()) then
    return true
  end

  NET.SendGamemodeMessage(ply, "Ragdolls cannot be spawned.")

  return false
end
