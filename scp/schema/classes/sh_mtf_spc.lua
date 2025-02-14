CLASS.name = "МОГ Эпсилон-11: Специалист"
CLASS.faction = FACTION_MTF
CLASS.isDefault = false
CLASS.Rank = 3

CLASS_MTFSPC = CLASS.index

function CLASS:CanSwitchTo(client)
    return client:HasClassWhitelist(self.index)
end