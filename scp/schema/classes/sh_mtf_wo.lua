CLASS.name = "МОГ Эпсилон-11: Уорент-Офицер"
CLASS.faction = FACTION_MTF
CLASS.isDefault = false
CLASS.Rank = 7

CLASS_MTFWO = CLASS.index

function CLASS:CanSwitchTo(client)
    return client:HasClassWhitelist(self.index)
end