require("types/map")

-- TODO: Find a solution to this
-- JitterEntity: Jitter an entity so it's physics object is updated
function MAP.JitterEntity(entity: EntityType)
	entity:SetPos(entity:GetPos() + Vector(0.001, 0.001, 0.001))

	timer.Simple(0.001, function()
		entity:SetPos(entity:GetPos() - Vector(0.001, 0.001, 0.001))
	end)
end
