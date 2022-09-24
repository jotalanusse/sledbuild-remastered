-- StartTouch: Called when a player enters the end zone
function ZN.END.PLYS.StartTouch(ply)
  if (RND.STATE.stage == ROUND.STAGES.STARTING or RND.STATE.stage == ROUND.STAGES.RACING) then
    if (RND.IsPlayerRacing(ply)) then
      if (ply:InVehicle()) then
        -- The player finished the race!
        local round = RND.STATE.round

        RND.FinishPlayerRace(ply, round)
        local racer = round.racers[ply:SteamID()]

        local spawn = MAP.SelectRandomSpawn()
        local vehicle = ply:GetVehicle()

        if (racer.position == 1) then
          PLYS.SetColor(ply, PLYS.COLORS.FIRST)

          spawn = MAP.SelectSpecificSpawn(MAP.ENTITIES.NAMES.SPAWN_1)
        elseif (racer.position == 2) then
          PLYS.SetColor(ply, PLYS.COLORS.SECOND)

          spawn = MAP.SelectSpecificSpawn(MAP.ENTITIES.NAMES.SPAWN_2)
        elseif (racer.position == 3) then
          PLYS.SetColor(ply, PLYS.COLORS.THIRD)

          spawn = MAP.SelectSpecificSpawn(MAP.ENTITIES.NAMES.SPAWN_3)
        end

        -- Messages and that things...
        NET.BroadcastPlayerFinishedMessage(ply, racer.position, racer.time)

        RND.RemovePlayer(ply, round) -- Remove the player from the round

        -- TODO: Check if the racer is the last one to finish (maybe end race early?)

        -- Give the player 3 seconds to enjoy the end of the race
        timer.Simple(3, function()
          if (vehicle:IsValid()) then
            -- Make their sled non-slippery
            VEHS.SetMaterial(vehicle, VEHS.MATERIALS.BUILDING)

            -- Teleport the sled back to spawn
            VEHS.Teleport(vehicle, spawn:GetPos())
          end

          -- Here we should check that everything exists as we wait 3 seconds
          -- A player might disconnect
          if (ply) then
            -- Or they might die
            if (ply:Alive()) then
              -- Set the player team back to building
              PLYS.SetTeam(ply, TEAMS.BUILDING)

              -- A player might get off their sled
              if (not ply:InVehicle()) then
                NET.SendGamemodeMessage(ply, "Remember to stay in your sled!")

                -- Teleport the player back to spawn
                PLYS.Teleport(ply, spawn:GetPos())
              end
            else
              NET.SendGamemodeMessage(ply, "How are you dead? You just finished the race!")
            end
          else
            -- Bro straight up disconnected
          end
        end)
      else
        -- This code should be unreachable, players shouldn't be able to get off
        NET.SendGamemodeMessage(ply, "You can't finish a race without a sled! You shouldn't be alive.",
          COLORS.WARNING)

        RND.RemovePlayer(ply, RND.STATE.round)
        ply:Kill()
      end
    else
      -- The player might cross multiple finish lines depending on the map design
    end
  else
    -- This code should be unreachable
    NET.SendGamemodeMessage(ply, "How are you at the finish line, we are not even racing? You shouldn't be alive.",
      COLORS.WARNING)
    ply:Kill()
  end
end

-- EndTouch: Called when a player leaves the end zone
function ZN.END.PLYS.EndTouch(ply)

end
