include("shared.lua")

sound.Add( {
    name = "sintezator_work",
    channel = CHAN_STATIC,
    volume = 1.0,
    level = 80,
    sound = "machinery/compressor_loop.wav"
} )

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
    pos = pos + self:GetUp() * 25

    -- Higher the value, the better the res
    local res = 5
    local circle = 0


    if imgui.Start3D2D( pos, ang, 0.05 / res, 820, 300 ) then
        local status = self:GetNW2Bool("InUse")
        local timer = self:GetNW2Int("Timer")

        self.at.xn, self.at.wn = yui_calc1(self.at.xn, self.at.wn, self.at.t, self.at.x, self.at.w, 2)
        self.at2.xn, self.at2.wn = yui_calc1(self.at2.xn, self.at2.wn, self.at2.t, self.at2.x, self.at2.w, 2)
        self.at3.xn, self.at3.wn = yui_calc1(self.at3.xn, self.at3.wn, self.at3.t, self.at3.x, self.at3.w, 2)
        self.at4.xn, self.at4.wn = yui_calc1(self.at4.xn, self.at4.wn, self.at4.t, self.at4.x, self.at4.w, 2)
        self.at5.xn, self.at5.wn = yui_calc1(self.at5.xn, self.at5.wn, self.at5.t, self.at5.x, self.at5.w, 2)

        surface.SetDrawColor( 199, 170, 116, 255 )
        surface.DrawRect( 0, 0, 820 * res, 350 * res )

        surface.SetDrawColor( 0, 0, 0, 255 )
        surface.DrawOutlinedRect(10*res, 10*res, 800*res, 330*res, 5*res)

        surface.SetTextColor(0, 0, 0)
        surface.SetFont("font_tektur2_big")

        if status then
            surface.DrawOutlinedRect(60*res, 50*res, 700*res, 145*res, 5*res)
            surface.SetTextPos(280*res, 70*res)
            surface.DrawText(self:GetNW2String("Item"))
            surface.SetTextPos(80*res, 130*res)
            surface.DrawText("ETA:")
            surface.SetFont("font_tektur2_big2")
            surface.SetTextPos(170*res, 130*res)
            surface.DrawText(timer .. "/s")
        else
            surface.SetTextPos(220*res, 90*res)
            surface.DrawText("Ожидание задачи")
        end

        surface.DrawOutlinedRect(60*res, 220*res, 700*res, 90*res, 5*res)
        if status then
            surface.DrawOutlinedRect(60*res, 220*res, 700*res, 90*res, 5*res)

            surface.DrawRect(self.at.xn*res, 240*res, self.at.wn*res, 50*res)
            surface.DrawRect(self.at2.xn*res, 240*res, self.at2.wn*res, 50*res)
            surface.DrawRect(self.at3.xn*res, 240*res, self.at3.wn*res, 50*res)
            surface.DrawRect(self.at4.xn*res, 240*res, self.at4.wn*res, 50*res)
            surface.DrawRect(self.at5.xn*res, 240*res, self.at5.wn*res, 50*res)
        end
        imgui.End3D2D()
    end

        local pos2 = self:GetPos()
        -- Change these numbers to position the screen on your model
        pos2 = pos2 - self:GetForward() * 6.5
        pos2 = pos2 - self:GetRight() * 32.5
        pos2 = pos2 + self:GetUp() * 34.3

        if imgui.Start3D2D( pos2, ang, 0.05 / res, 820, 300 ) then
            local tube1 = self:GetNW2Int("Fill1")
            local tube2 = self:GetNW2Int("Fill2")
            local tube3 = self:GetNW2Int("Fill3")
            self.ba.xn, self.ba.wn = yui_calc1(self.ba.xn, self.ba.wn, self.ba.t, self.ba.x, self.ba.w, 1)
            self.ba2.xn, self.ba2.wn = yui_calc1(self.ba2.xn, self.ba2.wn, self.ba2.t, self.ba2.x, self.ba2.w, 1)

            surface.SetDrawColor( 199, 170, 116, 255 )
            surface.DrawRect(0*res, 0*res, 80*res, 110*res)
            surface.DrawRect(600*res, 0*res, 80*res, 110*res)
            surface.DrawRect(1200*res, 0*res, 80*res, 110*res)

            surface.SetDrawColor( 0, 0, 0, 255 )
            surface.DrawOutlinedRect(0*res, 0*res, 80*res, 110*res, 5*res)
            surface.DrawOutlinedRect(600*res, 0*res, 80*res, 110*res, 5*res)
            surface.DrawOutlinedRect(1200*res, 0*res, 80*res, 110*res, 5*res)

            if tube3 == 1 then
                surface.SetDrawColor( 0, 0, 0, 255 )
                surface.DrawRect(10*res, self.ba.xn*res, 60*res, self.ba.wn*res)
                surface.DrawRect(10*res, self.ba2.xn*res, 60*res, self.ba2.wn*res)
            elseif tube3 == 2 then
                surface.SetDrawColor( 0, 255, 0, 255 )
                surface.DrawRect(5*res, 5*res, 70*res, 100*res)
            end

            if tube1 == 1 then
                surface.SetDrawColor( 0, 0, 0, 255 )
                surface.DrawRect(610*res, self.ba.xn*res, 60*res, self.ba.wn*res)
                surface.DrawRect(610*res, self.ba2.xn*res, 60*res, self.ba2.wn*res)
            elseif tube1 == 2 then
                surface.SetDrawColor( 0, 255, 0, 255 )
                surface.DrawRect(605*res, 5*res, 70*res, 100*res)
            end


            if tube2 == 1 then
                surface.SetDrawColor( 0, 0, 0, 255 )
                surface.DrawRect(1210*res, self.ba.xn*res, 60*res, self.ba.wn*res)
                surface.DrawRect(1210*res, self.ba2.xn*res, 60*res, self.ba2.wn*res)
            elseif tube2 == 2 then
                surface.SetDrawColor( 0, 255, 0, 255 )
                surface.DrawRect(1205*res, 5*res, 70*res, 100*res)
            end

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
        wn = 30,
        x = 65,
        w = 30,
        t = 725,
    }
    self.at2 = {
        xn = 115,
        wn = 30,
        x = 65,
        w = 30,
        t = 725,
    }
    self.at3 = {
        xn = 165,
        wn = 30,
        x = 65,
        w = 30,
        t = 725,
    }
    self.at4 = {
        xn = 215,
        wn = 30,
        x = 65,
        w = 30,
        t = 725,
    }
    self.at5 = {
        xn = 265,
        wn = 30,
        x = 65,
        w = 30,
        t = 725,
    }
    self.ba = {
        xn = 5,
        wn = 20,
        x = 5,
        w = 20,
        t = 80,
    }

    self.ba2 = {
        xn = 40,
        wn = 20,
        x = 5,
        w = 20,
        t = 80,
    }
end
