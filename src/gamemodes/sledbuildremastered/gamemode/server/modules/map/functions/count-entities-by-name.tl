require("types/map")

-- CountEntitiesByName: Count the amount of entities with a given name
function MAP.CountEntitiesByName(name: string): integer
	local entities = ents.FindByName(name)

	return #entities
end
