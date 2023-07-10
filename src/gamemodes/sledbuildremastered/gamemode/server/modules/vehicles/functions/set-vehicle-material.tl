require("server/modules/vehicles/types/vehicles")

-- SetVehicleMaterial: Apply a given material to a set of constrained props
function VEHICLES.SetVehicleMaterial(vehicle: VehicleType, material: string)
  local constrainedEntities = constraint.GetAllConstrainedEntities(vehicle)

  for _, v in ipairs(constrainedEntities) do
    local physObject = v:GetPhysicsObject()
    if (physObject:IsValid()) then -- TODO: This "IsValid" method has not been tested
      physObject:SetMaterial(material)
    end
  end
end
