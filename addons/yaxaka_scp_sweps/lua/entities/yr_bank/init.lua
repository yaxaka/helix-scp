AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

util.AddNetworkString("yr_bank")
util.AddNetworkString("yr_newobr")

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

net.Receive("yr_newobr", function(l, ply)
    if not ply:GetCharacter():IsScienceTeam() then return end

    local name = net.ReadString()
    local checkutf8 = stringname_check(name, ply)
    local len = #(name:gsub('[\128-\191]',''))

    if not checkutf8 then return end

    if len >= 10 then
        ply:Notify("Слишком длинное название")
        return
    else
        local el1 = net.ReadString()
        local el2 = net.ReadString()

        local a = yr_mix1(el1, el2, ply, name)
        if a == false then
            ply:Notify("Ошибка смешивания")
        end
    end
   
end)

function ENT:Use( activator )

end
