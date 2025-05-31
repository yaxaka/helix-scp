ITEM.name = "Инжектор"
ITEM.model = Model("models/weapons/sweps/eft/injector/w_meds_injector.mdl")
ITEM.width = 1
ITEM.height = 2
ITEM.funcs = "nil"
ITEM.infotable = {}


ITEM.iconCam = {
    pos = Vector(509.64, 427.61, 310.24),
    ang = Angle(24.7, 220, 0),
    fov = 0.47
}



function ITEM:GetDescription()
    return self:GetData("description", "T.F")
end

function ITEM:GetFuncs()
    return self:GetData("funcs", "nil")
end

function ITEM:GetInfoTbl()
    return self:GetData("infotable", "nil")
end

ITEM.functions.AUseSelf = {
    name = "Использовать на себе", 
    icon = "icon16/add.png", 
    OnRun = function(item)
        local client = item.player
        local entity = item.entity

        if (IsValid(client)) then
            client:ChatPrint(item:GetData("funcs"))
            hook.Run("YInjector_Use1", client, item:GetData("funcs"))
        end

        return false
    end,
    OnCanRun = function(item)
        local client = item.player
        return IsValid(client)
    end
}

ITEM.functions.BUseAnother = {
    name = "Использовать на другом", 
    icon = "icon16/add.png", 
    OnRun = function(item)
        local client = item.player
        local entity = item.entity

        if (IsValid(client)) then
            client:ChatPrint("This is a test.")

            if (IsValid(entity)) then
                client:ChatPrint(entity:GetName())
            end
        end

        return false
    end,
    OnCanRun = function(item)
        local client = item.player
        if IsValid(item.entity) then return false end
        return IsValid(client)
    end
}

ITEM.functions.CRead = {
    name = "Прочитать маркировку", 
    icon = "icon16/add.png", 
    OnRun = function(item)
        local client = item.player
        local entity = item.entity

        if (IsValid(client)) then
            for k,v in pairs(item:GetData("infotable")) do
                client:ChatPrint(v)
            end
        end

        return false
    end,
    OnCanRun = function(item)
        local client = item.player
        if IsValid(item.entity) then return false end
        return IsValid(client)
    end
}