local YCG_Button = {}
local wt_icon = Material("ycg/wt.png", "noclamp smooth mips nocull")
local adm_icon = Material("ycg/yas.png", "noclamp smooth mips nocull") 
local test_icon = Material("ycg/yas.png", "noclamp smooth mips nocull")

function YCG_Button:Init()
	self:SetSize(100, 80)
	self.anim1 = 0
	self.buttons = 0
	self:NoClipping(true)
end

function YCG_Button:Paint(w, h)
	--draw.RoundedBox( 25, 0.5, 0, w, h, Color(110, 110, 110, 150) )
	local x, y = self:GetPos()
	if self:IsHovered() then
		if self.anim1 < 15 then
			self.anim1 = self.anim1 + 1
		end
	else
		if self.anim1 > 0 then
			self.anim1 = self.anim1 - 1
		end
	end
	local val = self.anim1
	surface.SetMaterial(self.icon)
	surface.SetDrawColor(255, 255, 255, 255)
	surface.DrawTexturedRect(19-self.anim1/2, 9-self.anim1/2, 64+self.anim1, 64+self.anim1)
end

function YCG_Button:Think()
	if ycg_menu_opened == nil then self:Remove() end
end


function YCG_Button:OnMousePressed()
	if self.func ~= nil then
		self.func()
	end
	yas_bclick()
	return true
end


vgui.Register( "YCG_Button", YCG_Button, "editablepanel" )




local YCG_Main = {}

function YCG_Main:Init()
	self.buttons = 0
	self:SetPos(ScrW()/2, ScrH()-110)
	self:SetSize(0, 0)
	self:NoClipping(true)
	ycg_menu_opened = self
	input.SetCursorPos(ScrW()/2, ScrH()-120)
end

function YCG_Main:Think()
	self:SetSize(100*self.buttons, 80)
	local sw, sh = self:GetSize()
	self:SetPos(ScrW()/2-sw/2,ScrH()-110)
end

function YCG_Main:Paint(w, h)
	local clr = team.GetColor(LocalPlayer():Team())
	draw.RoundedBox( 25, 0, 0, w, h, Color(clr.r, clr.g, clr.b, 100) )
	for i=1,self.buttons-1 do
		draw.RoundedBox( 25, i*100-1, 12.5, 2, h-25, Color(255, 255, 255, 100) )
	end
end

function YCG_Main:AddButton(icon, func)
	local x, y = self:GetPos()
	local a = self:Add("YCG_Button")
	a.icon = icon
	a.func = func
	if self.buttons >= 2 then
		a:SetPos(0+100*self.buttons, 0)
	elseif self.buttons == 1 then
		a:SetPos(0+100, 0)
	else
		a:SetPos(0, 0)
	end
	self.buttons = self.buttons + 1
end

vgui.Register( "YCG_Main", YCG_Main, "editablepanel" )

concommand.Add("testpanel1", function()
	if ycg_menu_opened then
		ycg_menu_opened:Remove()
		ycg_menu_opened = nil
		gui.EnableScreenClicker(false)
	else
		gui.EnableScreenClicker(true)
		local a = vgui.Create("YCG_Main")
		if LocalPlayer().YAS_Role == "Superadmin" then
			local b1 = a:AddButton(adm_icon, function() RunConsoleCommand("yas") RunConsoleCommand("testpanel1") end)
		end
		local b2 = a:AddButton(wt_icon, function() radio_settings() end)
		local b3 = a:AddButton(test_icon, function() droplisttest() end)
	end
end)

function droplisttest()
	local Menu = DermaMenu()
	Menu:SetPos(input.GetCursorPos())
	local btnWithIcon1 = Menu:AddOption( "Адреналин", function() yas_bclick() RunConsoleCommand("testpanel1") end )
	local btnWithIcon2 = Menu:AddOption( "Адреналин", function() yas_bclick() RunConsoleCommand("testpanel1") end )
	local btnWithIcon3 = Menu:AddOption( "Норадреналин", function() yas_bclick() RunConsoleCommand("testpanel1") end )
end

function radio_settings()
	local Menu = DermaMenu()
	Menu:SetPos(input.GetCursorPos())
	local lply = LocalPlayer()

	local ico1 = "icon16/cancel.png"
	local ico2 = "icon16/cancel.png"

	if lply.RadioHear == true then
		ico1 = "icon16/accept.png"
	end

	if lply.RadioTalk == true then
		ico2 = "icon16/accept.png"
	end

	local btnWithIcon1 = Menu:AddOption( "Прослушивать рацию", function() if lply.RadioHear then lply.RadioHear = false yradio_switch(3, 2) else lply.RadioHear = true yradio_switch(3, 1) end RunConsoleCommand("testpanel1") end ):SetIcon(ico1)
	local btnWithIcon2 = Menu:AddOption( "Говорить в рацию", function() if lply.RadioTalk then lply.RadioTalk = false yradio_switch(2, 2) else lply.RadioTalk = true yradio_switch(2, 1) end RunConsoleCommand("testpanel1") end ):SetIcon(ico2)
	local btnWithIcon3 = Menu:AddOption( "Установить частоту", function() create_entry(Menu, "radio") RunConsoleCommand("testpanel1") end ):SetIcon("icon16/transmit.png")

end