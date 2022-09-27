-- StartTouch: Called when a vehicle enters the finish zone
function ZN.END.VEHS.StartTouch(vehicle)
  if (not VEHS.HasPlayer(vehicle)) then
    -- Make their sled non-slippery
    VEHS.SetMaterial(vehicle, VEHS.MATERIALS.BUILDING)

    -- Teleport the empty sled to spawn
    local spawn = MAP.SelectRandomSpawn()
    VEHS.Teleport(vehicle, spawn:GetPos())

    -- Let the player know that their sled was teleported
    local ply = VEHS.GetCreator(vehicle)

    -- Player might have disconnected
    if (IsValid(ply)) then
      NET.SendGamemodeMessage(ply, "Your sled has been retrieved!")
    end
  end
end
