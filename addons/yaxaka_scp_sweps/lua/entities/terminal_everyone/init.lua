AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:Initialize()
    self:SetModel( "models/unconid/pc_models/monitors/lcd_acer_16x9.mdl" ) 
    self:PhysicsInit( SOLID_VPHYSICS ) 
    self:SetMoveType( MOVETYPE_VPHYSICS ) 
    self:SetSolid( SOLID_VPHYSICS )
    self:SetUseType(SIMPLE_USE)
    self.Stations = {}
    self.Charging = false
    local phys = self:GetPhysicsObject() 
    if phys:IsValid() then 
        phys:Wake() 
    end
end

function ENT:SetupDataTables()
    self:SetNW2Bool( "InUse", false )
    self:SetNW2Int( "Page", 0 )
end



function ENT:Think()

end

function ENT:Use( activator )

end

