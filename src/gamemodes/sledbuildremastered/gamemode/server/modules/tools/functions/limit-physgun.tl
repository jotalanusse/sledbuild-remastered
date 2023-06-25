require("server/modules/tools/types/tools")

-- LimitPhysgun: Limit what the player can affect with their physgun
function TOOLS.LimitPhysgun(ply: PlayerType, entity: EntityType): boolean
  -- TODO: Check what this really is
  -- Probably a world entity (even admins shouldn't modify this)
  if (entity:GetClass() == "func_brush") then
    return false
  end

  if (entity:IsPlayer()) then
    -- Only admins may pick up players
    if (ply:IsAdmin()) then
      return true
    end

    return false
  end
end
