ITEM.name = "JmodPNV"
ITEM.description = "A Outfit Base."
ITEM.category = "JmodPNV"
ITEM.model = "models/Gibs/HGIBS.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.outfitCategory = "model"


function JmodTakeOnPNV(client, item)
	local character = client:GetCharacter()

	client:SetData("equipjmodp", true)

	JMod.EZ_Equip_Armor(client, HelixToJmod[item])

end

function JmodTakeOffPNV(client, item)
	local character = client:GetCharacter()

	client:SetData("equipjmodp", false)
	local find = client.EZarmor.items
	for k,v in pairs(find) do
		if v.name == HelixToJmod[item] then
			print(k)
			client.EZarmor.items[k] = nil
			JMod.UpdateInv(client, true, true)
		end
	end
end