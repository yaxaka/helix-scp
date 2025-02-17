local scp096_text_far = "Эхом доноситься как ломаються кости, рвёться плоть, сухожилия."
local scp096_text_close = "Кровь разбрызгиваеться во все стороны, объект выворачивает тело наизнанку и рвёт его, ошмётки крови распластываються по земле, заливая её кровью. Остатки падают на землю."

local eventdelay = 0

scp096_activated = false
scp096_ply = nil
scp096_triggered = false
scp096_1_count = 0

util.AddNetworkString("SCP096_1_Ent")

hook.Add("PlayerSwitchWeapon", "Activate096", function(ply, old, new)

	if not (IsValid(old) && IsValid(new)) then return end

	local nname = new:GetClass()
	local oldname = old:GetClass()

	if (nname == "scp096_swep") then
		scp096_ply = ply
		scp096_activated = true
		ply.SCP096 = true
	end

	if (oldname == "scp096_swep") then
		scp096_ply = nil
		scp096_activated = false
		ply.SCP096 = false
	end
end)


hook.Add("Think", "SCP096_Parse", function()
	if not scp096_activated then return end
	for i, v in ipairs(player.GetAll()) do
    	local tr = util.TraceLine(util.GetPlayerTrace(v))
    		if IsValid(tr.Entity) then
    			if (tr.Entity.SCP096) and not (v.scp096_1) and (v:Alive()) then
    				v:ChatPrint("Я чувствую, что что-то не так...")
    				v.scp096_1 = true
    				scp096_1_count = scp096_1_count + 1
    				scp096_triggered_func(scp096_ply)
    				net.Start("SCP096_1_Ent")
    				net.WriteInt(1, 2)
    				net.WriteEntity(v)
    				net.Send(scp096_ply)
    			end
    		end
	end
end)




function scp096_attack(victim, scp)
	local d = DamageInfo()
	d:SetDamage(victim:Health())
	d:SetAttacker(scp)
	d:SetDamageType(DMG_GENERIC) 

	victim:TakeDamageInfo(d)


	if CurTime() < eventdelay then return end
	local trace = scp:GetEyeTrace()

	local Pos1 = trace.HitPos + trace.HitNormal
	local Pos2 = trace.HitPos - trace.HitNormal

	for i=1,10 do
		util.Decal("Blood", Pos1, Pos2)
	end


	ix.chat.Send(scp, "localevent", scp096_text_far, nil, nil, {range = 3000})
	ix.chat.Send(scp, "localevent", scp096_text_close, nil, nil, {range = 1000})


	eventdelay = CurTime() + 5
end


function scp096_triggered_func(scp)
	print("trigger1")
	if timer.Exists("SCP_096_TRIGGERED") then return end
	print("trigger2")
	if scp096_triggered then return end
	print("trigger3")
	scp096_triggered = true
	local maxspeed = 400
	local maxrun = 400
	scp:Freeze(true)
	scp:EmitSound("096_triggering.wav")
	timer.Create("SCP_096_TRIGGERED", 30, 1, function()
		scp:Freeze(false)
		scp:SetMaxSpeed(maxspeed)
		scp:SetRunSpeed(maxrun)
	end)
end


function scp_096_chillout(scp)
	print("chill")
	scp:SetMaxSpeed(100)
	scp:SetRunSpeed(100)
end



hook.Add("OnNPCKilled", "Test", function(npc, attacker, inflictor)
	local pos = npc:GetPos()
	local ang = npc:GetAngles()
	local mdl = npc:GetModel()
	local uid = "SCP096_NPC_" .. npc:EntIndex()
	npc:Remove()
	--timer.Create(uid, 0.01, 1, function()
	--	ylib_CreateRagdoll(pos, ang, mdl)
	--end)
end)

hook.Add("PlayerDeath", "GlobalDeathMessage", function(victim)
	if victim.scp096_1 then
		victim.scp096_1 = false
		scp096_1_count = scp096_1_count - 1
	end

	if scp096_1_count <= 0 then
		scp096_1_count = 0
		scp096_triggered = false
		scp_096_chillout(scp096_ply)
		net.Start("SCP096_1_Ent")
		net.WriteInt(2, 2)
		net.WriteEntity(victim)
		net.Send(scp)
	end
end)