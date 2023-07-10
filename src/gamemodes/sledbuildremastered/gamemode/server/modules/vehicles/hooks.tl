require("server/modules/vehicles/types/vehicles")

hook.Add("PlayerSpawnedVehicle", "SBR:VEHICLES:SetCreator", VEHICLES.SetCreator)
hook.Add("PlayerSpawnVehicle", "SBR:VEHICLES:RestrictVehicles", VEHICLES.RestrictVehicles)
