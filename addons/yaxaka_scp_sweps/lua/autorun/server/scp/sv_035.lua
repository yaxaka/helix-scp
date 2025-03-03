util.AddNetworkString("SCP035_Task")
util.AddNetworkString("SCP035_Psy1")
util.AddNetworkString("SCP035_Psy2")
util.AddNetworkString("SCP035VictimTable")
util.AddNetworkString("guiMouse")
util.AddNetworkString("SCP035Remove")
util.AddNetworkString("SCP035RestoreView")
util.AddNetworkString("SCP035_PsyZombie")
util.AddNetworkString("SCP035_PsySelect")

local delay = 0
scp035_victimtable = {}
scp035_victimlvl = {}


function scp035_psyradius(ply)
	if CurTime() < delay then return end
	for k,v in pairs(ents.FindInSphere(ply:GetPos(), 400)) do
		if (v:IsPlayer()) && (v ~= ply) && not (scp035_victimtable[v]) then
			scp_ply_vars.scp_035_ply:ChatPrint("Оказано воздействие на: " .. v:Nick())
			if (scp035_victimlvl[v] == nil) then
				scp035_victimlvl[v] = 1
				scp035_launchpsy(v, 1)
			elseif (scp035_victimlvl[v] <= 6) then
				scp035_victimlvl[v] = scp035_victimlvl[v] + 1
				scp035_launchpsy(v, scp035_victimlvl[v])
			elseif (scp035_victimlvl[v] >= 7) then
				scp035_victimtable[v] = v:Nick()
				scp035_sendvictims(v, scp035_victimlvl[v])
			end
		end
	end
	delay = CurTime() + 1
end

function scp035_sendvictims(target)
	local tb = scp035_victimtable
	local ply = scp_ply_vars.scp_035_ply
	net.Start("SCP035VictimTable")
	net.WriteEntity(target)
	net.Send(ply)
end

function scp035_launchpsy(ply, lvl)
	net.Start("SCP035_Psy1")
	net.WriteInt(lvl, 5)
	net.Send(ply)
end

function scp035_launchpsy_zombie(ply)
	net.Start("SCP035_PsyZombie")
	net.Send(ply)
end

function scp035_secondpsy(ply, task)
	net.Start("SCP035_Psy2")
	net.WriteString(task)
	net.Send(ply)
end

net.Receive("SCP035_Task", function(l, ply)
	if ply == scp_ply_vars.scp_035_ply then
		local target = net.ReadEntity()
		if scp035_victimtable[target] && (scp035_victimlvl[target] >= 3) then
			local task = net.ReadString()
			scp035_secondpsy(target, task)
		end
	end
end)


net.Receive("SCP035_PsySelect", function(l, ply)
	if ply == scp_ply_vars.scp_035_ply then
		local type = net.ReadInt(3)
		local target = net.ReadEntity()
		local psyhozlvl = scp035_victimlvl[target]

		if psyhozlvl == nil then
			scp035_victimlvl[target] = 1
			scp035_launchpsy(target, 1)
			return
		end

		if type == 1 then
			psyhozlvl = psyhozlvl + 1
			scp035_launchpsy(target, psyhozlvl)
		end

		if type == 2 then
			if psyhozlvl <= 4 then
				ply:ChatPrint("Игрок под слишком слабым воздействием")
			else
				scp035_launchpsy_zombie(target)
			end
		end
	end
end)


hook.Add("PlayerDeath", "Remove035", function(victim)
	if scp035_victimtable[victim] then
		table.RemoveByValue(scp035_victimtable, victim:Nick())
		scp035_victimlvl[victim] = 0
		net.Start("SCP035Remove")
		net.WriteEntity(victim)
		net.Send(scp_ply_vars.scp_035_ply)
		net.Start("SCP035RestoreView")
		net.Send(victim)
	end
end)

hook.Add("PlayerDisconnected", "Remove035D", function(ply)
	if scp035_victimtable[victim] then
		table.RemoveByValue(scp035_victimtable, victim:Nick())
		scp035_victimlvl[victim] = 0
		net.Start("SCP035Remove")
		net.WriteEntity(victim)
	end
	if scp035_victimlvl[victim] then
		table.RemoveByValue(scp035_victimtable, victim:Nick())
	end
	if ply == scp_ply_vars.scp_035_ply then
		scp035_victimtable = {}
		scp035_victimlvl = {}
	end
end)

hook.Add("ShowSpare1", "GUiEnable", function(ply)
	if ply == scp_ply_vars.scp_035_ply then
		net.Start("guiMouse")
		net.Send(ply)
	end
end)