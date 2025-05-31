ITEM.name = "Рация"
ITEM.description = "Используется для связи на дистанции. На корпусе читается маркировка: Модель №1_3105"
ITEM.model = "models/skilllem_radio.mdl"
ITEM.width = 1
ITEM.height = 2



ITEM.model = "models/skilllem_radio.mdl"
ITEM.width = 1
ITEM.height = 2
ITEM.iconCam = {
    pos = Vector(-200, 0, 0),
    ang = Angle(-1.08, 0.05, 0),
    fov = 3.8
}



ITEM.functions.ATurnOn = {
    name = "Включить рацию", -- uses the "myFunctionPhrase" language phrase when displaying in the UI
    icon = "icon16/accept.png", -- path to the icon material
    OnRun = function(item)
        local client = item.player
        local entity = item.entity -- only set if this is function is being ran while the item is in the world

        if (IsValid(client)) then
            client:EmitSound("wt/click.wav")
        end

        -- do not remove this item from the owning player's inventory
        return false
    end,
    OnCanRun = function(item)
        -- only allow admins to run this item function
        local client = item.player
        return IsValid(client) and client:IsAdmin()
    end
}

ITEM.functions.BTurnOff = {
    name = "Выключить рацию", -- uses the "myFunctionPhrase" language phrase when displaying in the UI
    icon = "icon16/cancel.png", -- path to the icon material
    OnRun = function(item)
        local client = item.player
        local entity = item.entity -- only set if this is function is being ran while the item is in the world

        if (IsValid(client)) then
            client:EmitSound("wt/click.wav")
        end

        -- do not remove this item from the owning player's inventory
        return false
    end,
    OnCanRun = function(item)
        -- only allow admins to run this item function
        local client = item.player
        return IsValid(client) and client:IsAdmin()
    end
}