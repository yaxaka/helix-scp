local Player = FindMetaTable("Player")



function Player:GetRole()
	local lrole = yas_plyroles_table[self:SteamID64()]
	if lrole == nil then
		print("case1")
		local role = yas_LoadPlayer(self)
		if role == nil or false then
			return nil
		else
			return role, yas_roles[role].color
		end
	else
		return lrole, yas_roles[lrole].color
	end
end

function Player:GetFlags()
	local role = self:GetRole()
	local flags = yas_roles[role].flags
	if (flags == false) or (flags == nil) then
		return 'nil'
	else
		return flags
	end
end

function Player:SetRole(role)
	if yas_validrole(role) then
		yas_SavePlayer(self, role)
	end
	yas_refreshply(self)
end

function Player:RemoveRole()
	yas_SavePlayer(self, "User")
	yas_refreshply(self)
end

function Player:Auth(flag)
	local role = self:GetRole()
	local flags = yas_roles[role].flags

	if flags == nil then return false end
	if role == "User" then return false end

	local have_flag = string.find(flags, flag)
	local full_access = string.find(flags, "full")

	if have_flag or full_access then
		return true
	else
		return false
	end
end