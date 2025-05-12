sound.Add( {
	name = "lab_pump1",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 50,
	pitch = {195, 110},
	sound = "waterpump_1.wav"
} )


sound.Add( {
	name = "lab_pump2",
	channel = CHAN_STATIC,
	volume = 1.0,
	level = 60,
	pitch = {195, 110},
	sound = "waterpump_2.wav"
} )

local function emitsoundpump(ent)
	local a = CreateSound(ent, "lab_pump1")
	return a
end

local vector1 = Vector(0.000000, 0.000000, 0.850000)
local vector2 = Vector(0.050000, 1.000000, 1.000000)


local function updatepump(ent, posy)
	ent:SetLocalPos(Vector(0, posy, 5))
end

local function updatepump2(ent, posy, posz)
	ent:SetLocalPos(Vector(0, posy, posz))
end

hook.Add("YarTubeAnim", "Controller", function(parent, ent, newstate)
	if IsValid(parent) && IsValid(ent) && newstate ~= nil then
		if newstate == 1 then
			local hookname = "YarTubeUp_" .. parent:EntIndex()
			local pumping = emitsoundpump(ent)
			pumping:Play()
			parent.pumping = true
			hook.Add("Think", hookname, function()
				if IsValid(parent) && IsValid(ent) then
					if parent.ac1 <= 0.014 then
						parent.ac1 = parent.ac1 + 0.0001
						parent.ac2 = parent.ac2 + 0.00035
						local scale = ent:GetManipulateBoneScale(0)
						local pos = ent:GetLocalPos()
        				ent:ManipulateBoneScale( 0, scale + Vector(parent.ac1, 0, 0) )
        				ent:SetLocalPos(pos + Vector(0, 0, parent.ac2))
        			else
        				parent.filled = true
        				parent.pumping = false
        				parent.animstate = 1
        				hook.Remove("Think", hookname)
        				pumping:Stop()
					end
				end
			end)
		elseif newstate == 0 then
			local hookname = "YarTubeDown_" .. parent:EntIndex()
			local pumping = emitsoundpump(ent)
			pumping:Play()
			parent.pumping = true
			hook.Add("Think", hookname, function()
				if IsValid(parent) && IsValid(ent) then
					if parent.ac1 >= 0.001 then
						parent.ac1 = parent.ac1 - 0.0001
						parent.ac2 = parent.ac2 - 0.000325
						local scale = ent:GetManipulateBoneScale(0)
						local pos = ent:GetLocalPos()
						ent:ManipulateBoneScale( 0, scale - Vector(parent.ac1, 0, 0) )
						ent:SetLocalPos(pos - Vector(0, 0, parent.ac2))
        			else
        				parent.pumping = false
        				parent.animstate = 0
        				parent.ac1 = 0
        				parent.ac2 = 0
        				ent:ManipulateBoneScale(0, vector2)
        				ent:SetLocalPos(vector1)
        				hook.Remove("Think", hookname)
        				pumping:Stop()
					end
				end
			end)			
		end
	end
end)

function yar_pumperanim_downup(parent, ent, num)
	local moveposition = {
		[0] = 5,
		[1] = -3,
		[2] = 6.1,
	}

	local tt = ent:GetLocalPos()

	if IsValid(parent) && IsValid(ent) && num ~= nil then

		local hookname = "YarPumperMove1_" .. parent:EntIndex()
		ent.inmoving = true
		hook.Add("Think", hookname, function()
			if IsValid(parent) && IsValid(ent) then
				if tt.z ~= moveposition[num] then
					tt.z = math.Approach( tt.z, moveposition[num], 0.1 )
        			updatepump2(ent, tt.y, tt.z)
        		else
        			ent.inmoving = false
        			parent.animstate = num
        			hook.Remove("Think", hookname)
				end
			end
		end)	

	end
end

function yar_pumperanim_move(parent, ent, num, tube1, tube2, tube3)
	local moveposition = {
		[0] = -40,
		[1] = tube1:GetLocalPos().y,
		[2] = tube2:GetLocalPos().y,
		[3] = tube3:GetLocalPos().y,
	}

	local tubeents = {
		[0] = nil,
		[1] = tube1,
		[2] = tube2,
		[3] = tube3,
	}

	local tt = ent:GetLocalPos().y
	local tz = ent:GetLocalPos().z

	if IsValid(parent) && IsValid(ent) && num ~= nil then

		local hookname = "YarPumperMove1_" .. parent:EntIndex()
		ent.inmoving = true
		if tz ~= 5 then
			parent:DownUp(0)
		end
		timer.Create(hookname .. "_DelayUp", 2.5, 1, function()
			hook.Add("Think", hookname, function()
				if IsValid(parent) && IsValid(ent) then
					if tt ~= moveposition[num] then
						local tz = ent:GetLocalPos().z
						tt = math.Approach( tt, moveposition[num], 0.4 )
        				updatepump2(ent, tt, tz)
        			else
        				ent.inmoving = false
        				parent.animstate = num
        				hook.Remove("Think", hookname)
        				if num ~= 0 then
        					parent:DownUp(1)
        					timer.Create(hookname, 2.5, 1, function()
        						parent:FillTube(num)
        					end)
        				end
					end
				end
			end)
		end)	
	end
end