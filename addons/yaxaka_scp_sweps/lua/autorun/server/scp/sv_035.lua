util.AddNetworkString("SCP035_Task")
util.AddNetworkString("SCP035_Psy1")
util.AddNetworkString("SCP035_Psy2")
util.AddNetworkString("SCP035VictimTable")
util.AddNetworkString("guiMouse")
util.AddNetworkString("SCP035Remove")

local delay = 0
scp035_victimtable = {}
scp035_victimlvl = {}


function scp035_psyradius(ply)
	if CurTime() < delay then return end
	for k,v in pairs(ents.FindInSphere(ply:GetPos(), 100)) do
		if (v:IsPlayer()) && (v ~= ply) && not (scp035_victimtable[v]) then
			if (scp035_victimlvl[v] == nil) then
				scp035_victimlvl[v] = 1
				scp035_launchpsy(v)
			elseif (scp035_victimlvl[v] <= 2) then
				scp035_victimlvl[v] = scp035_victimlvl[v] + 1
				scp035_launchpsy(v)
			elseif (scp035_victimlvl[v] >= 3) then
				scp035_victimtable[v] = v:Nick()
				scp035_sendvictims(v)
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

function scp035_launchpsy(ply)
	net.Start("SCP035_Psy1")
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

hook.Add("PlayerDeath", "Remove035", function(victim)
	if scp035_victimtable[victim] then
		table.RemoveByValue(scp035_victimtable, victim:Nick())
		scp035_victimlvl[victim] = 0
		net.Start("SCP035Remove")
		net.WriteEntity(victim)
		net.Send(scp_ply_vars.scp_035_ply)
	end
end)