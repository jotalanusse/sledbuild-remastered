MCHK = {
  complete = true,
  checked = false
}

-- IsComplete: Return true is the map is complete
function MCHK.IsComplete()
  -- Only check the map once
  if (MCHK.checked) then
    return MCHK.complete
  end

  local totalStartZones = MAP.CountByClass(MAP.ENTITIES.NAMES.START_ZONE_CLASS)
  if (totalStartZones == 0) then
    MCHK.complete = false
  end

  local totalFinishZones = MAP.CountByClass(MAP.ENTITIES.NAMES.FINISH_ZONE_CLASS)
  if (totalFinishZones == 0) then
    MCHK.complete = false
  end

  local totalGates = MAP.CountByName(MAP.ENTITIES.NAMES.GATE_NAME)
  if (totalGates == 0) then
    MCHK.complete = false
  end

  local totalPushers = MAP.CountByName(MAP.ENTITIES.NAMES.PUSHER_NAME)
  if (totalGates == 0) then
    MCHK.complete = false
  end

  local totalSpawns1 = MAP.CountByName(MAP.ENTITIES.NAMES.SPAWN_1_NAME)
  if (totalSpawns1 == 0) then
    MCHK.complete = false
  end

  local totalSpawns2 = MAP.CountByName(MAP.ENTITIES.NAMES.SPAWN_2_NAME)
  if (totalSpawns2 == 0) then
    MCHK.complete = false
  end

  local totalSpawns3 = MAP.CountByName(MAP.ENTITIES.NAMES.SPAWN_3_NAME)
  if (totalSpawns3 == 0) then
    MCHK.complete = false
  end

  local totalSpawns = MAP.CountByName(MAP.ENTITIES.NAMES.SPAWN_NAME)
  if (totalSpawns == 0) then
    MCHK.complete = false
  end

  MCHK.checked = true

  return MCHK.complete
end

-- WarnPlayer: Checks the map for the neccesary entities/objects and warns the user if something is wrong
function MCHK.WarnPlayer(ply)
  local totalStartZones = MAP.CountByClass(MAP.ENTITIES.NAMES.START_ZONE_CLASS)
  if (totalStartZones == 0) then
    NET.SendGamemodeMessage(ply, "ERROR: No start zones found!", CONSOLE.COLORS.ERROR)
  end

  local totalFinishZones = MAP.CountByClass(MAP.ENTITIES.NAMES.FINISH_ZONE_CLASS)
  if (totalFinishZones == 0) then
    NET.SendGamemodeMessage(ply, "ERROR: No finish zones found!", CONSOLE.COLORS.ERROR)
  end

  local totalGates = MAP.CountByName(MAP.ENTITIES.NAMES.GATE_NAME)
  if (totalGates == 0) then
    NET.SendGamemodeMessage(ply, "ERROR: No gates found!", CONSOLE.COLORS.ERROR)
  end

  local totalPushers = MAP.CountByName(MAP.ENTITIES.NAMES.PUSHER_NAME)
  if (totalGates == 0) then
    NET.SendGamemodeMessage(ply, "ERROR: No pushers found!", CONSOLE.COLORS.ERROR)
  end

  local totalSpawns1 = MAP.CountByName(MAP.ENTITIES.NAMES.SPAWN_1_NAME)
  if (totalSpawns1 == 0) then
    NET.SendGamemodeMessage(ply, "ERROR: No specific spawn 1 found!", CONSOLE.COLORS.ERROR)
  end

  local totalSpawns2 = MAP.CountByName(MAP.ENTITIES.NAMES.SPAWN_2_NAME)
  if (totalSpawns2 == 0) then
    NET.SendGamemodeMessage(ply, "ERROR: No specific spawn 2 found!", CONSOLE.COLORS.ERROR)
  end

  local totalSpawns3 = MAP.CountByName(MAP.ENTITIES.NAMES.SPAWN_3_NAME)
  if (totalSpawns3 == 0) then
    NET.SendGamemodeMessage(ply, "ERROR: No specific spawn 3 found!", CONSOLE.COLORS.ERROR)
  end

  local totalSpawns = MAP.CountByName(MAP.ENTITIES.NAMES.SPAWN_NAME)
  if (totalSpawns == 0) then
    NET.SendGamemodeMessage(ply, "ERROR: No additional spawns found!", CONSOLE.COLORS.ERROR)
  end

  if (not MCHK.IsComplete()) then
    NET.SendGamemodeMessage(ply,
      "ERROR: The map is not complete, gameplay might be broken! " ..
      "Please check the map for missing entities! " ..
      "If you can, contact the map creator and tell them about this."
      , CONSOLE.COLORS.ERROR
    )

    NET.SendGamemodeMessage(ply, "This map is not supported by SBR, the game mode will not start.")
  end
end
