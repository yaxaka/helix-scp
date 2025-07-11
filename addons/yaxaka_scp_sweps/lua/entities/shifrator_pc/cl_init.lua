include("shared.lua")

function ENT:Initialize()
    self.Stations = {}
    self.TargetN = 120
end

function ENT:Draw( flags )
    self:DrawModel( flags )

    local ang = self:GetAngles()
    -- Change these numbers to rotate the screen correctly for your model
    ang:RotateAroundAxis( self:GetUp(), 90 )
    ang:RotateAroundAxis( self:GetRight(), -90 + 4.5 )
    ang:RotateAroundAxis( self:GetForward(), 0 )

    local pos = self:GetPos()
    -- Change these numbers to position the screen on your model
    pos = pos + self:GetForward() * 11.7
    pos = pos + self:GetRight() * 9.69
    pos = pos + self:GetUp() * 11.8

    -- Higher the value, the better the resolution
    local resolution = 1.1

    cam.Start3D2D( pos, ang, 0.05 / resolution )
        -- Paint the background. Effectively a 388x320 pixel screen
        surface.SetDrawColor( 0, 0, 0, 255 )
        surface.DrawRect( 0, 0, 388 * resolution, 320 * resolution )

        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.DrawRect( 7, 40, 376 * resolution, 70 * resolution )
        surface.DrawRect( 7, 130, 187 * resolution, 50 * resolution )
        surface.DrawRect( 215, 130, 187 * resolution, 50 * resolution )
        surface.SetDrawColor(102, 102, 102)
        surface.DrawOutlinedRect(7, 40, 376 * resolution, 70 * resolution, 3)
        surface.DrawOutlinedRect(7, 130, 187 * resolution, 50 * resolution, 3)
        surface.DrawOutlinedRect(215, 130, 187 * resolution, 50 * resolution, 3)

        -- Paint the content
        surface.SetFont("DermaLarge")
        surface.SetTextColor(0, 0, 0)
        surface.SetTextPos(12, 50)
        surface.DrawText("Станция загрузки и обновления")
        surface.SetTextPos(135, 80)
        surface.DrawText("шифраторов")
        surface.SetTextPos(13, 143)
        surface.SetTextColor(0, 0, 0)
        surface.DrawText("Подключено:." .. #self.Stations)
        surface.SetTextPos(245, 143)
        if self:GetObrazec() == false then
            surface.SetTextColor(255, 0, 0)
            surface.DrawText("Образец: !!!")
        else
            surface.SetTextColor(0, 255, 0)
            surface.DrawText("Образец {||}")
        end

        if self:GetCharging() then
            for i=1,100 do
                surface.SetDrawColor(math.random(1, 255), math.random(1, 255), math.random(1, 255))
                surface.DrawRect(7, 200, math.random(25, 376) * resolution, math.random(25, 120) * resolution)
            end

            surface.SetDrawColor(0, 0, 0, 255)

            if self.TargetN >= 1 then
                self.TargetN = self.TargetN - 0.14
            end

            surface.DrawRect(7, 200, 376 * resolution, self.TargetN * resolution)
        else
            self.TargetN = 120
        end
        for k,v in pairs(self.Stations) do
            
            if v == NULL then
                table.RemoveByValue(self.Stations, v)
            else
                local dist = v:GetPos():DistToSqr(self:GetPos())
                if dist >= 27000 then table.RemoveByValue(self.Stations, v) return end
            end
        end
    cam.End3D2D()
end

function ENT:Think()
    local a = self:GetPos()
    for k,v in pairs(ents.FindInSphere(a, 100)) do
        if v:GetClass() == "shifrator_base" then
            if not table.HasValue(self.Stations, v) then
                table.insert(self.Stations, v)
            end
        end
    end
end