require("types/vector")

global record EntityType
  SetPos: function(entity: EntityType, position: VectorType)
  GetPos: function(entity: EntityType): VectorType
  Fire: function(entity: EntityType, input: string, param: string, delay: number, activator: EntityType, caller: EntityType) -- TODO: Check how to accept any entity
  GetClass: function(entity: EntityType): string
  IsPlayer: function(entity: EntityType): boolean
  BoundingRadius: function(entity: EntityType): number
  Remove: function(entity: EntityType)
  SetCollisionGroup: function(entity: EntityType, group: integer)
end
