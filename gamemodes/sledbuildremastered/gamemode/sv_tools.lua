local RESTRICTED_TOOLS = {
  "balloon", "ballsocket_adv", "button",
  "dynamite", "elastic", "emitter",
  "eyeposer", "faceposer", "finger",
  "hoverball", "hydraulic", "ignite",
  "inflator", "lamp", "light",
  "magnetise", "muscle", "nail",
  "paint", "physprop", "pulley",
  "rope", "slider", "spawner",
  "statue", "thruster", "turret",
  "winch", "duplicator" -- TODO: See if duplicator show be disabled
}

-- ToolsBlacklistToolgun: Blacklist certain tools of the toolgun
function ToolsBlacklistToolgun(ply, trace, toolname)
  if (ply:IsAdmin()) then
    return true
  end

	for k, v in pairs(RESTRICTED_TOOLS) do
		if (toolname == v) then
			ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "This tool is restricted.")
			return false
		end
	end
end

hook.Add("CanTool", "SBRToolsBlacklistToolgun", ToolsBlacklistToolgun)

-- TODO: Test if this function actually does something
-- ToolsLimitToolgun: Limit what the player can affect with their toolgun
function ToolsLimitToolgun(ply, trace)
  -- TODO: Enable after testing
  -- if (ply:IsAdmin()) then
  --   return true
  -- end

  local entityClass = trace.Entity:GetClass()

  if (entityClass == "func_brush" or entityClass == "player") then
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "This entity cannot be toolgunned.")
    return false
  end
end

hook.Add("CanTool", "SBRToolsLimit", ToolsLimitToolgun)

-- ToolsLimitPhysgun: Limit what the player can affect with their physgun
function ToolsLimitPhysgun(ply, entity)
  if (entity:GetClass() == "func_brush") then
    return false
  end

  if (entity:IsPlayer()) then
    if (ply:IsAdmin()) then
      return true
    else
      return false
    end
  end
end

hook.Add("PhysgunPickup", "SBRToolsLimitPhysgun", ToolsLimitPhysgun)
