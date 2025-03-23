function yas_sendwarn(text_type, priority, target)
	net.Start("YAS_Warning")
	net.WriteInt(text_type, 5)
	net.WriteInt(priority, 5)
	net.WriteEntity(target)
	net.SendToServer()
	LocalPlayer():Notify("Предупреждение отправлено игроку.")
	yas_bsend()
end

function yas_tp_pos(target, pos)
	target.yas_tp_pos = pos
	LocalPlayer():Notify("Точка телепорта установлена на вашем месте.")
end

function yas_tp_send(target)
	target.teleported = true
	target.returnpos = target:GetPos()
	net.Start("YAS_TP")
	net.WriteEntity(target)
	net.WriteVector(target.yas_tp_pos)
	net.SendToServer()
	target.yas_tp_pos = nil
	LocalPlayer():Notify("Игрок телепортирован. Его точка телепорта сброшена.")
	yas_bsend()
end

function yas_tp_send(target)
	net.Start("YAS_TP")
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
	net.Start("YAS_Mutes")
	net.WriteInt(type, 4)
	net.WriteEntity(target)
	net.SendToServer()
	yas_bsend()
end

function yas_pm(target, text)
	net.Start("YAS_PM")
	net.WriteEntity(target)
	net.WriteString(text)
	net.SendToServer()
	yas_bsend()
end

function yas_freeze(target, type)
	net.Start("YAS_Freeze")
	net.WriteEntity(target)
	net.WriteInt(type, 4)
	net.SendToServer()
	yas_bsend()
end

function yas_god(target, type)
	net.Start("YAS_God")
	net.WriteEntity(target)
	net.WriteInt(type, 4)
	net.SendToServer()
	yas_bsend()
end

function yas_hp(target)
	net.Start("YAS_HP")
	net.WriteEntity(target)
	net.SendToServer()
	yas_bsend()
end

function yas_bclick()
	surface.PlaySound("yas/yas_button2.wav")
end

function yas_bsend()
	surface.PlaySound("yas/yas_send1.wav")
end


