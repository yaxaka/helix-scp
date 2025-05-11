AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")


function ENT:Initialize()
    self:SetModel( "models/mechanics/solid_steel/box_beam_8.mdl" ) 
    self:PhysicsInit( SOLID_VPHYSICS ) 
    self:SetMoveType( MOVETYPE_VPHYSICS ) 
    self:SetSolid( SOLID_VPHYSICS )
    self:SetUseType(SIMPLE_USE)
    self.animstate = 0
    self.ac1 = 0
    self.ac2 = 0
    self.pump = nil
    self.tube1 = nil
    self.tube2 = nil
    self.tube3 = nil

    local phys = self:GetPhysicsObject() 

    if phys:IsValid() then 
    end

    local child = ents.Create("yr_tubeholder")
    child:SetParent(self, 0)
    child:SetLocalPos(Vector(0, -40, 5))
    child:SetLocalAngles(Angle(90, 90, 0))
    child:Spawn()
    self.pump = child
    
    local podstavka = ents.Create("base_gmodentity")
    podstavka:SetParent(self, 0)
    podstavka:SetModel("models/mechanics/solid_steel/box_beam_8.mdl")
    podstavka:SetLocalAngles(Angle(0, 0, 0))
    podstavka:SetLocalPos(Vector(0, 0, -31))
    podstavka:PhysicsInit( SOLID_VPHYSICS )
    podstavka:Spawn()


    local tube1 = ents.Create("yr_labtube")
    tube1:SetParent(self, 0)
    tube1:SetLocalPos(Vector(0, 0, -25))
    tube1:SetLocalAngles(Angle(0, 0, 0))
    tube1:Spawn()
    self.tube1 = tube1

    local tube2 = ents.Create("yr_labtube")
    tube2:SetParent(self, 0)
    tube2:SetLocalPos(Vector(0, -30, -25))
    tube2:SetLocalAngles(Angle(0, 0, 0))
    tube2:Spawn()
    self.tube2 = tube2

    local tube3 = ents.Create("yr_labtube")
    tube3:SetParent(self, 0)
    tube3:SetLocalPos(Vector(0, 30, -25))
    tube3:SetLocalAngles(Angle(0, 0, 0))
    tube3:Spawn()
    self.tube3 = tube3
end

function ENT:SetupDataTables()
    self:SetNW2Bool( "InUse", false )
    self:SetNW2String( "Item", "Пусто" )
    self:SetNW2Int( "AnimState", self.animstate )
end



function ENT:Use( activator )
    if self.animstate == 0 then
        yar_pumperanim_move(self, self.pump, 1, self.tube1, self.tube2, self.tube3)
    else
        yar_pumperanim_move(self, self.pump, 0, self.tube1, self.tube2, self.tube3)
    end
end
