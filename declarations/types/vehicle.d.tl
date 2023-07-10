global record VehicleType
  GetDriver: function(vehicle: VehicleType): PlayerType

  -- EntityType methods: This will be removed when we can extend the EntityType class
  IsValid: function(vehicle: VehicleType): boolean
  GetPos: function(vehicle: VehicleType): VectorType
  SetCreator: function(vehicle: VehicleType, player: PlayerType)
end
