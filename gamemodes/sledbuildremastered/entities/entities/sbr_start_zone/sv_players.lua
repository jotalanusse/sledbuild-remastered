-- TODO: Might need to rename because of global function
-- PlayerStartZoneStartTouch: Called when a player touches the start zone
function PlayerStartZoneStartTouch(ply)
  -- You cant enter the start zone while the race begins
  if (STATE.state == ROUND_STATES.STARTING) then
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "You can't enter the start zone while the race is starting!")
    ply:Kill()
  else
    -- If the player is in the start zone we consider them a player
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "You are now a racer!")
    ply:SetTeam(TEAMS.RACING)
  end
end

-- PlayerStartZoneEndTouch: Called when a player leaves the start zone
function PlayerStartZoneEndTouch(ply)
  if (STATE.state == ROUND_STATES.STARTING) then
    -- You cant leave the start zone without a vehicle
    if (not ply:InVehicle()) then
      ply:PrintMessage(HUD_PRINTTALK,
        CONSOLE_PREFIX .. "You can't leave the start zone without a vehicle while the race is starting!")
      ply:Kill()
    end
  else
    -- If the player leaves the start zone we consider them a builder
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "You are now a builder!")
    ply:SetTeam(TEAMS.BUILDING)
  end
end
