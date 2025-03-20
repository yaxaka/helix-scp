surface.CreateFont( "NickFont", {
	font = "Inter", -- Use the font-name which is shown to you by your operating system Font Viewer.
	extended = true,
	size = 28,
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
	outline = true,
} )


function yas_sendwarn(text_type, priority, target)
	print("trigger")
	print(text_type)
	net.Start("YAS_Channel")
	net.WriteInt(text_type, 5)
	net.WriteInt(priority, 5)
	net.WriteEntity(target)
	net.SendToServer()
end


local PANEL = {}


function PANEL:Init()
	local parent = self:GetParent()
	

	self:SetPos(50, 141)
	self:SetSize(700, 335)

	for k,v in pairs(player.GetAll()) do
		local steamid = v:SteamID()
		local nick = v:Nick()
		local team_color = (ix.faction.Get(v:Team()).color)
		local classid = ix.class.Get(v:GetCharacter():GetClass())
		local class = "nil"
		if classid ~= nil then
			class = classid.name
		end
		


		local steamidw, steamidh = Helix_YUI_GetSize(nick, "DefaultFixed")
		local nickw, nickh = Helix_YUI_GetSize(nick, "NickFont")
		local classw, classh = Helix_YUI_GetSize(class, "HudHintTextLarge")

		self.Back = self:Add("DButton")
		self.Back:SetSize(700, 25)
		self.Back:SetText("")
		self.Back:Dock(TOP)
		self.Back:DockMargin(0, 15, 0, 0)
		self.Back.Target = v

		function self.Back:DoClick()
			local Menu = DermaMenu()

			local btnWithIcon = Menu:AddOption( "Option with icon" )
			btnWithIcon:SetIcon( "icon16/bug.png" )	-- Icons are in materials/icon16 folder

			Menu:AddSpacer()

			local Child, Parent = Menu:AddSubMenu( "Предупреждения" )
			Parent:SetIcon( "icon16/user_red.png" )
			Child:AddOption( "Телепорт в NonRP зону", function() yas_sendwarn(2, 1, self.Target) end ):SetIcon( "icon16/group.png" )
			Child:AddOption( "NonRP поведение", function() yas_sendwarn(1, 2, self.Target) end ):SetIcon( "icon16/group.png" )
			Child:AddOption( "Ручной ввод .../", function() yas_sendwarn(1, 1, self.Target) end ):SetIcon( "icon16/group.png" )

			


			Menu:Open()

		end


		self.Name = self:Add("DLabel", self.Back)
		self.Name:SetText(nick)
		self.Name:SetColor(team_color)
		self.Name:SetSize(nickw, nickh)
		self.Name:SetBright(false)
		self.Name:SetFont("NickFont")
		self.Name:Dock(TOP)
		self.Name:DockMargin(10, -26, 0, 5)



		self.Steamid = self:Add("YLabel", self.Back)
		self.Steamid:SetFont("DefaultFixed")
		self.Steamid:SetText("(" .. steamid .. ")")
		self.Steamid:SetSize(steamidw, steamidh)
		self.Steamid:Dock(TOP)
		self.Steamid:DockMargin(nickw+15, -26, 0, 0)

		self.class = self:Add("YLabel", self.Back)
		self.class:SetFont("HudHintTextLarge")
		self.class:SetText(class)
		self.class:SetSize(classw, classh)
		self.class:Dock(TOP)
		self.class:DockMargin(nickw+steamidw+classw/2+10, -13, 0, 0)

		self.Back.Paint = function(self, w, h)
			if self:IsHovered() then
				surface.SetDrawColor(0, 141, 202)
			else
				surface.SetDrawColor(0, 109, 155)
			end
				surface.DrawRect(0, 0, w, h)
		end
	end
end

function PANEL:Think()

end

function PANEL:Paint( aWide, aTall )
	surface.SetDrawColor(84, 23, 107)
	surface.DrawRect(0, 0, aWide, aTall)
end

vgui.Register( "YAdmin_Playerlist", PANEL, "DScrollPanel" )
