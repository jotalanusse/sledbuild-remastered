PRPS = {
  MAX_RADIUS = 128,
  BLACKLIST = {
    "models/props_phx/oildrum001_explosive.mdl",
    "models/props_junk/gascan001a.mdl",
    "models/props_junk/propane_tank001a.mdl",
    "models/props_c17/oildrum001_explosive.mdl",
    "models/props_phx/misc/flakshell_big.mdl",
    "models/props_phx/ww2bomb.mdl",
    "models/props_phx/amraam.mdl",
    "models/props_phx/mk-82.mdl",
    "models/props_phx/ball.mdl",
    "models/props_phx/cannonball.mdl",
    "models/props_phx/torpedo.mdl"
  },
  DEFAULT_COLLISION_GROUP = COLLISION_GROUP_DEBRIS_TRIGGER -- Same as debris, but hits triggers. Useful for an item that can be shot, but doesn't collide.

}

-- DisableRacingSpawning: Restricts a player from spawning props when racing
function PRPS.DisableRacingSpawning(ply)
  if (ply:Team()) == TEAMS.RACING then
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE.PREFIX .. "Props cannot be spawned while being a racer!")
    return false
  end

  return true
end

hook.Add("PlayerSpawnObject", "SBR.PRPS.DisableRacingSpawning", PRPS.DisableRacingSpawning)

-- Spawned: Called when a player spawns a prop
function PRPS.Spawned(ply, model, prop)
  -- Limit the max size of the prop that can be spawned
  if (prop:BoundingRadius() > PRPS.MAX_RADIUS) then
    prop:Remove()
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE.PREFIX .. "That prop is way too large for a sled.")
  end

  prop:SetCollisionGroup(PRPS.DEFAULT_COLLISION_GROUP) -- TODO: Wah do this do???
end

hook.Add("PlayerSpawnedProp", "SBR.PRPS.Spawned", PRPS.Spawned)

-- Block: Restrict the spawning of props in the blacklist
function PRPS.Block(ply, model)
  for k, v in pairs(PRPS.BLACKLIST) do
    if (string.find(model, v)) then
      ply:PrintMessage(HUD_PRINTTALK, CONSOLE.PREFIX .. "This prop is blacklisted.")
      return false
    end
  end
end

hook.Add("PlayerSpawnProp", "SBR.PRPS.Block", PRPS.Block)
