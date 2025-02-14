CLASS.name = "МОГ Эпсилон-11: Лейтенант"
CLASS.faction = FACTION_MTF
CLASS.isDefault = false
CLASS.Rank = 9

CLASS_MTFLT = CLASS.index

function CLASS:CanSwitchTo(client)
    return client:HasClassWhitelist(self.index)
end