-- Whitelisted vehicles
local WHITELISTED_VEHICLES = {
  "models/vehicles/prisoner_pod_inner.mdl",
  "models/nova/airboat_seat.mdl"
}

-- VehicleLimitType: Limit the kind of vehicles that can be used
function VehicleLimitType(ply, model, name, table)
  for k, v in pairs(WHITELISTED_VEHICLES) do
    if (string.find(model, v)) then
      return true
    end
  end

  ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "Only a Pod or Airboat Seat can be used.")
  return false
end

hook.Add("PlayerSpawnVehicle", "SBRVehicleLimitType", VehicleLimitType)


-- VehicleSetDefaultCollissions: Set the default collission for the spawned vehicle
function VehicleSetDefaultCollissions(ply, entity)
	entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER) -- Same as debris, but hits triggers. Useful for an item that can be shot, but doesn't collide.
end

hook.Add("PlayerSpawnedVehicle", "SBRVehicleSetDefaultCollissions", VehicleSetDefaultCollissions)