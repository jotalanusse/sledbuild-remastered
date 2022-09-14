SPD = {}

-- StartTracking: Start tracking the players speed
function SPD.StartTracking()

  timer.Create("SBR:SPD:UpdatePlayers", 0.5, 5, function ()
    -- We update the players and add more repetitions to the timer
    SPD.UpdatePlayers()
    timer.Adjust("SBR:SPD:UpdatePlayers", 0.5, 5)
  end)
end

-- StopTracking: Stop tracking the players speed
function SPD.StopTracking()
  timer.Remove("SBR:SPD:UpdatePlayers")
end

-- UpdatePlayers: Get all racing players and keep track of their speed
function SPD.UpdatePlayers()
  print("UPDAtiNG PLAYER SPEEDS") -- TODO: Remove

  -- We only need players of the racing team
  for _, v in (teams.GetPlayers(TEAMS.RACING)) do
    -- We only need players that are racing
    if (RND.IsPlayerRacing(v)) then
      -- If the player is not in a vehicle it doesn't count
      if (v:InVehicle()) then
        local vehicle = v:GetVehicle()
        local mph = vehicle:GetSpeed()

        -- Update the player's speed
        SPD.UpdatePlayer(v, mph)
      end
    end
  end
end

-- UpdatePLayer: Update the player's speed
function SPD.UpdatePlayer(ply, speed)
  ply:SetNWInt("SBR:Speed", speed)

  -- Update the player's top speed if necessary
  if (ply:GetNWInt("SBR:TopSpeed") < speed) then
    ply:SetNWInt("SBR:TopSpeed", speed)
  end
end