color_button = Color(21, 21, 21, 170)
color_button_outline = Color(191, 191, 191, 150)
color_button_outline_hover = Color(200, 200, 200, 140)
color_back = Color(0, 12, 61)
color_hover = Color(21, 21, 21, 221)
color_text = Color(255, 255, 255, 255)
color_btext = Color(255, 255, 255, 100)
color_btext_hover = Color(255, 255, 255, 200)
color_header = Color(255, 255, 255, 255)
color_headerfade = Color(255, 255, 255, 95)
local color_back_left = Color(112, 61, 87)
local color_back_right = Color(255, 255, 255, 255)
local color_back_top = Color(0, 26, 83)
local color_back_bottom = Color(255, 255, 255, 255)
local color_back_top_line = Color(1, 105, 180)
local color_droplist = Color(0, 19, 96)
local color_textentry = Color(0, 37, 184)
color_button_pressed = Color(0, 2, 94)
yui_zonepng = Material("zone_red.png", "alphatest 0 noclamp 0 smooth 1")

LocalPlayer().RadioHear = false
LocalPlayer().RadioTalk = false



scp_update_table = {
    [11] = {
        version = '0.0.1.4',
        header = 'Коммуникация',
        desc = "Добавлены рации, обновлено главное меню и прототип работы шприцов и их приготовление",
    },
    [10] = {
        version = '0.0.1.3',
        header = 'Синтезатор и админка',
        desc = "Доделан визуал и функционал синтезатора, новые функции админ панели и некоторые улучшения оптимизации",
    },
    [9] = {
        version = '0.0.1.2',
        header = 'Cleanups',
        desc = "Различные фиксы и исправления",
    },
    [8] = {
        version = '0.0.1.1',
        header = 'Научные лаборатории №1',
        desc = "Добавлен визуал терминала для учёных, банк образцов, функция синтеза химических элементов и их исследование",
    },
    [7] = {
        version = '0.0.1.0',
        header = 'Терминалы и задания',
        desc = "Добавлены новые терминалы с поддержкой нажатия в 3д пространстве, прототипы квестов",
    },
    [6] = {
        version = '0.0.0.9',
        header = 'SCP-096',
        desc = "Добавлена полноценная работа шифратора и станции его зарядки",
    },
    [5] = {
        version = '0.0.0.8',
        header = 'Жуки повсюду!',
        desc = "Фикс различных багов, прототип функций шифратора",
    },
    [4] = {
        version = '0.0.0.7',
        header = 'Набор юного тревожника',
        desc = "Добавлен органайзер таблов(таблетница). 3D модели в пути!",
    },
    [3] = {
        version = '0.0.0.6',
        header = 'UI Update',
        desc = "Изменения в UI главного меню!",
    },
	[2] = {
		version = '0.0.0.5',
		header = 'Weekend Summary SCP-035',
		desc = "Добавлены новые SCP, улучшена механика и оптимизация 035, улучшена совместимость с JMOD",
	},
	[1] = {
		version = '0.0.0.4',
		header = 'Weekend Summary #1',
		desc = "По итогам недели была завершена работа над следующими SCP: 096, 173, 131.",
	},
}

test_labatable = {
    [1] = {
        id = "idsamzmc",
        print_name = "Плоть говноеда",
        desc = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolo",
        category = "Органические материалы",
        danger = 1,
        author = "Doctor Coomer",
    }
}

test_labatable2 = {
    [1] = {
        id = "2842_ZNCB",
        desc = "Какое-то длинное описание на русском",
        category = "Органические материалы",
        danger = 1,
        desc2 = "Обнаружен в [REDACTED]",
    }
}



surface.CreateFont( "Header", {
	font = "Inter Black", -- Use the font-name which is shown to you by your operating system Font Viewer.
	extended = true,
	size = 102,
	weight = 500,
	blursize = 0,
	scanlines = 1,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = true,
} )

surface.CreateFont( "Header2", {
	font = "Inter Black", -- Use the font-name which is shown to you by your operating system Font Viewer.
	extended = true,
	size = 32,
	weight = 700,
	blursize = 0,
	scanlines = 1,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = true,
} )

