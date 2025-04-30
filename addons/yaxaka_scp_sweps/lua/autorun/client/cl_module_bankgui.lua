function call_bankgui()
	local DFrame = vgui.Create("DFrame") 
	DFrame:SetSize(800, 410) 
	DFrame:SetTitle("")
	DFrame:Center()
	DFrame:MakePopup()

	DFrame.Paint = function(self, w, h)
		surface.SetDrawColor(199, 170, 116)
		surface.DrawRect(0, 0, w, h)
		surface.SetDrawColor(0, 0, 0)
		surface.DrawOutlinedRect(10, 10, w-20, h-20, 2)

		surface.DrawOutlinedRect(112, 10, 1, h-20, 2)
		surface.DrawOutlinedRect(300, 10, 1, h-20, 2)
		surface.DrawOutlinedRect(530, 10, 1, h-20, 2)
		surface.DrawOutlinedRect(700, 10, 1, h-20, 2)

		surface.SetTextPos(50, 20)
		surface.SetTextColor(0, 0, 0)
		surface.SetFont("font_tektur_dframe_title")
		surface.DrawText("ID")
		surface.SetTextPos(176, 20)
		surface.DrawText("Name")
		surface.SetTextPos(360, 20)
		surface.DrawText("Description")
		surface.SetTextPos(584, 20)
		surface.DrawText("Author")
	end



	local DScrollPanel = vgui.Create( "DScrollPanel", DFrame )
	DScrollPanel:SetPos(10, 50)
	DScrollPanel:SetSize(780, 345)
	DScrollPanel.Paint = function(self, w, h)
		surface.SetDrawColor(0, 0, 0)
		surface.DrawRect(0, 0, w, 2)
	end

	for k,v in pairs(yr_chemlab_table) do
		local box = vgui.Create("editablepanel", DScrollPanel)
		box:Dock(TOP)
		box:DockMargin(0, 0, 0, 0)
		box:DockPadding(0, 0, 0, 0)
		box.Paint = function(self, w, h)
			surface.SetDrawColor(0, 0, 0)
			surface.DrawOutlinedRect(0, 0, w, 1, 2)
		end

		local hw, hh = Helix_YUI_GetSize(v.ID, "font_tektur_dframe")
		local nw, nh = Helix_YUI_GetSize(v.Name, "font_tektur_dframe")
		local aw, ah = Helix_YUI_GetSize(v.Author, "font_tektur_dframe")

		--local desc_box = DScrollPanel:Add("editablepanel", box)
		--desc_box:SetPos(100, 0)
		--desc_box:SetSize(190, 100)
		--desc_box.Paint = function(self, w, h)
		--end

		local header = DScrollPanel:Add("DLabel", box)
		header:SetFont("font_tektur_dframe")
		header:SetColor(Color(0, 0, 0))
		header:SetText(v.ID)
		header:Dock(TOP)
		header:DockMargin(7, 0, 0, 0)

		local name = DScrollPanel:Add("DLabel", box)
		name:SetFont("font_tektur_dframe")
		name:SetColor(Color(0, 0, 0))
		name:SetText(v.Name)
		name:Dock(TOP)
		name:DockMargin(196-nw/2, -20, 0, 0)

		local author = DScrollPanel:Add("DLabel", box)
		author:SetFont("font_tektur_dframe")
		author:SetColor(Color(0, 0, 0))
		author:SetText(v.Author)
		author:Dock(TOP)
		author:DockMargin(607-aw/2, -20, 0, 0)


		local button = DScrollPanel:Add("DButton", box)
		button:SetFont("font_tektur_dframe")
		button:SetText("Выбрать")
		button:Dock(TOP)
		button:DockMargin(699, -24, 10, 20)
		button.DoClick = function()
			net.Start("yr_bank")
			net.WriteBool(false)
			net.WriteString(v.ID)
			net.SendToServer()
			DFrame:Close()
			yas_bclick()
		end

	end
end


function call_sendnewgui()
	local DFrame = vgui.Create("DFrame") 
	DFrame:SetSize(100, 200) 
	DFrame:SetTitle("")
	DFrame:Center()
	DFrame:MakePopup()

	DFrame.Paint = function(self, w, h)
		surface.SetDrawColor(199, 170, 116)
		surface.DrawRect(0, 0, w, h)
		surface.SetDrawColor(0, 0, 0)
		surface.DrawOutlinedRect(10, 10, w-20, h-20, 2)
	end

end