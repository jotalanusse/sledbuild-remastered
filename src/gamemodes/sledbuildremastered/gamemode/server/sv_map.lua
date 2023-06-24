

-- GatesOpen: Open the gates so the player can race
function MAP.GatesOpen()
	for _, v in pairs(ents.FindByName(MAP.ENTITIES.NAMES.GATE)) do
		v:Fire("Disable", "", "0") -- Disable the gate with a delay of 0

		-- We do this to get props in direct contact with the gate to update their physics
		MAP.JitterEntity(v)
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
