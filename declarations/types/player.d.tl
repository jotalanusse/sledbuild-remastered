global record PlayerType
  IsAdmin: function(ply: PlayerType): boolean
  StripAmmo: function(ply: PlayerType)
  StripWeapons: function(ply: PlayerType)
  Give: function(ply: PlayerType, weaponClassName: string, bNoAmmo: boolean)
end
