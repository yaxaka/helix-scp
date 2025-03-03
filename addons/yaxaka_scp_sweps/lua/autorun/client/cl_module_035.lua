AddCSLuaFile()
local wave2 = Material("scp_rot/center035.png", "noclamp smooth alphatest 1")

local function YUI_DefaultPaint(headerp, self, w, h, sizew, sizeh)
    draw.RoundedBox(10, 0, 0, w, h, Color(36, 36, 36, 255))
    surface.SetMaterial(wave2)
    surface.SetDrawColor(color_white)
    surface.DrawTexturedRect(sizew/2-32/2, 10, 32, 32)
end

local foundedply = {}
hook.Add("Think", "SCP035_AdditionalPanels", function()
local lply = LocalPlayer()
if not (lply.scp035_additional) then return end
    for k,v in pairs(ents.FindInSphere(lply:GetPos(), 200)) do
        if (v:IsPlayer()) && (v ~= lply) && (foundedply[v] ~= true) then
            foundedply[v] = true
            local sizew, sizeh = 100, 120
            local DermaPanel = vgui.Create("DFrame") 
            DermaPanel:SetSize(sizew, sizeh)
            DermaPanel:SetPos(1, 1) 
            DermaPanel:SetTitle("")
            DermaPanel:ShowCloseButton(false)
            DermaPanel:MakePopup()
            DermaPanel:SetMouseInputEnabled(false)
            DermaPanel:SetKeyBoardInputEnabled(false) 
            DermaPanel:SetDraggable(false)

            local DComboBox = vgui.Create( "DComboBox", DermaPanel )
            DComboBox:SetPos(10, 50)
            DComboBox:SetSize(80, 20)
            DComboBox:SetValue("Действия")
            DComboBox:AddChoice("Атаковать ПСИ")
            DComboBox:AddChoice("Подмена союзника")

            local DermaButton = vgui.Create( "DButton", DermaPanel ) 
            DermaButton:SetText( "Отправить" )                 
            DermaButton:SetPos( 10, 80 )                   
            DermaButton:SetSize( 80, 20 )
            DermaButton.Pressed = false
            DermaButton.Target = v                 
            DermaButton.DoClick = function(self)
                surface.PlaySound("UI/buttonclick.wav")
                local value = DComboBox:GetValue()             
                if value == "Атаковать ПСИ" then
                    net.Start("SCP035_PsySelect")
                    net.WriteInt(1, 3)
                    net.WriteEntity(self.Target)
                    net.SendToServer()
                elseif value == "Подмена союзника" then
                    net.Start("SCP035_PsySelect") 
                    net.WriteInt(2, 3)         
                    net.WriteEntity(self.Target)
                    net.SendToServer()
                end     
            end
            DermaButton.Paint = function(self, w, h)
                if self:IsHovered() && not (self.Pressed) then
                    draw.RoundedBox(10, 0, 0, w, h, Color(138, 60, 60))
                else
                    draw.RoundedBox(10, 0, 0, w, h, Color(168, 0, 0))
                end
                if (self.Pressed) then
                    draw.RoundedBox(10, 0, 0, w, h, Color(102, 45, 45))
                end
            end
            DermaButton.OnDepressed = function(self, w, h)
                self.Pressed = true
            end
            DermaButton.OnReleased = function(self)
                self.Pressed = false
            end


            DermaPanel.Paint = function(self, w, h)
                YUI_DefaultPaint(0, self, w, h, sizew, sizeh)
            end

            DermaPanel.Think = function(self)
            if v == nil then self:Close() return end
                local vpos = v:GetPos()
                local point = vpos + v:OBBCenter()
                local data2D = point:ToScreen()
                local xx = data2D.x
                local yy = data2D.y
                local dist = vpos:Distance(lply:GetPos())
                DermaPanel:SetPos(xx-45, yy-90)

                if scpgui_mouse_enabled then
                    DermaPanel:SetMouseInputEnabled(true)
                else
                    DermaPanel:SetMouseInputEnabled(false)
                end

                if dist > 200 then
                    self:Close()
                    foundedply[v] = false
                end
                if lply.scp035_additional == false then
                    DermaPanel:Close()
                    foundedply[v] = false
                end
            end 
        end
    end
end)


local function YUI_DefaultPaint2(headerp, self, w, h, sizew, sizeh)
    surface.SetMaterial(wave2)
    surface.SetDrawColor(color_white)
    surface.DrawTexturedRect(sizew/2-32/2, sizeh/2-32/2, 32, 32)
end

local foundedply2 = {}

hook.Add("Think", "SCP035_RadiusDraws", function()
local lply = LocalPlayer()
    if not (lply.scp035_radiusdraws) then return end
    for k,v in pairs(ents.FindInSphere(lply:GetPos(), 400)) do
        print(foundedply2[v])
        if (v:IsPlayer()) && (v ~= lply) && (foundedply2[v] ~= true) then
            foundedply2[v] = true
            local sizew, sizeh = 32, 32
            local DermaPanel = vgui.Create("DFrame") 
            DermaPanel:SetSize(sizew, sizeh)
            DermaPanel:SetPos(1, 1) 
            DermaPanel:SetTitle("")
            DermaPanel:ShowCloseButton(false)
            DermaPanel:MakePopup()
            DermaPanel:SetMouseInputEnabled(false)
            DermaPanel:SetKeyBoardInputEnabled(false) 
            DermaPanel:SetDraggable(false)

            DermaPanel.Paint = function(self, w, h)
                YUI_DefaultPaint2(0, self, w, h, sizew, sizeh)
            end

            DermaPanel.Think = function(self)
                local vpos = v:GetPos()
                local point = vpos + v:OBBCenter()
                local data2D = point:ToScreen()
                local xx = data2D.x
                local yy = data2D.y
                local dist = vpos:Distance(lply:GetPos())
                DermaPanel:SetPos(xx-10, yy)

                if scpgui_mouse_enabled then
                    DermaPanel:SetMouseInputEnabled(true)
                else
                    DermaPanel:SetMouseInputEnabled(false)
                end

                if dist > 400 then
                    self:Close()
                    foundedply2[v] = false
                end
                if lply.scp035_radiusdraws == false then
                    DermaPanel:Close()
                    foundedply2[v] = false
                end
            end
        end
    end
end)