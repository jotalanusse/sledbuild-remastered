require("server/modules/vehicles/types/vehicles")

-- TeleportVehicle: Teleport a vehicle to the specified target
function VEHICLES.TeleportVehicle(vehicle: VehicleType, target: VectorType)
  -- Just in case check that the vehicle is valid -- TODO Check if this is necessary
  if (not vehicle:IsValid()) then
    return
  end

  local originalVehiclePos = vehicle:GetPos() -- Use this so the props don't tp to an unwanted position
  local constrainedEntities = constraint.GetAllConstrainedEntities(vehicle)

  for _, v in ipairs(constrainedEntities) do
    if (v and v:IsValid()) then
      v:SetCollisionGroup(VEHICLES.CONFIG.COLLISIONS.DEFAULT)
      v:SetPos(target + (v:GetPos() - originalVehiclePos))
    end
  end

  VEHICLES.StopVehicle(vehicle)
end
