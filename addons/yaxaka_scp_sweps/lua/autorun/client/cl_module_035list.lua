AddCSLuaFile()
local color_button = Color(168, 0, 0)
local color_button_outline = Color(0, 0, 0)
local color_back = Color(0, 12, 61)
local color_hover = Color(138, 60, 60)
local color_header = Color(255, 255, 255, 255)
local color_back_top = Color(36, 36, 36)
local color_back_top_line = Color(135, 128, 125)
local color_back_top_line = Color(135, 128, 125)
local color_button_pressed = Color(102, 45, 45)
local target_ply = nil
local target = nil
local w_enabled = false
local scp035_list = {nil}
scp035_main_panel = nil


local function YUI_GetSize(text, font)
    surface.SetFont(font)
    local w, h = surface.GetTextSize(text)
    return w, h
end

local function YUI_CreateText(nname, parent, font, text, posx, posy)
    local name = vgui.Create("DLabel", parent, nname)
    local tw, th = YUI_GetSize(text, font)
    name:SetName(nname)
    name:SetSize(tw, th)
    name:SetPos(posx, posy)
    name:SetFont(font)
    name:SetText(text)
end


local function YUI_CreateHeader(nname, w, h, parent, font, text)

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

local function YUI_Button(nname, x, y, parent, text, font, func, w, h)
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
        if func == "SendTask" then
            net.Start("SCP035_Task")
            net.WriteEntity(target_ply)
            net.WriteString(target)
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


local function YUI_ButtonClose(nname, x, y, parent, text, font, func, w, h)
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



local function YUI_TextEntry(nname, x, y, parent, text, w, h, func)
    local name = vgui.Create("DTextEntry", parent, nname)
    name:SetName(nname)
    name:SetSize(w, h)
    name:SetFont("DermaDefaultBold")
    name:SetPos(x, y)
    name:SetTextColor(color_black)
    name:SetPlaceholderText(text)
    name:SetPaintBackground(true)

    name.OnChange = function( self )
        if func == "SendTask" then
            target = self:GetValue()
        end
    end

    return name

end


local function YUI_DefaultPaint(headerp, self, w, h, sizew, sizeh)
    local pd = 100
    surface.SetDrawColor(color_back)
    --surface.DrawRect(0, 0, w, h)
    draw.RoundedBox( 10, 0, 0, 390, 67.27, color_back_top)
    surface.SetDrawColor(color_back_top_line)
    surface.DrawLine(10.77, 0, 10.77, 67.27)
    surface.DrawLine(378.15, 0, 378.15, 67.27)
    surface.SetDrawColor(color_back_top)
    surface.DrawRect(11.85, 67.27, 366.3, 137.73)
    surface.SetDrawColor(color_back_top_line)
    surface.DrawOutlinedRect(11.85, 67.27, 366.3, 137.73, 2)
end

function yss_module_remove035list(net_ply)
    table.RemoveByValue(scp035_list, net_ply)
    if (scp035_list[1] ~= nil) then
        scp035_main_panel:Close()
        enable_list035()
    elseif (scp035_list[1] == nil) then
        scp035_main_panel:Close()
    end
end

function yss_module_prelist(net_ply)
    if scp035_list[net_ply] then return end
    if scp035_list[1] == nil then
        table.insert(scp035_list, 1, net_ply)
    else
        table.insert(scp035_list, net_ply)
    end

    if scp035_main_panel == nil then
        enable_list035()
    else
        scp035_main_panel:Close()
        enable_list035()
    end
end


