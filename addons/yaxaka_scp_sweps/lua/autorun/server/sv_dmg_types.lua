local scp096_text_far = "Эхом доноситься как ломаються кости, рвёться плоть, сухожилия."
local scp096_text_close = "Кровь разбрызгиваеться во все стороны, объект выворачивает тело наизнанку и рвёт его, ошмётки крови распластываються по земле, заливая её кровью. Остатки падают на землю."

local eventdelay = 0

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