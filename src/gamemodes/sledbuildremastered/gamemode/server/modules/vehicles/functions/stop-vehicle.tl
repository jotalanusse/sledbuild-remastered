require("server/modules/vehicles/types/vehicles")

-- StopVehicle: Stops a vehicle (removes all inertia)
function VEHICLES.StopVehicle(vehicle: VehicleType)
  -- Just in case check that the vehicle is valid -- TODO Check if this is necessary
  if (not vehicle:IsValid()) then
    return
  end

  local constrainedEntities = constraint.GetAllConstrainedEntities(vehicle)

  for _, v in ipairs(constrainedEntities) do
    if (v and v:IsValid()) then
      local physObject = v:GetPhysicsObject()
      physObject:SetVelocityInstantaneous(Vector(0, 0, 0))
      physObject:SetAngleVelocityInstantaneous(Vector(0, 0, 0))
    end
  end
end
