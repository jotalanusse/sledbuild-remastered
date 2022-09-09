VEH = {
  WHITELIST = {
    "models/vehicles/prisoner_pod_inner.mdl",
    "models/nova/airboat_seat.mdl"
  },
  DEFAULT_COLLISION_GROUP = COLLISION_GROUP_DEBRIS_TRIGGER -- Same as debris, but hits triggers. Useful for an item that can be shot, but doesn't collide.
}

-- LimitType: Limit the kind of vehicles that can be used
function VEH.LimitType(ply, model, name, table)
  for k, v in pairs(VEHICLES.WHITELIST) do
    if (string.find(model, v)) then
      return true
    end
  end

  ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "Only a Pod or Airboat Seat can be used.")
  return false
end

hook.Add("PlayerSpawnVehicle", "SBR.VEH.LimitType", VEH.LimitType)

-- TODO: Whah do this do???
-- SetDefaultCollissions: Set the default collission for the spawned vehicle
function VEH.SetDefaultCollissions(ply, entity)
  entity:SetCollisionGroup(VEH.DEFAULT_COLLISION_GROUP)
end

hook.Add("PlayerSpawnedVehicle", "SBR.VEH.SetDefaultCollissions", VEH.SetDefaultCollissions)

-- PlayerLeave: Called when the player exits a vehicle
function VEH.PlayerLeave(ply, vehicle)
  -- TODO: Kill player if team racing
  ply:SetCollisionGroup(PLAYERS.DEFAULT_COLLISION_GROUP)
end

hook.Add("PlayerLeaveVehicle", "SBR.VEH.PlayerLeave", VEH.PlayerLeave)
