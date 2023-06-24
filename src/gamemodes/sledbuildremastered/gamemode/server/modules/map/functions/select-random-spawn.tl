require("types/map")

-- SelectRandomSpawn: Selects a random spawn position
function MAP.SelectRandomSpawn(): EntityType
  local spawnName = MAP.CONFIG.ENTITIES.NAMES.SPAWN

	local spawns = ents.FindByName(spawnName)
	local selectedSpawnIndex = math.random(1, MAP.CountEntitiesByName(spawnName))

	return spawns[selectedSpawnIndex]
end
