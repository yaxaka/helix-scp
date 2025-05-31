local pl = FindMetaTable("Player")

local all_ply = {}

util.AddNetworkString("yradio_switch")

net.Receive("yradio_switch", function(len, ply)
	local freq = net.ReadInt(9)
	ply:SetRadioFrequency(freq)
end)


function pl:SetupYRADIO()
	self:SetNW2Bool("yradio_talk", false)
	self:SetNW2Bool("yradio_hear", false)
	evoice_reset(self)
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
		evoice_reset(self)
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
	elseif (listener ~= talker) && (transmit) && (talk_freq == list_freq) && (dist < voice_dist) then
		
	end
end)