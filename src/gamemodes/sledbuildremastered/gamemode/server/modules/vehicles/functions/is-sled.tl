require("server/modules/vehicles/types/vehicles")

-- IsSled: Checks if a set of constrained props is considered a sled
function VEHICLES.IsSled(entity: EntityType): boolean
  local constrainedEntities = constraint.GetAllConstrainedEntities(entity)

  for _, v in ipairs(constrainedEntities) do
    -- If the entities contain a seat they are a sled -- TODO: Expand the options searched for (tf does this mean?)
    if (VEHICLES.IsRacingSeat(v)) then
      return true
    end
  end

  return false
end
