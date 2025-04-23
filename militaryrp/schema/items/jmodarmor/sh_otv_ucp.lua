ITEM.name = "OTV (UCP)"
ITEM.model = Model("models/eft_props/gear/armor/ar_otv_ucp.mdl")
ITEM.description = "Бронежилет Interceptor состоит из тканевого жилета-чехла Outer Tactical Vest (OTV), конструктивно выполненного со спинным и грудным «карманами», и двух защитных керамико-композитных противопульных вставок SAPI или ESAPI."
ITEM.category = "Бронежилет"
ITEM.width = 2 
ITEM.height = 3
ITEM.Jname = "OTV"
ITEM.functions.drop = {
	tip = "dropTip",
	icon = "icon16/world.png",
	OnRun = function(item)
		local bSuccess, error = item:Transfer(nil, nil, nil, item.player)

		if (!bSuccess and isstring(error)) or (item:GetData("equip")) then
			item.player:Notify("Error")
			return false
		else
			item:Remove()
		end

		return false
		end,
		OnCanRun = function(item)
			return !IsValid(item.entity) and !item.noDrop and (item:GetData("equip") == false)
	end
}

ITEM.noBusiness = true