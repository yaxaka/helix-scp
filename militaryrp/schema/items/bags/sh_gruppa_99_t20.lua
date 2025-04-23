ITEM.name = "Gruppa 99 T20"
ITEM.model = Model("models/eft_props/gear/backpacks/bp_gr99t20_o.mdl")
ITEM.category = "Рюкзак"
ITEM.description = "Рюкзак объемом 22 литра с эргономичной подвеской для выполнения ограниченных по времени задач. Рюкзак можно использовать как для оперативных задач, так и для городского ношения. При правильной упаковке внутренний объем рюкзака может составлять 25-27 литров. Минималистичный дизайн и военная функциональность будут полезны в городских условиях. Производитель Gruppa 99. Версия Umber Brown."
ITEM.Jname = "Gruppa 99 T20 (T)"
ITEM.width = 5
ITEM.height = 5

ITEM.invWidth = 6
ITEM.invHeight = 6

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