function enable_list035()
    local sizew, sizeh = 390, 205
    local DermaPanel = vgui.Create("DFrame", nil, "035_DFrame") 
    DermaPanel:SetSize(sizew, sizeh)
    DermaPanel:SetPos(20, 17) 
    DermaPanel:SetTitle("")
    DermaPanel:ShowCloseButton(false)
    DermaPanel:MakePopup()
    DermaPanel:SetMouseInputEnabled(false)
    DermaPanel:SetKeyBoardInputEnabled(false) 
    DermaPanel:SetDraggable(false)
    scp035_main_panel = DermaPanel


    DermaPanel.Paint = function(self, w, h)
        YUI_DefaultPaint(DermaPanel.headerpos, self, w, h, sizew, sizeh)
    end

    DermaPanel.Think = function(self)
        if scpgui_mouse_enabled then
            DermaPanel:SetMouseInputEnabled(true)
        else
            DermaPanel:SetMouseInputEnabled(false)
        end
    end 
    
    local toprot = vgui.Create("editablepanel", DermaPanel)
    toprot:SetPos(10.77, 1.07)
    toprot:SetSize(367.38, 66.2)

    local img_bg = vgui.Create("DImage", toprot)
    img_bg:SetSize(toprot:GetSize())        
    img_bg:SetImage("scp_rot/rot.png")


    local center_mask = vgui.Create("DImage", DermaPanel)
    center_mask:SetSize(44.17, 50.8)
    center_mask:SetPos(172.23, 10)
    center_mask:SetKeepAspect(false)        
    center_mask:SetImage("scp_rot/center035.png")

    local left_mask = vgui.Create("DImage", DermaPanel)
    left_mask:SetSize(56.17, 62.8)
    left_mask:SetPos(30.47, 6)
    left_mask:SetKeepAspect(true)        
    left_mask:SetImage("scp_rot/left035.png")

    local right_mask = vgui.Create("DImage", DermaPanel)
    right_mask:SetSize(56.17, 62.8)
    right_mask:SetPos(358.15-52.17, 6)
    right_mask:SetKeepAspect(true)        
    right_mask:SetImage("scp_rot/right035.png")


    local bottomrot = vgui.Create("editablepanel", DermaPanel)
    bottomrot:SetPos(12.93, 68.33)
    bottomrot:SetSize(364.14, 135.6)

    local img_bg2 = vgui.Create("DImage", bottomrot)
    img_bg2:SetSize(bottomrot:GetSize())        
    img_bg2:SetImage("scp_rot/rot.png")


    local DScrollPanel = vgui.Create( "DScrollPanel", DermaPanel )
    DScrollPanel:SetPos(22.62, 80.08)
    DScrollPanel:SetSize(344, 114)

    for k,v in pairs(scp035_list) do
        local buttonback = vgui.Create("editablepanel", DScrollPanel)


        local Name = DScrollPanel:Add("DButton", buttonback)
        local tw, th = YUI_GetSize(v:Nick(), "Trebuchet18")

        Name:SetText(v:Nick())
        Name:SetSize(tw, th+3)
        Name:SetFont("Trebuchet18")
        Name:SetTextColor(color_white)
        Name:Dock(TOP)
        Name:DockMargin(0, 0, 0, 10)
        Name.Pressed = false
        Name.Paint = function(self, w, h)
            if self:IsHovered() && not self.Pressed then
                draw.RoundedBox(10, 0, 0, w, h, color_hover)
            else
                draw.RoundedBox(10, 0, 0, w, h, color_button)
            end
            if self.Pressed then
                draw.RoundedBox(10, 0, 0, w, h, color_button_pressed)
            end
        end

        Name.OnDepressed = function(self)
            self.Pressed = true
            target_ply = v
        end

        Name.OnReleased = function(self)
            self.Pressed = false
            target_ply = v
            sendmsg_035ui()
        end
    end
end

local function YUI_DefaultPaint2(headerp, self, w, h, sizew, sizeh)
    local pd = 100
    surface.SetDrawColor(color_back_top)
    surface.DrawRect(0, 0, w, h)
    surface.SetDrawColor(color_back_top_line)
    surface.DrawOutlinedRect(0, 0, w, h, 2)
end


function sendmsg_035ui()
    local sizew, sizeh = 600, 140
    local SendMsgFrame = vgui.Create("DFrame") 
    SendMsgFrame:SetSize(0, 0) 
    SendMsgFrame:SetTitle("")
    SendMsgFrame:ShowCloseButton(false)

    SendMsgFrame:SetDraggable(false) 
    SendMsgFrame:MakePopup()
    local animat = true

    SendMsgFrame:SizeTo(sizew, sizeh, 1.8, 0, .1, function()
        animat = false
    end)


    SendMsgFrame.Paint = function(self, w, h)
        YUI_DefaultPaint2(SendMsgFrame.headerpos, self, w, h, sizew, sizeh)
    end

    SendMsgFrame.Think = function(self)
        if animat then
            self:Center()
        end
    end

    local rot = vgui.Create("editablepanel", SendMsgFrame)
    rot:SetPos(2, 2)
    rot:SetSize(sizew-2, sizeh-2)

    local img_bg2 = vgui.Create("DImage", rot)
    img_bg2:SetSize(rot:GetSize())        
    img_bg2:SetImage("scp_rot/rot.png")


    YUI_ButtonClose("MsgClose", sizew-50, 10, SendMsgFrame, "", "DermaDefaultBold", "Exit", 33, 20)
    YUI_CreateHeader("HeaderSend", sizew, sizeh, SendMsgFrame, "DermaLarge", "Напишите задачу")
    YUI_TextEntry("TextEntryTask", 77, 63, SendMsgFrame, "", 444, 20, "SendTask")
    YUI_Button("ButtonSend", 200, 94, SendMsgFrame, "Отправить", "Trebuchet18", "SendTask", 200, 29)
end