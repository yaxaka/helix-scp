ENT.Type = "anim" 
ENT.Base = "base_gmodentity" 
ENT.PrintName = "Shifrator PC" 
ENT.Author = "Yaxaka"
ENT.Category = "Shifrator"
ENT.Spawnable = true 


function ENT:SetupDataTables()
    self:NetworkVar( "Bool", "Obrazec" )
    self:NetworkVar( "Bool", "Charging" )
end