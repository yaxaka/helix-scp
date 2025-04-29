include("shared.lua")

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
color_gray = Color(128, 128, 128)

function ENT:DrawTranslucent()
	self:DrawModel()

	local ang = self:GetAngles()
    
    ang:RotateAroundAxis( self:GetUp(), 90 )
    ang:RotateAroundAxis( self:GetRight(), -90 )
    ang:RotateAroundAxis( self:GetForward(), 0 )

    local pos = self:GetPos()
    
    pos = pos + self:GetForward() * 2
    pos = pos + self:GetRight() * 9
    pos = pos + self:GetUp() * 15

    pos2 = pos + self:GetForward() * 2
    pos2 = pos + self:GetRight() * 9
    pos2 = pos - self:GetUp() * 15

    -- Higher the value, the better the res
    local res = 5
    local circle = 0

    if imgui.Start3D2D( pos, ang, 0.05 / res, 200, 150 ) then
    	surface.SetDrawColor( 199, 170, 116, 255 )
        surface.DrawRect( 0, 0, 300 * res, 250 * res )
        imgui.xCursor(0, 0, 300 * res, 250 * res)

        surface.SetDrawColor(0, 0, 0)
        surface.DrawOutlinedRect(10*res, 10*res, 280*res, 230*res, 10)
        surface.SetTextPos(55*res, 20*res)
        surface.SetTextColor(0, 0, 0)
        surface.SetFont("font_tektur2")
        surface.DrawText("Банк образцов")


        local select = imgui.xButtonTerminal("Выбрать из списка", "font_tektur", 52*res, 80*res, 10, Color(0, 0, 0), color_white, color_gray)
        local add = imgui.xButtonTerminal("Добавить новый", "font_tektur", 52*res, 180*res, 10, Color(0, 0, 0), color_white, color_gray)
        local status = imgui.xButtonTerminal("Убрать выбор", "font_tektur", 52*res, 130*res, 10, Color(0, 0, 0), color_white, color_gray)

        if select then
            yas_bclick()
            call_bankgui()
        end

        if status then
        	if self:GetItem() == "Не выбрано" then
                yas_bclick()
        	else
        		net.Start("yr_bank")
                net.WriteBool(true)
                net.SendToServer()
                yas_bclick()
        	end
        end

        if add then
            yas_bclick()
        end








        imgui.End3D2D()
    end

    if imgui.Start3D2D( pos2, ang, 0.05 / res, 200, 150 ) then
        local selecteditem = self:GetItem()
        surface.SetDrawColor( 199, 170, 116, 255 )
        surface.DrawRect( 0, 0, 300 * res, 110 * res )
        imgui.xCursor(0, 0, 300 * res, 110 * res)

        surface.SetDrawColor(0, 0, 0)
        surface.DrawOutlinedRect(10*res, 10*res, 280*res, 90*res, 10)


        surface.SetTextPos(52*res, 20*res)
        surface.SetTextColor(0, 0, 0)
        surface.SetFont("font_tektur2")
        surface.DrawText("Текущий выбор")

        surface.SetFont("font_tektur_normal")
        local tw, th = surface.GetTextSize(selecteditem)
        local tw2 = 150-tw/10
        surface.SetTextPos(tw2*res, 60*res)     
        surface.DrawText(selecteditem)



        imgui.End3D2D()
    end
end