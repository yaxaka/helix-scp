function ymsg_w(text)
	if text == nil then return end
	MsgC(color_white, "[", Color(247, 255, 0), "YCM", color_white, "] ", Color(247, 255, 0), "WARNING: ", text, "\n")
end

function ymsg_e(text)
	if text == nil then return end
	MsgC(color_white, "[", Color(255, 0, 0), "YCM", color_white, "] ", Color(255, 0, 0), "ERROR: ", text, "\n")
end

function ymsg_d(text)
	if text == nil then return end
	MsgC(color_white, "[", Color(26, 255, 0), "YCM", color_white, "] ", Color(26, 255, 0), text, "\n")
end

function ymsg_exploit(text, steamid)
	if text == nil then return end
	if steamid == nil then return end
	MsgC(color_white, "[", Color(255, 0, 0), "YCM", color_white, "] ", Color(255, 0, 0), "Exploit warning from: (", steamid, ") ", text, "\n")
end