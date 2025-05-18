function yas_sendwarn(text_type, priority, target, text)
	net.Start("YAS_Main")
	net.WriteString("warn")
	net.WriteEntity(target)
	net.WriteInt(text_type, 5)
	net.WriteInt(priority, 5)
	if text ~= nil && text ~= "" then
		net.WriteString(text)
	end
	net.SendToServer()
	LocalPlayer():Notify("Предупреждение отправлено игроку.")
	yas_bsend()
end

function yas_tp_pos(target, pos)
	target.yas_tp_pos = pos
	LocalPlayer():Notify("Точка телепорта установлена на вашем месте.")
end

function yas_giveadmin(target, bool)
	net.Start("YAS_RequestAction")
	net.WriteEntity(target)
	net.WriteBool(bool)
	net.SendToServer()
end

function yas_tp_send(target)
	target.teleported = true
	target.returnpos = target:GetPos()
	net.Start("YAS_Main")
	net.WriteString("tp")
	net.WriteEntity(target)
	net.WriteVector(target.yas_tp_pos)
	net.SendToServer()
	target.yas_tp_pos = nil
	LocalPlayer():Notify("Игрок телепортирован. Его точка телепорта сброшена.")
	yas_bsend()
end

function yas_tp_send(target)
	net.Start("YAS_Main")
	net.WriteString("tp")
	net.WriteEntity(target)
	net.WriteVector(target.returnpos)
	net.SendToServer()
	target.yas_tp_pos = nil
	target.teleported = nil
	LocalPlayer():Notify("Игрок вернут обратно. Его точка телепорта сброшена.")
	yas_bsend()
end

function yas_voicemute(target)
	target.voice_muted = true
	yas_netmute(1, target)
	LocalPlayer():Notify("Воис игрока замучен.")
	yas_bsend()
end

function yas_voiceunmute(target)
	target.voice_muted = nil
	yas_netmute(2, target)
	LocalPlayer():Notify("Воис игрока размучен.")
	yas_bsend()
end

function yas_chatmute(target)
	target.chat_muted = true
	yas_netmute(3, target)
	LocalPlayer():Notify("Чат игрока замучен.")
	yas_bsend()
end

function yas_chatunmute(target)
	target.chat_muted = nil
	yas_netmute(4, target)
	LocalPlayer():Notify("Чат игрока размучен.")
	yas_bsend()
end


function yas_netmute(type, target)
	net.Start("YAS_Main")
	net.WriteString("mute")
	net.WriteInt(type, 4)
	net.WriteEntity(target)
	net.SendToServer()
	yas_bsend()
end

function yas_pm(target, text)
	net.Start("YAS_Main")
	net.WriteString("pm")
	net.WriteEntity(target)
	net.WriteString(text)
	net.SendToServer()
	LocalPlayer():ChatNotify("Сообщение отправлено")
end

function yas_freeze(target, type)
	net.Start("YAS_Main")
	net.WriteString("freeze")
	net.WriteEntity(target)
	net.WriteInt(type, 4)
	net.SendToServer()
	yas_bsend()
end

function yas_god(target, type)
	net.Start("YAS_Main")
	net.WriteString("god")
	net.WriteEntity(target)
	net.WriteInt(type, 4)
	net.SendToServer()
	yas_bsend()
end

function yas_hp(target)
	net.Start("YAS_Main")
	net.WriteString("hp")
	net.WriteEntity(target)
	net.SendToServer()
	yas_bsend()
end

function yas_kick(target)
	net.Start("YAS_Main")
	net.WriteString("kick")
	net.WriteEntity(target)
	net.SendToServer()
	yas_bsend()
end

function yas_ban(target)
	net.Start("YAS_Main")
	net.WriteString("ban")
	net.WriteEntity(target)
	net.SendToServer()
	yas_bsend()
end

function yas_setclass(target, index, index2, bool)
	net.Start("YAS_Main")
	net.WriteString("whitelist")
	net.WriteBool(bool)
	net.WriteEntity(target)
	net.WriteString(index)
	net.WriteString(index2)
	net.SendToServer()
	yas_bsend()
end



function yas_charban(target, bool)
	net.Start("YAS_Main")
	net.WriteString("char_ban")
	net.WriteString(target:GetName())
	net.WriteBool(bool)
	net.SendToServer()
	yas_bsend()
end

function yas_flags(target, flags, bool)
	net.Start("YAS_Main")
	net.WriteString("char_flags")
	net.WriteEntity(target)
	net.WriteString(flags)
	net.WriteBool(bool)
	net.SendToServer()
end

function yas_charkick(target)
	net.Start("YAS_Main")
	net.WriteString("char_kick")
	net.WriteEntity(target)
	net.SendToServer()
end

function yas_giveitem(target, count, item)
	local count2 = tonumber(count)
	if count2 > 254 then LocalPlayer:Notfiy("Слишком большое значение") return end
	net.Start("YAS_Main")
	net.WriteString("giveitem")
	net.WriteEntity(target)
	net.WriteInt(count2, 9)
	net.WriteString(item)
	net.SendToServer()
end

function yas_bclick()
	surface.PlaySound("yas/yas_button2.wav")
end

function yas_bsend()
	surface.PlaySound("yas/yas_send1.wav")
end


