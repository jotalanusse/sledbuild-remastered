PRPS = {
  MAX_RADIUS = 128, -- Maximum radius of a prop before being considered too big

  -- Set the different collisions used by the props
  COLLISIONS = {
    DEFAULT = COLLISION_GROUP_DEBRIS_TRIGGER -- Same as debris, but hits triggers. Useful for an item that can be shot, but doesn't collide.
  },

  -- List of restricted props the players can't spawn
  RESTRICTED = {
    ["models/props_phx/oildrum001_explosive.mdl"] = true,
    ["models/props_junk/gascan001a.mdl"] = true,
    ["models/props_junk/propane_tank001a.mdl"] = true,
    ["models/props_c17/oildrum001_explosive.mdl"] = true,
    ["models/props_phx/misc/flakshell_big.mdl"] = true,
    ["models/props_phx/ww2bomb.mdl"] = true,
    ["models/props_phx/amraam.mdl"] = true,
    ["models/props_phx/mk-82.mdl"] = true,
    ["models/props_phx/ball.mdl"] = true,
    ["models/props_phx/cannonball.mdl"] = true,
    ["models/props_phx/torpedo.mdl"] = true
  },
}

-- DisableRacingSpawning: Restricts a player from spawning props when racing
function PRPS.DisableRacingSpawning(ply)
  if (ply:Team() == TEAMS.RACING) then
    NET.SendGamemodeMessage(ply, "Props cannot be spawned while being a racer.")

    return false
  end

  return true
end

hook.Add("PlayerSpawnObject", "SBR:PRPS:DisableRacingSpawning", PRPS.DisableRacingSpawning)

-- Spawned: Called when a player spawns a prop
function PRPS.Spawned(ply, model, prop)
  -- Limit the max size of the prop that can be spawned
  if (prop:BoundingRadius() > PRPS.MAX_RADIUS) then
    NET.SendGamemodeMessage(ply, "That prop is way too large for a sled.")

    prop:Remove()
  end
end

hook.Add("PlayerSpawnedProp", "SBR:PRPS:Spawned", PRPS.Spawned)

-- TODO: What does this do?
-- SetDefaultCollisions: Set the default collision for the spawned prop
function PRPS.SetDefaultCollisions(ply, model, prop)
  prop:SetCollisionGroup(PRPS.COLLISIONS.DEFAULT)
end

hook.Add("PlayerSpawnedProp", "SBR:PRPS:SetDefaultCollisions", PRPS.SetDefaultCollisions)

-- Restrict: Restrict the spawning of certain props
function PRPS.Restrict(ply, model)
  -- TODO: Enable after testing
  -- if (ply:IsAdmin()) then
  --   return true
  -- end

  if (PRPS.RESTRICTED[model]) then
    NET.SendGamemodeMessage(ply, "This prop is restricted.")

    return false
  end
end

hook.Add("PlayerSpawnProp", "SBR:PRPS:Block", PRPS.Restrict)
