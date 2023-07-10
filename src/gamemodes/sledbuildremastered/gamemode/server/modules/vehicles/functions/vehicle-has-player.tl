require("server/modules/vehicles/types/vehicles")

-- VehicleHasPlayer: Checks if a set of constrained props have a player
-- TODO: Check this function works as intended
function VEHICLES.VehicleHasPlayer(entity: EntityType): boolean
  local constrainedEntities = constraint.GetAllConstrainedEntities(entity)

  for _, v in ipairs(constrainedEntities) do
    if (VEHICLES.IsRacingSeat(v)) then
      local vehicle = (v as VehicleType)
      local ply = vehicle:GetDriver()

      if (ply and ply:IsValid()) then
        return true
      end
    end
  end

  return false
end
