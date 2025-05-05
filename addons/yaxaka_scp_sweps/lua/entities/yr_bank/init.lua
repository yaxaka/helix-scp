AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

yr_bankent = nil

function ENT:Initialize()
    self:SetModel( "models/props_interiors/VendingMachineSoda01a_door.mdl" ) 
    self:PhysicsInit( SOLID_VPHYSICS ) 
    self:SetMoveType( MOVETYPE_VPHYSICS ) 
    self:SetSolid( SOLID_VPHYSICS )
    self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject() 
    if phys:IsValid() then 
        phys:Wake()
        self:SetModelScale(0.5)  
        self:SetMaterial("phoenix_storms/gear")
        self:SetItem('Не выбрано')
    end
    yr_bankent = self
end



function ENT:Use( activator )

end
