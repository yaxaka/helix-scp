FACTION.name = "МОГ Эпсилон-11"
FACTION.description = "Обеспечивает внутреннюю безопасность Фонда SCP"
FACTION.color = Color(110, 110, 110)
FACTION.models = {"models/lucie/tro/tacticrespoff.mdl"}
FACTION.isDefault = true
FACTION.isGloballyRecognized = false

FACTION_MTF = FACTION.index

if (SERVER) then
    function FACTION:OnSpawn(client)
        ResetClassParameters(client, self, self.faction)
        client:SetBodygroup(3, 2) -- helmet
		client:SetBodygroup(7, 1) -- vest
		client:SetBodygroup(10, 1) -- patch
		client:SetBodygroup(11, 1) -- belt
		client:SetBodygroup(12, 0) -- belt
		client:SetBodygroup(6, 1) -- gloves
		if client == scp096_ply then
			scp096_ply = nil
		end
    end
    function FACTION:OnSet(client)
        ResetClassParameters(client, self, self.faction)
        client:SetBodygroup(3, 2) -- helmet
		client:SetBodygroup(7, 1) -- vest
		client:SetBodygroup(10, 1) -- patch
		client:SetBodygroup(11, 1) -- belt
		client:SetBodygroup(12, 0) -- belt
		client:SetBodygroup(6, 1) -- gloves
		if client == scp096_ply then
			scp096_ply = nil
		end
    end
end

ix.anim.SetModelClass("models/lucie/tro/tacticrespoff.mdl", "player")