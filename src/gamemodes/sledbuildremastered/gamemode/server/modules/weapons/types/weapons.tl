global record WEAPONS
  record Config
    record Loadouts
      DEFAULT: {string}
      ADMIN: {string}
    end

    LOADOUTS: Loadouts
  end

  CONFIG: Config

  Initialize: function()

  -- Functions
  RestrictWeaponPickup: function(ply: PlayerType, weapon: WeaponType): boolean
  SetPlayerLoadout: function(ply: PlayerType, loadout: {string})
  StripPlayerLoadout: function(ply: PlayerType)
end
