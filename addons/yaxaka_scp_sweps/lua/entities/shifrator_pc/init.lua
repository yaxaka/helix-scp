AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:Initialize()
    self:SetModel( "models/props_lab/monitor01a.mdl" ) 
    self:PhysicsInit( SOLID_VPHYSICS ) 
    self:SetMoveType( MOVETYPE_VPHYSICS ) 
    self:SetSolid( SOLID_VPHYSICS )
    self.Stations = {}
    local phys = self:GetPhysicsObject() 
    if phys:IsValid() then 
        phys:Wake() 
    end
end

function ENT:Think()
    local a = self:GetPos()
    for k,v in pairs(ents.FindInSphere(a, 50)) do
        if v:GetClass() == "shifrator_base" then
            if not table.HasValue(self.Stations, v) then
                table.insert(self.Stations, v)
            end
        end
    end
    for k,v in pairs(self.Stations) do
        if v == NULL then
            table.RemoveByValue(self.Stations, v)
        else
            local dist = v:GetPos():DistToSqr(a)
            if dist >= 27000 then table.RemoveByValue(self.Stations, v) return end
        end
    end
end

function ENT:Use( activator )
    if (activator:IsPlayer()) then
        
    end
end