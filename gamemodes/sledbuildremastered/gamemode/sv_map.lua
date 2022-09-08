-- GatesOpen: Open the gates so the player can race
function GatesOpen()
	for k, v in pairs(ents.FindByName(ENTITY_NAMES.GATE_NAME)) do
		v:Fire("Disable", "", "0") -- Disable the gate with a delay of 0
	end
end

-- GatesClose: Close the gates to prevent players from racing
function GatesClose()
	for k, v in pairs(ents.FindByName(ENTITY_NAMES.GATE_NAME)) do
		v:Fire("Enable", "", "0") -- Enable the gate with a delay of 0
	end
end

-- PusherEnable: Enables the pusher to move players on round start
function PusherEnable()
	for k, v in pairs(ents.FindByName(ENTITY_NAMES.PUSHER_NAME)) do
		v:Fire("Enable", "", "0") -- Enable the pusher with a delay of 0
	end
end

-- PusherDisable: Disables the pusher
function PusherDisable()
	for k, v in pairs(ents.FindByName(ENTITY_NAMES.PUSHER_NAME)) do
		v:Fire("Disable", "", "0") -- Disable the pusher with a delay of 0
	end
end