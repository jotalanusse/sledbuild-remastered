WPNS = {
  -- Loadouts a player can spawn with
  LOADOUTS = {
    DEFAULT = {
      ["gmod_tool"] = true,
      ["weapon_physgun"] = true,
      ["weapon_physcannon"] = true,
      ["gmod_camera"] = true,
    },
    ADMIN = {
      ["gmod_tool"] = true,
      ["weapon_physgun"] = true,
      ["weapon_physcannon"] = true,
      ["gmod_camera"] = true,
      ["weapon_crowbar"] = true,
      ["weapon_357"] = true,
      ["weapon_bugbait"] = true,
    },
  }
}

-- StripLoadout: Remove the player's loadout completely
-- function WPNS.StripLoadout(ply)
--   ply:StripAmmo()
--   ply:StripWeapons()
-- end

-- SetLoadout: Set the loadout for the player
function WPNS.SetLoadout(ply, loadout)
  -- WPNS.StripLoadout(ply)

  for k, _ in pairs(loadout) do
    ply:Give(k)
  end
end

-- Restrict: Restrict a player from picking up wepons outside of their loadout
function WPNS.Restrict(ply, weapon)
  if (ply:IsAdmin()) then
    return true
  end

  local weponsClass = weapon:GetClass()
  if (not WPNS.LOADOUTS.DEFAULT[weponsClass]) then
    -- TODO: We show no message because the default loadout contains multiple weapons

    return false
  end
end

hook.Add("PlayerCanPickupWeapon", "SBR:WPNS:Restrict", WPNS.Restrict)
