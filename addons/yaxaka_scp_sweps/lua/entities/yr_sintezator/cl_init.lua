include("shared.lua")

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT

function ENT:DrawUI()
    local ang = self:GetAngles()
    -- Change these numbers to rotate the screen correctly for your model
    ang:RotateAroundAxis( self:GetUp(), 90 )
    ang:RotateAroundAxis( self:GetRight(), 90 )
    ang:RotateAroundAxis( self:GetForward(), 180 )

    local pos = self:GetPos()
    -- Change these numbers to position the screen on your model
    pos = pos - self:GetForward() * 32
    pos = pos - self:GetRight() * 20
    pos = pos + self:GetUp() * 15

    -- Higher the value, the better the res
    local res = 5
    local circle = 0


    if imgui.Start3D2D( pos, ang, 0.05 / res, 800, 700 ) then
        self.at.xn, self.at.wn = yui_calc1(self.at.xn, self.at.wn, self.at.t, self.at.x, self.at.w)



        surface.SetDrawColor( 199, 170, 116, 255 )
        surface.DrawRect( 0, 0, 820 * res, 300 * res )

        surface.SetDrawColor( 0, 0, 0, 255 )

        surface.DrawOutlinedRect(60*res, 150*res, 700*res, 90*res, 5*res)

        surface.DrawRect(self.at.xn*res, 170*res, self.at.wn*res, 50*res)
        imgui.End3D2D()
    end
end

function ENT:DrawTranslucent()
    self:DrawModel()

    self:DrawUI()

end

function ENT:Initialize()
    self.at = {
        xn = 65,
        wn = 50,
        x = 65,
        w = 50,
        t = 710,
    }
end
