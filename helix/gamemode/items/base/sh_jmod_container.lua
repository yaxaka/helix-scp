ITEM.name = "JmodCont"
ITEM.description = "A Outfit Base."
ITEM.category = "JmodCont"
ITEM.model = "models/Gibs/HGIBS.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.outfitCategory = "model"


function JmodTakeOnContainer(client, item)
	local character = client:GetCharacter()

	client:SetData("equipjmodc", true)

	JMod.EZ_Equip_Armor(client, HelixToJmod[item])

end

function JmodTakeOffContainer(client, item)
	local character = client:GetCharacter()

	client:SetData("equipjmodc", false)
	local find = client.EZarmor.items
	for k,v in pairs(find) do
		if v.name == HelixToJmod[item] then
			print(k)
			client.EZarmor.items[k] = nil
			JMod.UpdateInv(client, true, true)
		end
	end
end