CLASS.name = "МОГ Эпсилон-11: Капитан"
CLASS.faction = FACTION_MTF
CLASS.isDefault = false
CLASS.Rank = 10

CLASS_MTFCPT = CLASS.index

function CLASS:CanSwitchTo(client)
    return client:HasClassWhitelist(self.index)
end