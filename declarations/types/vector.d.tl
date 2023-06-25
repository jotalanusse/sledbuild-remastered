global record VectorType
  x: number
  y: number
  z: number

  metamethod __add: function(VectorType, VectorType): VectorType
  metamethod __sub: function(VectorType, VectorType): VectorType
end
