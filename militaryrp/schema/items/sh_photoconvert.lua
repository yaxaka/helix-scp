ITEM.name = "Конверт с фото"
ITEM.description = "Необходимо его вскрыть чтобы увидеть содержимое."
ITEM.model = Model("models/props_debris/concrete_cynderblock001.mdl")
ITEM.width = 1
ITEM.height = 1

ITEM.functions.MyFunction = {
    name = "Вскрыть", -- uses the "myFunctionPhrase" language phrase when displaying in the UI
    icon = "icon16/camera.png", -- path to the icon material
    OnRun = function(item)
        local client = item.player
        local entity = item.entity -- only set if this is function is being ran while the item is in the world

        if (IsValid(client)) then
            client:ChatPrint("This is a test.")

            if (IsValid(entity)) then
                client:ChatPrint(entity:GetName())
            end
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