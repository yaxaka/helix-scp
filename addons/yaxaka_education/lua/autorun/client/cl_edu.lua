
function drawedu()

	local sizew, sizeh = ScrW(), ScrH()
	local DermaPanel22 = vgui.Create("DFrame") 
	DermaPanel22:SetSize(sizew, sizeh)
	DermaPanel22:SetPos(0, 0) 
	DermaPanel22:SetTitle("")
	DermaPanel22:ShowCloseButton(true)
	DermaPanel22:MakePopup()
	DermaPanel22:SetDraggable(false)

	local back = vgui.Create( "editablepanel", DermaPanel22 )
	back:SetPos(0, 0)
	back:SetSize(sizew, sizeh)

	local img_bg = back:Add("DImage")
    img_bg:SetSize(back:GetSize())        
    img_bg:SetImage("back1_b.png")

	local newsbox = back:Add("editablepanel")
	newsbox:SetPos(50, 100)
	newsbox:SetSize(sizew-100, sizeh-220)
	newsbox.Paint = function(self, w, h)
		surface.SetDrawColor(color_button)
		surface.DrawRect(0, 0, w, h)
		surface.SetDrawColor(color_button_outline)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
		surface.SetFont("Education")
		surface.SetTextPos(60*yu_scale, 640*yu_scale)
		surface.SetTextColor(255,0,0)
		surface.DrawText("Для чего это нужно?")
		surface.SetTextPos(60*yu_scale, 680*yu_scale)
		surface.SetTextColor(255,255,255)
		surface.DrawText("Данная версия позволит Вам увеличить в небольшом количестве функционал на некоторых серверах")
		surface.SetTextPos(60*yu_scale, 720*yu_scale)
		surface.DrawText("который поддерживает лишь эта версия.")

	end

	Helix_YUI_CreateText("Text1", newsbox, "Header", "Добро пожаловать", 50, 20)
	Helix_YUI_CreateText("Text2", newsbox, "Education", "Настоятельно рекомендуем установить версию garry’s mod на x86-64 - Chromium + 64-bit binaries систему", 50, 150)
	Helix_YUI_Button("ContinueEdu", sizew-444, sizeh-100, DermaPanel22, "Продолжить", "DermaLarge", "Edu1", 384, 55, back, true)
	Helix_YUI_CreateText("Text3", newsbox, "Education", "Порядок действий приведён ниже", 50, 220)

	local nw, nh = newsbox:GetSize()

	local edu1 = newsbox:Add("DImage")
    edu1:SetSize(587*yu_scale, 282*yu_scale)
    edu1:SetPos(50, nh/2-280/2)
    edu1:SetImage("edusteam1.png")
    local edu2 = newsbox:Add("DImage")
    edu2:SetSize(515*yu_scale, 286*yu_scale)
    edu2:SetPos(637*yu_scale, nh/2-280/2)
    edu2:SetImage("edusteam2.png")
    local edu3 = newsbox:Add("DImage")
    edu3:SetSize(629*yu_scale, 287*yu_scale)
    edu3:SetPos(1152*yu_scale, nh/2-280/2)
    edu3:SetImage("edusteam3.png")
	


end

function drawedu2()

	local sizew, sizeh = ScrW(), ScrH()
	local DermaPanel22 = vgui.Create("DFrame") 
	DermaPanel22:SetSize(sizew, sizeh)
	DermaPanel22:SetPos(0, 0) 
	DermaPanel22:SetTitle("")
	DermaPanel22:ShowCloseButton(true)
	DermaPanel22:MakePopup()
	DermaPanel22:SetDraggable(false)

	local back = vgui.Create( "editablepanel", DermaPanel22 )
	back:SetPos(0, 0)
	back:SetSize(sizew, sizeh)

	local img_bg = back:Add("DImage")
    img_bg:SetSize(back:GetSize())        
    img_bg:SetImage("back1_b.png")

	local newsbox = back:Add("editablepanel")
	newsbox:SetPos(50, 100)
	newsbox:SetSize(sizew-100, sizeh-220)
	newsbox.Paint = function(self, w, h)
		surface.SetDrawColor(color_button)
		surface.DrawRect(0, 0, w, h)
		surface.SetDrawColor(color_button_outline)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	Helix_YUI_CreateText("Text1", newsbox, "Header", "Прежде чем начать", 50, 20)

	Helix_YUI_CreateText("Text2", newsbox, "Education", "Предлагаем Вам ознакомиться с контентом который сможет вам помочь разобраться в тематике и механиках игры.", 50, 150)
	Helix_YUI_Button("ContinueEdu", sizew-444, sizeh-100, DermaPanel22, "Продолжить", "DermaLarge", "Edu2", 384, 55, back, true)

	local nw, nh = newsbox:GetSize()

	local scpfound = Helix_YUI_ButtonImage("youtube", nw/2-600-100, nh/2-350/2+50, newsbox, "youtube_preview.png", nil, nil, 600, 350)
	scpfound.DoClick = function()
		--
    end

    scpfound.Paint = function(self, w, h)
        if self:IsHovered() then
        	scpfound:SetColor(Color(255,255,255,100))
        else
            scpfound:SetColor(color_white)
        end
        if self.Pressed then
        	scpfound:SetColor(Color(255,255,255,50))
        end
    end

    local youtubef = Helix_YUI_ButtonImage("youtube2", nw/2+100, nh/2-350/2+50, newsbox, "youtube_preview.png", nil, nil, 600, 350)
	youtubef.DoClick = function()
		--
    end

    youtubef.Paint = function(self, w, h)
        if self:IsHovered() then
        	youtubef:SetColor(Color(255,255,255,100))
        else
            youtubef:SetColor(color_white)
        end
        if self.Pressed then
        	youtubef:SetColor(Color(255,255,255,50))
        end
    end

end

concommand.Add("edu", function()
	drawedu()
end)