local PANEL = {}

function PANEL:Init()
	local parent = self:GetParent()

	self:SetPos(50, 141)
	self:SetSize(700, 335)

	for k,v in pairs(player.GetAll()) do
		self.Back = self:Add("editablepanel")
		self.Name = self:Add("YLabel", self.Back)
		self.Name:SetText(v:Nick())
		self.Name:SetFont("Trebuchet24")
		self.Name:Dock(TOP)
		self.Name:DockMargin(0, 5, 0, 5)
	end
end

function PANEL:Think()

end

function PANEL:Paint( aWide, aTall )
	surface.SetDrawColor(84, 23, 107)
	surface.DrawRect(0, 0, aWide, aTall)
end

vgui.Register( "YAdmin_Playerlist", PANEL, "DScrollPanel" )
