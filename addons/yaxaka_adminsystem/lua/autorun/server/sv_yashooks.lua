hook.Add("PostGamemodeLoaded", "InitYAS", function()
	yas_CreateTable()
end)

local load_queue = {}

hook.Add("PlayerInitialSpawn", "Yas_Role", function(ply)
	if yas_LoadPlayer(ply) == nil or false then
		yas_SavePlayer(ply, "User")
	end
end)

