ITEM.name = "Синяя таблетка"
ITEM.model = Model("models/props_junk/popcan01a.mdl")
ITEM.description = "Таблетка овальной формы, с гравиркой 'AP'"
ITEM.category = "Медицина"
ITEM.width = 1
ITEM.height = 1
ITEM.Type = "Psyho"
ITEM.Strong = 1


ITEM.noBusiness = true



ITEM.functions.Drink = {
	OnRun = function(item)
		-- IMPORTANT: Make sure you use "item" instead of "ITEM" here - these two are entirely different things!
		local client = item.player

		hook.Run("MedicineEFT", client, item.Type, item.Strong)
		-- Returning true will cause the item to be removed from the character's inventory.
		return true
	end
}
