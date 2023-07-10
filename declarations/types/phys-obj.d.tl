-- TODO: Change the name of this type omg it's so bad
global record PhysObjType
  SetVelocityInstantaneous: function(physObj: PhysObjType, velocity: VectorType)
  SetAngleVelocityInstantaneous: function(physObj: PhysObjType, velocity: VectorType)
  IsValid: function(physObj: PhysObjType): boolean -- TYPE: Still don't know if this corresponds to the EntityType or the PhysObjType
  SetMaterial: function(physObj: PhysObjType, materialName: string)
end
