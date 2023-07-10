require("server/modules/vehicles/types/vehicles")

-- TODO: Make this function go over an array of valid seats
-- IsRacingSeat: Checks if an entity is a racing seat
function VEHICLES.IsRacingSeat(entity: EntityType): boolean
  return entity:GetClass() == VEHICLES.CONFIG.DEFAULT_SEAT_CLASS
end
