-- slb_teleport trigger

ENT.Base = "base_entity"
ENT.Type = "brush"
ENT.AlreadyTeleported = 0

--[[---------------------------------------------------------
		Name: Initialize
-----------------------------------------------------------]]
function ENT:Initialize()	
end

--[[---------------------------------------------------------
		Name: StartTouch
-----------------------------------------------------------]]

function ENT:StartTouch( entity )
	entity:SetNetworkedBool( "propisinteleport", true )
	if entity:IsPlayer() and !entity:InVehicle() then
	-- The player isn't supposed to get here without a vehicle.. kill him! >:-D
		if !game.GetMap() == "slb_snowsled_v3" then -- DON'T PUT TRIGGERS OVER NON-RACING AREAS!
			entity:Kill()
		end
	end

	if entity:IsPlayer() and entity:InVehicle() then
		if self.AlreadyTeleported == 0 then
			self.AlreadyTeleported = self.AlreadyTeleported + 1
			timer.Simple(1, function() self.TeleportRacer(self, entity, self.AlreadyTeleported) end )
			_G["FirstPosition"] = entity:Nick()

			entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )
			entity:AddFrags(1)
			entity:SetColor(Color(0, 255, 0, 255))
			entity:EmitSound("sledbuild/race/slb_win.mp3", 150, 100)

			for k,v in pairs(player.GetAll()) do
				v:PrintMessage( HUD_PRINTTALK , "[1st] [" ..entity:Nick().. "] First!")
				v:PrintMessage( HUD_PRINTCENTER , "[1st] [" ..entity:Nick().. "] First!")
			end

		elseif self.AlreadyTeleported == 1 then

			self.AlreadyTeleported = self.AlreadyTeleported + 1

			timer.Simple(1, function() self.TeleportRacer(self, entity, self.AlreadyTeleported) end )

			_G["SecondPosition"] = entity:Nick()

			entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )

			entity:SetColor(Color(255, 255, 0, 255))
			entity:EmitSound("vo/npc/barney/ba_yell.wav", 150, 100)

			for k,v in pairs(player.GetAll()) do
				v:PrintMessage( HUD_PRINTTALK , "[2nd] [" ..entity:Nick().. "] Second!")
				v:PrintMessage( HUD_PRINTCENTER , "[2nd] [" ..entity:Nick().. "] Second!")
			end

		elseif self.AlreadyTeleported == 2 then

			self.AlreadyTeleported = self.AlreadyTeleported + 1

			timer.Simple(1, function() self.TeleportRacer( self, entity, self.AlreadyTeleported) end )

			_G["ThirdPosition"] = entity:Nick()

			entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )

			entity:SetColor(Color(255, 0, 0, 255))
			entity:EmitSound("vo/npc/barney/ba_yell.wav", 150, 100)

			for k,v in pairs(player.GetAll()) do
				v:PrintMessage( HUD_PRINTTALK , "[3rd] [" ..entity:Nick().. "] Third!")
				v:PrintMessage( HUD_PRINTCENTER , "[3rd] [" ..entity:Nick().. "] Third!")
			end

		else

			self.AlreadyTeleported = self.AlreadyTeleported + 1

			timer.Simple(1, function() self.TeleportRacer( self, entity, self.AlreadyTeleported) end )

			entity:SetCollisionGroup( COLLISION_GROUP_WEAPON )
			entity:AddDeaths(1)
			entity:SetColor(Color(255, 255, 255, 255))
			entity:EmitSound("sledbuild/race/slb_lose.mp3", 150, 100)

			for k,v in pairs(player.GetAll()) do
				v:PrintMessage( HUD_PRINTTALK , "[" ..self.AlreadyTeleported.. "th] [" ..entity:Nick().. "]") -- I'll assume there's no more than 20 racers..
			end
		end
	elseif (entity:IsValid() && (entity:GetClass()=="prop_vehicle_prisoner_pod")) then -- The sled has no player in it! (but a vehicle!)
		timer.Simple(5, function() self.TeleportEmptySled(self, entity) end ) -- Teleport back the lost sled after X seconds (has to be less than executeprop !)

	elseif entity:IsValid() then
		timer.Simple(20, function() self.executeprop( self, entity) end ) -- Kill props and players
	end
	net.Start("RaceVariables")
		net.WriteFloat(_G["HowMany"])
		net.WriteFloat(_G["lastRace"])
		net.WriteString(_G['FirstPosition'])
		net.WriteString(_G['SecondPosition'])
		net.WriteString(_G['ThirdPosition'])
	net.Broadcast()
