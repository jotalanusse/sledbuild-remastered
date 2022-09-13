MAP = {
	ENTITIES = {
		NAMES = {
			GATE_NAME = "sbr_gate",
			PUSHER_NAME = "sbr_pusher",
			SPAWN_1_NAME = "sbr_spawn_1",
			SPAWN_2_NAME = "sbr_spawn_2",
			SPAWN_3_NAME = "sbr_spawn_3",
			SPAWN_NAME = "sbr_spawn",
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
	for _, v in pairs(ents.FindByName(MAP.ENTITIES.NAMES.GATE_NAME)) do
		v:Fire("Disable", "", "0") -- Disable the gate with a delay of 0
	end
end

-- GatesClose: Close the gates to prevent players from racing
function MAP.GatesClose()
	for _, v in pairs(ents.FindByName(MAP.ENTITIES.NAMES.GATE_NAME)) do
		v:Fire("Enable", "", "0") -- Enable the gate with a delay of 0
	end
end

-- PushersEnable: Enables the pushers to move players on round start
function MAP.PushersEnable()
	for _, v in pairs(ents.FindByName(MAP.ENTITIES.NAMES.PUSHER_NAME)) do
		v:Fire("Enable", "", "0") -- Enable the pusher with a delay of 0
	end
end

-- PushersDisable: Disables the pushers
function MAP.PushersDisable()
	for _, v in pairs(ents.FindByName(MAP.ENTITIES.NAMES.PUSHER_NAME)) do
		v:Fire("Disable", "", "0") -- Disable the pusher with a delay of 0
	end
end

-- SelectRandomSpawn: Selects a random spawn position
function MAP.SelectRandomSpawn()
	local spawns = ents.FindByName(MAP.ENTITIES.NAMES.SPAWN_NAME)
	local selectedSpawnIndex = math.random(1, MAP.CountByName(MAP.ENTITIES.NAMES.SPAWN_NAME))

	return spawns[selectedSpawnIndex]
end
