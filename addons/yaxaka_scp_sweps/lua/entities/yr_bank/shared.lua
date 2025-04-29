ENT.Type = "anim" 
ENT.Base = "base_gmodentity" 
ENT.PrintName = "Bank obrazcov" 
ENT.Author = "Yaxaka"
ENT.Category = "Yaxaka's Science"
ENT.Spawnable = true 



function ENT:SetupDataTables()
    self:NetworkVar( "Bool", "InUse" )
    self:NetworkVar("String", "Item")
end

