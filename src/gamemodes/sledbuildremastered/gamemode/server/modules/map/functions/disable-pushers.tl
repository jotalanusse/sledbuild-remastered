require("types/map")

-- DisablePushers: Disable all pushers in the map
function MAP.DisablePushers()
  -- TODO: Possible runtime ERROR, I still don't know if the entity table is ordered
	for _, v in ipairs(ents.FindByName(MAP.CONFIG.ENTITIES.NAMES.PUSHER)) do
		v:Fire("Disable", "", 0) -- Disable the pusher with a delay of 0
	end
end
