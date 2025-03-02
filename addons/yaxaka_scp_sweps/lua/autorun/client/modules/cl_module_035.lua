local wave2 = Material("scp_rot/center035.png", "noclamp smooth alphatest 1")

local function YUI_DefaultPaint(headerp, self, w, h, sizew, sizeh)
    draw.RoundedBox(10, 0, 0, w, h, Color(36, 36, 36, 255))
    surface.SetMaterial(wave2)
    surface.SetDrawColor(color_white)
    surface.DrawTexturedRect(sizew/2-32/2, 10, 32, 32)
end

local foundedply = {}

concommand.Add("DrawButtonTest", function()
local owner = LocalPlayer()


for k,v in pairs(ents.FindInSphere(owner:GetPos(), 200)) do
    if (v:IsPlayer()) && (v ~= owner) && (foundedply[v] ~= true) then
        foundedply[v] = true
        PrintTable(foundedply)
        local sizew, sizeh = 100, 120
        local DermaPanel = vgui.Create("DFrame") 
        DermaPanel:SetSize(sizew, sizeh)
        DermaPanel:SetPos(1, 1) 
        DermaPanel:SetTitle("")
        DermaPanel:ShowCloseButton(true)
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
        DermaButton:SetText( "Say hi" )                 
        DermaButton:SetPos( 10, 80 )                   
        DermaButton:SetSize( 80, 20 )
        DermaButton.Pressed = false                 
        DermaButton.DoClick = function()             
            RunConsoleCommand( "say", DComboBox:GetValue() )            
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
        DermaButton.OnDepressed = function(self)
            self.Pressed = true
            draw.RoundedBox(10, 0, 0, w, h, Color(102, 45, 45))
        end
        DermaButton.OnReleased = function(self)
            self.Pressed = false
        end


        DermaPanel.Paint = function(self, w, h)
            YUI_DefaultPaint(0, self, w, h, sizew, sizeh)
        end

        DermaPanel.Think = function(self)
            local vpos = v:GetPos()
            local point = vpos + v:OBBCenter()
            local data2D = point:ToScreen()
            local xx = data2D.x
            local yy = data2D.y
            local dist = vpos:Distance(owner:GetPos())
            DermaPanel:SetPos(xx-45, yy-90)

            if scpgui_mouse_enabled then
                DermaPanel:SetMouseInputEnabled(true)
            else
                DermaPanel:SetMouseInputEnabled(false)
            end

            if dist > 365 then
                self:Close()
                foundedply[v] = false
            end
        end 
    end
end

end)