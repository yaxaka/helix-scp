local color_button = Color(0, 4, 246)
local eye_color_button = color_button
local color_button_outline = Color(0, 0, 0)
local color_back = Color(0, 12, 61)
local color_hover = Color(68, 69, 174)
local color_text = Color(255, 255, 255, 255)
local color_header = Color(255, 255, 255, 255)
local color_back_left = Color(112, 61, 87)
local color_back_right = Color(255, 255, 255, 255)
local color_back_top = Color(0, 26, 83)
local color_back_bottom = Color(255, 255, 255, 255)
local color_back_top_line = Color(1, 105, 180)
local color_droplist = Color(0, 19, 96)
local color_textentry = Color(0, 37, 184)
local color_button_pressed = Color(0, 2, 94)
local yzc_selected_button = nil
local yzc_name = nil
local yzc_show = false
local yzc_musicurl = nil
local yzc_volume = 1
local yzc_delay = 0
local yzc_zone_selected = nil
ytool_corner_tbl = {}
local activ_tab = {}
local c_text = 0
local c_text2 = 0
local textentry_c = 0
yzc_menu_mode = "Main"
ytool_scrolltable = {}
ytool_textentry = {}




function YUI_GetSize(text, font)
    surface.SetFont(font)
    local w, h = surface.GetTextSize(text)
    return w, h
end

function YUI_CreateText(nname, parent, font, text, posx, posy)
    local name = vgui.Create("DLabel", parent, nname)
    name:SetName(nname)
    name:SetPos(posx, posy)
    name:SetSize(YUI_GetSize(text, font))
    name:SetFont(font)
    name:SetText(text)
end


function YUI_CreateHeader(nname, w, h, parent, font, text)

    local tw, th = YUI_GetSize(text, font)
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

function YUI_Button(nname, x, y, parent, text, font, func, w, h)
    local name = vgui.Create( "DButton", parent, nname )
    name:SetName(nname)
    name:SetText(text)
    name:SetColor(color_white)
    name:SetFont(font)                 
    name:SetPos(x, y)                    
    name:SetSize(w, h)
    name.Pressed = false                  
    name.DoClick = function()
        chat.PlaySound()
        if func == "DrawNewZone" then
            net.Start("REQZCT")
            net.SendToServer()
            parent:Close()
        end
        if func == "SaveNew" then
            if (yzc_name == nil) or (yzc_delay == nil) or (yzc_volume == nil) or (yzc_musicurl == nil) or (ytool_corner_tbl == nil) then else
                net.Start("ZCT_Save")
                net.WriteTable(ytool_corner_tbl)
                net.WriteString(yzc_name)
                net.WriteString(yzc_musicurl)
                net.WriteUInt(yzc_volume, 4)
                net.WriteUInt(yzc_delay, 4)
                net.SendToServer()
                parent:Close()
            end
        end
        if func == "Delete" then
            net.Start("ZCT_Delete")
            net.WriteString(yzc_name)
            net.SendToServer()
            parent:Close()
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
        	draw.RoundedBox( 13, 0, 0, w, h, color_hover)
        else
            draw.RoundedBox( 13, 0, 0, w, h, color_button)
        end
        if self.Pressed then
        	draw.RoundedBox( 13, 0, 0, w, h, color_button_pressed)
        end
        surface.SetDrawColor(color_button_outline)
        surface.DrawOutlinedRect( 0, 0, w, h, 1)
    end
end


function YUI_ButtonImage(nname, x, y, parent, img, font, func, w, h)
    local name = vgui.Create( "DImageButton", parent, nname )
    name:SetName(nname)
    name:SetImage(img)
    name:SetColor(eye_color_button)
    name:SetPos(x, y)                    
    name:SetSize(w, h)
    name:SetStretchToFit(true)
    name.Pressed = false                  
    name.DoClick = function()
        chat.PlaySound()
        if func == "ShowZone" then
            if yzc_show == false && (ytool_corner_tbl ~= nil) then
                LocalPlayer():ChatPrint("Zone draw enabled")
                yzc_show = true
            else
                LocalPlayer():ChatPrint("Zone draw disabled")
                yzc_show = false
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
        	eye_color_button = color_hover
        	name:SetColor(color_hover)
        else
            eye_color_button = color_button
            name:SetColor(color_button)
        end
        if self.Pressed then
        	eye_color_button = color_button_pressed
        	name:SetColor(color_button_pressed)
        end
    end
end


function YUI_ButtonClose(nname, x, y, parent, text, font, func, w, h)
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

