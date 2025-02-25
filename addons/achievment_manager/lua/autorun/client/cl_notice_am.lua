local panel_w, panel_h = 350, 80
local img_w, img_h = 64, 64
local am_font = "CloseCaption_Normal"
local delay = 0


net.Receive("am_popup", function()
	local str = net.ReadString()
	local str2 = net.ReadString()
	am_init_popup(str, str2)
end)


function am_textsize(text, font)
    surface.SetFont(font)
    local w, h = surface.GetTextSize(text)
    return w, h
end

function am_create_text(name, parent, font, text, posx, posy)
	local tw, th = am_textsize(text, font)
	local p_x, p_y = parent:GetSize()
    local xx = (img_w+24)
    local yy = (panel_h/2-th/2)

    name = vgui.Create("DLabel", parent)
    if tw > 200 then
		yy = (panel_h/2-th/2-20)
		name:SetSize(tw/1.2, th+40)
	else
		name:SetSize(tw, th)
	end
    name:SetPos(xx, yy)
    name:SetFont(font)
    name:SetText(text)
    name:SetTextColor(Color(255, 200, 0))
    name:SetWrap(true)
end

function am_init_popup(category, achiv)
	if CurTime() < delay then 
		timer.Create("Popup_" .. math.Rand(1,1000), 5, 1, function() am_popup_notice(category, achiv) end)
	elseif CurTime() > delay then
		delay = CurTime() + 6
		am_popup_notice(category, achiv)
	end
end


function am_popup_notice(category, achiv)
	local text = am_table[category][achiv].name
	local imgs = am_table[category][achiv].img
	

	local NotifyPanel = vgui.Create("DNotify")
	NotifyPanel:SetPos(ScrW()-panel_w, ScrH()-panel_h)
	NotifyPanel:SetSize(panel_w, panel_h)

	local bg = vgui.Create("DPanel", NotifyPanel)
	bg:Dock(FILL)
	bg:SetBackgroundColor(Color(50, 50, 50))
	local bg_w, bg_h = bg:GetSize()
	local bg_x, bg_y = bg:GetPos()

	local img = vgui.Create("DImage", bg)
	img:SetSize(img_w, img_h)
	img:SetPos(bg_x+14, panel_h/2-img_h/2)
	img:SetImage(imgs)


	am_create_text("achiv", bg, am_font, text, bg_x, bg_y, img)


	NotifyPanel:AddItem(bg)
	surface.PlaySound("am_sound.wav")
end
