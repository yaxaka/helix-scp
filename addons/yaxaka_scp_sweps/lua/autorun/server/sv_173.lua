scp_173_activated = false
scp_173_ply = nil
scp_173_canmove = true
scp_173_prop =  nil
scp_173_watchers = {}
scp_173_moves = {"scp_173_step01.wav", "scp_173_step02.wav", "scp_173_step03.wav", "scp_173_step04.wav", "scp_173_step05.wav", "scp_173_step06.wav", "scp_173_step07.wav", "scp_173_step08.wav", "scp_173_step09.wav", "scp_173_step10.wav", "scp_173_step11.wav"}

util.AddNetworkString("SCP173_Scream")



hook.Add("Think", "SCP173_Move", function()
	if not scp_173_activated then return end
	local scp_pos = scp_173_prop:GetPos()
	scp_173_visible()
	if #scp_173_watchers <= 2 then
		scp_173_canmove = true
	elseif #scp_173_watchers >= 3 then
		scp_173_canmove = false
	end
end)

function scp_173_scream(ply)
	net.Start("SCP173_Scream")
	net.Send(ply)
end

function scp_173_move()
	scp_173_ply:EmitSound(scp_173_moves[math.random(1, #scp_173_moves)])
end

function scp_173_visible()
	for i, v in ipairs(player.GetAll()) do
    	local visible = islookingat(v, scp_173_prop)
    	local ts = not_in_173_table(v)
    	if visible && (v ~= scp_173_ply) && (ts) && (v:Alive()) then
    		table.insert(scp_173_watchers, v)
    	elseif not visible && (v ~= scp_173_ply) then
    		table.RemoveByValue(scp_173_watchers, v)
    	end
	end
end

function not_in_173_table(ply)
	for k,v in ipairs(scp_173_watchers) do
		if v == ply then
			return true
		end
		return false
	end
end


function islookingat( ply, data )
	if not IsValid( data ) then return end
	local mins, maxs = data:GetModelBounds()
	local h = Vector( 0, 0, maxs.z - mins.z )
	local pos = data:GetPos() + h * .25

	local vis = math.cos( math.rad( ( ply:GetFOV() + 50 ) / 2 ) )
	local diff = ply:GetAimVector():Dot((pos - (ply:GetPos() + ply:EyePos()) / 2 ):GetNormalized())
	return diff > 0 and diff > vis and ( ply:IsLineOfSightClear( pos ) or ply:IsLineOfSightClear( pos + h ) )
end

hook.Add("PlayerFootstep", "SCP173_Step", function(ply, pos, foot, sound, volume, rf)
	if scp_173_activated then
		if ply == scp_173_ply then
			return false
		end
	end
end)

hook.Add("PlayerDeath", "SCP173_AfterKill", function(victim, inf, attacker)
	if scp_173_activated then
		if (attacker == scp_173_ply) then
			attacker:EmitSound("scp_173_attack02.wav")
		end
	end
end)