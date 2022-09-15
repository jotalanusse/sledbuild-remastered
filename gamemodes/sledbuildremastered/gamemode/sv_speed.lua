SPD = {
  FREQUENCY = 0.2, -- How often the speed is updated
}

-- StartTracking: Start tracking the players speed
function SPD.StartTracking()

  timer.Create("SBR:SPD:UpdatePlayers", SPD.FREQUENCY, 5, function()
    -- We update the players and add more repetitions to the timer
    SPD.UpdatePlayers()
    timer.Adjust("SBR:SPD:UpdatePlayers", SPD.FREQUENCY, 5)
  end)
end

-- StopTracking: Stop tracking the players speed
function SPD.StopTracking()
  timer.Remove("SBR:SPD:UpdatePlayers")
end

-- UpdatePlayers: Get all racing players and keep track of their speed
function SPD.UpdatePlayers()
  -- We only need players of the racing team
  for _, v in pairs(team.GetPlayers(TEAMS.RACING)) do
    -- We only need players that are racing
    if (RND.IsPlayerRacing(v)) then
      -- If the player is not in a vehicle it doesn't count
      if (v:InVehicle()) then
        local vehicle = v:GetVehicle()
        local velocity = vehicle:GetVelocity():Length()

        -- Why the fuck does the US keep using these stupid units?
        local mph = math.Round(velocity / 17.6, 2) -- TODO: For some reason the rounding is not working

        -- Update the player's speed
        SPD.UpdatePlayer(v, mph)
      end
    end
  end
end

-- UpdatePlayer: Update the player's speed
function SPD.UpdatePlayer(ply, speed)
  ply:SetNWInt("SBR:Speed", speed)

  -- Update the player's top speed as well if necessary
  if (ply:GetNWInt("SBR:TopSpeed") < speed) then
    ply:SetNWInt("SBR:TopSpeed", speed)
  end
end