function YUI_ButtonLeftW_Icon(nname, w, h, parent, icon, font, func)
    local name = vgui.Create( "DImageButton", parent, nname )
    name:SetName(nname)
    local status = 0
    local xx = (74/2+2)
    local yy = (parent.headerpos+75+button_lastpos) 
    name:SetPos(xx, yy)                    
    name:SetSize(57, 55)
    name:SetImage(icon)                  
    name.DoClick = function()
        chat.PlaySound()
        parent.ActiveTab = func
        yzc_selected_button = name           
    end

    name.Paint = function(self, w, h)
        if self:IsHovered() or name == yzc_selected_button then
            name:SetImage("zone_red.png")
        else
        	name:SetImage("zone.png")
        end
        surface.SetDrawColor(color_button)
        surface.DrawRect(0, 0, w, h)
        surface.SetDrawColor(color_hover)
        surface.DrawRect(0, h * .9, w, h * status )

    end

    button_lastpos = yy + 9
end

function YUI_DefaultPaint(headerp, self, w, h, sizew, sizeh)
	local pd = 100
    surface.SetDrawColor(color_back)
    surface.DrawRect(0, 0, w, h)
    surface.SetDrawColor(color_back_top)
    surface.DrawRect(0, 0, w, 64)
    surface.DrawRect(0, 64, 134, h)
    surface.SetDrawColor(color_back_top_line)
    surface.DrawRect(0, 64, w, 5)
    surface.SetDrawColor(0, 4, 246)
    surface.DrawRect(20, headerp+75, 94, 55)
    surface.DrawRect(20, headerp+75+pd, 94, 55)
    surface.DrawRect(20, headerp+75+pd+pd, 94, 55)
    surface.DrawRect(20, headerp+75+pd+pd+pd, 94, 55)
    surface.DrawRect(20, headerp+75+pd+pd+pd+pd, 94, 55)
    if self.ActiveTab == "Zone" then
    	yzc_selected_button:SetImage("zone_red.png")
    	surface.SetDrawColor(color_droplist)
    	surface.DrawRect(492, 82, 291, 291)
        if yzc_zone_selected then
    	   draw.RoundedBox(10, 708, 388, 58, 50, eye_color_button)
        end
    	surface.SetDrawColor(color_textentry)
    	surface.DrawRect(159, 229, 291, 23)
    	surface.DrawRect(159, 263, 291, 23)
    	surface.DrawRect(159, 295, 291, 23)
    	surface.DrawRect(159, 327, 291, 23)
    end
end


function YUI_CreateTextCorner(nname, parent, font, text, posx, posy)
	c_text = c_text + 1
    local name = vgui.Create("DLabel", parent, nname)
    name:SetName(nname)
    name:SetPos(posx, posy)
    name:SetSize(YUI_GetSize(text, font))
    name:SetFont(font)
    name:SetText(text)
    name:SetName("TAB1_Zone_Corner" .. c_text)
end

function YUI_CreateTextC(nname, parent, font, text, posx, posy)
    c_text2 = c_text2 + 1
    local name = vgui.Create("DLabel", parent, nname)
    name:SetName(nname)
    name:SetPos(posx, posy)
    name:SetFont(font)
    if text == "nil" then
        name:SetText("Unselected")
        name:SetSize(YUI_GetSize("Unselected", font))
    else
        name:SetText(text)
        name:SetSize(YUI_GetSize(text, font))
    end
    ytool_scrolltable[c_text2] = name
end

function YUI_CreateText(nname, parent, font, text, posx, posy)
    local name = vgui.Create("DLabel", parent, nname)
    name:SetName(nname)
    name:SetPos(posx, posy)
    name:SetSize(YUI_GetSize(text, font))
    name:SetFont(font)
    name:SetText(text)
end

function YUI_TextEntryTAB1(nname, x, y, parent, text, w, h, func)
    textentry_c = textentry_c + 1
    local name = vgui.Create("DTextEntry", parent, nname)
    name:SetName(nname)
    name:SetSize(w, h)
    name:SetFont("DermaDefaultBold")
    name:SetPos(x, y)
    name:SetPlaceholderText(text)
    name:SetTextColor(Color(255, 255, 255))
    name:SetPaintBackground(false)

    if func == "EnterDelay" or func == "EnterVolume" then
         name:SetNumeric(true)
    end

    name.OnChange = function( self )
        if func == "EnterName" then
            yzc_name = self:GetValue()
        elseif func == "EnterVolume" then
            yzc_volume = self:GetValue()
        elseif func == "EnterMusicUrl" then
            yzc_musicurl = self:GetValue()
        elseif func == "EnterDelay" then
            yzc_delay = self:GetValue()
        end
    end

    ytool_textentry[textentry_c] = name
end



