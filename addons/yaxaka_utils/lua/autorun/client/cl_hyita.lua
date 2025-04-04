color_button = Color(21, 21, 21, 170)
color_button_outline = Color(191, 191, 191, 150)
color_button_outline_hover = Color(200, 200, 200, 140)
color_back = Color(0, 12, 61)
color_hover = Color(21, 21, 21, 221)
color_text = Color(255, 255, 255, 255)
color_btext = Color(255, 255, 255, 100)
color_btext_hover = Color(255, 255, 255, 200)
color_header = Color(255, 255, 255, 255)
local color_back_left = Color(112, 61, 87)
local color_back_right = Color(255, 255, 255, 255)
local color_back_top = Color(0, 26, 83)
local color_back_bottom = Color(255, 255, 255, 255)
local color_back_top_line = Color(1, 105, 180)
local color_droplist = Color(0, 19, 96)
local color_textentry = Color(0, 37, 184)
color_button_pressed = Color(0, 2, 94)

scp_update_table = {
    [5] = {
        version = '0.0.8',
        header = 'Жуки повсюду!',
        desc = "Фикс различных багов, прототип функций шифратора",
    },
    [4] = {
        version = '0.0.7',
        header = 'Набор юного тревожника',
        desc = "Добавлен органайзер таблов(таблетница). 3D модели в пути!",
    },
    [3] = {
        version = '0.0.6',
        header = 'UI Update',
        desc = "Изменения в UI главного меню!",
    },
	[2] = {
		version = '0.0.5',
		header = 'Weekend Summary SCP-035',
		desc = "Добавлены новые SCP, улучшена механика и оптимизация 035, улучшена совместимость с JMOD",
	},
	[1] = {
		version = '0.0.4',
		header = 'Weekend Summary #1',
		desc = "По итогам недели была завершена работа над следующими SCP: 096, 173, 131.",
	},
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
        chat.PlaySound()
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
            end
            dparent:Dim()
            parent.loadCharacterPanel:SlideUp()
        end
        if func == "Exit" then
            if (dparent.bUsingCharacter) then
                parent:Close()
            else
                RunConsoleCommand("disconnect")
            end
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
    if pomehi_error == true then return end
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
            if (v.hp <= 75) && (v.hp >= 50) then
                stage_pomehi = 1
            elseif (v.hp <= 49) && (v.hp >=30) then
                stage_pomehi = 2
            elseif (v.hp <= 29) then
                stage_pomehi = 3
            end
        end
    end

    if timer.Exists("ShifrSwitch") then return else
        timer.Create("ShifrSwitch", 5, 0, function()
            if stage_pomehi == 3 then
                pomehi_error = true
                stage_pomehi = 0
            elseif stage_pomehi == 0 then
                pomehi_error = false
                stage_pomehi = 3
            end
        end)
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
