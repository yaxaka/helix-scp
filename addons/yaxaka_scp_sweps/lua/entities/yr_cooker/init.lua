AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

yr_cooker = nil

function ENT:Initialize()
    self:SetModel( "models/props_combine/health_charger001.mdl" ) 
    self:PhysicsInit( SOLID_VPHYSICS ) 
    self:SetMoveType( MOVETYPE_VPHYSICS ) 
    self:SetSolid( SOLID_VPHYSICS )
    self:SetUseType(SIMPLE_USE)

    local phys = self:GetPhysicsObject() 
    if phys:IsValid() then 
        phys:Wake()
    end
    yr_cooker = self
end

function ENT:SetupDataTables()
    self:SetNW2Int("State", 0)
end

function ENT:Use(ply)
    self:StartWork()
end

function ENT:StartWork()
    self:SetNW2Int("State", 1)
    timer.Create("test1", 13, 1, function()
        self:SetNW2Int("State", 2)
    end)
end