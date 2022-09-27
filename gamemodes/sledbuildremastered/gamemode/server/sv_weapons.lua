WPNS = {
  -- Loadouts a player can spawn with
  LOADOUTS = {
    DEFAULT = {
      "gmod_tool",
      "weapon_physgun",
      "weapon_physcannon",
      "gmod_camera",
    },
    ADMIN = {
      "gmod_tool",
      "weapon_physgun",
      "weapon_physcannon",
      "gmod_camera",
      "weapon_crowbar",
      "weapon_357",
      "weapon_bugbait",
    },
  }
}

-- StripLoadout: Remove the player's loadout completely
function WPNS.StripLoadout(ply)
  ply:StripAmmo()
  ply:StripWeapons()
end

-- SetLoadout: Set the loadout for the player
function WPNS.SetLoadout(ply, loadout)
  WPNS.StripLoadout(ply)

  for _, v in pairs(loadout) do
    ply:Give(v)
  end
end
