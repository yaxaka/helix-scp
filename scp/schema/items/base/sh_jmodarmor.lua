ITEM.name = "JMOD Armor"
ITEM.description = "A Jmod Outfit Base."
ITEM.category = "JArmor"
ITEM.model = "models/Gibs/HGIBS.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.jData = {}
ITEM.approach = 1

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
			print("clienteq")
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
			print("clientuneq")
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
	if self.Shifrator then
		client.Shifrator = true
	end
end

function ITEM:OnUnequipped()
	local client = self.player
	hook.Run("JmodUnEquip", client, self.Jname, self)
	if self.Shifrator then
		client.Shifrator = false
	end
end
