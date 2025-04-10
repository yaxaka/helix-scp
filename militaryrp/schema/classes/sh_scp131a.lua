CLASS.name = "SCP-131-A"
CLASS.faction = FACTION_SCP
CLASS.isDefault = false
CLASS.Rank = 0

CLASS_SCP131A = CLASS.index

if (SERVER) then
    function CLASS:OnSpawn(client)
        ResetClassParameters(client, self, self.faction)
    end
    function CLASS:OnSet(client)
        ResetClassParameters(client, self, self.faction)
    end
end

function CLASS:CanSwitchTo(client)
    return client:HasClassWhitelist(self.index)
end