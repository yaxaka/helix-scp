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

		self.Back = self:Add("DButton")
		self.Back:SetSize(700, 25)
		self.Back:SetText("")
		self.Back:Dock(TOP)
		self.Back:DockMargin(0, 15, 0, 0)
		self.Back.Target = v

		function self.Back:DoClick()
			local Menu = DermaMenu()
			ply_target = self.Target
			local selfpos = LocalPlayer():GetPos()


			local btnWithIcon = Menu:AddOption( "Скопировать SteamID", function() SetClipboardText(ply_target:SteamID()) end )
			btnWithIcon:SetIcon( "icon16/page_copy.png" )

			Menu:AddSpacer()

			local Warns, Parent = Menu:AddSubMenu( "Предупреждения" )
			Parent:SetIcon( "icon16/exclamation.png" )
			Warns:AddOption( "Телепорт в NonRP зону", function() yas_sendwarn(2, 1, ply_target) end ):SetIcon( "icon16/email_go.png" )
			Warns:AddOption( "NonRP поведение", function() yas_sendwarn(1, 2, ply_target) end ):SetIcon( "icon16/email_go.png" )
			Warns:AddOption( "Ручной ввод", function() yas_sendwarn(1, 1, ply_target) end ):SetIcon( "icon16/email_edit.png" )

			Menu:AddSpacer()

			local Teleport, Parent2 = Menu:AddSubMenu( "Телепорт" )
			Parent2:SetIcon( "icon16/plugin_go.png" ) 
			Teleport:AddOption( "Установить точку телепорта", function() yas_tp_pos(ply_target, selfpos) end ):SetIcon( "icon16/user_edit.png" )

			if ply_target.yas_tp_pos ~= nil then
				Teleport:AddOption( "Телепортировать на точку", function() yas_tp_send(ply_target) end ):SetIcon( "icon16/user_go.png" )
			end

			if ply_target.teleported ~= nil then
				Teleport:AddOption( "Вернуть обратно", function() yas_return_send(ply_target) end ):SetIcon( "icon16/arrow_undo.png" )
			end



			local Mute, Parent3 = Menu:AddSubMenu( "Мут" )
			Parent3:SetIcon( "icon16/sound.png" ) 

			if ply_target.voice_muted ~= nil then
				Mute:AddOption( "Размутить воис", function() yas_voiceunmute(ply_target) end ):SetIcon( "icon16/sound_add.png" )
			else
				Mute:AddOption( "Замутить воис", function() yas_voicemute(ply_target) end ):SetIcon( "icon16/sound_mute.png" )
			end
			
			if ply_target.chat_muted ~= nil then
				Mute:AddOption( "Размутить чат", function() yas_chatunmute(ply_target) end ):SetIcon( "icon16/sound_add.png" )
			else
				Mute:AddOption( "Замутить чат", function() yas_chatmute(ply_target) end ):SetIcon( "icon16/sound_mute.png" )
			end

			local persmess = Menu:AddOption( "Отправить личное сообщение", function() yas_pm(ply_target, "Еее тест мессаге!!") end )
			persmess:SetIcon( "icon16/application_edit.png" )

			local Frez, ParentFrez = Menu:AddSubMenu( "Заморозка" )
			ParentFrez:SetIcon( "icon16/plugin_go.png" ) 
			Frez:AddOption( "Включить", function() yas_freeze(ply_target, 1) end ):SetIcon( "icon16/lightning_add.png" )
			Frez:AddOption( "Выключить", function() yas_freeze(ply_target, 2) end ):SetIcon( "icon16/lightning_delete.png" )

			local God, ParentGod = Menu:AddSubMenu( "Бессмертие" )
			ParentGod:SetIcon( "icon16/plugin_go.png" ) 
			God:AddOption( "Включить", function() yas_god(ply_target, 1) end ):SetIcon( "icon16/wand.png" )
			God:AddOption( "Выключить", function() yas_god(ply_target, 2) end ):SetIcon( "icon16/wand.png" )

			local hp = Menu:AddOption( "Восстановить хп", function() yas_hp(ply_target) end )
			hp:SetIcon( "icon16/heart_add.png" )

			Menu:Open()

		end


		self.Name = self:Add("DLabel", self.Back)
		self.Name:SetText(nick)
		self.Name:SetColor(team_color)
		self.Name:SetSize(nickw, nickh)
		self.Name:SetBright(false)
		self.Name:SetFont("NickFont")
		self.Name:Dock(TOP)
		self.Name:DockMargin(10, -27, 0, 5)



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
