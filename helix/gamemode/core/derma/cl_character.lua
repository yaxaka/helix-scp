
local gradient = surface.GetTextureID("vgui/gradient-d")
local audioFadeInTime = 2
local animationTime = 0.5
local matrixZScale = Vector(1, 1, 0.0001)

-- character menu panel
DEFINE_BASECLASS("ixSubpanelParent")
local PANEL = {}

function PANEL:Init()
	self:SetSize(self:GetParent():GetSize())
	self:SetPos(0, 0)

	self.childPanels = {}
	self.subpanels = {}
	self.activeSubpanel = ""

	self.currentDimAmount = 0
	self.currentY = 0
	self.currentScale = 1
	self.currentAlpha = 255
	self.targetDimAmount = 255
	self.targetScale = 0.9
end

function PANEL:Dim(length, callback)
	length = length or animationTime
	self.currentDimAmount = 0

	self:CreateAnimation(length, {
		target = {
			currentDimAmount = self.targetDimAmount,
			currentScale = self.targetScale
		},
		easing = "outCubic",
		OnComplete = callback
	})

	self:OnDim()
end

function PANEL:Undim(length, callback)
	length = length or animationTime
	self.currentDimAmount = self.targetDimAmount

	self:CreateAnimation(length, {
		target = {
			currentDimAmount = 0,
			currentScale = 1
		},
		easing = "outCubic",
		OnComplete = callback
	})

	self:OnUndim()
end

function PANEL:OnDim()
end

function PANEL:OnUndim()
end

function PANEL:Paint(width, height)
	local amount = self.currentDimAmount
	local bShouldScale = self.currentScale != 1
	local matrix

	-- draw child panels with scaling if needed
	if (bShouldScale) then
		matrix = Matrix()
		matrix:Scale(matrixZScale * self.currentScale)
		matrix:Translate(Vector(
			ScrW() * 0.5 - (ScrW() * self.currentScale * 0.5),
			ScrH() * 0.5 - (ScrH() * self.currentScale * 0.5),
			1
		))

		cam.PushModelMatrix(matrix)
		self.currentMatrix = matrix
	end

	BaseClass.Paint(self, width, height)

	if (bShouldScale) then
		cam.PopModelMatrix()
		self.currentMatrix = nil
	end

	if (amount > 0) then
		local color = Color(0, 0, 0, amount)

		surface.SetDrawColor(color)
		surface.DrawRect(0, 0, width, height)
	end
end

vgui.Register("ixCharMenuPanel", PANEL, "ixSubpanelParent")

-- character menu main button list
PANEL = {}

function PANEL:Init()
	local parent = self:GetParent()
	self:SetSize(parent:GetWide() * 0.25, parent:GetTall())

	self:GetVBar():SetWide(0)
	self:GetVBar():SetVisible(false)
end

function PANEL:Add(name)
	local panel = vgui.Create(name, self)
	panel:Dock(TOP)

	return panel
end

function PANEL:SizeToContents()
	self:GetCanvas():InvalidateLayout(true)

	-- if the canvas has extra space, forcefully dock to the bottom so it doesn't anchor to the top
	if (self:GetTall() > self:GetCanvas():GetTall()) then
		self:GetCanvas():Dock(BOTTOM)
	else
		self:GetCanvas():Dock(NODOCK)
	end
end

vgui.Register("ixCharMenuButtonList", PANEL, "DScrollPanel")

-- main character menu panel
PANEL = {}

AccessorFunc(PANEL, "bUsingCharacter", "UsingCharacter", FORCE_BOOL)

