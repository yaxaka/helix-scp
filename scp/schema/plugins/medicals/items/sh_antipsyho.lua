ITEM.name = "Синяя таблетка"
ITEM.model = Model("models/props_junk/popcan01a.mdl")
ITEM.description = "Таблетка овальной формы, с гравиркой 'AP'"
ITEM.category = "Медицина"
ITEM.width = 1
ITEM.height = 1
ITEM.pill = true

ITEM.noBusiness = true



ITEM.functions.Use = {
    name = "Использовать", 
    icon = "icon16/pill.png", 
    OnRun = function(item)
        local client = item.player

        if (IsValid(client)) then
        	item:OnUsed()
            return true
        end

        -- do not remove this item from the owning player's inventory
        return false
    end,
    OnCanRun = function(item)
    	return true
    end
}

function ITEM:OnUsed()
	local client = self.player
	hook.Run("MedicineEFT", client, "Psyho", 1)
end