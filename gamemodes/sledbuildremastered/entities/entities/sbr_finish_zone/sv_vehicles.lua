-- StartTouch: Called when a vehicle enters the finish zone
function ZN.END.VEHS.StartTouch(vehicle)
  if (not VEHS.HasPlayer(vehicle)) then
    local spawn = MAP.SelectRandomSpawn()
    VEHS.Teleport(vehicle, spawn:GetPos())
  end
end
