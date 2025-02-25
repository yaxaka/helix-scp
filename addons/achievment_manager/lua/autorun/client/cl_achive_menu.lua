local color_button = Color(64, 42, 44)
local color_button_outline = Color(112, 61, 87)
local color_back = Color(86, 39, 48)
local color_hover = Color(255, 0, 0, 255)
local color_text = Color(255, 255, 255, 255)
local color_header = Color(255, 255, 255, 255)
local color_back_left = Color(112, 61, 87)
local color_back_right = Color(255, 255, 255, 255)
local color_back_top = Color(255, 68, 0)
local color_back_bottom = Color(255, 255, 255, 255)
local achiv_back_color = Color(78, 78, 78)
local button_lastpos = 0
local button_lastposcenter = 0
local headerpos = 0
local headerfont = "DermaLarge"
local name_font = "Trebuchet24"
local desc_font = "Trebuchet18"
local category_font = "DermaLarge"
local achivs = nil
local achivsb = nil
local achivsc = nil

function YUIL_GetSize(text, font)
    surface.SetFont(font)
    local w, h = surface.GetTextSize(text)
    return w, h
end

function YUIL_CreateText(name, parent, font, text, posx, posy)
    name = vgui.Create("DLabel", parent)
    name:SetPos(posx, posy)
    name:SetSize(YUIL_GetSize(text, font))
    name:SetFont(font)
    name:SetText(text)
end

function YUIL_CreateHeader2(name, w, h, parent, font, text)

    local tw, th = YUIL_GetSize(text, font)
    local xx = (w/2 - tw/2)
    local yy = (th/2)

    name = vgui.Create("DLabel", parent)
    name:SetPos(xx, yy)
    name:SetSize(tw, th)
    name:SetFont(font)
    name:SetColor(color_header)
    name:SetText(text)
    button_lastposcenter = yy - 10
    parent.headerpos = yy + th + 12

end

function YUIL_ButtonCenter(name, w, h, parent, text, font, func)
    name = vgui.Create( "DButton", parent, name )
    local status = 0
    local tw, th = YUIL_GetSize(text, font)
    local xx = (w/2 - tw/2)
    local yy = (h-tw/2-8) 
    name:SetText(text)
    name:SetColor(color_white)
    name:SetFont(font)                 
    name:SetPos(xx, yy)                    
    name:SetSize(tw, th+8)                  
    name.DoClick = function()
        chat.PlaySound()
        parent:Close()              
    end

    name.Paint = function(self, w, h)
        if self:IsHovered() then
            status = math.Clamp(status + 5 * FrameTime(), 0, 1)
        else
            status = math.Clamp(status - 5 * FrameTime(), 0, 1)
        end
        surface.SetDrawColor(color_button)
        surface.DrawRect(0, 0, w, h)
        surface.SetDrawColor(color_hover)
        surface.DrawRect(0, h * .9, w, h * status )
        surface.SetDrawColor(color_button_outline)
        surface.DrawOutlinedRect( 0, 0, w, h, 1)
    end

    button_lastposcenter = yy - 10
end

function YUIL_DefaultPaint2(headerp, self, w, h, sizew, sizeh)
    surface.SetDrawColor(color_back)
    surface.DrawRect(0, 0, w, h)
    surface.SetDrawColor(color_back_top)
    surface.DrawRect(0, 1, w, headerp)
    surface.SetDrawColor(color_back_left)
    surface.DrawRect(sizew-5, headerp, w, h)
    surface.DrawRect(-sizew+5, headerp, w, h)
end

function am_request_achiv()
    net.Start("am_req")
    net.SendToServer()
end

local table_unlocked = {}

function am_unlocked(class, achiv)
    PrintTable(table_unlocked)
    local h_id = am_table[class][achiv].id
    print(h_id)
    local id = tostring(table_unlocked[class])
    print(id)
    local test1 = string.find(id, h_id)
    if test1 ~= nil then
        return true
    else
        return false
    end
end

function am_unlocked_hide(class, hid)   
    local id = tostring(table_unlocked[class])
    local test1 = string.find(id, hid)
    if test1 ~= nil then
        return true
    else
        return false
    end
end

net.Receive("am_send", function()
local ach_tbl = net.ReadTable()
PrintTable(ach_tbl)
for cf,ach_category in pairs(ach_tbl) do
    table_unlocked[ach_category.AM_Name] = ach_category.AM_Flags
end

am_mainmenu()


end)


