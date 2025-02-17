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
        client.SCP096 = true
        scp096_ply = client
        scp096_activated = true
        client:ToggleWepRaised()
        scp096_reset_targets()
    end
    function CLASS:OnSet(client)
        client:SetWalkSpeed(100)
        client:SetSlowWalkSpeed(100)
        client:SetRunSpeed(100)
        client:StripWeapons()
        client:Give("scp096_swep")
        client.SCP096 = true
        client.SCP = true
        scp096_ply = client
        scp096_activated = true
        client:ToggleWepRaised()
        scp096_reset_targets()
    end
end


function scp096_reset_targets()
    for i, v in ipairs( player.GetAll() ) do
        v.scp096_1 = false
    end
end