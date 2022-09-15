MAP = {
	-- List of entities that our gamemode iteracts with
	ENTITIES = {
		NAMES = {
			GATE = "sbr_gate",
			PUSHER = "sbr_pusher",
			SPAWN_1 = "sbr_spawn_1",
			SPAWN_2 = "sbr_spawn_2",
			SPAWN_3 = "sbr_spawn_3",
			SPAWN = "sbr_spawn",
			START_ZONE_CLASS = "sbr_start_zone",
			FINISH_ZONE_CLASS = "sbr_finish_zone",
		}
	}
}

-- CountByName: Count the amount of entities with a given name
function MAP.CountByName(name)
	local entities = ents.FindByName(name)

	return #entities
end

-- CountByClass: Count the amount of entities with a given class
function MAP.CountByClass(class)
	local entities = ents.FindByClass(class)

	return #entities
end

-- GatesOpen: Open the gates so the player can race
function MAP.GatesOpen()
	for _, v in pairs(ents.FindByName(MAP.ENTITIES.NAMES.GATE)) do
		v:Fire("Disable", "", "0") -- Disable the gate with a delay of 0
	end
end

-- GatesClose: Close the gates to prevent players from racing
function MAP.GatesClose()
	for _, v in pairs(ents.FindByName(MAP.ENTITIES.NAMES.GATE)) do
		v:Fire("Enable", "", "0") -- Enable the gate with a delay of 0
	end
end

-- PushersEnable: Enables the pushers to move players on round start
function MAP.PushersEnable()
	for _, v in pairs(ents.FindByName(MAP.ENTITIES.NAMES.PUSHER)) do
		v:Fire("Enable", "", "0") -- Enable the pusher with a delay of 0
	end
end

-- PushersDisable: Disables the pushers
function MAP.PushersDisable()
	for _, v in pairs(ents.FindByName(MAP.ENTITIES.NAMES.PUSHER)) do
		v:Fire("Disable", "", "0") -- Disable the pusher with a delay of 0
	end
end

-- SelectRandomSpawn: Selects a random spawn position
function MAP.SelectRandomSpawn()
	local spawns = ents.FindByName(MAP.ENTITIES.NAMES.SPAWN)
	local selectedSpawnIndex = math.random(1, MAP.CountByName(MAP.ENTITIES.NAMES.SPAWN))

	return spawns[selectedSpawnIndex]
end

-- SelectSpecificSpawn: Selects a specific spawn position
function MAP.SelectSpecificSpawn(name)
	local spawns = ents.FindByName(name)

	if (#spawns == 0) then
		-- The mapper didn't add specific spawns, so we'll just use the default spawns

		return MAP.SelectRandomSpawn()
	end

	-- There should only be one of each specific spawn
	local selectedSpawn = spawns[1]

	return selectedSpawn
end
