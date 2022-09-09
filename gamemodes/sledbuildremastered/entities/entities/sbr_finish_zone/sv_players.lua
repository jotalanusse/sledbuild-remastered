-- StartTouch: Called when a player touches the end zone
function ZN.END.PLYS.StartTouch(ply)
  if (RND.IsPlayerRacing(ply)) then
    -- Update the state for our racer
    local racer = RND.STATE.round.racers[ply:SteamID()]

    -- Update the racer state
    racer.finished = true
    racer.time = CurTime() - RND.STATE.round.startTime

    -- Calculate the time
    local timeTable = string.FormattedTime(racer.time)
    local formattedTime = string.format("%02i:%02i.%03i", timeTable.m, timeTable.s, timeTable.ms * 10)

    ply:PrintMessage(HUD_PRINTTALK, CONSOLE_PREFIX .. "Finished! Your time is " .. formattedTime)
  else
    -- This code should be unreachable
  end
end

-- EndTouch: Called when a player leaves the end zone
function ZN.END.PLYS.EndTouch(ply)

end
