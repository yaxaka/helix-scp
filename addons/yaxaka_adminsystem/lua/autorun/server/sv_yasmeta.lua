local Player = FindMetaTable("Player")

function Player:GetRole()
	return yas_LoadPlayer(self)
end