concommand.Add("ytool", function()
    net.Start("TBLC2")
    net.SendToServer()

	button_lastpos = 0
    
	local sizew, sizeh = 800, 600
	local DermaPanel = vgui.Create("DFrame", nil, "MAIN_DFrame") 
	DermaPanel:SetSize(0, 0) 
	DermaPanel:SetTitle("")
	DermaPanel:ShowCloseButton(false) 
	DermaPanel:SetDraggable(false) 
	DermaPanel:MakePopup()
	DermaPanel.ActiveTab = yzc_menu_mode
	local animat = true

	DermaPanel:SizeTo(sizew, sizeh, 1.8, 0, .1, function()
		animat = false
	end)


	DermaPanel.Paint = function(self, w, h)
		YUI_DefaultPaint(DermaPanel.headerpos, self, w, h, sizew, sizeh)
	end

	DermaPanel.Think = function(self)
	YUI_activetab(DermaPanel, DermaPanel.ActiveTab)
		if animat then
			self:Center()
		end
	end







YUI_CreateHeader("MAIN_Header", sizew, sizeh, DermaPanel, "DermaLarge", "Yaxaka Tools")
YUI_ButtonLeftW_Icon("MAIN_Button1", sizew, sizeh, DermaPanel, "zone.png", "DermaDefaultBold", "Zone")
YUI_ButtonLeftW_Icon("MAIN_Button2", sizew, sizeh, DermaPanel, "zone.png", "DermaDefaultBold", "Main")
YUI_ButtonLeftW_Icon("MAIN_Button3", sizew, sizeh, DermaPanel, "zone.png", "DermaDefaultBold", "Main")
YUI_ButtonLeftW_Icon("MAIN_Button4", sizew, sizeh, DermaPanel, "zone.png", "DermaDefaultBold", "Main")
YUI_ButtonLeftW_Icon("MAIN_Button5", sizew, sizeh, DermaPanel, "zone.png", "DermaDefaultBold", "Main")
YUI_ButtonClose("MAIN_CloseButton", 731, 9, DermaPanel, "Close", "DermaDefault", "t", 61, 21)

YUI_Button("TAB1_Zone_Button_New", 159, 98, DermaPanel, "Draw New", "CloseCaption_Bold", "DrawNewZone", 181, 50)
YUI_CreateTextCorner("TAB1_Zone_CC1", DermaPanel, "CloseCaption_Normal", "Corner 1:", 170, 159)
YUI_CreateTextCorner("TAB1_Zone_CC2", DermaPanel, "CloseCaption_Normal", "Corner 2:", 170, 185)
YUI_CreateTextC("TAB1_Zone_C1", DermaPanel, "DermaDefault", tostring(ytool_corner_tbl["TAB1_Zone_Corner1"]), 262, 171)
YUI_CreateTextC("TAB1_Zone_C2", DermaPanel, "DermaDefault", tostring(ytool_corner_tbl["TAB1_Zone_Corner2"]), 266, 197)

YUI_TextEntryTAB1("TAB1_Zone_Entry1", 159, 229, DermaPanel, "Enter name here", 291, 23, "EnterName")
YUI_TextEntryTAB1("TAB1_Zone_Entry2", 159, 263, DermaPanel, "Music url/path here", 291, 23, "EnterMusicUrl")
YUI_TextEntryTAB1("TAB1_Zone_Entry3", 159, 295, DermaPanel, "Volume, 1 - 100%", 291, 23, "EnterVolume")
YUI_TextEntryTAB1("TAB1_Zone_Entry4", 159, 327, DermaPanel, "Delay for start in seconds", 291, 23, "EnterDelay")

YUI_Button("TAB1_Zone_Button_SaveNew", 159, 369, DermaPanel, "Save new", "CloseCaption_Bold", "SaveNew", 181, 50)
YUI_Button("TAB1_Zone_Button_Load", 492, 388, DermaPanel, "Overwrite", "CloseCaption_Bold", "SaveNew", 181, 50)
YUI_Button("TAB1_Zone_Button_Overwrite", 492, 453, DermaPanel, "Delete", "CloseCaption_Bold", "Delete", 181, 50)

YUI_ButtonImage("TAB1_Zone_Button_Show", 715, 390, DermaPanel, "eye_open.png", "CloseCaption_Bold", "ShowZone", 45, 45)
c_text = 0
c_text2 = 0
textentry_c = 0

local MainScroll = vgui.Create( "DScrollPanel", DermaPanel, "TAB1_Zone_Droplist" )
MainScroll:SetPos(492, 72)
MainScroll:SetSize(291, 291)
if (ytool_zones ~= nil) and (ytool_zones ~= false) then
    for k,v in pairs(ytool_zones) do
        local Corner1 = v.Corner1
        local Corner2 = v.Corner2  
        local Scroll_Back = vgui.Create("editablepanel", MainScroll)
        local Zone_Name = MainScroll:Add("DButton", Scroll_Back)
        Zone_Name:SetText(v.Name)
        Zone_Name:SetFont("DermaDefaultBold")
        Zone_Name:SetTextColor(Color(255, 255, 255))
        local tw, th = YUI_GetSize(v.Name, "DermaDefaultBold")
        Zone_Name:Dock(TOP)
        Zone_Name:DockMargin(1, 1, 0, -th)
        Zone_Name.Selected = false
        Zone_Name.Paint = function(self, w, h)
            if self:IsHovered() then
                surface.SetDrawColor(color_hover)
                surface.DrawRect(0, 0, w, h)
            else
                surface.SetDrawColor(0, 37, 184)
                surface.DrawRect(0, 0, w, h)
            end
            if self.Selected then
                surface.SetDrawColor(255, 0, 0)
                surface.DrawOutlinedRect( 0, 0, w, h, 2 )
            end
        end
        yzc_zone_selected = nil
        Zone_Name.OnDepressed = function(self)
            if self.Selected then
                self.Selected = false
                yzc_zone_selected = self
                ytool_scrolltable[1]:SetText("Unselected")
                ytool_scrolltable[2]:SetText("Unselected")
                ytool_textentry[1]:SetValue("")
                ytool_textentry[2]:SetValue("")
                ytool_textentry[3]:SetValue("")
                ytool_textentry[4]:SetValue("")                
            else
                if (yzc_zone_selected ~= nil) then
                    yzc_zone_selected.Selected = false
                    yzc_zone_selected = nil
                end
                self.Selected = true
                yzc_zone_selected = self
                ytool_corner_tbl["TAB1_Zone_Corner1"] = Vector(Corner1)
                ytool_scrolltable[1]:SetText(Corner1)
                ytool_corner_tbl["TAB1_Zone_Corner2"] = Vector(Corner2)
                ytool_scrolltable[2]:SetText(Corner2)

                ytool_textentry[1]:SetValue(v.Name)
                ytool_textentry[2]:SetValue(v.MusicUrl) 
                ytool_textentry[3]:SetValue(v.Volume)
                ytool_textentry[4]:SetValue(v.Delay)
                yzc_name = v.Name
                yzc_musicurl = v.MusicUrl
                yzc_volume = v.Volume
                yzc_delay = v.Delay


                local tw1, th1 = YUI_GetSize(Corner1, "HudHintTextLarge")
                local tw2, th2 = YUI_GetSize(Corner1, "HudHintTextLarge")
                ytool_scrolltable[1]:SetSize(tw1, th1)
                ytool_scrolltable[2]:SetSize(tw2, th2)
            end
        end

        Scroll_Back:Dock(TOP)
        Scroll_Back:DockMargin( 1, 0, 0, 0 )
    end
end


end)


