function ylib_CreateRagdoll(Vector, Ang, Model)
	local rag = ents.Create("prop_ragdoll")
	rag:SetModel(Model)
	rag:SetPos(Vector)
	rag:Spawn()
	rag:SetMaterial("models/props_c17/FurnitureFabric001a")
end