end

function ENT:TeleportEmptySled(entity)
	if entity:GetNWBool( "propisinteleport" ) then
		self.TeleportRacer(self, entity, 0)
		for k,v in pairs(player.GetAll()) do
			v:PrintMessage( HUD_PRINTTALK , "[Sledbuild] Lost Sled Retrieved.")
		end
	end
end

function ENT:executeprop( entity )
	if entity:GetNWBool( "propisinteleport" ) then
		if entity:GetClass()=="prop_physics" then
			entity:Remove()
		elseif entity:IsPlayer() then
			entity:Kill()
		end
	end
end

function ENT:TeleportRacer( entity, finishid )

	local Destination = "Destination_1st" -- Default spawn. (incase something fails.)
	local Vehicle
	if entity:GetClass() == "prop_vehicle_prisoner_pod" then
		Vehicle = entity
	else
		Vehicle = entity:GetVehicle()
	end

	if finishid == 1 then Destination = ents.FindByName("Destination_1st")[1]:GetPos()
		elseif finishid == 2 then Destination = ents.FindByName("Destination_2nd")[1]:GetPos()
		elseif finishid == 3 then Destination = ents.FindByName("Destination_3rd")[1]:GetPos()
		else
			if game.GetMap() == "slb_snowsled_v3" then
				Destination = ents.FindByName("Destination_Lose"..math.random(1, 3))[math.random(1, 2)]:GetPos()
			else
				Destination = ents.FindByName("Destination_Lose"..math.random(1, 6))[1]:GetPos()
			end
	end

	-- Phoenixf129 Fix.
	local VehPos = Vehicle:GetPos()
	local ConstrainedEntities = constraint.GetAllConstrainedEntities( Vehicle )
	for _, ent2 in pairs( ConstrainedEntities ) do
		ent2:SetPos(Destination + (ent2:GetPos() - VehPos))
		ent2:SetCollisionGroup( COLLISION_GROUP_DEBRIS_TRIGGER )
	end
	-- End fix... that was easy. For some reason the duplicator library doesn't like being used how it used to, so this here's a workaround!
end

-- -------------------------------------------------------------------

--[[---------------------------------------------------------
		Name: EndTouch
-----------------------------------------------------------]]
function ENT:EndTouch( entity )
	entity:SetNetworkedBool( "propisinteleport", false )
end

--[[---------------------------------------------------------
		Name: Touch
-----------------------------------------------------------]]
function ENT:Touch( entity )
end

--[[---------------------------------------------------------
		Name: PassesTriggerFilters
		Desc: Return true if this object should trigger us
-----------------------------------------------------------]]
function ENT:PassesTriggerFilters( entity )
	return true
end

--[[---------------------------------------------------------
		Name: KeyValue
		Desc: Called when a keyvalue is added to us
-----------------------------------------------------------]]
function ENT:KeyValue( key, value )
end

--[[---------------------------------------------------------
		Name: Think
		Desc: Entity's think function. 
-----------------------------------------------------------]]
function ENT:Think()
end

--[[---------------------------------------------------------
		Name: OnRemove
		Desc: Called just before entity is deleted
-----------------------------------------------------------]]
function ENT:OnRemove()
end

--[[---------------------------------------------------------
		Name: AcceptInput
		Desc: Do button shite
-----------------------------------------------------------]]
function ENT:AcceptInput(name, activator, caller)
end

--[[---------------------------------------------------------
		Name: KeyValue
		Desc: Called when a keyvalue is added to us
-----------------------------------------------------------]]
function ENT:KeyValue(key, value)
end

-- Reset
function ENT:Reset()
	self.AlreadyTeleported = 0
end