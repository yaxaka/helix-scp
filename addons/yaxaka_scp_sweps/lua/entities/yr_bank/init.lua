AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("yr_bank")


local selfent = nil

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
    selfent = self
end

net.Receive("yr_bank", function(l, ply)
    if not ply:GetCharacter():IsScienceTeam() then return end


    local type = net.ReadBool()

    if type == true then
        selfent:SetItem("Не выбрано")
    else
        local str = net.ReadString()
        if #str >= 20 then return end
        if yr_LoadElement(str) == nil then return end

        selfent:SetItem(str)
    end
end)

function ENT:Use( activator )

end