surface.CreateFont( "Inter default", {
    font = "Inter", -- Use the font-name which is shown to you by your operating system Font Viewer.
    extended = true,
    size = 25,
    weight = 300,
    blursize = 0,
    scanlines = 1,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
} )

surface.CreateFont( "Community", {
	font = "Overpass Mono", -- Use the font-name which is shown to you by your operating system Font Viewer.
	extended = true,
	size = 29,
	weight = 500,
	blursize = 0,
	scanlines = 1,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = true,
} )

surface.CreateFont( "Education", {
    font = "Overpass Mono", -- Use the font-name which is shown to you by your operating system Font Viewer.
    extended = true,
    size = 32,
    weight = 600,
    blursize = 0,
    scanlines = 1,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = true,
} )

surface.CreateFont( "font1", {
    font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer.
    extended = false,
    size = 172,
    weight = 700,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
} )

surface.CreateFont( "font2", {
    font = "Consolas", -- Use the font-name which is shown to you by your operating system Font Viewer.
    extended = false,
    size = 120,
    weight = 600,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
} )

surface.CreateFont( "font_tektur", {
    font = "Tektur", -- Use the font-name which is shown to you by your operating system Font Viewer.
    extended = true,
    size = 120,
    weight = 600,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
} )

surface.CreateFont( "font_tektur_normal", {
    font = "Tektur", -- Use the font-name which is shown to you by your operating system Font Viewer.
    extended = true,
    size = 120,
    weight = 100,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
} )

surface.CreateFont( "font_tektur_dframe_title", {
    font = "Tektur", -- Use the font-name which is shown to you by your operating system Font Viewer.
    extended = true,
    size = 25,
    weight = 600,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
} )

surface.CreateFont( "font_tektur_dframe", {
    font = "Tektur", -- Use the font-name which is shown to you by your operating system Font Viewer.
    extended = true,
    size = 20,
    weight = 500,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
} )

surface.CreateFont( "font_tektur2", {
    font = "Tektur", -- Use the font-name which is shown to you by your operating system Font Viewer.
    extended = true,
    size = 160,
    weight = 650,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
} )

surface.CreateFont( "font_tektur2_big", {
    font = "Tektur", -- Use the font-name which is shown to you by your operating system Font Viewer.
    extended = false,
    size = 250,
    weight = 650,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
} )

surface.CreateFont( "font_tektur2_big2", {
    font = "Tektur", -- Use the font-name which is shown to you by your operating system Font Viewer.
    extended = false,
    size = 250,
    weight = 400,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
} )

surface.CreateFont( "font2_sub", {
    font = "Consolas", -- Use the font-name which is shown to you by your operating system Font Viewer.
    extended = false,
    size = 60,
    weight = 600,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
} )

surface.CreateFont( "font_version", {
    font = "Consolas", -- Use the font-name which is shown to you by your operating system Font Viewer.
    extended = false,
    size = 20,
    weight = 400,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
} )

surface.CreateFont( "consolas", {
    font = "Consolas", -- Use the font-name which is shown to you by your operating system Font Viewer.
    extended = false,
    size = 24,
    weight = 400,
    blursize = 0,
    scanlines = 0,
    antialias = false,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = true,
} )

surface.CreateFont( "consolas_small", {
    font = "Consolas", -- Use the font-name which is shown to you by your operating system Font Viewer.
    extended = false,
    size = 14,
    weight = 100,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
} )

surface.CreateFont( "font3", {
    font = "Arial", -- Use the font-name which is shown to you by your operating system Font Viewer.
    extended = false,
    size = 152,
    weight = 600,
    blursize = 0,
    scanlines = 0,
    antialias = true,
    underline = false,
    italic = false,
    strikeout = false,
    symbol = false,
    rotary = false,
    shadow = false,
    additive = false,
    outline = false,
} )

function Helix_YUI_GetSize(text, font)
    surface.SetFont(font)
    local w, h = surface.GetTextSize(text)
    return w, h
end

function Helix_YUI_CreateText(nname, parent, font, text, posx, posy)
    local name = parent:Add("DLabel")
    name:SetFont(font)
    name:SetText(text)
    name:SetName(nname)
    name:SetPos(posx, posy)
    name:SetSize(Helix_YUI_GetSize(text, font))
