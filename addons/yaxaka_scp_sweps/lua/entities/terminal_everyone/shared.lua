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
    self:NetworkVar("Bool", "Bank")
    self:NetworkVar("Bool", "ResearchBot")
    self:NetworkVar("Bool", "Sintezator")
    self:NetworkVar("Bool", "ChemLab")
    self:NetworkVar("Bool", "DNARedactor")
    self:NetworkVar("Bool", "HaveObrazec")
end

