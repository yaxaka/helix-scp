ITEM.name = "Шифратор"
ITEM.model = Model("models/alyx_emptool_prop.mdl")
ITEM.description = "Модификация для ПНВ"
ITEM.category = "ПНВ"
ITEM.width = 1 
ITEM.height = 1
ITEM.noBusiness = true
ITEM.eqs = 0

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



if (CLIENT) then
	function ITEM:PaintOver(item, w, h)
		self.approachtarget = w-20
		
		if (item:GetData("equip")) then
			if item.eqs == 0 then item.eqs = 1 surface.PlaySound("npc/scanner/scanner_electric1.wav") end
			item.approach = math.Approach(item.approach, self.approachtarget, 5)
			draw.RoundedBox(10, 10, h-14, item.approach, 8, Color(110, 255, 110))
		elseif not (item:GetData("equip")) then
			if item.eqs == 1 then item.eqs = 0 surface.PlaySound("npc/scanner/scanner_electric2.wav") end
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



function ITEM:OnEquipped()
	local client = self.player
	client.Shifrator = true
end

function ITEM:OnUnequipped()
	local client = self.player
end
