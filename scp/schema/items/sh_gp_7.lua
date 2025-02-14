ITEM.name = "GP7"
ITEM.model = Model("models/eft_props/gear/nvgs/nvg_spi_t7.mdl")
ITEM.description = "ПНВ"
ITEM.category = "JmodGas"
ITEM.width = 1 -- Width and height refer to how many grid spaces this item takes up.
ITEM.height = 1
ITEM.Type = 4

-- Items will be purchasable through the business menu. To disable the purchasing of this item, we specify ITEM.noBusiness.
ITEM.noBusiness = true

-- If you'd rather have the item only purchasable by a specific criteria, then you can specify it as such.
-- Make sure you haven't defined ITEM.noBusiness if you are going to be doing this.
--[[
ITEM.factions = {FACTION_POLICE} -- Only a certain faction can buy this.
ITEM.classes = {FACTION_POLICE_CHIEF} -- Only a certain class can buy this.
ITEM.flag = "z" -- Only a character having a certain flag can buy this.
]]

-- If the item is purchasable, then you'll probably want to set a price for it:
--[[
ITEM.price = 5
]]

ITEM.functions.drop = {
	tip = "dropTip",
	icon = "icon16/world.png",
	OnRun = function(item)
		local bSuccess, error = item:Transfer(nil, nil, nil, item.player)

		if (!bSuccess and isstring(error)) then
			item.player:NotifyLocalized(error)
		else
			item:Remove()
		end

		return false
		end,
		OnCanRun = function(item)
			return !IsValid(item.entity) and !item.noDrop
	end
}

ITEM.functions.EquipOn = {
	name = "Экипировать",
	icon = "icon16/add.png", 
	OnRun = function(item)
		local client = item.player
		local entity = item.entity -- only set if this is function is being ran while the item is in the world

		if (IsValid(client)) and (!client:GetData("equipjmodg")) then
			client:ChatPrint("Вы экипировали противогаз")
			JmodTakeOnGas(client, item.uniqueID)
		else
			client:ChatPrint("Вы уже экипировали противогаз")
		end

			return false
		end,
}

ITEM.functions.EquipOff = {
	name = "Снять",
	icon = "icon16/add.png", 
	OnRun = function(item)
		local client = item.player
		local entity = item.entity -- only set if this is function is being ran while the item is in the world

		if (IsValid(client)) and (client:GetData("equipjmodg")) then
			client:ChatPrint("Вы сняли противогаз")
			JmodTakeOffGas(client, item.uniqueID)
		else
			client:ChatPrint("Вы уже сняли противогаз!")
		end

			return false
		end,
}