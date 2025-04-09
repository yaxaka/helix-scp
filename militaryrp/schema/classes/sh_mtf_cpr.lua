CLASS.name = "МОГ Эпсилон-11: Капрал"
CLASS.faction = FACTION_MTF
CLASS.isDefault = false
CLASS.Rank = 4

CLASS_MTFCPR = CLASS.index

function CLASS:CanSwitchTo(client)
    return client:HasClassWhitelist(self.index)
end