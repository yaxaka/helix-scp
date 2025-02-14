CLASS.name = "МОГ Эпсилон-11: Сержант Первого Класса"
CLASS.faction = FACTION_MTF
CLASS.isDefault = false
CLASS.Rank = 6

CLASS_MTFSRG2 = CLASS.index

function CLASS:CanSwitchTo(client)
    return client:HasClassWhitelist(self.index)
end