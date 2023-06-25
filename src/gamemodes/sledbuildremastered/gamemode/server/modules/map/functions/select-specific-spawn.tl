require("server/modules/map/types/map")

-- SelectSpecificSpawn: Selects a specific spawn position
function MAP.SelectSpecificSpawn(name: string): EntityType
	local spawns = ents.FindByName(name)

	if (#spawns == 0) then
    -- TODO: Should we throw an error here?
    -- TODO: Check this during map check
		-- The mapper didn't add specific spawns, so we'll just use the default spawns
		return MAP.SelectRandomSpawn()
	end

	-- There should only be one of each specific spawn
	local selectedSpawn = spawns[1]

	return selectedSpawn
end
