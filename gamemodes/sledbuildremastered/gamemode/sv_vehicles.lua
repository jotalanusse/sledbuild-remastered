VEHS = {
  WHITELIST = {
    "models/vehicles/prisoner_pod_inner.mdl",
    "models/nova/airboat_seat.mdl"
  },
  DEFAULT_COLLISION_GROUP = COLLISION_GROUP_DEBRIS_TRIGGER -- Same as debris, but hits triggers. Useful for an item that can be shot, but doesn't collide.
}

-- LimitType: Limit the kind of vehicles that can be used
function VEHS.LimitType(ply, model, name, table)
  for k, v in pairs(VEHS.WHITELIST) do
    if (string.find(model, v)) then
      return true
    end
  end

  ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "Only a Pod or Airboat Seat can be used.")
  return false
end

hook.Add("PlayerSpawnVehicle", "SBR.VEHS.LimitType", VEHS.LimitType)

-- TODO: Whah do this do???
-- SetDefaultCollissions: Set the default collission for the spawned vehicle
function VEHS.SetDefaultCollissions(ply, entity)
  entity:SetCollisionGroup(VEHS.DEFAULT_COLLISION_GROUP)
end

hook.Add("PlayerSpawnedVehicle", "SBR.VEHS.SetDefaultCollissions", VEHS.SetDefaultCollissions)

-- PlayerLeave: Called when the player exits a vehicle
function VEHS.PlayerLeave(ply, vehicle)
  -- TODO: We kill the players if they are part of the current race
  -- There is a weird bug where the game crashes when trying to kill the player
  -- so for now we just won't allow players to exit their vehicles

    ply:SetCollisionGroup(PLYS.DEFAULT_COLLISION_GROUP)
end

hook.Add("PlayerLeaveVehicle", "SBR.VEHS.PlayerLeave", VEHS.PlayerLeave)

-- CanExitVehicle: Called when the player tries to exit a vehicle
function VEHS.CanExitVehicle(vehicle, ply)
  if (ply:IsAdmin()) then
    return true
  end

  if(RND.IsPlayerRacing(ply)) then
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "You can't leave your sled while racing!")
    return false
  end
end

hook.Add("CanExitVehicle", "SBR.VEHS.CanExitVehicle", VEHS.CanExitVehicle)
