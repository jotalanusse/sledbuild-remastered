require("server/modules/weapons/types/weapons")
require("server/modules/net/types/net")
require("shared/modules/helpers/types/helpers")

-- RestrictWeaponPickup: Restrict a player from picking up wepons outside of their loadout
function WEAPONS.RestrictWeaponPickup(ply: PlayerType, weapon: WeaponType): boolean
  if (ply:IsAdmin()) then
    return true
  end

  local weaponClass = weapon:GetClass()
  if (not HELPERS.ArrayContainsString(WEAPONS.CONFIG.LOADOUTS.DEFAULT, weaponClass)) then
    NET.SendGamemodeMessage(ply, "You cannot pick up this weapon!")

    return false
  end
end
