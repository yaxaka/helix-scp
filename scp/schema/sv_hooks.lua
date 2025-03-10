
-- Here is where all of your serverside hooks should go.

-- Change death sounds of people in the police faction to the metropolice death sound.
function Schema:GetPlayerDeathSound(client)
	local character = client:GetCharacter()

	if (character and character:IsPolice()) then
		return "NPC_MetroPolice.Die"
	end
end

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

