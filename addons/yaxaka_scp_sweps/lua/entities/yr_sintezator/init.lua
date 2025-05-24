AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")

ent_sintezator = nil

function ENT:Initialize()
    self:SetModel( "models/props_c17/substation_transformer01a.mdl" ) 
    self:PhysicsInit( SOLID_VPHYSICS ) 
    self:SetMoveType( MOVETYPE_VPHYSICS ) 
    self:SetSolid( SOLID_VPHYSICS )
    self:SetUseType(SIMPLE_USE)
    self.animstate = 0
    self.ac1 = 0
    self.ac2 = 0

    local phys = self:GetPhysicsObject() 
    self:SetModelScale(0.4)
    self:DrawShadow(false)

    if phys:IsValid() then 
    end

    ent_sintezator = self

    local child = ents.Create("gmod_button")
    child:SetModel("models/props_wasteland/horizontalcoolingtank04.mdl")
    child:SetParent(self, 0)
    child:SetLocalPos(Vector(0, 75, -16))
    child:SetLocalAngles(Angle(0, 90, 0))
    child:SetModelScale(0.3)
    child:Spawn()
    child:SetSolid(SOLID_NONE) 
    self.child = child

    local patronman = ents.Create("yr_patronmanager")
    patronman:SetParent(self, 0)
    patronman:SetLocalPos(Vector(0, 0, 60))
    patronman:SetLocalAngles(Angle(0, 0, 0))
    patronman:Spawn()
    patronman:SetSolid(SOLID_NONE) 

end

function ENT:SetupDataTables()
    self:SetNW2Bool( "InUse", false )
    self:SetNW2Int( "Fill1", 0 )
    self:SetNW2Int( "Fill2", 0 )
    self:SetNW2Int( "Fill3", 0 )
    self:SetNW2String( "Item", "Пусто" )
    self:SetNW2Int( "Timer", 0 )
    self:SetNW2Int( "AnimState", self.animstate )
end

function ENT:StartWork(state)
    if (state) then
        self:SetNW2Bool( "InUse", true )
        self.soundid = self:StartLoopingSound("machinery/compressor_loop.wav")
    elseif not (state) then
        self:SetNW2Bool( "InUse", false )
        self:StopLoopingSound(self.soundid)
    end
end