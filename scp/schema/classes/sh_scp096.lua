CLASS.name = "SCP-096"
CLASS.faction = FACTION_SCP
CLASS.isDefault = false
CLASS.Rank = 0

CLASS_SCP096 = CLASS.index

function CLASS:CanSwitchTo(client)
    return client:HasClassWhitelist(self.index)
end

if (SERVER) then
    function CLASS:OnSpawn(client)
        client:SetWalkSpeed(100)
        client:SetSlowWalkSpeed(100)
        client:SetRunSpeed(100)
        client:StripWeapons()
        client:Give("scp096_swep")
        client.SCP = true
        scp096_ply = client
        client:ToggleWepRaised()
    end
    function CLASS:OnSet(client)
        client:SetWalkSpeed(100)
        client:SetSlowWalkSpeed(100)
        client:SetRunSpeed(100)
        client:StripWeapons()
        client:Give("scp096_swep")
        client.SCP = true
        scp096_ply = client
        client:ToggleWepRaised()
    end
end
