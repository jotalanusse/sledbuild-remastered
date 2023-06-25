global record PlayerType
  IsAdmin: function(ply: PlayerType): boolean
  StripAmmo: function(ply: PlayerType)
  StripWeapons: function(ply: PlayerType)
  Give: function(ply: PlayerType, weaponClassName: string, bNoAmmo: boolean)
end

global record WeaponType 
  -- General EntityType functions
  GetClass: function(entity: WeaponType): string -- TODO: This is from the EntityType
end

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

global record TraceResultType
  Entity: EntityType
end