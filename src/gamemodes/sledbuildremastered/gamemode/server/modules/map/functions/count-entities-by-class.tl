require("server/modules/map/types/map")

-- CountEntitiesByClass: Count the amount of entities with a given class
function MAP.CountEntitiesByClass(class: string): integer
	local entities = ents.FindByClass(class)

	return #entities
end