function am_mainmenu()

    local sizew, sizeh = 500, 450
    local DermaPanel = vgui.Create("DFrame") 
    DermaPanel:SetSize(0, 0) 
    DermaPanel:SetTitle("")
    DermaPanel:ShowCloseButton(false) 
    DermaPanel:SetDraggable(false) 
    DermaPanel:MakePopup()
    local animat = true

    DermaPanel:SizeTo(sizew, sizeh, 1.8, 0, .1, function()
        animat = false
    end)


    DermaPanel.Think = function(self)
        if animat then
            self:Center()
        end
    end


    YUIL_CreateHeader2("Header", sizew, sizeh, DermaPanel, "DermaLarge", "Список достижений")
    
    local headerp = DermaPanel.headerpos


    local tbl = am_table
    

    local DScrollPanel = vgui.Create( "DScrollPanel", DermaPanel )
    local xx = (sizew/2-64)

    DScrollPanel:SetPos(0, headerp)
    DScrollPanel:SetSize(sizew, sizeh-headerp-10)
    local dp_w, dp_h = DScrollPanel:GetPos()
    local dp_ww, dp_hh = DScrollPanel:GetSize()

    local Line = vgui.Create("editablepanel", DermaPanel)
    Line:SetPos(0, headerp)
    Line:SetSize(sizew, 1)
    Line.Paint = function(self, w, h)
            surface.SetDrawColor(Color(0, 0, 0))
            surface.DrawRect(0, 0, w, h)
    end

    for category,v in pairs(tbl) do
        local category_n = am_table_tr[category].name
        local HeaderBack = vgui.Create("editablepanel", DScrollPanel)
        local tw, th = YUIL_GetSize(category_n, category_font)

        local cat = DScrollPanel:Add("DLabel", HeaderBack)
        HeaderBack:SetSize(sizew, th+10)

        cat:SetFont(category_font)
        cat:SetColor(color_header)
        cat:SetText(category_n)
        cat:SetSize(sizew, th+10)
            

        cat:Dock( TOP )
        cat:DockMargin( sizew/2-tw/2, 0, 0, 0 )

        HeaderBack:Dock(TOP)
        HeaderBack:DockMargin( 0, -5, 0, -th-10 )
        local cat_x, cat_y = cat:GetPos()

            
        HeaderBack.Paint = function(self, w, h)
            surface.SetDrawColor(am_table_tr[category]["color"])
            surface.DrawRect(0, 0, w, h)
            surface.SetDrawColor(Color(9, 9, 9))
            surface.DrawRect(0, h-2, w, h)
            surface.SetDrawColor(Color(9, 9, 9))
            surface.DrawRect(0, 0, w, 2)
        end
            

        for k,v in pairs(v) do
            if v["hide"] && not am_unlocked_hide(category, v["id"]) then else
                local Achiv_Back = vgui.Create("editablepanel", DScrollPanel)
                local img = DScrollPanel:Add("DImage", Achiv_Back)
                local achiv_check = am_unlocked(category, k)
                img:SetSize(128, 128)
                Achiv_Back:SetSize(128, 128)
                img:SetPos(headerpos, 1)
                if (achiv_check) then
                    img:SetImage(v["img"])
                else
                    img:SetImage("locked.png")
                end
                img:Dock(TOP)
                img:DockMargin( 25, 0, 328, 0 )


                Achiv_Back:Dock(TOP)
                Achiv_Back:DockMargin( 0, 0, 0, -128 )
                Achiv_Back.Paint = function(self, w, h)
                    surface.SetDrawColor(Color(60, 60, 60))
                    surface.DrawRect(0, 0, w, h)
                end

                local tw, th = YUIL_GetSize(v["name"], name_font)
                local name = DScrollPanel:Add("DLabel")
                name:SetFont(name_font)
                name:SetColor(color_header)
                name:SetSize(tw, th+15)
                name:SetText(v["name"])
                name:Dock( TOP )
                name:DockMargin( headerp+128, -105, 0, 0 )
                w, h = name:GetSize()
                name:SetWrap(true)

                local tw, th = YUIL_GetSize(v["desc"], desc_font)
                local name2 = DScrollPanel:Add("DLabel")
                name2:SetFont(desc_font)
                name2:SetColor(color_header)
                name2:SetSize(tw, th+15)
                name2:SetText(v["desc"])
                name2:Dock( TOP )
                name2:DockMargin( headerp+128, 0, 0, 45 )
                w, h = name2:GetSize()
                name2:SetWrap(true)
            end
        end
    end



    YUIL_ButtonCenter("Exit", sizew, sizeh, DermaPanel, "Выйти", "Trebuchet24")

    DermaPanel.Paint = function(self, w, h)
        YUIL_DefaultPaint2(headerp, self, w, h, sizew, sizeh)
        surface.SetDrawColor(achiv_back_color)
        surface.DrawRect(dp_w, dp_h, dp_ww, dp_hh+10)
    end

end