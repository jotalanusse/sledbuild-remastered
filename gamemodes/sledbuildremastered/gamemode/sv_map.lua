MAP = {}

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
