global record PlayerType
  IsAdmin: function(play: PlayerType): boolean
end

global record EntityType
  SetPos: function(entity: EntityType, position: VectorType)
  GetPos: function(entity: EntityType): VectorType
  Fire: function(entity: EntityType, input: string, param: string, delay: number, activator: EntityType, caller: EntityType) -- TODO: Check how to accept any entity
end

global record ColorType
  r: integer
  g: integer
  b: integer
  a: integer
end

global record VectorType
  x: number
  y: number
  z: number

  metamethod __add: function(VectorType, VectorType): VectorType
  metamethod __sub: function(VectorType, VectorType): VectorType
end
