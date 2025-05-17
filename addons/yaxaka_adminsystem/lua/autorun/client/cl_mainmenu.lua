surface.CreateFont( "HeaderAdmin1", {
	font = "Be Vietnam Pro", -- Use the font-name which is shown to you by your operating system Font Viewer.
	extended = false,
	size = 30,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "HeaderAdminNick", {
	font = "Be Vietnam Pro", -- Use the font-name which is shown to you by your operating system Font Viewer.
	extended = false,
	size = 30,
	weight = 500,
	blursize = 0,
	scanlines = 0,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

surface.CreateFont( "Baumans", {
	font = "Baumans", -- Use the font-name which is shown to you by your operating system Font Viewer.
	extended = true,
	size = 30,
	weight = 500,
	blursize = 0,
	scanlines = 1,
	antialias = true,
	underline = false,
	italic = false,
	strikeout = false,
	symbol = false,
	rotary = false,
	shadow = false,
	additive = false,
	outline = false,
} )

local opened = nil
local PANEL = {}

function PANEL:Init()
	self:SetText_Base( "" )
end

function PANEL:Paint( aWide, aTall )

	local TextX, TextY = 0, 0
	if self.TextColor == nil then
		self.TextColor = Color(255, 255, 255)
	end
	surface.SetFont(self:GetFont())
	surface.SetTextColor( self.TextColor )

	local w, h = surface.GetTextSize(self:GetText())
	surface.SetTextPos( TextX, TextY )
	
	surface.DrawText( self:GetText() )


end

PANEL.SetText_Base = FindMetaTable( "Panel" ).SetText

function PANEL:SetText( aText ) 
	self.Text = tostring( aText ) 
end

function PANEL:GetText() 
	return self.Text or "" 
end

vgui.Register( "YLabel", PANEL, "DLabel" )




local PANEL2 = {}



function PANEL2:Init()
	self:Center()
	self:SetSize(800, 600)
	self:MakePopup()
	self:SetMouseInputEnabled(true)
	self:ShowCloseButton(false)
	self:SetTitle("")
end



function PANEL2:Paint( aWide, aTall )
	draw.RoundedBox(10, 0, 0, aWide, aTall, Color(41, 12, 78))
	surface.SetFont("HeaderAdmin1")
	surface.SetTextColor(Color(255, 255, 255))
	surface.SetTextPos(94, 10)
	surface.DrawText("Welcome, your access level:")
	surface.SetFont("HeaderAdminNick")
	surface.SetTextPos(94, 49)
	surface.DrawText(LocalPlayer():Nick())
	surface.SetTextPos(124, 49)
	local group = LocalPlayer().YAS_Role
	if group == "Superadmin" then
		surface.SetTextColor(Color(255, 0, 0))
	elseif group == "Moderator" then
		surface.SetTextColor(Color(0, 43, 255))
	end
	surface.DrawText(group)
end


vgui.Register( "YAdminF", PANEL2, "DFrame" )


local PANEL3 = {}



function PANEL3:Init()
	self:SetText("")
end

function PANEL3:DoClick()
	yas_bclick()
	local parent = self:GetParent()
	opened = nil
	parent:Close()
end

function PANEL3:Paint( aWide, aTall )
	if self:IsHovered() then
		surface.SetDrawColor(self.HoverColor)
	else
		surface.SetDrawColor(self.Color)
	end
	surface.DrawRect(0, 0, aWide, aTall)
end


vgui.Register( "YCloseButton", PANEL3, "DButton" )

local PANEL33 = {}



function PANEL33:Init()
	self:SetText("")
end

function PANEL33:DoClick()
	yas_bclick()
	local parent = self:GetParent()
	if parent.Activetab == nil then

	else
		parent.Activetab:Remove()
		parent.mainbuttons:Show()
	end
end

function PANEL33:Paint( aWide, aTall )
	if self:IsHovered() then
		surface.SetDrawColor(self.HoverColor)
	else
		surface.SetDrawColor(self.Color)
	end
	surface.DrawRect(0, 0, aWide, aTall)
end


vgui.Register( "YBackButton", PANEL33, "DButton" )

local PANEL4 = {}



function PANEL4:Init()
	self:SetText("")
end

function PANEL4:DoClick()
	yas_bclick()
	local parent = self:GetParent()
	local mainparent = parent:GetParent()
	local newpanel = self.NewPanel
	if self.Text == "Players" then
		parent:Hide()
		local list = vgui.Create("YAdmin_Playerlist", mainparent)
		mainparent.Activetab = list
	end
	
end

function PANEL4:Paint( aWide, aTall )
	if self.Rounded then
		if self:IsHovered() then
			draw.RoundedBox(20, 0, 0, aWide, aTall, self.HoverColor)
		else
			draw.RoundedBox(20, 0, 0, aWide, aTall, self.Color)
		end
	else
		if self:IsHovered() then
			surface.SetDrawColor(self.HoverColor)
		else
			surface.SetDrawColor(self.Color)
		end

		surface.DrawRect(0, 0, aWide, aTall)
	end

	if self.Image ~= nil then
		if self:IsHovered() then
			surface.SetMaterial(self.ImageHover)
			surface.DrawTexturedRect(self.IX, self.IY, self.IW, self.IH)
		else
			surface.SetMaterial(self.Image)
			surface.DrawTexturedRect(self.IX, self.IY, self.IW, self.IH)
		end			
	end

	if self.Text ~= nil then
		surface.SetFont("Baumans")
		surface.SetTextColor(0, 0, 0)
		surface.SetTextPos(self.TX, self.TY)
		surface.DrawText(self.Text)
	end
end


vgui.Register( "YButton", PANEL4, "DButton" )



local PANELMain = {}

function PANELMain:Init()
	if IsValid(SingleDFrame) then
    	SingleDFrame:Remove()
    end

    local bkey = nil

    for i=1,159 do
    	local value = input.LookupKeyBinding(i)
    	if value ~= nil then
    		local strfind = string.find(value, "yas")
    		if strfind then
    			bkey = value
    		end
    	end
    end

    if bkey ~= nil then
		self.bind = input.GetKeyCode(bkey)
	end

    opened = self
  	local sw = ScrW()
    local sh = ScrH()

	local sizew, sizeh = 1, 1
	self:SetSize(sizew, sizeh)
	self:Center()
	self:MakePopup()
    self:SetTitle("")
    self:ShowCloseButton(false) 
    self:SetDraggable(false) 

    self.animat = true

    self:SizeTo(800, 500, 1.8, 0, .1, function()
        self.animat = false
    end)

    self.mainbuttons = self:Add("DPanel")
    self.mainbuttons:SetSize(800, 500)
    self.mainbuttons:SetPos(0, 0)
    self.mainbuttons:SetBackgroundColor(Color(0, 0, 0, 0))

	self.CloseMain = self:Add("YCloseButton")
	self.CloseMain:SetPos(755, 15)
	self.CloseMain:SetSize(24, 24)
	self.CloseMain.Color = Color(200, 0, 0)
	self.CloseMain.HoverColor = Color(150, 0, 0)

	self.BackMain = self:Add("YBackButton")
	self.BackMain:SetPos(715, 15)
	self.BackMain:SetSize(24, 24)
	self.BackMain.Color = Color(0, 109, 155)
	self.BackMain.HoverColor = Color(0, 141, 202)

	self.Avatar = self:Add("AvatarImage")
	self.Avatar:SetSize(64, 64)
	self.Avatar:SetPos(15, 15)
	self.Avatar:SetPlayer(LocalPlayer(), 64)

	self.Zones = self.mainbuttons:Add("YButton")
	self.Zones:SetPos(69, 141)
	self.Zones:SetSize(128, 128)
	self.Zones.IX, self.Zones.IY = 35, 25
	self.Zones.IW, self.Zones.IH = 58, 47
	self.Zones.Rounded = true
	self.Zones.TX, self.Zones.TY = 28, 88
	self.Zones.Text = "Zone's"
	self.Zones.Image = Material("admin_zones.png")
	self.Zones.ImageHover = Material("admin_zones_hover.png")
	self.Zones.Color = Color(148, 40, 150, 200)
	self.Zones.HoverColor = Color(148, 40, 150, 255)

	self.Logs = self.mainbuttons:Add("YButton")
	self.Logs:SetPos(247, 141)
	self.Logs:SetSize(128, 128)
	self.Logs.IX, self.Logs.IY = 35, 25
	self.Logs.IW, self.Logs.IH = 58, 47
	self.Logs.Rounded = true
	self.Logs.TX, self.Logs.TY = 36, 88
	self.Logs.Text = "Logs"
	self.Logs.Image = Material("admin_zones.png")
	self.Logs.ImageHover = Material("admin_zones_hover.png")
	self.Logs.Color = Color(148, 40, 150, 200)
	self.Logs.HoverColor = Color(148, 40, 150, 255)

	self.SCP = self.mainbuttons:Add("YButton")
	self.SCP:SetPos(425, 141)
	self.SCP:SetSize(128, 128)
	self.SCP.IX, self.SCP.IY = 35, 25
	self.SCP.IW, self.SCP.IH = 58, 47
	self.SCP.Rounded = true
	self.SCP.TX, self.SCP.TY = 10, 88
	self.SCP.Text = "SCP Panel"
	self.SCP.Image = Material("admin_zones.png")
	self.SCP.ImageHover = Material("admin_zones_hover.png")
	self.SCP.Color = Color(148, 40, 150, 200)
	self.SCP.HoverColor = Color(148, 40, 150, 255)

	self.Players = self.mainbuttons:Add("YButton")
	self.Players:SetPos(603, 141)
	self.Players:SetSize(128, 128)
	self.Players.IX, self.Players.IY = 35, 25
	self.Players.IW, self.Players.IH = 58, 47
	self.Players.Rounded = true
	self.Players.TX, self.Players.TY = 24, 88
	self.Players.Text = "Players"
	self.Players.Image = Material("admin_zones.png")
	self.Players.ImageHover = Material("admin_zones_hover.png")
	self.Players.Color = Color(148, 40, 150, 200)
	self.Players.HoverColor = Color(148, 40, 150, 255)

	self.Banlist = self.mainbuttons:Add("YButton")
	self.Banlist:SetPos(69, 329)
	self.Banlist:SetSize(128, 128)
	self.Banlist.IX, self.Banlist.IY = 35, 25
	self.Banlist.IW, self.Banlist.IH = 58, 47
	self.Banlist.Rounded = true
	self.Banlist.TX, self.Banlist.TY = 26, 88
	self.Banlist.Text = "Banlist"
	self.Banlist.Image = Material("admin_zones.png")
	self.Banlist.ImageHover = Material("admin_zones_hover.png")
	self.Banlist.Color = Color(148, 40, 150, 200)
	self.Banlist.HoverColor = Color(148, 40, 150, 255)

	self.Utility = self.mainbuttons:Add("YButton")
	self.Utility:SetPos(247, 329)
	self.Utility:SetSize(128, 128)
	self.Utility.IX, self.Utility.IY = 35, 25
	self.Utility.IW, self.Utility.IH = 58, 47
	self.Utility.Rounded = true
	self.Utility.TX, self.Utility.TY = 31, 88
	self.Utility.Text = "Utility"
	self.Utility.Image = Material("admin_zones.png")
	self.Utility.ImageHover = Material("admin_zones_hover.png")
	self.Utility.Color = Color(148, 40, 150, 200)
	self.Utility.HoverColor = Color(148, 40, 150, 255)

	self.Roles = self.mainbuttons:Add("YButton")
	self.Roles:SetPos(426, 329)
	self.Roles:SetSize(128, 128)
	self.Roles.IX, self.Roles.IY = 35, 25
	self.Roles.IW, self.Roles.IH = 58, 47
	self.Roles.Rounded = true
	self.Roles.TX, self.Roles.TY = 34, 88
	self.Roles.Text = "Roles"
	self.Roles.Image = Material("admin_zones.png")
	self.Roles.ImageHover = Material("admin_zones_hover.png")
	self.Roles.Color = Color(148, 40, 150, 200)
	self.Roles.HoverColor = Color(148, 40, 150, 255)

	self.Database = self.mainbuttons:Add("YButton")
	self.Database:SetPos(603, 329)
	self.Database:SetSize(128, 128)
	self.Database.IX, self.Database.IY = 35, 25
	self.Database.IW, self.Database.IH = 58, 47
	self.Database.Rounded = true
	self.Database.TX, self.Database.TY = 14, 88
	self.Database.Text = "Database"
	self.Database.Image = Material("admin_zones.png")
	self.Database.ImageHover = Material("admin_zones_hover.png")
	self.Database.Color = Color(148, 40, 150, 200)
	self.Database.HoverColor = Color(148, 40, 150, 255)
end



function PANELMain:Think()
	if self.animat then
  		self:Center()
   	end
end

function PANELMain:Paint( aWide, aTall )
	draw.RoundedBox(10, 0, 0, aWide, aTall, Color(41, 12, 78))
	surface.SetFont("HeaderAdmin1")
	surface.SetTextColor(Color(255, 255, 255))
	surface.SetTextPos(94, 10)
	surface.DrawText("Welcome, your access level:")
	surface.SetFont("HeaderAdminNick")
	surface.SetTextPos(94, 49)
	surface.DrawText(LocalPlayer():Nick())
	surface.SetTextPos(384, 10)
	local group = LocalPlayer().YAS_Role
	if group == "Superadmin" then
		surface.SetTextColor(Color(255, 0, 0))
	elseif group == "Moderator" then
		surface.SetTextColor(Color(0, 43, 255))
	end
	surface.DrawText(group)
end

function PANELMain:OnKeyCodePressed(key)
	local yas = input.LookupKeyBinding(key)
	if yas == nil then return end
	if string.find(yas, "yas") then
		self:Close()
		opened = nil
	end
end

vgui.Register( "YAdmin_Main", PANELMain, "DFrame" )

local PANEL_WriteField = {}

function PANEL_WriteField:Init()
	if IsValid(SingleDFrame) then
    	SingleDFrame:Remove()
    end
  	local sw = ScrW()
    local sh = ScrH()

	local sizew, sizeh = 1, 1
	self:SetSize(sizew, sizeh)
	self:Center()
	self:MakePopup()
    self:SetTitle("")
    self:ShowCloseButton(true) 
    self:SetDraggable(false) 
    local parent = self
    self.animat = true

    self:SizeTo(500, 150, 1.8, 0, .1, function()
        self.animat = false
    end)

    local entry = self:Add("DTextEntry")
	entry:SetSize(400, 25)
	entry:SetPos(500/2-400/2, 150/2-30)
	entry:SetFont("Inter default")
	entry:SetPlaceholderText("Введите аргументы")

    local send = self:Add("YButton")
    send:SetSize(200, 30)
    send:SetPos(500/2-200/2, 150/2+20)
    send:SetFont("Inter default")
    send:SetText("Отправить")
    send.Color = Color(148, 40, 150, 200)
	send.HoverColor = Color(148, 40, 150, 255)
	send.DoClick = function()
		local val = entry:GetValue()
		if val == "" then return end
		yas_bclick()
		local func = parent.func

		if func == "warn" then
			yas_sendwarn(3, 1, ply_target, val)
		end

		if func == "pm" then
			yas_pm(ply_target, val)
		end

		self:Close()
	end

end



function PANEL_WriteField:Think()
	if self.animat then
  		self:Center()
   	end
end

function PANEL_WriteField:Paint( aWide, aTall )
	draw.RoundedBox(10, 0, 0, aWide, aTall, Color(41, 12, 78))

end


vgui.Register( "YAdmin_WriteField", PANEL_WriteField, "DFrame" )


concommand.Add("yas", function()
	if LocalPlayer().YAS_Role == "User" then return end
	if opened then
		opened:Close()
		opened = nil
	else
		vgui.Create("YAdmin_Main")
	end	
end)

