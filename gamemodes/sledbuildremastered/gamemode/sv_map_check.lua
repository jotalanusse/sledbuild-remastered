MCHK = {}

-- Define global variables
SetGlobalBool("SBR:MCHK:Complete", true) -- Whether the map is complete or not
SetGlobalBool("SBR:MCHK:Checked", false) -- Whether the map was checked or not

-- IsComplete: Return true is the map is complete
function MCHK.IsComplete()
  -- Only check the map once, else return the cached result
  if (GetGlobalBool("SBR:MCHK:Checked", false)) then
    return GetGlobalBool("SBR:MCHK:Complete", false)
  end

  local totalStartZones = MAP.CountByClass(MAP.ENTITIES.NAMES.START_ZONE_CLASS)
  if (totalStartZones == 0) then
    SetGlobalBool("SBR:MCHK:Complete", false)
  end

  local totalFinishZones = MAP.CountByClass(MAP.ENTITIES.NAMES.FINISH_ZONE_CLASS)
  if (totalFinishZones == 0) then
    SetGlobalBool("SBR:MCHK:Complete", false)
  end

  local totalGates = MAP.CountByName(MAP.ENTITIES.NAMES.GATE)
  if (totalGates == 0) then
    SetGlobalBool("SBR:MCHK:Complete", false)
  end

  local totalPushers = MAP.CountByName(MAP.ENTITIES.NAMES.PUSHER)
  if (totalGates == 0) then
    SetGlobalBool("SBR:MCHK:Complete", false)
  end

  -- local totalSpawns1 = MAP.CountByName(MAP.ENTITIES.NAMES.SPAWN_1)
  -- if (totalSpawns1 == 0) then
  --   SetGlobalBool("SBR:MCHK:Complete", false)
  -- end

  -- local totalSpawns2 = MAP.CountByName(MAP.ENTITIES.NAMES.SPAWN_2)
  -- if (totalSpawns2 == 0) then
  --   SetGlobalBool("SBR:MCHK:Complete", false)
  -- end

  -- local totalSpawns3 = MAP.CountByName(MAP.ENTITIES.NAMES.SPAWN_3)
  -- if (totalSpawns3 == 0) then
  --   SetGlobalBool("SBR:MCHK:Complete", false)
  -- end

  local totalSpawns = MAP.CountByName(MAP.ENTITIES.NAMES.SPAWN)
  if (totalSpawns == 0) then
    SetGlobalBool("SBR:MCHK:Complete", false)
  end

  -- Mark the map as checked
  SetGlobalBool("SBR:MCHK:Checked", true)

  return GetGlobalBool("SBR:MCHK:Complete", false)
end

-- TODO: This whole process could be more efficient
-- WarnPlayer: Checks the map for the necessary entities/objects and warns the user if something is wrong
function MCHK.WarnPlayer(ply)
  if (not MCHK.IsComplete()) then
    local totalStartZones = MAP.CountByClass(MAP.ENTITIES.NAMES.START_ZONE_CLASS)
    if (totalStartZones == 0) then
      NET.SendGamemodeMessage(ply, "ERROR: No start zones found!", COLORS.ERROR)
    end

    local totalFinishZones = MAP.CountByClass(MAP.ENTITIES.NAMES.FINISH_ZONE_CLASS)
    if (totalFinishZones == 0) then
      NET.SendGamemodeMessage(ply, "ERROR: No finish zones found!", COLORS.ERROR)
    end

    local totalGates = MAP.CountByName(MAP.ENTITIES.NAMES.GATE)
    if (totalGates == 0) then
      NET.SendGamemodeMessage(ply, "ERROR: No gates found!", COLORS.ERROR)
    end

    local totalPushers = MAP.CountByName(MAP.ENTITIES.NAMES.PUSHER)
    if (totalGates == 0) then
      NET.SendGamemodeMessage(ply, "ERROR: No pushers found!", COLORS.ERROR)
    end

    -- local totalSpawns1 = MAP.CountByName(MAP.ENTITIES.NAMES.SPAWN_1)
    -- if (totalSpawns1 == 0) then
    --   NET.SendGamemodeMessage(ply, "ERROR: No specific spawn 1 found!", COLORS.ERROR)
    -- end

    -- local totalSpawns2 = MAP.CountByName(MAP.ENTITIES.NAMES.SPAWN_2)
    -- if (totalSpawns2 == 0) then
    --   NET.SendGamemodeMessage(ply, "ERROR: No specific spawn 2 found!", COLORS.ERROR)
    -- end

    -- local totalSpawns3 = MAP.CountByName(MAP.ENTITIES.NAMES.SPAWN_3)
    -- if (totalSpawns3 == 0) then
    --   NET.SendGamemodeMessage(ply, "ERROR: No specific spawn 3 found!", COLORS.ERROR)
    -- end

    local totalSpawns = MAP.CountByName(MAP.ENTITIES.NAMES.SPAWN)
    if (totalSpawns == 0) then
      NET.SendGamemodeMessage(ply, "ERROR: No additional spawns found!", COLORS.ERROR)
    end

    NET.SendGamemodeMessage(ply,
      "ERROR: The map [" .. game.GetMap() .. "] is not complete, gameplay might be broken! " ..
      "Please check for missing entities! " ..
      "If you can, contact the map creator and tell them about this."
      , COLORS.ERROR
    )

    NET.SendGamemodeMessage(ply, "This map is not supported by SBR, the gamemode will not start.")
  end
end
