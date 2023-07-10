require("server/modules/map/enums/map-entity-reference-type")
require("server/modules/map/enums/map-entity-name")

global MapEntityNameToReferenceType <total>: {MapEntityName:MapEntityReferenceType} = {
  ["sbr_gate"] = "name",
  ["sbr_pusher"] = "name",
  ["sbr_spawn_1"] = "name",
  ["sbr_spawn_2"] = "name",
  ["sbr_spawn_3"] = "name",
  ["sbr_spawn"] = "name",
  ["sbr_start_zone"] = "class",
  ["sbr_finish_zone"] = "class"
}
