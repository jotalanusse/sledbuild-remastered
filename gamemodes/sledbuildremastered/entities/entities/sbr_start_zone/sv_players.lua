-- TODO: Might need to rename because of global function
-- PlayerStartZoneStartTouch: Called when a player touches the start zone
function PlayerStartZoneStartTouch(ply)
  -- You cant enter the start zone while the race begins
  if (RND.STATE.stage == ROUND_STAGES.STARTING) then
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "You can't enter the start zone while the race is starting!")
    ply:Kill()
  else
    -- If the player is in the start zone we consider them a racer
    if (ply:Team() == TEAMS.BUILDING) then
      ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "You are now a racer!") -- TODO: Replace for a UI element
      ply:SetTeam(TEAMS.RACING)
    end
  end
end

-- PlayerStartZoneEndTouch: Called when a player leaves the start zone
function PlayerStartZoneEndTouch(ply)
  if (RND.STATE.stage == ROUND_STAGES.STARTING) then
    -- You cant leave the start zone without a vehicle
    if (ply:Team() == TEAMS.RACING and not ply:InVehicle()) then
      ply:PrintMessage(HUD_PRINTTALK,
        CONSOLE_PREFIX .. "You can't leave the start zone without a vehicle while the race is starting!")
      ply:Kill()
    end
  else
    -- If the player leaves the start zone we consider them a builder
    if (ply:Team() == TEAMS.RACING) then
      ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "You are now a builder!") -- TODO: Replace for a UI element
      ply:SetTeam(TEAMS.BUILDING)
    end
  end
end
