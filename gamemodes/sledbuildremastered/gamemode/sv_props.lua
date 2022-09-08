-- PropRestrictRacingSpawning: Restricts a player from spawning props when racing
function PropRestrictRacingSpawning(ply)
  if (ply:Team() == TEAMS.RACING) then
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "Props cannot be spawned while racing!")
    return false
  end

  return true
end

hook.Add("PlayerSpawnObject", "SBRPropRestrictRacingSpawning", PropRestrictRacingSpawning)

-- PropLimitSize: Limit the max size of props that can be spawned
function PropLimitSize(ply, model, prop)
  if (prop:BoundingRadius() > PROPS.MAX_RADIUS) then -- Note: Radius is half the size of the diameter (half the size of the prop)
    prop:Remove()
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "That prop is way too large for a sled.")
  end

  prop:SetCollisionGroup(PROPS.DEFAULT_COLLISION_GROUP)
end

hook.Add("PlayerSpawnedProp", "SBRPropLimitSize", PropLimitSize)

-- PropBlock: Restrict the spawning of props in the blacklist
function PropBlock(ply, model)
  for k, v in pairs(PROPS.BLACKLIST) do
    if (string.find(model, v)) then
      ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "This prop is blacklisted.")
      return false
    end
  end
end

hook.Add("PlayerSpawnProp", "SBRPropBlock", PropBlock)
