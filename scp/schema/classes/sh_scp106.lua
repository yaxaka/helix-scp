CLASS.name = "SCP-106"
CLASS.faction = FACTION_SCP
CLASS.isDefault = false
CLASS.Rank = 0

CLASS_SCP106 = CLASS.index

function CLASS:CanSwitchTo(client)
    return client:HasClassWhitelist(self.index)
end