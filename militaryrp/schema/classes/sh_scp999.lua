CLASS.name = "SCP-999"
CLASS.faction = FACTION_SCP
CLASS.isDefault = false
CLASS.Rank = 0

CLASS_SCP999 = CLASS.index

function CLASS:CanSwitchTo(client)
    return client:HasClassWhitelist(self.index)
end

if (SERVER) then
    function CLASS:OnSpawn(client)
        ResetClassParameters(client, self, self.faction)
    end
    function CLASS:OnSet(client)
        ResetClassParameters(client, self, self.faction)
    end
end