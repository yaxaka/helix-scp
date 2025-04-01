local PLAYER = FindMetaTable("Player")


function PLAYER:SetupSCP(value)
	self:SetModel(value.model)
	self:StripWeapons()
	self:Give(value.weapon)
	self:ToggleWepRaised()
	self:SetWalkSpeed(value.walkspeed)
	self:SetSlowWalkSpeed(value.slowwalkspeed)
	self:SetRunSpeed(value.runspeed)
	self:SetFriction(value.friction)
	local customfunc = value.customfunction
	if customfunc ~= nil then
		value.customfunction(self)
	end
end

function PLAYER:SetSCP(value)
	if value == nil then ymsg_e("Incorrect SCP table value!") return end
	self.SCPName = value
	self.SCP = true
	self:SetupSCP(value)
end

function PLAYER:GetSCP()
	return self.SCPName
end

function PLAYER:RemoveSCP()
	self.SCPName = nil
	self.SCP = false
end


