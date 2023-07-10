require("server/modules/vehicles/types/vehicles")
require("server/modules/net/types/net")
require("shared/modules/helpers/types/helpers")

-- RestrictVehicles: Restrict the kind of vehicles that can be used
function VEHICLES.RestrictVehicles(ply: PlayerType, model: string): boolean
  if (ply:IsAdmin()) then
    return true
  end

  if (HELPERS.ArrayContainsString(VEHICLES.CONFIG.ALLOWED_VEHICLES, model)) then
    return true
  end

  NET.SendGamemodeMessage(ply, "This vehicle is restricted.")

  return false
end
