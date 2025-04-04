ITEM.name = "Шифратор"
ITEM.model = Model("models/alyx_emptool_prop.mdl")
ITEM.description = "Модификация для ПНВ"
ITEM.category = "ПНВ"
ITEM.width = 1 
ITEM.height = 1
ITEM.noBusiness = true
ITEM.eqs = 0
ITEM.hp = 100
ITEM.broken = false

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
	icon = "icon16/lightning_add.png", 
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
		if (equip ~= true) && not (IsValid(item.entity)) && (IsValid(client)) && not (item.broken) then
			return true
		else
			if (item.broken) then
				client:Notify("Устройство сломано")
			end
			return false
		end
	end
}

ITEM.functions.EquipOff = {
	name = "Снять",
	icon = "icon16/lightning_delete.png", 
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

ITEM.functions.hp = {
    name = "Узнать состояние", 
    tip = "Чем меньше значение, тем нестабильнее работа", 
    icon = "icon16/information.png", 
    OnRun = function(item)
        local client = item.player
        local entity = item.entity -- only set if this is function is being ran while the item is in the world

        if (IsValid(client)) then
            client:Notify("Состояние: " .. item.hp .. "/100")
        end

        return false
    end,
    OnCanRun = function(item)
        local client = item.player
        return IsValid(client)
    end
}

function ITEM:OnEquipped()
	local client = self.player
	local timerid = tostring(self)

	hook.Run("Shifrator", self, client)

	client.shifrator_attached = true

	timer.Create(timerid, 1, 0, function()
		self.hp = self.hp - 1

		if (self.hp == 75)then
			client:Notify("Шифратор отключён.")
			timer.Remove(timerid)
			self:SetData("equip", false)
			self:OnUnequipped(client)
		elseif (self.hp == 49) then
			client:Notify("Шифратор отключён.")
			timer.Remove(timerid)
			self:SetData("equip", false)
			self:OnUnequipped(client)
		elseif (self.hp <= 10) then
			client:Notify("Шифратор отключён.")
			timer.Remove(timerid)
			self:SetData("equip", false)
			self:OnUnequipped(client)
			return
		end

	end)

end

function ITEM:OnUnequipped(oldclient)

	local client = self.player
	local timerid = tostring(self)

	if client == nil then
		oldclient.shifrator_attached = false
	else
		client.shifrator_attached = false
	end
	

	if timer.Exists(timerid) then timer.Remove(timerid) end

	if self.hp <= 10 then
		self.broken = true
	end
end