end

function Helix_YUI_CreateTextFade(nname, parent, font, text, posx, posy)
    local name = parent:Add("DLabel")
    name:SetFont(font)
    name:SetText(text)
    name:SetTextColor(Color(255, 255, 255, 95))
    name:SetName(nname)
    name:SetPos(posx, posy)
    name:SetSize(Helix_YUI_GetSize(text, font))
end

function Helix_YUI_CreateHeader(nname, w, h, parent, font, text)

    local tw, th = Helix_YUI_GetSize(text, font)
    local xx = (w/2 - tw/2)
    local yy = (th/2)

    local name = vgui.Create("DLabel", parent, nname)
    name:SetName(nname)
    name:SetPos(xx, yy)
    name:SetSize(tw, th)
    name:SetFont(font)
    name:SetColor(color_header)
    name:SetText(text)
    parent.headerpos = yy 

end

function Helix_YUI_Button(nname, x, y, dparent, text, font, func, w, h, parent, bHasCharacter)
    local name = dparent:Add("DButton")
    name:SetName(nname)
    name:SetText(text)
    name:SetColor(color_btext)
    name:SetFont(font)                 
    name:SetPos(x, y)                    
    name:SetSize(w, h)
    name.Pressed = false                  
    name.DoClick = function(self)
        yas_bclick()
        if func == "Create" then
            local maximum = hook.Run("GetMaxPlayerCharacter", LocalPlayer()) or ix.config.Get("maxCharacters", 5)
            -- don't allow creation if we've hit the character limit
            if (#ix.characters >= maximum) then
                dparent:GetParent():ShowNotice(3, L("maxCharacters"))
                return
            end

            dparent:Dim()
            parent.newCharacterPanel:SetActiveSubpanel("faction", 0)
            parent.newCharacterPanel:SlideUp()
        end
        if func == "Load" then      
            if (!bHasCharacter) then
                self:SetDisabled(true)
            else
                dparent:Dim()
                parent.loadCharacterPanel:SlideUp()
            end
        end
        if func == "Exit" then
            if (dparent.bUsingCharacter) then
                parent:Close()
            else
                RunConsoleCommand("disconnect")
            end
        end
        if func == "Edu1" then
            dparent:Close()
            drawedu2()
        end    
        if func == "Edu2" then
            dparent:Close()
        end
    end
    name.OnDepressed = function(s)
    	s.Pressed = true
	end
	name.OnReleased = function(s)
		s.Pressed = false
	end

    name.Paint = function(self, w, h)
        if self:IsHovered() then
        	self:SetColor(color_btext_hover)
        	surface.SetDrawColor(color_hover)
        	surface.DrawRect(0, 0, w, h)
        	surface.SetDrawColor(color_button_outline_hover)
        	surface.DrawOutlinedRect(0, 0, w, h, 1)
        else
        	self:SetColor(color_btext)
        	surface.SetDrawColor(color_button)
        	surface.DrawRect(0, 0, w, h)
            --surface.SetDrawColor(color_button_outline)
        	--surface.DrawOutlinedRect(0, 0, w, h, 1)
        end
        if self.Pressed then
        	surface.SetDrawColor(Color(50, 50, 50, 150))
        	surface.DrawRect(0, 0, w, h)
        end
    end
    return name
end

function Helix_YUI_ButtonE(nname, x, y, dparent, text, font, func, w, h, parent, bHasCharacter)
    local name = dparent.characterList:Add("DButton")
    name:SetName(nname)
    name:SetText(text)
    name:SetColor(color_btext)
    name:SetFont(font)                 
    name:SetPos(x, y)                    
    name:SetSize(w, h)
    name.Pressed = false                  
    name.DoClick = function()
        chat.PlaySound() 
    end
    name.OnDepressed = function(s)
        s.Pressed = true
    end
    name.OnReleased = function(s)
        s.Pressed = false
    end

    name.Paint = function(self, w, h)
        if self:IsHovered() then
            self:SetColor(color_btext_hover)
            surface.SetDrawColor(color_hover)
            surface.DrawRect(0, 0, w, h)
            surface.SetDrawColor(color_button_outline_hover)
            surface.DrawOutlinedRect(0, 0, w, h, 1)
        else
            self:SetColor(color_btext)
            surface.SetDrawColor(color_button)
            surface.DrawRect(0, 0, w, h)
            surface.SetDrawColor(color_button_outline)
            surface.DrawOutlinedRect(0, 0, w, h, 1)
        end
        if self.Pressed then
            surface.SetDrawColor(Color(50, 50, 50, 150))
            surface.DrawRect(0, 0, w, h)
        end
    end
end

function Helix_YUI_ButtonCommunity(nname, x, y, parent, img, font, func, w, h)
    local name = parent:Add("DButton")
    name:SetName(nname)
    name:SetText("")
    name:SetColor(color_white)
    name:SetFont(font)                 
    name:SetPos(x, y)                    
    name:SetSize(w, h)
    name.Pressed = false
    name.png = nil
    name.text = nil

    if img == "Discord" then
    	name.png = Material("buttons/discord.png", "smooth")
    	name.text = "Discord"
    end
    if img == "Steam" then
    	name.png = Material("buttons/steam.png", "smooth")
    	name.text = "Steam"
    end
    if img == "Rules" then
    	name.png = Material("buttons/rules.png", "smooth")
    	name.text = "Правила"
    end

    local tw, th = Helix_YUI_GetSize(name.text, font)

    name.DoClick = function()
        chat.PlaySound()    
    end
    name.OnDepressed = function(s)
    	s.Pressed = true
	end
	name.OnReleased = function(s)
		s.Pressed = false
	end

    name.Paint = function(self, w, h)
        if self:IsHovered() then
        	surface.SetDrawColor(color_hover)
        	surface.DrawRect(0, 0, w, h)
        	surface.SetDrawColor(color_button_outline_hover)
        	surface.DrawOutlinedRect(0, 0, w, h, 1)

        	surface.SetFont("Community")
        	surface.SetTextColor(color_btext_hover)
        	surface.SetTextPos(52, h/2-th/2)
        	surface.DrawText(self.text)

        	surface.SetDrawColor(Color(200, 200, 200, 255))
        	surface.SetMaterial(self.png)
			surface.DrawTexturedRect(10, h/2-32/2, 32, 32)
        else
        	surface.SetDrawColor(color_button)
            surface.DrawRect(0, 0, w, h)

            surface.SetFont("Community")
            surface.SetTextColor(color_btext)
            surface.SetTextPos(52, h/2-th/2)
            surface.DrawText(self.text)

            surface.SetDrawColor(Color(255, 255, 255, 255))
        	surface.SetMaterial(self.png)
			surface.DrawTexturedRect(10, h/2-32/2, 32, 32)
        end
        if self.Pressed then
        	surface.SetDrawColor(color_white)
        	surface.SetMaterial(self.png)
        	surface.DrawTexturedRect(10, h/2-32/2, 32, 32)
        end
    end

    return name
end


function Helix_YUI_ButtonImage(nname, x, y, parent, img, font, func, w, h)
    local name = vgui.Create( "DImageButton", parent, nname )
    name:SetName(nname)
    name:SetImage(img)
    name:SetColor(color_white)
    name:SetPos(x, y)                    
    name:SetSize(w, h)
    name:SetStretchToFit(true)
    name.Pressed = false                  
    name.DoClick = function()
        chat.PlaySound()          
    end
    name.OnDepressed = function(s)
    	s.Pressed = true
	end
	name.OnReleased = function(s)
		s.Pressed = false
	end

    name.Paint = function(self, w, h)
        if self:IsHovered() then
        	name:SetColor(color_white)
        else
            name:SetColor(color_button)
        end
        if self.Pressed then
        	name:SetColor(color_button_pressed)
        end
    end
    return name
end


function Helix_YUI_ButtonClose(nname, x, y, parent, text, font, func, w, h)
    local name = vgui.Create( "DButton", parent, nname )
    name:SetName(nname)
    name:SetText(text)
    name:SetColor(color_white)
    name:SetFont(font)                 
    name:SetPos(x, y)                    
    name:SetSize(w, h)                  
    name.DoClick = function()
        chat.PlaySound()
        parent:Close()
    end

    name.Paint = function(self, w, h)
        if self:IsHovered() then
        	draw.RoundedBox( 13, 0, 0, w, h, color_hover)
        else
            draw.RoundedBox( 13, 0, 0, w, h, Color(255, 0, 0))
        end
        surface.SetDrawColor(color_button_outline)
        surface.DrawOutlinedRect( 0, 0, w, h, 1)
    end
end


local stage_pomehi = 0

net.Receive("Shifrator", function(l, ply)
    local b = net.ReadBool()
    print(b)
    if b == true then
        LocalPlayer().Shifrator = true
        shifrator_pomehi()
    elseif b == false then
        if timer.Exists("ShifrPomehi") then timer.Remove("ShifrPomehi") end
        if timer.Exists("ShifrSwitch") then timer.Remove("ShifrSwitch") end
        if timer.Exists("ChpControl") then timer.Remove("ShifrSwitch") end
        stage_pomehi = 0
        LocalPlayer().Shifrator = false
    end
end)


hook.Add("PostDrawTranslucentRenderables", "Shifrator", function()
    if (LocalPlayer().Shifrator == false) or (LocalPlayer().Shifrator == nil) then return end
    local postodraw = nil
    for k,v in pairs(player.GetAll()) do
        local mdl = v:GetModel()
        if mdl == "models/washton/scp096/scp096unity.mdl" then
            local boneid = v:LookupBone( "ValveBiped.Bip01_Head1" )
            local bonepos = v:GetBonePosition(boneid) 
            postodraw = bonepos + Vector(3, 0, 2)
        end
    end
    render.SetColorMaterial()

    local pos = LocalPlayer():GetEyeTrace().HitPos

    if postodraw == nil then return end
    render.DrawSphere( postodraw, 7, 30, 30, Color( 0, 0, 0, 255 ) )

end)


function shifrator_pomehi()
    local tbl = LocalPlayer():GetCharacter():GetInventory():GetItems(true)

    for k,v in pairs(tbl) do
        if v.name == "Шифратор" && v.data.equip == true && LocalPlayer().Shifrator == true then
            if (v.hp > 50) && (v.hp < 75) then
                stage_pomehi = 1
            elseif (v.hp > 30) && (v.hp < 49) then
                stage_pomehi = 2
            elseif (v.hp < 29) then
                stage_pomehi = 3
            end
        end
    end
end


hook.Add("HUDPaint", "ShifrPomehi", function()
    if stage_pomehi == 0 then return end
    if LocalPlayer().Shifrator == false then return end
    if stage_pomehi == 1 then
        for i=1,10 do
            surface.SetDrawColor(0, 0, 0)
            surface.DrawRect(math.random(1, ScrW()), math.random(1, ScrH()), math.random(1, 10), math.random(1,10))
        end
    end

    if stage_pomehi == 2 then
        for i=1,20 do
            surface.SetDrawColor(Color(math.random(0, 20), math.random(0, 20), math.random(0, 20)))
            surface.DrawRect(math.random(1, ScrW()), math.random(1, ScrH()), math.random(1, 40), math.random(1,40))
        end
    end

    if stage_pomehi == 3 then
        for i=1,30 do
            surface.SetDrawColor(Color(math.random(0, 50), math.random(0, 50), math.random(0, 50)))
            surface.DrawRect(math.random(1, ScrW()), math.random(1, ScrH()), math.random(1, 100), math.random(1,100))
        end
    end

end)


function yui_calc1(animval_x, new_width, targetx, defx, defw, speed1)
    local reached_x = targetx
    local speed = speed1 or 1

    if reached_x > animval_x && new_width == defw then
        animval_x = animval_x + speed
    end

    if animval_x >= reached_x && new_width > 0 then
        animval_x = animval_x + speed
        new_width = new_width - speed
    elseif animval_x == defx && new_width < defw then
        new_width = new_width + speed
    end

    if new_width == 0 then
        animval_x = defx
    end

    return animval_x, new_width
end

function yui_calc2(animval_x, new_width, targetx, defx, defw, speed1)
    local reached_x = targetx
    local speed = speed1 or 1

    if reached_x > animval_x && new_width == defw then
        animval_x = animval_x + speed
    end

    if animval_x >= reached_x && new_width > 0 then
        animval_x = animval_x + speed
        new_width = new_width - speed
    elseif animval_x == defx && new_width < defw then
        new_width = new_width + speed
    end

    if new_width == 0 then
        animval_x = defx
    end

    return animval_x, new_width
end

local function charWrap(text, remainingWidth, maxWidth)
    local totalWidth = 0

    text = text:gsub(".", function(char)
        totalWidth = totalWidth + surface.GetTextSize(char)

        -- Wrap around when the max width is reached
        if totalWidth >= remainingWidth then
            -- totalWidth needs to include the character width because it's inserted in a new line
            totalWidth = surface.GetTextSize(char)
            remainingWidth = maxWidth
            return "\n" .. char
        end

        return char
    end)

    return text, totalWidth
end


function yui_darkrpwarp(text, font, maxWidth)
    local totalWidth = 0

    surface.SetFont(font)

    local spaceWidth = surface.GetTextSize(' ')
    text = text:gsub("(%s?[%S]+)", function(word)
            local char = string.sub(word, 1, 1)
            if char == "\n" or char == "\t" then
                totalWidth = 0
            end

            local wordlen = surface.GetTextSize(word)
            totalWidth = totalWidth + wordlen

            -- Wrap around when the max width is reached
            if wordlen >= maxWidth then -- Split the word if the word is too big
                local splitWord, splitPoint = charWrap(word, maxWidth - (totalWidth - wordlen), maxWidth)
                totalWidth = splitPoint
                return splitWord
            elseif totalWidth < maxWidth then
                return word
            end

            -- Split before the word
            if char == ' ' then
                totalWidth = wordlen - spaceWidth
                return '\n' .. string.sub(word, 2)
            end

            totalWidth = wordlen
            return '\n' .. word
        end)

    return text
end

function yui_surfacetext(text, font, x, y, clr)
    surface.SetFont(font)
    local w, h = surface.GetTextSize(text)
    surface.SetDrawColor(clr)
    surface.SetTextPos(x-w/2, y-h/2)
    surface.DrawText(text)
end

function yui_surfacepng(png, x, y, w, h, clr, clr_hover)
    surface.SetMaterial(png)
    surface.SetDrawColor(clr or color_white)
    surface.DrawTexturedRect(x, y, w, h)
end

local PANEL_YUIBUTTON = {}



function PANEL_YUIBUTTON:Init()
    self:SetText("")
end

function PANEL_YUIBUTTON:DoClick()
    yas_bclick()
    self.func()
end

function PANEL_YUIBUTTON:Paint( aWide, aTall )
    if self.Image ~= nil then
        surface.SetMaterial(self.Image)
        if self:IsHovered() then
            surface.SetDrawColor(color_white)
            surface.DrawTexturedRect(5, aTall/2-self.ISizeH/2, self.ISizeW, self.ISizeH)
        else
            surface.SetDrawColor(Color(0, 0, 0))
            surface.DrawTexturedRect(5, aTall/2-self.ISizeH/2, self.ISizeW, self.ISizeH)
        end         
    end

    local tw, th = Helix_YUI_GetSize(self.text, "Baumans")

    if self.text ~= nil then
        surface.SetFont("Baumans")
        if self:IsHovered() then
            surface.SetTextColor(color_white)
        else
            surface.SetTextColor(0, 0, 0)
        end
        surface.SetTextPos(self.ISizeW+10, aTall/2-th/2)
        surface.DrawText(self.text)
    end
end


vgui.Register( "YUIButton", PANEL_YUIBUTTON, "DButton" )



























hook.Add("CanDrawAmmoHUD", "DisableIt", function()
    return false
end)

hook.Add( "PlayerSwitchWeapon", "Raise", function( ply, old, wep )
    local arccw = string.find(wep:GetClass(), "arccw")
    local scp = string.find(wep:GetClass(), "scp")
    print(wep)
    if arccw or scp then
        timer.Create("wepeq1", 0.1, 1, function()
            RunConsoleCommand("say", "/ToggleRaise")
        end)
    end
end )