include("shared.lua")

ENT.RenderGroup = RENDERGROUP_TRANSLUCENT


function ENT:DrawTranslucent()
    self:DrawModel()
end