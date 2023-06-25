require("types/entity")

global record ents
  FindByName: function(_name: string): {EntityType}
  FindByClass: function(_class: string): {EntityType}
end
