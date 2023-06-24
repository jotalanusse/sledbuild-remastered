require("types/map")

-- OpenGates: Open all gates on the map
function MAP.OpenGates()
  -- TODO: Possible runtime ERROR, I still don't know if the entity table is ordered
	for _, v in ipairs(ents.FindByName(MAP.CONFIG.ENTITIES.NAMES.GATE)) do
		v:Fire("Disable", "", 0) -- Disable the gate with a delay of 0

		MAP.JitterEntity(v) -- Get props in direct contact with the gate to update their physics
	end
end
