require("server/modules/map-check/types/map-check")
require("server/modules/map/types/map")

-- CheckMap: Chek the map and save information about missing parts
function MAP_CHECK.CheckMap()
  if MAP_CHECK.STATE.WAS_MAP_CHECKED then
    return
  end

  for _, v in pairs(MAP.CONFIG.ENTITIES.NAMES) do
    
  end

  MAP_CHECK.STATE.WAS_MAP_CHECKED = true
end
