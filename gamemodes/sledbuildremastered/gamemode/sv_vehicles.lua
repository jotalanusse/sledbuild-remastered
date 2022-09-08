-- Whitelisted vehicles
local WHITELISTED_VEHICLES = {
  "models/vehicles/prisoner_pod_inner.mdl",
  "models/nova/airboat_seat.mdl"
}

-- VehicleLimitType: Limit the kind of vehicles that can be used
function VehicleLimitType(pl, model, name, table)
  for k, v in pairs(WHITELISTED_VEHICLES) do
    if string.find(model, v) then
      return true
    end
  end

  pl:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "Only a Pod or Airboat Seat can be used.")
  return false
end

hook.Add("PlayerSpawnVehicle", "SBRVehicleLimitType", VehicleLimitType)
