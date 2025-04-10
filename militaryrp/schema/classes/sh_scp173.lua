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
        ResetClassParameters(client, self, self.faction)
    end
    function CLASS:OnSet(client)
        ResetClassParameters(client, self, self.faction)
    end
end

function spawn_scp173_model(client)
    local scp173 = ents.Create("prop_dynamic")
    scp173:SetModel("models/scp/173.mdl")
    scp173:SetPos(client:GetPos())
    scp173:Spawn()
    scp_173_prop = scp173
    client:SetNoDraw(true)
    client:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
end