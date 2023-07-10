global record VEHICLES
  record Config
    record Collisions
      DEFAULT: integer
    end

    record Materials
      BUILDING: string
      RACING: string
    end

    DEFAULT_SEAT_CLASS: string
    ALLOWED_VEHICLES: {string}
    COLLISIONS: Collisions
    MATERIALS: Materials
  end

  CONFIG: Config

  Initialize: function()

  -- Functions
  GetVechicleCreator: function(entity: EntityType): PlayerType
  IsRacingSeat: function(entity: EntityType): boolean
  IsSled: function(entity: EntityType): boolean
  RestrictVehicles: function(ply: PlayerType, model: string): boolean
  SetCreator: function(ply: PlayerType, vehicle: VehicleType)
  SetVehicleMaterial: function(vehicle: VehicleType, material: string)
  StopVehicle: function(vehicle: VehicleType)
  TeleportVehicle: function(vehicle: VehicleType, target: VectorType)
  VehicleHasPlayer: function(entity: EntityType): boolean
end
