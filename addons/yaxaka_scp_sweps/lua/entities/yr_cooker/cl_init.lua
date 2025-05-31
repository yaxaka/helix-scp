include("shared.lua")

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
color_gray = Color(128, 128, 128)

function ENT:Initialize()
    self:ManipulateBonePosition(1, Vector(-7, 0, 0))
    self:ManipulateBoneAngles(2, Angle(0, 0, 0))
    self.num = -7
    self.num2 = 1
end

function ENT:DrawTranslucent()
    local status = self:GetNW2Int("State")
	self:DrawModel()

	local ang = self:GetAngles()
    
    ang:RotateAroundAxis( self:GetUp(), 90 )
    ang:RotateAroundAxis( self:GetRight(), -90 )
    ang:RotateAroundAxis( self:GetForward(), 0 )

    local pos = self:GetPos()
    
    pos = pos + self:GetForward() * 6.2
    pos = pos + self:GetRight() * 2.8
    pos = pos - self:GetUp() * 3

    -- Higher the value, the better the res
    local res = 5
    local circle = 0

    if imgui.Start3D2D( pos, ang, 0.05 / res, 100, 50 ) then
        surface.SetDrawColor( 199, 170, 116, 255 )
        surface.DrawRect( 0, 0, 200 * res, 100 * res )

        surface.SetDrawColor( 0, 0, 0, 255 )
        surface.DrawOutlinedRect(5*res, 5*res, 190*res, 90*res, 10)

        surface.SetTextColor(0, 0, 0)
        surface.SetFont("font_tektur")

        if status == 1 then
            surface.SetTextPos(60*res, 37*res)
            surface.DrawText("В работе")
        else
            surface.SetTextPos(51*res, 37*res)
            surface.DrawText("Ожидание")
        end



    imgui.End3D2D()
    end

end

function ENT:Think()
    local inuse = self:GetNW2Int("State")
    local bonpos = self:GetManipulateBonePosition(1)
    if inuse == 1 then
        if self.num2 > self.num then
            self.num = self.num + 0.005
            self:ManipulateBonePosition(1, Vector(self.num, 0, 0))
            self:ManipulateBoneAngles(2, Angle(0, -self.num*1000, 0))
        end    
    elseif inuse == 2 then
        if self.num > -7 then
            self.num = self.num - 0.005
            self:ManipulateBonePosition(1, Vector(self.num, 0, 0))
            self:ManipulateBoneAngles(2, Angle(0, self.num*1000, 0))
        end
    end
end