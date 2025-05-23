local PANEL = {}

function PANEL:Init()
	local frameparent = self:GetParent()
	

	self:SetPos(15, 100)
	self:SetSize(755+12, 385)

	local musiczones = self:Add("YUIButton")
	musiczones:SetPos(30, 10)
	musiczones:SetSize(110, 30)
	musiczones.Image = yui_zonepng
	musiczones.text = "Music"
	musiczones.ISizeW = 32
	musiczones.ISizeH = 32
	musiczones.func = function() print("suhariki") end

	local spawnzones = self:Add("YUIButton")
	spawnzones:SetPos(140+25, 10)
	spawnzones:SetSize(120, 30)
	spawnzones.Image = yui_zonepng
	spawnzones.text = "Spawn"
	spawnzones.ISizeW = 32
	spawnzones.ISizeH = 32
	spawnzones.func = function() print("suhariki") end

	local triggerzones = self:Add("YUIButton")
	triggerzones:SetPos(280+40, 10)
	triggerzones:SetSize(120, 30)
	triggerzones.Image = yui_zonepng
	triggerzones.text = "Trigger"
	triggerzones.ISizeW = 32
	triggerzones.ISizeH = 32
	triggerzones.func = function() print("suhariki") end

	local helixzones = self:Add("YUIButton")
	helixzones:SetPos(420+60, 10)
	helixzones:SetSize(120, 30)
	helixzones.Image = yui_zonepng
	helixzones.text = "Helix"
	helixzones.ISizeW = 32
	helixzones.ISizeH = 32
	helixzones.func = function() print("suhariki") end

	local adminzones = self:Add("YUIButton")
	adminzones:SetPos(540+80, 10)
	adminzones:SetSize(120, 30)
	adminzones.Image = yui_zonepng
	adminzones.text = "Admin"
	adminzones.ISizeW = 32
	adminzones.ISizeH = 32
	adminzones.func = function() print("suhariki") end
end

function PANEL:Think()

end

function PANEL:Paint( aWide, aTall )
	surface.SetDrawColor(84, 23, 107)
	surface.DrawRect(0, 0, aWide, aTall)
	surface.SetDrawColor(41, 12, 78)
	surface.DrawRect(0, 50, aWide, 2)
end

vgui.Register( "YAdmin_ZoneMenu", PANEL, "editablepanel" )