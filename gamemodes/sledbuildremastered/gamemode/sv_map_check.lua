MCHK = {}

-- CheckMap: Checks the map for the neccesary entities/objects and warn the user if something is wrong
function MCHK.CheckMap(ply)
  local completeMap = true

  local totalStartZones = MAP.CountByClass(ENTITY_NAMES.START_ZONE_CLASS)
  if (totalStartZones == 0) then
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE.PREFIX .. "ERROR: No start zones found!")
    completeMap = false
  end

  local totalFinishZones = MAP.CountByClass(ENTITY_NAMES.FINISH_ZONE_CLASS)
  if (totalFinishZones == 0) then
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE.PREFIX .. "ERROR: No finish zones found!")
    completeMap = false
  end

  local totalGates = MAP.CountByName(ENTITY_NAMES.GATE_NAME)
  if (totalGates == 0) then
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE.PREFIX .. "ERROR: No gates found!")
    completeMap = false
  end

  local totalPushers = MAP.CountByName(ENTITY_NAMES.PUSHER_NAME)
  if (totalGates == 0) then
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE.PREFIX .. "ERROR: No pushers found!")
    completeMap = false
  end

  local totalSpawns1 = MAP.CountByName(ENTITY_NAMES.SPAWN_1_NAME)
  if (totalSpawns1 == 0) then
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE.PREFIX .. "ERROR: No specific spawn 1 found!")
    completeMap = false
  end

  local totalSpawns2 = MAP.CountByName(ENTITY_NAMES.SPAWN_2_NAME)
  if (totalSpawns2 == 0) then
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE.PREFIX .. "ERROR: No specific spawn 2 found!")
    completeMap = false
  end

  local totalSpawns3 = MAP.CountByName(ENTITY_NAMES.SPAWN_3_NAME)
  if (totalSpawns3 == 0) then
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE.PREFIX .. "ERROR: No specific spawn 3 found!")
    completeMap = false
  end

  local totalSpawns = MAP.CountByName(ENTITY_NAMES.SPAWN_NAME)
  if (totalSpawns == 0) then
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE.PREFIX .. "ERROR: No additional spawns found!")
    completeMap = false
  end

  if (not completeMap) then
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE.PREFIX .. "ERROR: The map is not complete, gameplay might be broken!")
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE.PREFIX .. "ERROR: Please check the map for missing entities!")
    ply:PrintMessage(HUD_PRINTTALK,
      CONSOLE.PREFIX .. "ERROR: If you can, contact the map creator and tell him about this!")
  end
end
