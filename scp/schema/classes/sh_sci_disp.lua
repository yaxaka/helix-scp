CLASS.name = "Диспетчер"
CLASS.faction = FACTION_SCI
CLASS.isDefault = false
CLASS.Rank = 3

CLASS_SCIDSP = CLASS.index

function CLASS:CanSwitchTo(client)
    return client:HasClassWhitelist(self.index)
end