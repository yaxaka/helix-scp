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

function ply:GiveQuest(name, custom)
	for k,v in pairs(yaxaka_quests) do
		if v[name] then
			self.activequest = v[name]
			ymsg_d(self:SteamID64() .. " получил квест " .. v[name].Name)
			v[name].OnStart(self)
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

function ply:SetSecurityPoint(tabl)
	if self:HaveQuest() then
		self.qsp_min = tabl[1]
		self.qsp_max = tabl[2]
		self.qsp_name = tabl['name']
	end
end

function ply:GetSecurityPoint()
	return self.qsp_min, self.qsp_max, self.qsp_name
end