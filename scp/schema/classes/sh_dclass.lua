CLASS.name = "Класс D"
CLASS.faction = FACTION_DCLASS
CLASS.isDefault = true
CLASS.Rank = 0

CLASS_DCLASS = CLASS.index

function CLASS:CanSwitchTo(client)
    return client:HasClassWhitelist(self.index)
end