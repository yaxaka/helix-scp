ITEM.name = "Triton"
ITEM.model = Model("models/eft_props/gear/chestrigs/cr_triton.mdl")
ITEM.category = "Разгрузочный жилет"
ITEM.description = "Боевой нагрудник Тритон М43–А - Создан для размещёния и переноски элементов амуниции и снаряжения, для использования в умеренном и жарком климате"
ITEM.Jname = "Triton"
ITEM.width = 2
ITEM.height = 3

ITEM.invWidth = 4
ITEM.invHeight = 4

ITEM.noBusiness = true

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


if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		self.approachtarget = w-20
		if (item:GetData("equip")) then
			item.approach = math.Approach(item.approach, self.approachtarget, 5)
			draw.RoundedBox(10, 10, h-14, item.approach, 8, Color(110, 255, 110))
		elseif not (item:GetData("equip")) then
			item.approach = 1
		end
	end
end

ITEM.functions.EquipOn = {
	name = "Экипировать",
	icon = "icon16/shield.png", 
	OnRun = function(item)
		local client = item.player
		local entity = item.entity
		local equip = item:GetData("equip") 
		if (IsValid(client)) && (equip ~= true) then
			item:SetData("equip", true)
			item:OnEquipped()
		end

			return false
		end,
	OnCanRun = function(item)
		local equip = item:GetData("equip")
		local client = item.player
		if (equip ~= true) && not (IsValid(item.entity)) && (IsValid(client)) then
			return true
		else
			return false
		end
	end
}

ITEM.functions.EquipOff = {
	name = "Снять",
	icon = "icon16/shield_delete.png", 
	OnRun = function(item)
		local client = item.player
		local entity = item.entity

		if (IsValid(client)) && (item:GetData("equip") == true) then
			item:SetData("equip", false)
			item:OnUnequipped()
		end

			return false
		end,

	OnCanRun = function(item)
		local equip = item:GetData("equip")
		local client = item.player
		if (equip == true) && not (IsValid(item)) && (IsValid(client)) then
			return true
		else
			return false
		end
	end
}


ITEM:Hook("drop", function(item)
	--item:SetCollisionGroup(1)
	print("t")
end)



function ITEM:OnEquipped()
	local client = self.player
	hook.Run("JmodEquip", client, self.Jname, self)
end

function ITEM:OnUnequipped()
	local client = self.player
	hook.Run("JmodUnEquip", client, self.Jname, self)
end
