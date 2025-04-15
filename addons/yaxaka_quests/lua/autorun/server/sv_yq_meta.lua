local ply = FindMetaTable( "Player" )

function ply:HaveQuest()
	if self.activequest ~= nil then
		return true
	elseif self.activequest == nil then
		return false
	end
end

function ply:ActiveQuest()
	if self:HaveQuest() then
		return self.activequest
	else
		return nil
	end
end

function ply:GiveQuest(name)
	for k,v in pairs(yaxaka_quests) do
		if v[name] then
			self.activequest = v
			ymsg_d(self:SteamID64() .. " получил квест " .. v.Name)
			yq_give_quest(self, v)
		end
	end
end

function ply:RemoveQuest()
	if self:HaveQuest() then
		self.activequest = nil
		yq_remove_quest(self)
		ymsg_d(self:SteamID64() .. " утратил квест")
	else
		ymsg_e(self:SteamID64() .. " попытка удалить квест без наличия квеста")
	end
end