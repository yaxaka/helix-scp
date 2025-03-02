hook.Add("CreateClientsideRagdoll", "test", function(entity, ragdoll)
	local rag = ragdoll:GetClass()
	if rag == "class C_HL2MPRagdoll" then return end
	ragdoll:Remove()
	return false
end)


