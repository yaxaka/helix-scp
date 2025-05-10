hook.Add("YarTubeAnim", "Controller", function(parent, ent, newstate)
	if IsValid(parent) && IsValid(ent) && newstate ~= nil then
		if newstate == 1 then
			local hookname = "YarTubeUp_" .. parent:EntIndex()
			hook.Add("Think", hookname, function()
				if IsValid(parent) && IsValid(ent) then
					if parent.ac1 <= 0.014 then
						parent.ac1 = parent.ac1 + 0.0001
						parent.ac2 = parent.ac2 + 0.00035
						local scale = ent:GetManipulateBoneScale(0)
						local pos = ent:GetLocalPos()
						ent:SetLocalPos(pos + Vector(0, 0, parent.ac2))
        				ent:ManipulateBoneScale( 0, scale + Vector(parent.ac1, 0, 0) )
        			else
        				parent.animstate = 1
        				hook.Remove("Think", hookname)
					end
				end
			end)
		elseif newstate == 0 then
			local hookname = "YarTubeDown_" .. parent:EntIndex()
			hook.Add("Think", hookname, function()
				if IsValid(parent) && IsValid(ent) then
					if parent.ac1 >= 0 then
						parent.ac1 = parent.ac1 - 0.0001
						parent.ac2 = parent.ac2 - 0.000330
						local scale = ent:GetManipulateBoneScale(0)
						local pos = ent:GetLocalPos()
						ent:ManipulateBoneScale( 0, scale - Vector(parent.ac1, 0, 0) )
						ent:SetLocalPos(pos - Vector(0, 0, parent.ac2))
        			else
        				parent.animstate = 0
        				hook.Remove("Think", hookname)
					end
				end
			end)			
		end
	end
end)
