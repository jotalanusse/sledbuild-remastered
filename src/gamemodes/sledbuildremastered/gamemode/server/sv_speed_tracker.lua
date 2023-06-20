SPD = {
  UPDATE_FREQUENCY = 0.2, -- How often the speed is updated
}

-- StartTracking: Start tracking the players speed
function SPD.StartTracking()

  timer.Create("SBR:SPD:UpdatePlayers", SPD.UPDATE_FREQUENCY, 0, function()
    -- Update the players
    SPD.UpdatePlayers()
  end)
end

-- StopTracking: Stop tracking the players speed
function SPD.StopTracking()
  timer.Remove("SBR:SPD:UpdatePlayers")

  -- Reset the players speed
  for _, v in pairs(player.GetAll()) do
    v:SetNWFloat("SBR:Speed", 0)
  end
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
        local mph = math.Round(velocity / 17.6, 2)

        -- Update the player's speed
        SPD.UpdatePlayer(v, mph)
      end
    else
      -- TODO: Maybe this is too resource intensive?
      -- If the player is not racing current speed is 0
      SPD.UpdatePlayer(v, 0)
    end
  end
end

-- UpdatePlayer: Update the player's speed
function SPD.UpdatePlayer(ply, speed)
  ply:SetNWInt("SBR:Speed", speed)

  -- Update the player's top speed as well if necessary
  if (speed > ply:GetNWInt("SBR:TopSpeed")) then
    ply:SetNWInt("SBR:TopSpeed", speed)
  end
end

-- ResetPlayer: Resets a player's speed
function SPD.ResetPlayer(ply)
  ply:SetNWInt("SBR:Speed", 0)
end