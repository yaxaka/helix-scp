local Player = FindMetaTable("Player")



function Player:GetRole()
	if yas_LoadPlayer(self) == nil or false then
		return yas_LoadPlayer(self)
	else
		local role = yas_LoadPlayer(self)
		for k,v in pairs(yas_roles) do
			if v.name == role then
				return role, v.color
			end
		end
	end
end