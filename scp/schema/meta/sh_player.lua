
local PLAYER = FindMetaTable("Player")

function PLAYER:IsPolice()
	return self:Team() == FACTION_POLICE
end

function PLAYER:Add035LVL()
	if self:Get035LVL() == nil then
		self.Under035Lvl = 1
	else
		self.Under035Lvl = self.Under035Lvl + 1
	end
	net.Start("SCP035Change")
	net.WriteInt(self.Under035Lvl, 5)
	net.WriteBool(true)
	net.Send(self)
end

function PLAYER:Minus035LVL()
	local lvl = self:Get035LVL()
	if lvl == nil then return
	elseif lvl >= 2 then
		self.Under035Lvl = self.Under035Lvl - 1
		net.Start("SCP035Change")
		net.WriteInt(self.Under035Lvl, 5)
		net.WriteBool(true)
		net.Send(self)	
	else
		self:Restore035LVL()
	end
end

function PLAYER:Get035LVL()
	return self.Under035Lvl
end

function PLAYER:Restore035LVL()
	self.Under035Lvl = 0
	net.Start("SCP035Change")
	net.WriteInt(self.Under035Lvl, 5)
	net.WriteBool(false)
	net.Send(self)
end

function PLAYER:Under035Control()
	return self.Under035
end

function PLAYER:Set035Control()
	self.Under035 = true
	net.Start("SCP035Change")
	net.WriteInt(self:Get035LVL(), 5)
	net.WriteBool(true)
	net.Send(self)
end

function PLAYER:Remove035Control()
	self.Under035 = false
	net.Start("SCP035Change")
	net.WriteInt(0, 5)
	net.WriteBool(false)
	net.Send(self)
end

function PLAYER:RotMaterial(Phase, Type, all)
	local phase_texture = nil
	if Phase == 1 then
		phase_texture = "scp_rot/frame8_1"
	elseif Phase == 2 then
		phase_texture = "scp_rot/frame8_2"
	elseif Phase == 3 then
		phase_texture = "scp_rot/frame8_3"
	end

	if (Phase == nil) or (Type == nil) then return end

	if (all == false) then
		for k,v in pairs(self:GetMaterials()) do
			local find = string.find(v, Type)
			if find then
				self:SetSubMaterial(k, phase_texture)
			end
		end
	else
		for k,v in pairs(self:GetMaterials()) do
			self:SetSubMaterial(k, phase_texture)
		end
	end
end

function PLAYER:ResetMaterials()
	for k,v in pairs(self:GetMaterials()) do
		self:SetSubMaterial(k, "")
	end
	self:SetMaterial("")
end


function PLAYER:StartBodyRot035()
	local timername = self:Nick() .. "_rotting1"
	local timername2 = self:Nick() .. "_rotting2"
	local timername3 = self:Nick() .. "_rotting3"
	timer.Create(timername, ix.config.Get("RotPhase1"), 1, function()
		if not IsValid(self) then return end
		self:RotMaterial(1, "head", false)
		self:RotMaterial(1, "eye", false)
		self:RotMaterial(1, "upper", false)
		self:TakeDamage(10, nil)
		self:EmitSound("sopli.wav")
		timer.Create(timername2, ix.config.Get("RotPhase2"), 1, function()
			if not IsValid(self) then return end
			self:RotMaterial(2, "head", true)
			self:SetMaterial("scp_rot/frame8_2")
			self:TakeDamage(10, nil)
			self:EmitSound("sopli.wav")
			timer.Create(timername3, ix.config.Get("RotPhase3"), 1, function()
				if not IsValid(self) then return end
				self:EmitSound("sopli.wav")
				self:RotMaterial(3, "head", true)
				self:SetMaterial("scp_rot/frame8_3")
				self:TakeDamage(10, nil)
			end)
		end)
	end)
end

function PLAYER:ResetBodyRot035()
	local timername = self:Nick() .. "_rotting1"
	local timername2 = self:Nick() .. "_rotting2"
	local timername3 = self:Nick() .. "_rotting3"
	if timer.Exists(timername) then timer.Remove(timername) end
	if timer.Exists(timername2) then timer.Remove(timername2) end
	if timer.Exists(timername3) then timer.Remove(timername3) end
end