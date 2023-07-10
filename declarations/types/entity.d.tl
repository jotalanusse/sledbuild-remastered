require("types/vector")
require("types/phys-obj")
require("types/player")

-- TYPE: When Teal supports extending types, then all variables of type EntityType will be truly generic.
global record EntityType
  SetPos: function(entity: EntityType, position: VectorType)
  GetPos: function(entity: EntityType): VectorType
  Fire: function(entity: EntityType, input: string, param: string, delay: number, activator: EntityType, caller: EntityType) -- TYPE: EntityType should support all EntityType extensions
  GetClass: function(entity: EntityType): string
  IsPlayer: function(entity: EntityType): boolean
  BoundingRadius: function(entity: EntityType): number
  Remove: function(entity: EntityType)
  SetCollisionGroup: function(entity: EntityType, group: integer)
  IsValid: function(entity: EntityType): boolean
  GetPhysicsObject: function(entity: EntityType): PhysObjType
  GetCreator: function(entity: EntityType): PlayerType
end
