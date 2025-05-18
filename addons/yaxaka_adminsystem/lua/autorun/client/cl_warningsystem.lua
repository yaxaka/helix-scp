local lastnotify = 0
local warncolor_1 = Color(255, 203, 0)
local warncolor_2 = Color(255, 0, 0)
local warntype = 3
local sendedwarntype = 0
local delay = 0
local warn_text = nil

local triangle = {
	{ x = 222, y = 60 },
	{ x = 249, y = 13 },
	{ x = 277, y = 60 }
}

local PANEL = {}

function PANEL:Init()

  	local sw = ScrW()
    local sh = ScrH()

	local sizew, sizeh = 1, 1
	self:SetSize(sizew, sizeh)
	--self:SetPos(sw-500, sh-300)
	self:MakePopup()
    self:SetTitle("")
    self:ShowCloseButton(false) 
    self:SetDraggable(false)
    self:SetMouseInputEnabled(false)
    self:SetKeyBoardInputEnabled(false)


    self.animat = true

    self:SizeTo(500, 200, 1.2, 0, .1, function()
        self.animat = false
    end)

    self.text = self:Add("DLabel")
    self.text:SetFont("CloseCaption_Normal")
    self.text:SetText(warn_text)
    self.text:SetPos(30, 77)
    self.text:SetSize(445, 100)
    self.text:SetWrap(true)
    self.text:SetAutoStretchVertical(true)



end

function PANEL:Think()
	if self.animat then
  		self:SetPos(ScrW()-550, ScrH()-300)
   	end
end

function PANEL:Paint( aWide, aTall )
	draw.RoundedBox(20, 0, 0, aWide, aTall, Color(39, 39, 39))

	if warntype == 1 then
		surface.SetDrawColor(warncolor_1)
	elseif warntype == 2 then
		surface.SetDrawColor(warncolor_2)
	elseif warntype == 3 then
		surface.SetDrawColor(color_white)
	end

	surface.DrawRect(20, 35, 150, 6)
	surface.DrawRect(330, 35, 150, 6)
	draw.NoTexture()
	surface.DrawPoly( triangle )

end

vgui.Register("YASNotify", PANEL, "DFrame")

local function yas_warntype1(text, priority)
	sendedwarntype = priority
	warn_text = text
	local a = vgui.Create("YASNotify")

	lastnotify = 1
	timer.Create("YAS_WarnColors", 0.5, 0, function()
		if not IsValid(a) then timer.Remove("YAS_WarnColors") end

   		if sendedwarntype ~= warntype then
   			warntype = sendedwarntype
   			surface.PlaySound("yas/yas_warn.wav")
   		else
   			warntype = 3
   		end
   	end)

   	timer.Create("YAS_WarnDelete", 5, 1, function()
   		a:Remove()
   		lastnotify = 0
   	end)

end

net.Receive("YAS_Warning", function()
	local priority = net.ReadInt(5)
	local text = net.ReadString()

	if lastnotify == 1 then return end
	yas_warntype1(text, priority)

end)


