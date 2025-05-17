local ycm = "[YCM] "

function ymsg_w(text)
	if text == nil then return end
	MsgC(color_white, "[", Color(247, 255, 0), "YCM", color_white, "] ", Color(247, 255, 0), "WARNING: ", text, "\n")
	ServerLog( ycm .. "WARNING: " .. text )
end

function ymsg_e(text)
	if text == nil then return end
	MsgC(color_white, "[", Color(255, 0, 0), "YCM", color_white, "] ", Color(255, 0, 0), "ERROR: ", text, "\n")
	ServerLog( ycm .. "ERROR: " .. text )
end

function ymsg_d(text)
	if text == nil then return end
	MsgC(color_white, "[", Color(26, 255, 0), "YCM", color_white, "] ", Color(26, 255, 0), text, "\n")
	ServerLog( ycm .. text )
end

function ymsg_exploit(text, steamid)
	if text == nil then return end
	if steamid == nil then return end
	MsgC(color_white, "[", Color(255, 0, 0), "YCM", color_white, "] ", Color(255, 0, 0), "Exploit warning from: (", steamid, ") ", text, "\n")
	ServerLog( ycm .. "Exploit warning from: " .. steamid .. " " .. text )
end





function stringname_check(str, ply)

    
    local russian = str:find("[\128-\255]")
    local secure = str:find("[%W]")
    local secure2 = str:find("[%w]")

    if russian ~= nil then
        --russland
        if secure2 ~= nil then ply:Notify("Введите название на одном языке") return false end
    else
        --english
        if secure ~= nil then ply:Notify("Введите название на одном языке") return false end
    end

    return true
end