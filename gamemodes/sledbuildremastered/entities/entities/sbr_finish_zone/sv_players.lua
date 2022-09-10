-- StartTouch: Called when a player touches the end zone
function ZN.END.PLYS.StartTouch(ply)
  if (RND.IsPlayerRacing(ply)) then
    -- The player finished the race!
    local round = RND.STATE.round
    local racer = RND.STATE.round.racers[ply:SteamID()]

    -- Add the racer to the finished list
    local index = table.maxn(round.racers) + 1
    round.racers[index] = {
      ply = ply,
      maxSpeed = racer.maxSpeed,
      time = CurTime() - round.startTime,
    }

    -- Once the racer finishes we can reset their state
    RND.STATE.round.racers[ply:SteamID()] = nil -- Remove the player from the racing list
    ply:SetTeam(TEAMS.BUILDING) -- Set the player team back to building

    -- Calculate the time
    local timeTable = string.FormattedTime(round.racers[index].time)
    local formattedTime = string.format("%02i:%02i.%03i", timeTable.m, timeTable.s, timeTable.ms * 10)

    -- Messages and that things...
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "Finished #" .. index .. "! Your time is [" .. formattedTime .. "]")

    if (ply:InVehicle()) then
      -- Teleport racer back
      local spawn = MAP.SelectRandomSpawn()
      TLPT.Vehicle(ply:GetVehicle(), spawn:GetPos())
    else
      -- This code should be unreachable, players shouldn't be able to get off
      ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "How did you get off your sled? You shouldn't even be alive.")
      ply:Kill()
    end

    -- TODO: Check if the racer is the last one to finish
  else
    -- This code should be unreachable
    ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "How did you finish the race without being a racer? You shouldn't even be alive.")
    ply:Kill()
  end
end

-- EndTouch: Called when a player leaves the end zone
function ZN.END.PLYS.EndTouch(ply)

end
