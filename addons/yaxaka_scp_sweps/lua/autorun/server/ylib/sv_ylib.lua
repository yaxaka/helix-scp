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

hook.Add("AnimationShifrator", "First", function(parent, child)
	hook.Add("Think", "ShifratorAnimation", function()
		if parent.Act2 == true then
        	if parent.NewTarget >= 13 then
            	parent.NewTarget = parent.NewTarget - 0.3
            	child:SetLocalPos(Vector(0, 0, parent.NewTarget))
            else
            	if parent.NewTarget2 >= 1 then
            		parent.NewTarget2 = parent.NewTarget2 - 7
            		child:SetLocalAngles(Angle(90, 0, parent.NewTarget2))
            	end
        	end
    	end
	end)
end)

hook.Add("AnimationShifrator2", "First", function(parent, child)
	hook.Add("Think", "ShifratorAnimation", function()
		if parent.Act2 == true then

        	if parent.NewTarget <= 14.7 && parent.NewTarget2 >= 83 then
            	parent.NewTarget = parent.NewTarget + 0.3
            	child:SetLocalPos(Vector(0, 0, parent.NewTarget))
            	if parent.NewTarget == 15 then
            		timer.Create(parent:EntIndex() .. "childremove", 0.2, 1, function()
            			child:Remove()
            		end)
            	end
            end

            if parent.NewTarget2 <= 83 then
            	parent.NewTarget2 = parent.NewTarget2 + 8
            	child:SetLocalAngles(Angle(90, 0, parent.NewTarget2))
            else

            end
    	end
	end)
end)