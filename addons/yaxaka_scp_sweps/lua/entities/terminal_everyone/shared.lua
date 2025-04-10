ENT.Type = "anim" 
ENT.Base = "base_gmodentity" 
ENT.PrintName = "PC Screen" 
ENT.Author = "Yaxaka"
ENT.Category = "Screen Test"
ENT.Spawnable = true 



function ENT:SetupDataTables()
    self:NetworkVar( "Bool", "InUse" )
    self:NetworkVar("Entity", "Owner")
    self:NetworkVar("Int", "Page")
end

