require("types/map")

-- EnablePushers: Enable all pushers in the map
function MAP.EnablePushers()
  -- TODO: Possible runtime ERROR, I still don't know if the entity table is ordered
	for _, v in ipairs(ents.FindByName(MAP.CONFIG.ENTITIES.NAMES.PUSHER)) do
		v:Fire("Enable", "", 0) -- Enable the pusher with a delay of 0
	end
end
