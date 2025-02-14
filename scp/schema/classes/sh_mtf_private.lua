CLASS.name = "МОГ Эпсилон-11: Рядовой"
CLASS.faction = FACTION_MTF
CLASS.isDefault = false
CLASS.Rank = 2

CLASS_MTFPVT = CLASS.index

function CLASS:CanSwitchTo(client)
    return client:HasClassWhitelist(self.index)
end