VEHS = {
  DEFAULT_SEAT_CLASS = "prop_vehicle_prisoner_pod", -- The default seat class

  -- Allowed vehicles a player can spawn
  ALLOWED = {
    ["models/vehicles/prisoner_pod_inner.mdl"] = true,
    ["models/nova/airboat_seat.mdl"] = true
  },

  -- Set the different collisions used by the vehicles
  COLLISIONS = {
    DEFAULT = COLLISION_GROUP_DEBRIS_TRIGGER -- Same as debris, but hits triggers. Useful for an item that can be shot, but doesn't collide.
  },

  -- Materials used by the gamemode for the sleds
  MATERIALS = {
    BUILDING = "dirt",
    RACING = "gmod_ice"
  }
}

-- Teleport: Teleport a vehicle to the specified target
function VEHS.Teleport(vehicle, target)
  -- Just in case check that the vehicle is valid
  if (not vehicle:IsValid()) then
    return
  end

  local originalVehiclePos = vehicle:GetPos() -- Use this so the props don't tp to an unwanted position
  local constrainedEntities = constraint.GetAllConstrainedEntities(vehicle)

  for _, v in pairs(constrainedEntities) do
    if (v and v:IsValid()) then
      v:SetCollisionGroup(VEHS.COLLISIONS.DEFAULT)
      v:SetPos(target + (v:GetPos() - originalVehiclePos))
    end
  end

  VEHS.Stop(vehicle)
end

-- Stop: Stops a vehicle (removes all inertia)
function VEHS.Stop(vehicle)
  -- Just in case check that the vehicle is valid
  if (not vehicle:IsValid()) then
    return
  end

  local constrainedEntities = constraint.GetAllConstrainedEntities(vehicle)

  for _, v in pairs(constrainedEntities) do
    if (v and v:IsValid()) then
      local physObject = v:GetPhysicsObject()
      physObject:SetVelocityInstantaneous(Vector(0, 0, 0))
      physObject:SetAngleVelocityInstantaneous(Vector(0, 0, 0))
    end
  end
end

-- SetMaterial: Apply a given material to a set of constrained props
function VEHS.SetMaterial(entity, material)
  local constrainedEntities = constraint.GetAllConstrainedEntities(entity)

  for _, v in pairs(constrainedEntities) do
    local physObject = v:GetPhysicsObject()
    if (IsValid(physObject)) then
      physObject:SetMaterial(material)
    end
  end
end

-- IsSled: Checks if a set of constrained props is considered a sled
function VEHS.IsSled(entity)
  local constrainedEntities = constraint.GetAllConstrainedEntities(entity)

  for _, v in pairs(constrainedEntities) do
    -- If the entities contain a seat they are a sled
    if (v:GetClass() == VEHS.DEFAULT_SEAT_CLASS) then
      return true
    end
  end

  return false
end

-- HasPlayer: Checks if a set of constrained props have a player
function VEHS.HasPlayer(entity)
  local constrainedEntities = constraint.GetAllConstrainedEntities(entity)

  -- If the entities contain a player they have a player (obviously)
  for _, v in pairs(constrainedEntities) do
    if (v:GetClass() == VEHS.DEFAULT_SEAT_CLASS) then
      -- TODO: Do I need the "v:GetDriver()" check?
      if (v:GetDriver() and v:GetDriver():IsValid()) then
        return true
      end
    end
  end

  return false
end

-- GetCreator: Get the owner of a set of constrained props
function VEHS.GetCreator(entity)
  local constrainedEntities = constraint.GetAllConstrainedEntities(entity)

  for _, v in pairs(constrainedEntities) do
    if (v:GetClass() == VEHS.DEFAULT_SEAT_CLASS) then
      local creator = v:GetCreator()

      if (creator:IsPlayer()) then
        return creator
      end
    end
  end
end

-- SetDefaultCreator: Sets the creator of a vehicle to the player that spawned it
function VEHS.SetDefaultCreator(ply, vehicle)
  vehicle:SetCreator(ply)
end

hook.Add("PlayerSpawnedVehicle", "SBR:VEHS:SetDefaultCreator", VEHS.SetDefaultCreator)

-- Restrict: Restrict the kind of vehicles that can be used
function VEHS.Restrict(ply, model, name, table)
  if (VEHS.ALLOWED[model]) then
    return true
  end

  NET.SendGamemodeMessage(ply, "Only a Pod or an Airboat Seat can be used.")

  return false
end

hook.Add("PlayerSpawnVehicle", "SBR:VEHS:LimitType", VEHS.Restrict)

-- DisableRacingSpawning: Restricts a player from spawning vehicles when racing
function VEHS.DisableRacingSpawning(ply, model, name, table)
  if (ply:Team() == TEAMS.RACING) then
    NET.SendGamemodeMessage(ply, "Vehicles cannot be spawned while being a racer.")

    return false
  end

  return true
end

hook.Add("PlayerSpawnVehicle", "SBR:VEHS:DisableRacingSpawning", VEHS.DisableRacingSpawning)

-- SetDefaultCollisions: Set the default collision for the spawned vehicle
function VEHS.SetDefaultCollisions(ply, entity)
  entity:SetCollisionGroup(VEHS.COLLISIONS.DEFAULT)
end

hook.Add("PlayerSpawnedVehicle", "SBR:VEHS:SetDefaultCollisions", VEHS.SetDefaultCollisions)

-- PlayerLeave: Called when the player exits a vehicle
function VEHS.PlayerLeave(ply, vehicle)
  -- TODO: We kill the players if they are part of the current race
  -- There is a weird bug where the game crashes when trying to kill the player
  -- so for now we just won't allow players to exit their vehicles (CanExitVehicle)

  ply:SetCollisionGroup(PLYS.COLLISIONS.DEFAULT)
end

hook.Add("PlayerLeaveVehicle", "SBR:VEHS:PlayerLeave", VEHS.PlayerLeave)

-- CanExitVehicle: Called when the player tries to exit a vehicle
function VEHS.CanExitVehicle(vehicle, ply)
  if (ply:IsAdmin()) then
    return true
  end

  if (RND.IsPlayerRacing(ply)) then
    NET.SendGamemodeMessage(ply, "You can't leave your sled while racing!")

    return false
  end
end

hook.Add("CanExitVehicle", "SBR:VEHS:CanExitVehicle", VEHS.CanExitVehicle)
