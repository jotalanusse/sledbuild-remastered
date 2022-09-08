ENT.Base = "base_entity"
ENT.Type = "brush"


function ENT:Initialize()
end


function ENT:StartTouch(entity)
end

function ENT:EndTouch(entity)
	entity:SetNetworkedBool("propisinteleport", false)
end
