
-- Here is where all of your serverside hooks should go.

-- Change death sounds of people in the police faction to the metropolice death sound.
function Schema:GetPlayerDeathSound(client)
	local character = client:GetCharacter()

	if (character and character:IsPolice()) then
		return "NPC_MetroPolice.Die"
	end
end


hook.Add("MedicineEFT", "Psyho", function(ply, type, strong)
	print(1)
	if not IsValid(ply) or type == nil then return end
	print(2)
	if type == "Psyho" then
		print(3)
		local lvl = ply:Get035LVL()
		if (lvl == nil) or (lvl == 0) then
			print(4)
			Schema:PillsAnimation(ply)
			ply:Notify("Вы не почувствовали ничего нового")
		else
			print(5)
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
