ITEM.name = "JmodVest"
ITEM.description = "A Outfit Base."
ITEM.category = "JmodVest"
ITEM.model = "models/Gibs/HGIBS.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.outfitCategory = "model"


function JmodTakeOnVest(client, item)
	local character = client:GetCharacter()

	client:SetData("equipjmodv", true)

	JMod.EZ_Equip_Armor(client, HelixToJmod[item])

end

function JmodTakeOffVest(client, item)
	local character = client:GetCharacter()

	client:SetData("equipjmodv", false)
	local find = client.EZarmor.items
	for k,v in pairs(find) do
		if v.name == HelixToJmod[item] then
			print(k)
			client.EZarmor.items[k] = nil
			JMod.UpdateInv(client, true, true)
		end
	end
end