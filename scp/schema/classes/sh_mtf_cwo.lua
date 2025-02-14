CLASS.name = "МОГ Эпсилон-11: Старший Уорент-Офицер"
CLASS.faction = FACTION_MTF
CLASS.isDefault = false
CLASS.Rank = 8

CLASS_MTFCWO = CLASS.index

function CLASS:CanSwitchTo(client)
    return client:HasClassWhitelist(self.index)
end