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
util.AddNetworkString("SCP035Change2")

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

scp035_havebody = false

function scp035_takebody(owner)
	local tr = owner:GetEyeTrace().Entity
	if scp035_havebody then return end
	if IsValid(tr) && tr:IsPlayer() then
		local dist = owner:GetPos():Distance(tr:GetPos())
		if dist > 60 then return end
		scp035_havebody = true
		local model = tr:GetModel()
		local targetweapons = tr:GetWeapons()
		local bodygr = tr:GetBodyGroups()
		local trhp = tr:Health()
		local trarm = tr:Armor()
		tr:Kill()
		owner:SetModel(model)
		owner:SetHealth(trhp)
		owner:SetArmor(trarm)
		net.Start("SCP035Change2")
		net.WriteEntity(owner)
		net.WriteBool(true)
		net.Broadcast()
		owner:StartBodyRot035()
	end
end



function scp035_bodydead()
	net.Start("SCP035Change2")
	net.WriteEntity(owner)
	net.WriteBool(false)
	net.Broadcast()
	scp_ply_vars.scp_035_ply:SetModel("models/scp_035_real/scp_035_real.mdl")
	scp035_havebody = false
end

function scp035_sendvictims(target)
	local ply = scp_ply_vars.scp_035_ply
	ysn_send("SCP035VictimTable", {target}, ply)
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
	ysn_send("SCP035_Psy2", {task}, ply)
end

function scp035_setcontrol(ply)
	if (ply:Under035Control() == true) then return end
	print("trigger2")
	ply:Set035Control()
	print(ply)
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
			if psyhozlvl >= 7 then print("trigger5") scp035_setcontrol(target) return end
			print("trigger4")
			psyhozlvl = psyhozlvl + 1
			target:Add035LVL()
			scp035_setcontrol(target)
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

		ysn_send("SCP035Remove", {victim}, scp_ply_vars.scp_035_ply)

		net.Start("SCP035RestoreView")
		net.Send(victim)


	end
	if victim == scp_ply_vars.scp_035_ply then
		local oldpos = victim:GetPos()
		victim:Spawn()
		victim:SetPos(oldpos)
		scp035_bodydead()
	end
end)

hook.Add("EntityTakeDamage", "SCP035death", function(ply, dmg)
	if ply ~= scp_ply_vars.scp_035_ply then return end
	local hp = ply:Health()
	local damage = dmg:GetDamage()
	if damage > hp then
		scp035_bodydead()
		dmg:SetDamage(0)
	end 
end)




hook.Add("PlayerDisconnected", "Remove035D", function(ply)
	if ply:Under035Control() && (scp_ply_vars.scp_035_ply ~= nil) then
		ysn_send("SCP035Remove", {ply}, scp_ply_vars.scp_035_ply)
	end
	if ply == scp_ply_vars.scp_035_ply then
		scp035_victimtable = {}
		scp035_havebody = false
	end
end)

hook.Add("ShowSpare1", "GUiEnable", function(ply)
	if ply == scp_ply_vars.scp_035_ply then
		net.Start("guiMouse")
		net.Send(ply)
	end
end)