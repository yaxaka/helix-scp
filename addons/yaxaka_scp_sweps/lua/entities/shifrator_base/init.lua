AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:Initialize()
    self:SetModel( "models/props_combine/combine_mortar01b.mdl" ) 
    self:PhysicsInit( SOLID_VPHYSICS ) 
    self:SetMoveType( MOVETYPE_VPHYSICS ) 
    self:SetSolid( SOLID_VPHYSICS )
    self:SetUseType(SIMPLE_USE)
    self.Act = nil
    self.Act2 = false
    self.NewTarget = 15
    self.NewTarget2 = 90
    local phys = self:GetPhysicsObject() 
    if phys:IsValid() then 
        phys:Wake()
        self:SetModelScale(0.2) 
    end
    print(self:GetBoneCount())
end

function ENT:Use( activator )
    if (activator:IsPlayer()) then
        if self.Act == nil then
            local scaner = ents.Create("base_gmodentity")
            scaner:SetModel("models/alyx_emptool_prop.mdl")
            scaner:SetParent(self, 1)
            scaner:SetLocalPos(Vector(0, 0, 15))
            --scaner:SetPos(self:GetPos() + Vector(0, 0, 13))
            scaner:SetLocalAngles(Angle(90, 0, 90))
            scaner:SetModelScale(1.1) 
            scaner:Spawn()
            self.Act = scaner
            self.Act2 = true
            self:EmitSound("shifrator/station_plugin.wav")
            hook.Run("AnimationShifrator", self, self.Act)
        end
    end
end