function YUI_activetab(Panel, Activ)

local childs = Panel:GetChildren()

for _,v in ipairs(Panel:GetChildren()) do
	if Activ == "Main" then
		local find = string.find(tostring(v:GetName()), "TAB")
		if find then
			v:Hide()
		end
	end
	local find = string.find(tostring(v:GetName()), Activ )
	local find2 = string.find(tostring(v:GetName()), "MAIN" )

	if find then
		v:Show()
	elseif not (find) && not (find ~= find2) then
		v:Hide()
	end

    if yzc_zone_selected == nil then
        local findLoad = string.find(tostring(v:GetName()), "TAB1_Zone_Button_Load" )
        local findOverwrite = string.find(tostring(v:GetName()), "TAB1_Zone_Button_Overwrite" )
        local findDelete = string.find(tostring(v:GetName()), "TAB1_Zone_Button_Delete" )
        local findEye = string.find(tostring(v:GetName()), "TAB1_Zone_Button_Show" )
        if findLoad then
            v:Hide()
        end
        if findOverwrite then
            v:Hide()
        end
        if findDelete then
            v:Hide()
        end
        if findEye then
            v:Hide()
        end
    elseif yzc_zone_selected ~= nil then
        if findLoad then
            v:Show()
        end
        if findOverwrite then
            v:Show()
        end
        if findDelete then
            v:Show()
        end
        if findEye then
            v:Show()
        end
    end
end

end


hook.Add( "PostDrawTranslucentRenderables", "DrawYZone", function()
    if yzc_show then
        local center = LerpVector(0.5, ytool_corner_tbl["TAB1_Zone_Corner1"], ytool_corner_tbl["TAB1_Zone_Corner2"])
        local min = WorldToLocal(ytool_corner_tbl["TAB1_Zone_Corner1"], angle_zero, center, angle_zero)
        local max = WorldToLocal(ytool_corner_tbl["TAB1_Zone_Corner2"], angle_zero, center, angle_zero)
        render.SetColorMaterial() -- white material for easy coloring

        --cam.IgnoreZ( true ) -- makes next draw calls ignore depth and draw on top
        render.DrawWireframeBox(center, angle_zero, min, max, color)
        --cam.IgnoreZ( false ) -- disables previous call
    end

end)