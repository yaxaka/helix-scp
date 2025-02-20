function ylib_CreateRagdoll(Vector, Ang, Model)
	local rag = ents.Create("prop_ragdoll")
	rag:SetModel(Model)
	rag:SetPos(Vector)
	rag:Spawn()
	rag:SetMaterial("models/props_c17/FurnitureFabric001a")
end

scp_ply_vars = {}
scp_index_vars = {}

function LoadSCPTables_Helix()
	for k,v in pairs(ix.class.list) do
		local name = v.name
		local s = string.find(name, "SCP", 1)
		if s ~= nil then
			local new_word = string.Replace(name, "-", "_")
			local new_word2 = string.lower(new_word .. "_ply")
			scp_ply_vars[new_word2] = nil
		end

	end
end

function HelixSCP()
	for k,v in pairs(ix.class.list) do
		local id = v.faction
		if id == 6 then
			scp_index_vars[v.index] = v.index
		end

	end
end

hook.Add("PostGamemodeLoaded", "CreateTables", function()
	LoadSCPTables_Helix()
end)