CLASS.name = "SCP-173"
CLASS.faction = FACTION_SCP
CLASS.isDefault = false
CLASS.Rank = 0

CLASS_SCP173 = CLASS.index

function CLASS:CanSwitchTo(client)
    return client:HasClassWhitelist(self.index)
end

if (SERVER) then
    function CLASS:OnSpawn(client)
        client:SetWalkSpeed(200)
        client:SetSlowWalkSpeed(150)
        client:SetRunSpeed(500)
        client:StripWeapons()
        client:Give("scp173_swep")
        client.SCP = true
        client.SCP096 = false
        scp_173_ply = client
        scp_173_activated = true
        client:ToggleWepRaised()
        client.scp096_1 = false
        spawn_scp173_model(client)
    end
    function CLASS:OnSet(client)
        client:SetWalkSpeed(200)
        client:SetSlowWalkSpeed(150)
        client:SetRunSpeed(500)
        client:StripWeapons()
        client:Give("scp173_swep")
        client.SCP096 = false
        client.SCP = true
        scp_173_ply = client
        scp_173_activated = true
        client:ToggleWepRaised()
        client.scp096_1 = false
        spawn_scp173_model(client)
    end
end

function spawn_scp173_model(client)
    local scp173 = ents.Create("prop_dynamic")
    scp173:SetModel("models/props_wasteland/gaspump001a.mdl")
    scp173:SetPos(client:GetPos())
    scp173:Spawn()
    scp_173_prop = scp173
    client:SetNoDraw(true)
    client:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
    print(scp173)
end