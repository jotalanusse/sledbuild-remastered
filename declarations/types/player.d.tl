require("types/entity")

global type EntityType -- TYPE: We do this to avoid circular dependencies

global record PlayerType
  IsAdmin: function(ply: PlayerType): boolean
  StripAmmo: function(ply: PlayerType)
  StripWeapons: function(ply: PlayerType)
  Give: function(ply: PlayerType, weaponClassName: string, bNoAmmo: boolean)

  -- EntityType methods: This will be removed when we can extend the EntityType class
  IsValid: function(ply: PlayerType): boolean
end
