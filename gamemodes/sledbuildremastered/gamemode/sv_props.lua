-- Blacklisted props
local PROP_BLACKLIST = {
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
}

-- PropRestrictRacingSpawning: Restricts a player from spawning props when racing
function PropRestrictRacingSpawning(ply)
  if ply:Team() == TEAM_RACING then
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "Props cannot be spawned while racing!")
    return false
  end

  return true
end

hook.Add("PlayerSpawnObject", "SBRPropRestrictRacingSpawning", PropRestrictRacingSpawning)

-- PropLimitSize: Limit the max size of props that can be spawned
function PropLimitSize(ply, model, prop)
  if prop:BoundingRadius() > MAX_PROP_RADIUS then -- Note: Radius is half the size of the diameter (half the size of the prop)
    prop:Remove()
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "That prop is way too large for a sled.")
  end

  prop:SetCollisionGroup(COLLISION_GROUP_DEBRIS_TRIGGER) -- Same as debris, but hits triggers. Useful for an item that can be shot, but doesn't collide.
end

hook.Add("PlayerSpawnedProp", "SBRPropLimitSize", PropLimitSize)

-- PropBlock: Restrict the spawning of props in the blacklist
function PropBlock(ply, model)
  for k, v in pairs(PROP_BLACKLIST) do
    if string.find(model, v) then
      ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "This prop is blacklisted.")
      return false
    end
  end
end

hook.Add("PlayerSpawnProp", "SBRPropBlock", PropBlock)
