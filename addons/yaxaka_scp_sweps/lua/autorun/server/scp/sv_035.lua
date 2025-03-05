util.AddNetworkString("SCP035_Task")
util.AddNetworkString("SCP035_Psy1")
util.AddNetworkString("SCP035_Psy2")
util.AddNetworkString("SCP035VictimTable")
util.AddNetworkString("guiMouse")
util.AddNetworkString("SCP035Remove")
util.AddNetworkString("SCP035RestoreView")
util.AddNetworkString("SCP035_PsyZombie")
util.AddNetworkString("SCP035_PsySelect")
util.AddNetworkString("SCP035Change")

local delay = 0
scp035_victimtable = {}


function scp035_psyradius(ply)
	if CurTime() < delay then return end
	for k,v in pairs(ents.FindInSphere(ply:GetPos(), 400)) do
		if (v:IsPlayer()) && (v ~= ply) && (v:Under035Control() ~= true) then
			local lvl = v:Get035LVL()
			if (lvl == nil) then
				v:Add035LVL()
				scp035_launchpsy(v, 1)
			elseif (lvl <= 6) then
				v:Add035LVL()
				scp035_launchpsy(v, lvl)
			elseif (lvl >= 7) then
				scp035_setcontrol(v)
			end
		end
	end
	delay = CurTime() + 1
end

function scp035_sendvictims(target)
	local ply = scp_ply_vars.scp_035_ply
	net.Start("SCP035VictimTable")
	print("seding")
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

function scp035_setcontrol(ply)
	if (ply:Under035Control()) then return end
	ply:Set035Control()
	scp035_sendvictims(ply)
end

net.Receive("SCP035_Task", function(l, ply)
	if ply == scp_ply_vars.scp_035_ply then
		local target = net.ReadEntity()
		if target:Under035Control() && (target:Get035LVL() >= 3) then
			local task = net.ReadString()
			scp035_secondpsy(target, task)
		end
	end
end)


net.Receive("SCP035_PsySelect", function(l, ply)
	if ply == scp_ply_vars.scp_035_ply then
		local type = net.ReadInt(3)
		local target = net.ReadEntity()
		local psyhozlvl = target:Get035LVL()

		if psyhozlvl == nil then
			target:Add035LVL()
			scp035_launchpsy(target, 1)
			return
		end

		if type == 1 then
			if psyhozlvl >= 7 then scp035_setcontrol(target) return end
			psyhozlvl = psyhozlvl + 1
			target:Add035LVL()
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
	if victim:Under035Control() then
		table.RemoveByValue(scp035_victimtable, victim:Nick())
		victim:Restore035LVL()
		victim:Remove035Control()
		net.Start("SCP035Remove")
		net.WriteEntity(victim)
		net.Send(scp_ply_vars.scp_035_ply)
		net.Start("SCP035RestoreView")
		net.Send(victim)
	end
end)

hook.Add("PlayerDisconnected", "Remove035D", function(ply)
	if ply:Under035Control() && (scp_ply_vars.scp_035_ply ~= nil) then
		net.Start("SCP035Remove")
		net.WriteEntity(ply)
		net.Send(scp_ply_vars.scp_035_ply)
	end
	if ply == scp_ply_vars.scp_035_ply then
		scp035_victimtable = {}
	end
end)

hook.Add("ShowSpare1", "GUiEnable", function(ply)
	if ply == scp_ply_vars.scp_035_ply then
		net.Start("guiMouse")
		net.Send(ply)
	end
end)