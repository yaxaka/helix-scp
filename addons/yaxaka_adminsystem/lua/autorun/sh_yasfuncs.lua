function yas_sendwarn(text_type, priority, target)
	net.Start("YAS_Warning")
	net.WriteInt(text_type, 5)
	net.WriteInt(priority, 5)
	net.WriteEntity(target)
	net.SendToServer()
	LocalPlayer():Notify("Предупреждение отправлено игроку.")
end

function yas_tp_pos(target, pos)
	target.yas_tp_pos = pos
	LocalPlayer():Notify("Точка телепорта установлена на вашем месте.")
end

function yas_tp_send(target)
	net.Start("YAS_TP")
	net.WriteEntity(target)
	net.WriteVector(target.yas_tp_pos)
	net.SendToServer()
	target.yas_tp_pos = nil
	LocalPlayer():Notify("Игрок телепортирован. Его точка телепорта сброшена.")
end

function yas_voicemute(target)
	target.voice_muted = true
	yas_netmute(1, target)
	LocalPlayer():Notify("Воис игрока замучен.")
end

function yas_voiceunmute(target)
	target.voice_muted = nil
	yas_netmute(2, target)
	LocalPlayer():Notify("Воис игрока размучен.")
end

function yas_chatmute(target)
	target.chat_muted = true
	yas_netmute(3, target)
	LocalPlayer():Notify("Чат игрока замучен.")
end

function yas_chatunmute(target)
	target.chat_muted = nil
	yas_netmute(4, target)
	LocalPlayer():Notify("Чат игрока размучен.")
end


function yas_netmute(type, target)
	net.Start("YAS_Mutes")
	net.WriteInt(type, 4)
	net.WriteEntity(target)
	net.SendToServer()
end


function yas_bclick()
	surface.PlaySound("yas/yas_button2.wav")
end

function yas_bsend()
	surface.PlaySound("yas/yas_send1.wav")
end


