AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:Initialize()
    self:SetModel( "models/millscp/flask/flask.mdl" ) 
    self:PhysicsInit( SOLID_VPHYSICS ) 
    self:SetMoveType( MOVETYPE_VPHYSICS ) 
    self:SetSolid( SOLID_VPHYSICS )
    self:SetUseType(SIMPLE_USE)
    self.animstate = 0
    self.ac1 = 0
    self.ac2 = 0
    self.pumping = false
    self.filled = false

    local phys = self:GetPhysicsObject() 

    if phys:IsValid() then 
    end

    local child = ents.Create("base_gmodentity")
    child:SetModel("models/xqm/cylinderx2.mdl")
    child:SetParent(self, 1)
    child:SetLocalPos(Vector(0, 0, 0.85))
    child:SetLocalAngles(Angle(90, 0, 0))
    child:SetModelScale(0.5)
    child:Spawn()
    self.child = child
    local scale = child:GetManipulateBoneScale(0)
    child:ManipulateBoneScale( 0, scale + Vector(-0.95, 0, 0) )

end

function ENT:SetupDataTables()
    self:SetNW2Int( "AnimState", self.animstate )
end



function ENT:Pumping(num)
    if self.pumping == true then return end
    hook.Run("YarTubeAnim", self, self.child, num)
end


