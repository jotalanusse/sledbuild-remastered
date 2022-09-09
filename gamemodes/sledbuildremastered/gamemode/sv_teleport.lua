TLPT = {}

-- Vehicle: Teleport a vehicle to the target
function TLPT.Vehicle(vehicle, destination)
	local constrainedEntities = constraint.GetAllConstrainedEntities(vehicle)

	for k, v in pairs(constrainedEntities) do
		if v and v:IsValid() then
			v:GetPhysicsObject():SetVelocityInstantaneous(Vector(0, 0, 0))
			v:SetCollisionGroup(VEHS.DEFAULT_COLLISION_GROUP)
			v:SetPos(destination) -- TODO: Teleport props to their relative destination
			v:GetPhysicsObject():SetVelocityInstantaneous(Vector(0, 0, 0))
		end
	end
end
