-- CountByName: Count the amount of entities with a given name
local function CountByName(name)
  local count = 0

  for k, v in pairs(ents.FindByName(name)) do
    count = count + 1
  end

  return count
end

-- CountByClass: Count the amount of entities with a given class
local function CountByClass(class)
  local count = 0

  for k, v in pairs(ents.FindByClass(class)) do
    count = count + 1
  end

  return count
end

-- Check: Checks the map for the neccesary entities/objects and warn the user if something is wrong
function CheckMap(ply)
  local completeMap = true

  local totalStartZones = CountByClass(ENTITY_NAMES.START_ZONE_CLASS)
  if (totalStartZones == 0) then
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "ERROR: No start zones found!")
    completeMap = false
  end

  local totalFinishZones = CountByClass(ENTITY_NAMES.FINISH_ZONE_CLASS)
  if (totalFinishZones == 0) then
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "ERROR: No finish zones found!")
    completeMap = false
  end

  local totalGates = CountByName(ENTITY_NAMES.GATE_NAME)
  if (totalGates == 0) then
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "ERROR: No gates found!")
    completeMap = false
  end

  local totalPushers = CountByName(ENTITY_NAMES.PUSHER_NAME)
  if (totalGates == 0) then
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "ERROR: No pushers found!")
    completeMap = false
  end

  local totalSpawns1 = CountByName(ENTITY_NAMES.SPAWN_1_NAME)
  if (totalSpawns1 == 0) then
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "ERROR: No specific spawn 1 found!")
    completeMap = false
  end

  local totalSpawns2 = CountByName(ENTITY_NAMES.SPAWN_2_NAME)
  if (totalSpawns2 == 0) then
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "ERROR: No specific spawn 2 found!")
    completeMap = false
  end

  local totalSpawns3 = CountByName(ENTITY_NAMES.SPAWN_3_NAME)
  if (totalSpawns3 == 0) then
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "ERROR: No specific spawn 3 found!")
    completeMap = false
  end

  local totalSpawns = CountByName(ENTITY_NAMES.SPAWN_NAME)
  if (totalSpawns == 0) then
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "ERROR: No additional spawns found!")
    completeMap = false
  end

  if (not completeMap) then
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "ERROR: The map is not complete, gameplay might be broken!")
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "ERROR: Please check the map for missing entities!")
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "ERROR: If you can, contact the map creator and tell him about this!")
  end
end
