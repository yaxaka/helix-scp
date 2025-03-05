
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
end

function PLAYER:Minus035LVL()
	local lvl = self:Get035LVL()
	if lvl == nil then return
	elseif lvl >= 2 then
		self.Under035Lvl = self.Under035Lvl - 1
	else
		self:Restore035LVL()
	end	
end

function PLAYER:Get035LVL()
	return self.Under035Lvl
end

function PLAYER:Restore035LVL()
	self.Under035Lvl = 0
end

function PLAYER:Under035Control()
	return self.Under035
end

function PLAYER:Set035Control()
	self.Under035 = true
end

function PLAYER:Remove035Control()
	self.Under035 = false
end



