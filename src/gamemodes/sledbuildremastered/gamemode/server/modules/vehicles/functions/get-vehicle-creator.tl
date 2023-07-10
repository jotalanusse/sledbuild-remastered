require("server/modules/vehicles/types/vehicles")

-- GetVechicleCreator: Get the creator of a set of constrained props
function VEHICLES.GetVechicleCreator(entity: EntityType): PlayerType
  local constrainedEntities = constraint.GetAllConstrainedEntities(entity)

  for _, v in ipairs(constrainedEntities) do
    if (VEHICLES.IsRacingSeat(v)) then
      local creator = v:GetCreator()

      -- TODO: Check if this is necessary?
      -- if (creator:IsPlayer()) then
      --   return creator
      -- end

      return creator
    end
  end
end
