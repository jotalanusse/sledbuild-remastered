global record WEAPONS
  record Config
    record Loadouts
      DEFAULT: {WeaponClassEnum}
      ADMIN: {WeaponClassEnum}
    end

    LOADOUTS: Loadouts
  end

  CONFIG: Config

  Initialize: function()

  -- Functions
  RestrictWeaponPickup: function(ply: PlayerType, weapon: WeaponType): boolean
  SetPlayerLoadout: function(ply: PlayerType, loadout: {WeaponClassEnum})
  StripPlayerLoadout: function(ply: PlayerType)
end
