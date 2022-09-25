-- StartTouch: Called when a player enters the start zone
function ZN.STRT.PLYS.StartTouch(ply)
  -- You cant enter the start zone while the race begins
  if (GetGlobalInt("SBR:RND:Stage", 0) == ROUND.STAGES.STARTING) then
    if (RND.IsPlayerRacing(ply)) then
      if (not ply:InVehicle()) then
        NET.SendGamemodeMessage(ply, "You can't re-enter the start zone without a vehicle while the race is starting!",
          COLORS.WARNING)
        ply:Kill()
      end
    else
      NET.SendGamemodeMessage(ply, "You can't step in the start zone while the race is starting!", COLORS.WARNING)
      ply:Kill()
    end
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
  if (GetGlobalInt("SBR:RND:Stage", 0) == ROUND.STAGES.STARTING) then
    -- You cant leave the start zone without a vehicle
    if (ply:Team() == TEAMS.RACING and not ply:InVehicle()) then
      NET.SendGamemodeMessage(ply, "You can't leave the start zone without a vehicle while the race is starting!",
        COLORS.WARNING)
        
      RND.RemovePlayer(ply, RND.round)
      ply:Kill()
    end
  else
    -- The player stayed in the start zone during the race start
    if (RND.IsPlayerRacing(ply)) then
      NET.SendGamemodeMessage(ply, "You didn't leave the start zone during the race start, you were removed from the race.")

      RND.RemovePlayer(ply, RND.round)
    end

    -- If the player leaves the start zone we consider them a builder
    if (ply:Team() == TEAMS.RACING) then
      NET.SendGamemodeMessage(ply, "You are now a builder!") -- TODO: Replace for a UI element
      PLYS.SetTeam(ply, TEAMS.BUILDING)
    end
  end
end
