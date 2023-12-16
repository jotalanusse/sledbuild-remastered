require("server/modules/map/enums/reference-type")
require("server/modules/map/enums/map-entity-name")

global MapEntityNameToReferenceTypeEnum <total>: {MapEntityNameEnum:ReferenceTypeEnum} = {
  ["sbr_gate"] = "name",
  ["sbr_pusher"] = "name",
  ["sbr_spawn_1"] = "name",
  ["sbr_spawn_2"] = "name",
  ["sbr_spawn_3"] = "name",
  ["sbr_spawn"] = "name",
  ["sbr_start_zone"] = "class",
  ["sbr_finish_zone"] = "class"
}
