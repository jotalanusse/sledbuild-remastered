require("server/modules/map/types/map")

-- CloseGates: Close all gates on the map
function MAP.CloseGates()
  -- TODO: Possible runtime ERROR, I still don't know if the entity table is ordered
	for _, v in ipairs(ents.FindByName(MAP.CONFIG.ENTITIES.NAMES.GATE)) do
		v:Fire("Enable", "", 0) -- Enable the gate with a delay of 0
	end
end
