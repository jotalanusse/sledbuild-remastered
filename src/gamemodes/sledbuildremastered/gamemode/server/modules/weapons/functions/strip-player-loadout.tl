require("server/modules/weapons/types/weapons")

-- StripPlayerLoadout: Remove the player's loadout completely
function WEAPONS.StripPlayerLoadout(ply: PlayerType)
  ply:StripAmmo()
  ply:StripWeapons()
end
