CLASS.name = "МОГ Эпсилон-11: Рекрут"
CLASS.faction = FACTION_MTF
CLASS.isDefault = true
CLASS.Rank = 1

CLASS_MTFRECRUIT = CLASS.index

function CLASS:CanSwitchTo(client)
    return false
end

if (SERVER) then
    function CLASS:OnSpawn(client)
        net.Start("GuidanceY")
        net.Send(client)
    end
end
