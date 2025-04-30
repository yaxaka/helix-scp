yr_chemtags_funcs = {
	tachycardia = {
		name = "Тахикардия",
		require = "Player",
        func = function(ply)

           	local hp = ply:Health()

            if hp <= 20 then
            	timer.Create(ply:SteamID64() .. "_yr_tahicardio2", 3, 15, function()
                	if not ply:Alive() then timer.Remove(ply:SteamID64() .. "_yr_tahicardio2") end
                    ply:SetHealth(ply:Health() - 1)
                end)
            else
                timer.Create(ply:SteamID64() .. "_yr_tahicardio2", 3, 50, function()
                    if not ply:Alive() then timer.Remove(ply:SteamID64() .. "_yr_tahicardio2") end
                    ply:SetHealth(ply:Health() - 1)
                end)
            end                    
        end,
	},
	endurance = {
		name = "Выносливость",
		require = "Player",
		func = function(ply)
			local speed = ply:GetRunSpeed()
			ply:SetRunSpeed(speed+200)
			timer.Create(ply:SteamID64() .. "_yr_endurance1", 120, 1, function()
				ply:SetRunSpeed(speed)
			end)
		end,
	},

}



util.AddNetworkString("yr_requestmix")

net.Receive("yr_requestmix", function(l, ply)
	if not ply:GetCharacter():IsScienceTeam() then return end

	local fel = net.ReadString()
	local sel = net.ReadString()
	local newname = net.ReadString()

	if yr_LoadElement(fel) == nil or yr_LoadElement(sel) == nil then return end

	yr_mix1(fel, sel, newname, ply:GetCharacter():GetName())
end)