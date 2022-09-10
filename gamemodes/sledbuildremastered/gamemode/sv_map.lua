MAP = {}

-- CountByName: Count the amount of entities with a given name
function MAP.CountByName(name)
	local count = 0

	for k, v in pairs(ents.FindByName(name)) do
		count = count + 1
	end

	return count
end

-- CountByClass: Count the amount of entities with a given class
function MAP.CountByClass(class)
	local count = 0

	for k, v in pairs(ents.FindByClass(class)) do
		count = count + 1
	end

	return count
end

-- GatesOpen: Open the gates so the player can race
function MAP.GatesOpen()
	for k, v in pairs(ents.FindByName(ENTITY_NAMES.GATE_NAME)) do
		v:Fire("Disable", "", "0") -- Disable the gate with a delay of 0
	end
end

-- GatesClose: Close the gates to prevent players from racing
function MAP.GatesClose()
	for k, v in pairs(ents.FindByName(ENTITY_NAMES.GATE_NAME)) do
		v:Fire("Enable", "", "0") -- Enable the gate with a delay of 0
	end
end

-- PushersEnable: Enables the pushers to move players on round start
function MAP.PushersEnable()
	for k, v in pairs(ents.FindByName(ENTITY_NAMES.PUSHER_NAME)) do
		v:Fire("Enable", "", "0") -- Enable the pusher with a delay of 0
	end
end

-- PushersDisable: Disables the pushers
function MAP.PushersDisable()
	for k, v in pairs(ents.FindByName(ENTITY_NAMES.PUSHER_NAME)) do
		v:Fire("Disable", "", "0") -- Disable the pusher with a delay of 0
	end
end

-- SelectRandomSpawn: Selects a random spawn position
function MAP.SelectRandomSpawn()
	local spawns = ents.FindByName(ENTITY_NAMES.SPAWN_NAME)
	local selectedSpawnIndex = math.random(1, MAP.CountByName(ENTITY_NAMES.SPAWN_NAME))

	return spawns[selectedSpawnIndex]
end
