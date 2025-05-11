AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:Initialize()
    self:SetModel( "models/props_lab/tpplug.mdl" ) 
    self:PhysicsInit( SOLID_VPHYSICS ) 
    self:SetMoveType( MOVETYPE_VPHYSICS ) 
    self:SetSolid( SOLID_VPHYSICS )
    self:SetUseType(SIMPLE_USE)
    self.animstate = 0
    self.ac1 = 0
    self.ac2 = 0
    self.inmoving = false

    local phys = self:GetPhysicsObject() 
    self:DrawShadow(false)

    if phys:IsValid() then 
    end



end

function ENT:SetupDataTables()
    self:SetNW2Bool( "InUse", false )
    self:SetNW2String( "Item", "Пусто" )
    self:SetNW2Int( "AnimState", self.animstate )
end



function ENT:Use( activator )

end
