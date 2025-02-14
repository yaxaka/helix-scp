CLASS.name = "МОГ Эпсилон-11: Сержант"
CLASS.faction = FACTION_MTF
CLASS.isDefault = false
CLASS.Rank = 5

CLASS_MTFSRG = CLASS.index

function CLASS:CanSwitchTo(client)
    return client:HasClassWhitelist(self.index)
end