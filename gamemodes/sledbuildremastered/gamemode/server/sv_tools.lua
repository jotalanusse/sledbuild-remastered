TLS = {
  -- Restricted tools
  RESTRICTED = {
    ["balloon"] = true,
    ["ballsocket_adv"] = true,
    ["button"] = true,
    ["dynamite"] = true,
    ["elastic"] = true,
    ["emitter"] = true,
    ["eyeposer"] = true,
    ["faceposer"] = true,
    ["finger"] = true,
    ["hoverball"] = true,
    ["hydraulic"] = true,
    ["ignite"] = true,
    ["inflator"] = true,
    ["lamp"] = true,
    ["light"] = true,
    ["magnetise"] = true,
    ["muscle"] = true,
    ["nail"] = true,
    ["paint"] = true,
    ["physprop"] = true,
    ["pulley"] = true,
    ["rope"] = true,
    ["slider"] = true,
    ["spawner"] = true,
    ["statue"] = true,
    ["thruster"] = true,
    ["turret"] = true,
    ["winch"] = true,
  }
}

-- RestrictToolgun: Restrict certain tools of the toolgun
function TLS.RestrictToolgun(ply, trace, toolName)
  if (ply:IsAdmin()) then
    return true
  end

  if (TLS.RESTRICTED[toolName]) then
    NET.SendGamemodeMessage(ply, "This tool is restricted.")

    return false
  end
end

hook.Add("CanTool", "SBR:TLS:BlacklistToolgun", TLS.RestrictToolgun)

-- LimitToolgun: Limit what the player can affect with their toolgun
function TLS.LimitToolgun(ply, trace)
  -- TODO: Make admins unable to accidentally affect world entities

  -- Don't let player affect world entities or other players
  local entityClass = trace.Entity:GetClass()
  if (entityClass == "func_brush" or entityClass == "player") then
    NET.SendGamemodeMessage(ply, "This entity cannot be toolgunned.")

    return false
  end
end

hook.Add("CanTool", "SBR:TLS:LimitToolgun", TLS.LimitToolgun)

-- LimitPhysgun: Limit what the player can affect with their physgun
function TLS.LimitPhysgun(ply, entity)
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

hook.Add("PhysgunPickup", "SBR:TLS:LimitPhysgun", TLS.LimitPhysgun)
