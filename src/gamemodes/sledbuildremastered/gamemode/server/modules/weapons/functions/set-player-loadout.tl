require("server/modules/weapons/types/weapons")

-- SetPlayerLoadout: Set the loadout for the player
function WEAPONS.SetPlayerLoadout(ply: PlayerType, loadout: {WeaponClassEnum})
  WEAPONS.StripPlayerLoadout(ply)

  for _, v in ipairs(loadout) do
    ply:Give(v)
  end
end
