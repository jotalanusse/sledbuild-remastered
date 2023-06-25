require("server/modules/weapons/types/weapons")

hook.Add("PlayerCanPickupWeapon", "SBR:WEAPONS:RestrictWeaponPickup", WEAPONS.RestrictWeaponPickup)
