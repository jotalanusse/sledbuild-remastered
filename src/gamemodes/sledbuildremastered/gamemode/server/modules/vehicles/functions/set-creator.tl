require("server/modules/vehicles/types/vehicles")

-- TODO: Is this function/functionality even needed?
-- SetCreator: Sets the creator of a vehicle to the player that spawned it
-- Params are inverted because of the way the hook is called
function VEHICLES.SetCreator(ply: PlayerType, vehicle: VehicleType)
  vehicle:SetCreator(ply)
end
