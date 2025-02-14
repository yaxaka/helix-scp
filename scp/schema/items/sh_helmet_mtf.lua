ITEM.name = "FAST MT"
ITEM.model = Model("models/eft_props/gear/helmets/helmet_ops_core_fast_black.mdl")
ITEM.description = "Элемент броневой индивидуальной защиты человека"
ITEM.category = "JmodHelmet"
ITEM.width = 2 -- Width and height refer to how many grid spaces this item takes up.
ITEM.height = 2
ITEM.Type = 2

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

		if (IsValid(client)) and (!client:GetData("equipjmodh")) then
			client:ChatPrint("Вы экипировали шлем")
			JmodTakeOnHelmet(client, item.uniqueID)
		else
			client:ChatPrint("Вы уже экипировали шлем")
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

		if (IsValid(client)) and (client:GetData("equipjmodh")) then
			client:ChatPrint("Вы сняли шлем")
			JmodTakeOffHelmet(client, item.uniqueID)
		else
			client:ChatPrint("Вы уже сняли шлем!")
		end

			return false
		end,
}