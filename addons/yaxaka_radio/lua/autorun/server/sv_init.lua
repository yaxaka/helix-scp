local pl = FindMetaTable("Player")

local functionsman = {
	[1] = function(ply, freq)
		ply:SetRadioFrequency(freq)
		ymsg_d(ply:Nick() .. " changed freq to " .. freq)
	end,
	[2] = function(ply, state)
		if state == 1 then
			ply:RadioTalk(true)
		elseif state == 2 then
			ply:RadioTalk(false)
		end
		ymsg_d(ply:Nick() .. " changed radiotalk to " .. state)
	end,
	[3] = function(ply, state)
		if state == 1 then
			ply:RadioHear(true)
		elseif state == 2 then
			ply:RadioHear(false)
		end
		ymsg_d(ply:Nick() .. " changed radiohear to " .. state)
	end,
}

util.AddNetworkString("yradio_switch")

local delay = {}

net.Receive("yradio_switch", function(len, ply)
	if delay[ply] == nil then delay[ply] = CurTime() end
	if CurTime() < delay[ply] then return end

	local type = net.ReadInt(3)
	local state = net.ReadInt(9)
	if type == nil or state == nil then return end

	functionsman[type](ply, state)
	ply:EmitSound("wt/click.wav")
	delay[ply] = CurTime() + 0.5
end)


function pl:SetupYRADIO()
	self:SetNW2Bool("yradio_talk", false)
	self:SetNW2Bool("yradio_hear", false)
end

function pl:SetRadioFrequency(num)
	self.RadioFreq = num
end

function pl:GetRadioFrequency()
	return self.RadioFreq
end

function pl:IsRadioTalk()
	return self:GetNW2Bool("yradio_talk") 
end

function pl:IsRadioHear()
	return self:GetNW2Bool("yradio_hear")
end

function pl:RadioTalk(bool)
	if bool then
		self:SetNW2Bool("yradio_talk", true)
	elseif not bool then
		self:SetNW2Bool("yradio_talk", false)
	end
end

function pl:RadioHear(bool)
	if bool then
		self:SetNW2Bool("yradio_hear", true)
	elseif not bool then
		self:SetNW2Bool("yradio_hear", false)
	end
end



hook.Add("PlayerCanHearPlayersVoice", "YRadio1", function(listener, talker)
	if listener == talker then return end
	local transmit = talker:IsRadioTalk()
	local talk_freq = talker:GetRadioFrequency()
	local list_freq = listener:GetRadioFrequency()
	local dist = talker:GetPos():Distance(listener:GetPos())
	local voice_dist = ix.config.Get("voiceDistance")

	if (listener ~= talker) && (transmit) && (talk_freq == list_freq) && (dist > voice_dist) then
		if listener:IsRadioHear() then
			return true
		end		
	end
end)