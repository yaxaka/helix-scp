ITEM.name = "BNTI Kirasa-N"
ITEM.model = Model("models/eft_props/gear/armor/ar_kirasa_n.mdl")
ITEM.description = "Бронежилет Кираса N поверхностного ношения предназначен для оснащения личного состава спецподразделений армии, полиции. Бронежилет обеспечивает круговую защиту торса человека. Элементы демпфера обеспечивают вентиляцию поджилетного пространства и уменьшают запреградный урон."
ITEM.category = "Бронежилет"
ITEM.width = 2 
ITEM.height = 3
ITEM.Jname = "BNTI Kirasa-N"
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