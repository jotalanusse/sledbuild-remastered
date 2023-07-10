require("server/modules/map-check/types/map-check")
require("server/modules/map/types/map")

-- CheckMap: Chek the map and save information about missing parts
function MAP_CHECK.CheckMap()
  if MAP_CHECK.STATE.WAS_MAP_CHECKED then
    return
  end

  for _, name in pairs(MAP.MAP_CHECKS) do
    mapCheck:Check()
  end

  MAP_CHECK.STATE.WAS_MAP_CHECKED = true
end
