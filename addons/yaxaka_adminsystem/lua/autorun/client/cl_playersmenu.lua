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

		self.Back = self:Add("editablepanel")
		self.Back:SetSize(700, 25)
		self.Back:Dock(TOP)
		self.Back:DockMargin(0, 15, 0, 0)


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

		print(nickw+steamidw+15)
		self.class = self:Add("YLabel", self.Back)
		self.class:SetFont("HudHintTextLarge")
		self.class:SetText(class)
		self.class:SetSize(classw, classh)
		self.class:Dock(TOP)
		self.class:DockMargin(nickw+steamidw+classw/2+10, -13, 0, 0)

		self.Back.Paint = function(self, w, h)
			surface.SetDrawColor(0, 109, 155)
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
