hook.Add("MedicineEFT", "Psyho", function(ply, type, strong)
	if not IsValid(ply) or type == nil then return end
	if type == "Psyho" then
		local lvl = ply:Get035LVL()
		if (lvl == nil) or (lvl == 0) then
			Schema:PillsAnimation(ply)
			ply:Notify("Вы не почувствовали ничего нового")
		else
			Schema:PillsAnimation(ply)
			ply:Notify("Вы чувствуете себя лучше")
			ply:Minus035LVL()
		end
	end
end)

hook.Add("YaxakaPillCase", "DefaultController", function(ply, bool, pill)
	if not IsValid(ply) or bool == nil then return end
	if bool then
		--add pill
	elseif not bool then
		--remove pill
	end
end)