require("server/modules/ragdolls/types/ragdolls")
require("server/modules/net/types/net")

-- DisableRagdollSpawning: Disable ragdolls from being spawned
function RAGDOLLS.DisableRagdollSpawning(ply: PlayerType): boolean
  if (ply:IsAdmin()) then
    return true
  end

  NET.SendGamemodeMessage(ply, "Ragdolls cannot be spawned.")

  return false
end