function PANEL:Init()
	local sizew, sizeh = ScrW(), ScrH()
	local parent = self:GetParent()
	local padding = self:GetPadding()
	local halfWidth = ScrW() * 0.5
	local halfPadding = padding * 0.5
	local bHasCharacter = #ix.characters > 0
	print(bHasCharacter)

	self.bUsingCharacter = LocalPlayer().GetCharacter and LocalPlayer():GetCharacter()
	self:DockPadding(padding, padding, padding, padding)

	local backimg = self:Add("DImage")
	backimg:SetImage("back1.png")
	backimg:SetPos(-1, 0)
	backimg:SetSize(ScrW()+1, ScrH())

	local editpanel1 = backimg:Add("editablepanel")
	editpanel1:SetSize(backimg:GetSize())

	editpanel1.Paint = function(self, w, h)
		surface.SetTextColor(color_header)
		surface.SetFont("Header")
		surface.SetTextPos(99, 172)
		surface.DrawText("[Y&I] Главное меню")
		surface.SetTextColor(color_headerfade)
		surface.SetFont("Header2")
		surface.SetTextPos(103, 269)
		surface.DrawText("MILITARY SCP RP")
	end



	-- button list
	self.mainButtonList = self:Add("ixCharMenuButtonList")
	self.mainButtonList:Dock(LEFT)


	Helix_YUI_Button("T1", 103, 392, self, "Создать персонажа", "DermaLarge", "Create", 384, 55, parent, bHasCharacter)
	Helix_YUI_Button("T2", 103, 461, self, "Выбрать персонажа", "DermaLarge", "Load", 384, 55, parent, bHasCharacter)
	local community = Helix_YUI_Button("T3", 103, 530, self, "Наше комьюнити", "DermaLarge", "Community", 384, 55, parent)
	Helix_YUI_Button("T4", 103, 1000, self, "Выйти", "DermaLarge", "Exit", 384, 55, parent)
	local ds = Helix_YUI_ButtonCommunity("T5", 103, 782, self, "Discord", "Community", "1", 180, 45, parent)
	local steam = Helix_YUI_ButtonCommunity("T6", 103, 841, self, "Steam", "Community", "1", 180, 45, parent)
	local rules = Helix_YUI_ButtonCommunity("T7", 103, 900, self, "Rules", "Community", "1", 180, 45, parent)

	community.DoClick = function()
		yas_bclick()
		gui.OpenURL("https://discord.gg/wwvycqzTjM")
	end

	ds.DoClick = function()
		yas_bclick()
		gui.OpenURL("https://discord.gg/wwvycqzTjM")
	end

	steam.DoClick = function()
		yas_bclick()
		gui.OpenURL("https://steamcommunity.com/sharedfiles/filedetails/?id=3416350427")
	end

	rules.DoClick = function()
		yas_bclick()
		gui.OpenURL("https://docs.google.com/document/d/17oCawPtsYLBCBbDqt29_ZX1YRWmqu6vu39pzfjw0HhI/edit?usp=sharing")
	end

	-- create character button
	--[[local createButton = self.mainButtonList:Add("ixMenuButton")
	createButton:SetText("create")
	createButton:SizeToContents()
	createButton.DoClick = function()
		local maximum = hook.Run("GetMaxPlayerCharacter", LocalPlayer()) or ix.config.Get("maxCharacters", 5)
		-- don't allow creation if we've hit the character limit
		if (#ix.characters >= maximum) then
			self:GetParent():ShowNotice(3, L("maxCharacters"))
			return
		end

		self:Dim()
		parent.newCharacterPanel:SetActiveSubpanel("faction", 0)
		parent.newCharacterPanel:SlideUp()
	end

	-- load character button
	self.loadButton = self.mainButtonList:Add("ixMenuButton")
	self.loadButton:SetText("load")
	self.loadButton:SizeToContents()
	self.loadButton.DoClick = function()
		self:Dim()
		parent.loadCharacterPanel:SlideUp()
	end

	if (!bHasCharacter) then
		self.loadButton:SetDisabled(true)
	end

	-- community button
	local extraURL = ix.config.Get("communityURL", "")
	local extraText = ix.config.Get("communityText", "@community")

	if (extraURL != "" and extraText != "") then
		if (extraText:sub(1, 1) == "@") then
			extraText = L(extraText:sub(2))
		end

		local extraButton = self.mainButtonList:Add("ixMenuButton")
		extraButton:SetText(extraText, true)
		extraButton:SizeToContents()
		extraButton.DoClick = function()
			gui.OpenURL(extraURL)
		end
	end

	-- leave/return button
	self.returnButton = self.mainButtonList:Add("ixMenuButton")
	self:UpdateReturnButton()
	self.returnButton.DoClick = function()
		if (self.bUsingCharacter) then
			parent:Close()
		else
			RunConsoleCommand("disconnect")
		end
	end--]]

	local newsbox = self:Add("editablepanel")
	newsbox:SetPos(sizew-600, sizeh/2)
	newsbox:SetSize(590, sizeh/2.05)
	newsbox.Paint = function(self, w, h)
		surface.SetDrawColor(color_button)
		surface.DrawRect(0, 0, w, h)
		surface.SetDrawColor(color_button_outline)
		surface.DrawOutlinedRect(0, 0, w, h, 1)
	end

	local MainScroll = vgui.Create( "DScrollPanel", newsbox )
   	MainScroll:Dock(FILL)
   	MainScroll:DockMargin(10, 0, 10, 50)

   	table.SortByMember( scp_update_table, "version" )

	for _,v in ipairs(scp_update_table) do

		local headerlog = MainScroll:Add("editablepanel")
		headerlog:Dock(TOP)
		headerlog:DockMargin(1, 20, 0, 0)
		local tw, th = Helix_YUI_GetSize(v.header, "DermaLarge")
		headerlog:SetSize(tw, th)
		headerlog.Paint = function(self, w, h)
			surface.SetFont("DermaLarge")
			surface.SetTextColor(color_white)
			surface.SetTextPos(20, 0)
			surface.DrawText(v.header)
		end
			
			
		local version = MainScroll:Add("editablepanel")
		version:Dock(TOP)
		version:DockMargin(1, 0, 0, 10)
		local tw, th = Helix_YUI_GetSize(v.version, "font_version")
		version:SetSize(tw, th)
		version.Paint = function(self, w, h)
			surface.SetFont("font_version")
			surface.SetTextColor(color_white)
			surface.SetTextPos(23, 0)
			surface.DrawText(v.version)
		end
		

		local descback = vgui.Create("editablepanel", MainScroll)
		descback:Dock(FILL)

		local wrappedtext = yui_darkrpwarp(v.desc, "Community", 510)
		local desc = MainScroll:Add("DLabel")
		local tw, th = Helix_YUI_GetSize(wrappedtext, "Community")
		desc:SetTextColor(color_white)
		desc:SetFont("Community")
		desc:SetText(wrappedtext)
		desc:SetAutoStretchVertical(true)
		desc:Dock(TOP)
		desc:DockMargin(25, 0, 0, 0)
		local desc_w, desc_h = desc:GetSize()
		local desc_x, desc_y = desc:GetPos()

		local descback_paint = vgui.Create("editablepanel", MainScroll)

		descback_paint:SetSize(tw, th)
		--descback_paint:SetPos(desc_x, desc_y)
		descback_paint:Dock(TOP)
		descback_paint:DockMargin(20, -th, 0, 5)

		descback_paint.Paint = function(self, w, h)
			surface.SetDrawColor(Color(91, 91, 91, 80))
			surface.DrawRect(0, 0, w, h)
		end
	end

	self.mainButtonList:SizeToContents()-- Main panel
end

function PANEL:UpdateReturnButton(bValue)
	if (bValue != nil) then
		self.bUsingCharacter = bValue
	end
end


function PANEL:OnDim()
	-- disable input on this panel since it will still be in the background while invisible - prone to stray clicks if the
	-- panels overtop slide out of the way
	self:SetMouseInputEnabled(false)
	self:SetKeyboardInputEnabled(false)
end

function PANEL:OnUndim()
	self:SetMouseInputEnabled(true)
	self:SetKeyboardInputEnabled(true)

	-- we may have just deleted a character so update the status of the return button
	self.bUsingCharacter = LocalPlayer().GetCharacter and LocalPlayer():GetCharacter()
	self:UpdateReturnButton()
end

function PANEL:OnClose()
	for _, v in pairs(self:GetChildren()) do
		if (IsValid(v)) then
			v:SetVisible(false)
		end
	end
end

function PANEL:PerformLayout(width, height)
	local padding = self:GetPadding()

	self.mainButtonList:SetPos(padding, height - self.mainButtonList:GetTall() - padding)
end

vgui.Register("ixCharMenuMain", PANEL, "ixCharMenuPanel")

-- container panel
PANEL = {}

function PANEL:Init()
	if (IsValid(ix.gui.loading)) then
		ix.gui.loading:Remove()
	end

	if (IsValid(ix.gui.characterMenu)) then
		if (IsValid(ix.gui.characterMenu.channel)) then
			ix.gui.characterMenu.channel:Stop()
		end

		ix.gui.characterMenu:Remove()
	end

	self:SetSize(ScrW(), ScrH())
	self:SetPos(0, 0)

	-- main menu panel
	self.mainPanel = self:Add("ixCharMenuMain")

	-- new character panel
	self.newCharacterPanel = self:Add("ixCharMenuNew")
	self.newCharacterPanel:SlideDown(0)

	-- load character panel
	self.loadCharacterPanel = self:Add("ixCharMenuLoad")
	self.loadCharacterPanel:SlideDown(0)

	-- notice bar
	self.notice = self:Add("ixNoticeBar")

	-- finalization
	self:MakePopup()
	self.currentAlpha = 255
	self.volume = 0

	ix.gui.characterMenu = self

	if (!IsValid(ix.gui.intro)) then
		self:PlayMusic()
	end

	hook.Run("OnCharacterMenuCreated", self)
end

function PANEL:PlayMusic()
	local path = "sound/" .. ix.config.Get("music")
	local url = path:match("http[s]?://.+")
	local play = url and sound.PlayURL or sound.PlayFile
	path = url and url or path

	play(path, "noplay", function(channel, error, message)
		if (!IsValid(self) or !IsValid(channel)) then
			return
		end

		channel:SetVolume(self.volume or 0)
		channel:Play()

		self.channel = channel

		self:CreateAnimation(audioFadeInTime, {
			index = 10,
			target = {volume = 1},

			Think = function(animation, panel)
				if (IsValid(panel.channel)) then
					panel.channel:SetVolume(self.volume * 0.5)
				end
			end
		})
	end)
end

function PANEL:ShowNotice(type, text)
	self.notice:SetType(type)
	self.notice:SetText(text)
	self.notice:Show()
end

function PANEL:HideNotice()
	if (IsValid(self.notice) and !self.notice:GetHidden()) then
		self.notice:Slide("up", 0.5, true)
	end
end

function PANEL:OnCharacterDeleted(character)
	if (#ix.characters == 0) then
		self.mainPanel.loadButton:SetDisabled(true)
		self.mainPanel:Undim() -- undim since the load panel will slide down
	else
		--self.mainPanel.loadButton:SetDisabled(false)
	end

	self.loadCharacterPanel:OnCharacterDeleted(character)
end

function PANEL:OnCharacterLoadFailed(error)
	self.loadCharacterPanel:SetMouseInputEnabled(true)
	self.loadCharacterPanel:SlideUp()
	self:ShowNotice(3, error)
end

function PANEL:IsClosing()
	return self.bClosing
end

function PANEL:Close(bFromMenu)
	self.bClosing = true
	self.bFromMenu = bFromMenu

	local fadeOutTime = animationTime * 8

	self:CreateAnimation(fadeOutTime, {
		index = 1,
		target = {currentAlpha = 0},

		Think = function(animation, panel)
			panel:SetAlpha(panel.currentAlpha)
		end,

		OnComplete = function(animation, panel)
			panel:Remove()
		end
	})

	self:CreateAnimation(fadeOutTime - 0.1, {
		index = 10,
		target = {volume = 0},

		Think = function(animation, panel)
			if (IsValid(panel.channel)) then
				panel.channel:SetVolume(self.volume * 0.5)
			end
		end,

		OnComplete = function(animation, panel)
			if (IsValid(panel.channel)) then
				panel.channel:Stop()
				panel.channel = nil
			end
		end
	})

	-- hide children if we're already dimmed
	if (bFromMenu) then
		for _, v in pairs(self:GetChildren()) do
			if (IsValid(v)) then
				v:SetVisible(false)
			end
		end
	else
		-- fade out the main panel quicker because it significantly blocks the screen
		self.mainPanel.currentAlpha = 255

		self.mainPanel:CreateAnimation(animationTime * 2, {
			target = {currentAlpha = 0},
			easing = "outQuint",

			Think = function(animation, panel)
				panel:SetAlpha(panel.currentAlpha)
			end,

			OnComplete = function(animation, panel)
				panel:SetVisible(false)
			end
		})
	end

	-- relinquish mouse control
	self:SetMouseInputEnabled(false)
	self:SetKeyboardInputEnabled(false)
	gui.EnableScreenClicker(false)
end

function PANEL:Paint(width, height)
	surface.SetTexture(gradient)
	surface.SetDrawColor(0, 0, 0, 255)
	surface.DrawTexturedRect(0, 0, width, height)
end

function PANEL:PaintOver(width, height)
	if (self.bClosing and self.bFromMenu) then
		surface.SetDrawColor(color_black)
		surface.DrawRect(0, 0, width, height)
	end
end

function PANEL:OnRemove()
	if (IsValid(self.channel)) then
		self.channel:Stop()
		self.channel = nil
	end
end

vgui.Register("ixCharMenu", PANEL, "EditablePanel")

if (IsValid(ix.gui.characterMenu)) then
	ix.gui.characterMenu:Remove()

	--TODO: REMOVE ME
	ix.gui.characterMenu = vgui.Create("ixCharMenu")
end
