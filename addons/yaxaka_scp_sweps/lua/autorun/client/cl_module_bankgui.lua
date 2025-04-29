function call_bankgui()
	local DFrame = vgui.Create("DFrame") 
	DFrame:SetSize(600, 300) 
	DFrame:SetTitle("")
	DFrame:Center()
	DFrame:MakePopup()

	DFrame.Paint = function(self, w, h)
		surface.SetDrawColor(199, 170, 116)
		surface.DrawRect(0, 0, w, h)
		surface.SetDrawColor(0, 0, 0)
		surface.DrawOutlinedRect(10, 10, w-20, h-20, 2)

		surface.DrawOutlinedRect(110, 10, 1, h-20, 2)
		surface.DrawOutlinedRect(300, 10, 1, h-20, 2)

		surface.SetTextPos(50, 20)
		surface.SetTextColor(0, 0, 0)
		surface.SetFont("font_tektur_dframe_title")
		surface.DrawText("ID")
	end



	local DScrollPanel = vgui.Create( "DScrollPanel", DFrame )
	DScrollPanel:SetPos(10, 50)
	DScrollPanel:SetSize(580, 160)

	for k,v in pairs(test_labatable2) do
		local box = DScrollPanel:Add("editablepanel")
		box:Dock(FILL)
		box:DockMargin(0, 0, 0, 0)
		box.Paint = function(self, w, h)
			surface.SetDrawColor(0, 0, 0)
			surface.DrawOutlinedRect(0, 0, w, h, 2)
			surface.DrawOutlinedRect(100, 0, 1, h, 2)
		end

		local hw, hh = Helix_YUI_GetSize(v.id, "font_tektur_dframe")
		local dw, dh = Helix_YUI_GetSize(v.desc, "font_tektur_dframe")

		local desc_box = DScrollPanel:Add("editablepanel")
		desc_box:SetPos(100, 0)
		desc_box:SetSize(190, 100)
		desc_box.Paint = function(self, w, h)
		end

		local header_box = DScrollPanel:Add("editablepanel")
		header_box:SetPos(0, 0)
		header_box:SetSize(100, 100)

		local header = header_box:Add("DLabel", DScrollPanel)
		header:SetFont("font_tektur_dframe")
		header:SetColor(Color(0, 0, 0))
		header:SetText(v.id)
		header:SetSize(90, 26)
		header:SetPos(6, 25)

		local button = header_box:Add("DButton", DScrollPanel)
		button:SetFont("font_tektur_dframe")
		button:SetText("Выбрать")
		button:SetSize(80, 25)
		button:SetPos(10, 60)
		button.DoClick = function()
			net.Start("yr_bank")
			net.WriteBool(false)
			net.WriteString(v.id)
			net.SendToServer()
			DFrame:Close()
			yas_bclick()
		end

	end
end