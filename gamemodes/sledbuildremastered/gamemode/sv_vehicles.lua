VEHS = {
  ALLOWED = {
    ["models/vehicles/prisoner_pod_inner.mdl"] = true,
    ["models/nova/airboat_seat.mdl"] = true
  },
  COLLISIONS = {
    DEFAULT = COLLISION_GROUP_DEBRIS_TRIGGER -- Same as debris, but hits triggers. Useful for an item that can be shot, but doesn't collide.
  }
}

-- Teleport: Teleport a vehicle to the specified target
function VEHS.Teleport(vehicle, target)
  -- The vehicle could despawn at any time
  if (vehicle:IsValid()) then
    local originalVehiclePos = vehicle:GetPos() -- Use this so the props don't tp to an unwanted position
    local constrainedEntities = constraint.GetAllConstrainedEntities(vehicle)

    for k, v in pairs(constrainedEntities) do
      if v and v:IsValid() then
        v:GetPhysicsObject():SetVelocityInstantaneous(Vector(0, 0, 0))
        v:SetCollisionGroup(VEHS.COLLISIONS.DEFAULT)
        v:SetPos(target + (v:GetPos() - originalVehiclePos))
        v:GetPhysicsObject():SetVelocityInstantaneous(Vector(0, 0, 0))
      end
    end
  end
end

-- IsSled: Checks if a set of constrained props is considered a sled
function VEHS.IsSled(entity)
  local constrainedEntities = constraint.GetAllConstrainedEntities(entity)

  for k, v in pairs(constrainedEntities) do
    -- TODO: Store entity class in a gobal variable?
    if (v:GetClass() == "prop_vehicle_prisoner_pod") then
      return true
    end
  end

  return false
end

-- HasPlayer: Checks if a set of constrained props have a player
function VEHS.HasPlayer(entity)
  local constrainedEntities = constraint.GetAllConstrainedEntities(entity)

  for k, v in pairs(constrainedEntities) do
    -- TODO: Store entity class in a gobal variable?
    if (v:GetClass() == "prop_vehicle_prisoner_pod") then
      -- TODO: Do I need the "v:GetDriver()" check?
      if (v:GetDriver() and v:GetDriver():IsValid()) then
        return true
      end
    end
  end

  return false
end

-- Restrict: Restrict the kind of vehicles that can be used
function VEHS.Restrict(ply, model, name, table)
  if (VEHS.ALLOWED[model]) then
    return true
  end

  NET.SendGamemodeMessage(ply, "Only a Pod or Airboat Seat can be used.")
  return false
end

hook.Add("PlayerSpawnVehicle", "SBR.VEHS.LimitType", VEHS.Restrict)

-- TODO: Whah do this do???
-- SetDefaultCollissions: Set the default collission for the spawned vehicle
function VEHS.SetDefaultCollissions(ply, entity)
  entity:SetCollisionGroup(VEHS.COLLISIONS.DEFAULT)
end

hook.Add("PlayerSpawnedVehicle", "SBR.VEHS.SetDefaultCollissions", VEHS.SetDefaultCollissions)

-- PlayerLeave: Called when the player exits a vehicle
function VEHS.PlayerLeave(ply, vehicle)
  -- TODO: We kill the players if they are part of the current race
  -- There is a weird bug where the game crashes when trying to kill the player
  -- so for now we just won't allow players to exit their vehicles

  ply:SetCollisionGroup(PLYS.COLLISIONS.DEFAULT)
end

hook.Add("PlayerLeaveVehicle", "SBR.VEHS.PlayerLeave", VEHS.PlayerLeave)

-- CanExitVehicle: Called when the player tries to exit a vehicle
function VEHS.CanExitVehicle(vehicle, ply)
  -- TODO: Enable after testing
  -- if (ply:IsAdmin()) then
  --   return true
  -- end

  if (RND.IsPlayerRacing(ply)) then
    NET.SendGamemodeMessage(ply, "You can't leave your sled while racing!")
    return false
  end
end

hook.Add("CanExitVehicle", "SBR.VEHS.CanExitVehicle", VEHS.CanExitVehicle)
