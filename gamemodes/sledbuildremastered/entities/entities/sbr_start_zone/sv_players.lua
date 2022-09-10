-- StartTouch: Called when a player enters the start zone
function ZN.STRT.PLYS.StartTouch(ply)
  -- You cant enter the start zone while the race begins
  if (RND.STATE.stage == ROUND.STAGES.STARTING) then
    -- TODO: Can you re-enter as a racer?
    NET.SendGamemodeMessage(ply, "You can't step in the start zone while the race is starting!", CONSOLE.COLORS.WARNING)
    ply:Kill()
  else
    -- If the player is in the start zone we consider them a racer
    if (ply:Team() == TEAMS.BUILDING) then
      NET.SendGamemodeMessage(ply, "You are now a racer!") -- TODO: Replace for a UI element
      PLYS.SetTeam(ply, TEAMS.RACING)
    end
  end
end

-- EndTouch: Called when a player leaves the start zone
function ZN.STRT.PLYS.EndTouch(ply)
  if (RND.STATE.stage == ROUND.STAGES.STARTING) then
    -- You cant leave the start zone without a vehicle
    if (ply:Team() == TEAMS.RACING and not ply:InVehicle()) then
      NET.SendGamemodeMessage(ply, "You can't leave the start zone without a vehicle while the race is starting!", CONSOLE.COLORS.WARNING)
      ply:Kill()
    end
  else
    -- If the player leaves the start zone we consider them a builder
    if (ply:Team() == TEAMS.RACING) then
      NET.SendGamemodeMessage(ply, "You are now a builder!") -- TODO: Replace for a UI element
      PLYS.SetTeam(ply, TEAMS.BUILDING)
    end
  end
end
