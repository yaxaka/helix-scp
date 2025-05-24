yr_chemtags_funcs = {
	tachycardia = {
		name = "Тахикардия",
        maxpower = 100,
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
        maxpower = 60,
		func = function(ply)

		end,
	},
    supressor1 = {
        name = "Поглощение 1-й категории",
        maxpower = 100,
        func = function(ply)
            --T.F
        end,
    },
    supressor2 = {
        name = "Поглощение 2-й категории",
        maxpower = 55,
        func = function(ply)
            --T.F
        end,
    },
    supressor3 = {
        name = "Поглощение 3-й категории",
        maxpower = 30,
        func = function(ply)
            --T.F
        end,
    },
    health_suppressor = {
        name = "Снижение чувствительности к боли",
        maxpower = 40,
        func = function(ply)
            --T.F
        end,
    },
    psyop1 = {
        name = "Галлюциногенные эффекты зрения",
        maxpower = 40,
        func = function(ply)
            --T.F
        end,
    },
    psyop2 = {
        name = "Галлюциногенные эффекты слуха",
        maxpower = 40,
        func = function(ply)
            --T.F
        end,
    },
    run1 = {
        name = "Увеличение скорости передвижения 1-й категории",
        maxpower = 30,
        func = function(ply)
            --T.F
        end,
    },
    run2 = {
        name = "Увеличение скорости передвижения 2-й категории",
        maxpower = 50,
        func = function(ply)
            --T.F
        end,
    },
    run3 = {
        name = "Увеличение скорости передвижения 3-й категории",
        maxpower = 70,
        func = function(ply)
            --T.F
        end,
    },    
    heal1 = {
        name = "Ускорение восстановления тканей 1-й категории",
        maxpower = 30,
        func = function(ply)
            --T.F
        end,
    },
    heal2 = {
        name = "Ускорение восстановления тканей 2-й категории",
        maxpower = 45,
        func = function(ply)
            --T.F
        end,
    },
    heal3 = {
        name = "Ускорение восстановления тканей 3-й категории",
        maxpower = 55,
        func = function(ply)
            --T.F
        end,
    },
    weak = {
        name = "Слабость мышц",
        maxpower = 60,
        func = function(ply)
            --T.F
        end,
    },
    pressurelow = {
        name = "Сниженное давление",
        maxpower = 70,
        func = function(ply)
            --T.F
        end,
    },
    pressurehigh = {
        name = "Повышенное давление",
        maxpower = 70,
        func = function(ply)
            --T.F
        end,
    },
    bloodloss1 = {
        name = "Вероятность внутреннего кровотечения",
        maxpower = 40,
        func = function(ply)
            --T.F
        end,
    },
    fallover1 = {
        name = "Вероятность потери сознания",
        maxpower = 50,
        func = function(ply)
            --T.F
        end,
    },
    rvota = {
        name = "Тошнота",
        maxpower = 70,
        func = function(ply)
            --T.F
        end,
    },
    regen_stamina = {
        name = "Восстановление запаса сил",
        maxpower = 70,
        func = function(ply)
            --T.F
        end,
    },
    night_eyes = {
        name = "Улучшенное зрение ночью",
        maxpower = 30,
        func = function(ply)
            --T.F
        end,
    },
    gold_hands = {
        name = "Улучшение концетрации",
        maxpower = 30,
        func = function(ply)
            --T.F
        end,
    },
    wet_eyes = {
        name = "Сильная секреция слёзных желез",
        maxpower = 30,
        func = function(ply)
            --T.F
        end,
    },
    paralyze = {
        name = "Паралич",
        maxpower = 10,
        func = function(ply)
            --T.F
        end,
    },
    madmax = {
        name = "Бешенство",
        maxpower = 10,
        func = function(ply)
            --T.F
        end,
    },
    muscles1 = {
        name = "Усиление мышц",
        maxpower = 40,
        func = function(ply)
            --T.F
        end,
    },
    eduboss = {
        name = "Повышенная обучаемость",
        maxpower = 15,
        func = function(ply)
            --T.F
        end,
    },
    hear1 = {
        name = "Улучшение слуха",
        maxpower = 15,
        func = function(ply)
            --T.F
        end,
    },
    nobonecrack = {
        name = "Устойчивость к переломам",
        maxpower = 10,
        func = function(ply)
            --T.F
        end,
    },
    bloodstop1 = {
        name = "Ускоренное свёртывание крови",
        maxpower = 20,
        func = function(ply)
            --T.F
        end,
    },
    nofire = {
        name = "Сниженная секреция сальных желез",
        maxpower = 20,
        func = function(ply)
            --T.F
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
--[[
net.Receive("yr_requestmix", function(l, ply)
	if not ply:GetCharacter():IsScienceTeam() then return end
	if yr_bankent == nil then return end

	local fel = net.ReadString()
	local sel = net.ReadString()
	local newname = net.ReadString()

	if yr_LoadElement(fel) == nil or yr_LoadElement(sel) == nil then return end
    if ent_sintezator == nil then return end

    if self:GetNW2Bool("InUse") == true then return end

    local timer = fel.Weight + sel.Weight * 30

    print(timer .. "/s")

    timer.Create(ply:SteamID64() .. "_mixer", 1, 1, function()
        --yr_mix1(fel, sel, newname, ply:GetCharacter():GetName())
    end)
    --ent_sintezator:StartWork()

end)--]]

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
    if ent_sintezator == nil then return end
    if ent_sintezator:GetNW2Bool("InUse") == true then return end

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

        local timer_sintez = yr_LoadElement(el1).Weight + yr_LoadElement(el2).Weight
        timer_sintez = timer_sintez * 30
    
        print(timer_sintez .. "/s")
        ent_sintezator:SetNW2Int( "Timer", timer_sintez )
        ent_sintezator:StartWork(true)
        timer.Create(ply:SteamID64() .. "_sintezatorwork1", 1, timer_sintez, function()
            local newval = ent_sintezator:GetNW2Int( "Timer" ) - 1
            ent_sintezator:SetNW2Int( "Timer", newval )
        end)
        timer.Create(ply:SteamID64() .. "_sintezatorwork2", timer_sintez, 1, function()
            ent_sintezator:SetNW2Int( "Timer", 0 )
            ent_sintezator:StartWork(false)
            --local a = yr_mix1(el1, el2, ply, name)
          --  if a == false then    
          --      ply:Notify("Ошибка смешивания")      
           --     return
           -- else
                ply:Notify("Работа синтезатора завершена")
            --end  
        end)
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