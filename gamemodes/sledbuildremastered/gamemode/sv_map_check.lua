MCHK = {}

-- CheckMap: Checks the map for the neccesary entities/objects and warn the user if something is wrong
function MCHK.CheckMap(ply)
  local completeMap = true

  local totalStartZones = MAP.CountByClass(ENTITY.NAMES.START_ZONE_CLASS)
  if (totalStartZones == 0) then
    NET.SendGamemodeMessage(ply, "ERROR: No start zones found!", CONSOLE.COLORS.ERROR)
    completeMap = false
  end

  local totalFinishZones = MAP.CountByClass(ENTITY.NAMES.FINISH_ZONE_CLASS)
  if (totalFinishZones == 0) then
    NET.SendGamemodeMessage(ply, "ERROR: No finish zones found!", CONSOLE.COLORS.ERROR)
    completeMap = false
  end

  local totalGates = MAP.CountByName(ENTITY.NAMES.GATE_NAME)
  if (totalGates == 0) then
    NET.SendGamemodeMessage(ply, "ERROR: No gates found!", CONSOLE.COLORS.ERROR)
    completeMap = false
  end

  local totalPushers = MAP.CountByName(ENTITY.NAMES.PUSHER_NAME)
  if (totalGates == 0) then
    NET.SendGamemodeMessage(ply, "ERROR: No pushers found!", CONSOLE.COLORS.ERROR)
    completeMap = false
  end

  local totalSpawns1 = MAP.CountByName(ENTITY.NAMES.SPAWN_1_NAME)
  if (totalSpawns1 == 0) then
    NET.SendGamemodeMessage(ply, "ERROR: No specific spawn 1 found!", CONSOLE.COLORS.ERROR)
    completeMap = false
  end

  local totalSpawns2 = MAP.CountByName(ENTITY.NAMES.SPAWN_2_NAME)
  if (totalSpawns2 == 0) then
    NET.SendGamemodeMessage(ply, "ERROR: No specific spawn 2 found!", CONSOLE.COLORS.ERROR)
    completeMap = false
  end

  local totalSpawns3 = MAP.CountByName(ENTITY.NAMES.SPAWN_3_NAME)
  if (totalSpawns3 == 0) then
    NET.SendGamemodeMessage(ply, "ERROR: No specific spawn 3 found!", CONSOLE.COLORS.ERROR)
    completeMap = false
  end

  local totalSpawns = MAP.CountByName(ENTITY.NAMES.SPAWN_NAME)
  if (totalSpawns == 0) then
    NET.SendGamemodeMessage(ply, "ERROR: No additional spawns found!", CONSOLE.COLORS.ERROR)
    completeMap = false
  end

  if (not completeMap) then
    NET.SendGamemodeMessage(ply, "ERROR: The map is not complete, gameplay might be broken!", CONSOLE.COLORS.ERROR)
    NET.SendGamemodeMessage(ply, "ERROR: Please check the map for missing entities!", CONSOLE.COLORS.ERROR)
    NET.SendGamemodeMessage(ply, "ERROR: If you can, contact the map creator and tell him about this.",
      CONSOLE.COLORS.ERROR)
  end
end
