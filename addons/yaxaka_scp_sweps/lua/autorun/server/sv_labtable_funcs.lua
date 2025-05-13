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

util.AddNetworkString("yr_bank")
util.AddNetworkString("yr_newobr")
util.AddNetworkString("yr_research")
util.AddNetworkString("Patronmanager")

net.Receive("Patronmanager", function(l, ply)
    if not ply:GetCharacter():IsScienceTeam() then return end
    if yr_bankent == nil then return end
    if ent_patronmanager == nil then return end

    local type = net.ReadInt(5)
    local type2 = net.ReadInt(5)

    if type == 1 then
        net.Start("Patronmanager")
        if type2 == 1 then
            net.WriteBool(true)
        elseif type2 == 2 then
            net.WriteBool(false)
        end

        net.WriteString(yr_bankent:GetItem())
        net.Send(ply)

        ent_patronmanager:MoveToTube(type2)

    end

    if type == 2 then
        ent_patronmanager:DownUp(0)
        ent_patronmanager:DrainAll()
        timer.Create("DelayDownupTube_" .. ent_patronmanager:EntIndex(), 2, 1, function()
            ent_patronmanager:MoveToTube(0)
        end)
    end
end)

net.Receive("yr_requestmix", function(l, ply)
	if not ply:GetCharacter():IsScienceTeam() then return end
	if yr_bankent == nil then return end

	local fel = net.ReadString()
	local sel = net.ReadString()
	local newname = net.ReadString()

	if yr_LoadElement(fel) == nil or yr_LoadElement(sel) == nil then return end
    if ent_sintezator == nil then return end

    ent_sintezator:StartWork()

	yr_mix1(fel, sel, newname, ply:GetCharacter():GetName())
end)

net.Receive("yr_bank", function(l, ply)
    if not ply:GetCharacter():IsScienceTeam() then return end
    if yr_bankent == nil then return end


    local type = net.ReadBool()

    if type == true then
        yr_bankent:SetItem("Не выбрано")
    else
        local str = net.ReadString()
        if #str >= 20 then return end
        if yr_LoadElement(str) == nil then return end

        yr_bankent:SetItem(str)
    end
end)

net.Receive("yr_newobr", function(l, ply)
    if not ply:GetCharacter():IsScienceTeam() then return end
    if yr_bankent == nil then return end

    local name = net.ReadString()
    local checkutf8 = stringname_check(name, ply)
    local len = #(name:gsub('[\128-\191]',''))

    if not checkutf8 then return end

    if len >= 10 then
        ply:Notify("Слишком длинное название")
        return
    else
        local el1 = net.ReadString()
        local el2 = net.ReadString()

        local a = yr_mix1(el1, el2, ply, name)
        if a == false then
            ply:Notify("Ошибка смешивания")
            return
        end

    end
   
end)

net.Receive("yr_research", function(l, ply)
    if not ply:GetCharacter():IsScienceTeam() then return end
    if yr_bankent == nil then return end

    local item = yr_bankent:GetItem()

    if item == "Не выбрано" then return end

    local l = yr_lapki(item)
    local l1 = 'nil'
    local l2 = 'nil'
    local l3 = 'nil'
    local parents = yr_LoadElement(item).Parents


    if type(l) == type({}) then
        if l.lapki ~= nil then
            l1 = l.lapki.lapka1.name
            l2 = l.lapki.lapka2.name
            l3 = l.lapki.lapka3.name
        else
    	   l1 = l.lapka1.name
    	   l2 = l.lapka2.name
    	   l3 = l.lapka3.name
        end

    	net.Start("yr_research")
    	net.WriteString(l1)
    	net.WriteString(l2)
    	net.WriteString(l3)
        net.WriteString(item)
        net.WriteString(parents)
    	net.Send(ply)

    end
end)