ENT.Base = "base_entity"
ENT.Type = "brush"

include("sv_players.lua")
include("sv_props.lua")
include("sv_vehicles.lua")

-- Initialize: Called when the entity is created
function ENT:Initialize() end

-- StartTouch: Called when an entity enters the trigger
function ENT:StartTouch(entity)
  -- Check if the player is alive, no dead winners :)
  if (entity:IsPlayer() and entity:Alive()) then
    ZN.END.PLYS.StartTouch(entity)
  elseif (entity:IsValid()) then
    -- TODO: If different entities touch the teleport the vehicle will be teleport n amount of times
    -- find a way to fix this.

    local isSled = VEHS.IsSled(entity)
    if (isSled) then
      ZN.END.VEHS.StartTouch(entity)
    else
      ZN.END.PRPS.StartTouch(entity)
    end
  end
end

-- EndTouch: Called when an entity leaves the trigger
function ENT:EndTouch(entity)
  -- We also check if the player is alive to avoid useless messages (maybe?)
  if (entity:IsPlayer() and entity:Alive()) then
    ZN.END.PLYS.EndTouch(entity)
  end
end
