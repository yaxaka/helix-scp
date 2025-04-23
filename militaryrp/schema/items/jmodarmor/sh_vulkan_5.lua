ITEM.name = "Vulkan-5"
ITEM.model = Model("models/eft_props/gear/helmets/helmet_vulkan_5.mdl")
ITEM.description = "Тяжелый защитный с высоким уровнем защиты «Вулкан-5» предназначен для использования в комплекте боевой экипировки с целью круговой защиты головы человека шестого класса от пуль стрелкового оружия."
ITEM.category = "Шлем"
ITEM.width = 2 
ITEM.height = 2
ITEM.Jname = "Vulkan-5"
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