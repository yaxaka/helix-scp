AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:Initialize()
    self:SetModel( "models/props_combine/stasisfield.mdl" ) 
    self:PhysicsInit( SOLID_VPHYSICS ) 
    self:SetMoveType( MOVETYPE_VPHYSICS ) 
    self:SetSolid( SOLID_VPHYSICS )
    self:SetUseType(SIMPLE_USE)
    self.animstate = 0
    self.ac1 = 0
    self.ac2 = 0

    local phys = self:GetPhysicsObject() 
    self:SetModelScale(0.05)
    self:DrawShadow(false)

    if phys:IsValid() then 
    end

    local child = ents.Create("yr_labtube")
    child:SetModel("models/xqm/cylinderx2.mdl")
    child:SetParent(self, 1)
    child:SetLocalPos(Vector(0, 0, -24))
    child:SetLocalAngles(Angle(0, 0, 0))
    --child:SetModelScale(0.5)
    child:Spawn()
    --self.child = child

end

function ENT:SetupDataTables()
    self:SetNW2Bool( "InUse", false )
    self:SetNW2String( "Item", "Пусто" )
    self:SetNW2Int( "AnimState", self.animstate )
end



function ENT:Use( activator )

end
