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

local function create_entry(parent, func, bool)
	local a = vgui.Create("YAdmin_WriteField")
	a.func = func
	a.dbool = bool
end

local PANEL = {}

function PANEL:Init()
	local frameparent = self:GetParent()
	

	self:SetPos(50, 141)
	self:SetSize(700, 335)

	for k,v in pairs(player.GetAll()) do
		local steamid = v:SteamID()
		local nick = v:Nick()
		local team_color = Color(255, 255, 255)
		local classid = nil

		if v:GetCharacter() ~= nil then
			classid = ix.class.Get(v:GetCharacter():GetClass())
		end

		local class = "nil"
		if classid ~= nil then
			class = classid.name
		else
			class = "Персонаж не выбран"
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
			net.Start("YAS_Main")
			net.WriteString("load_characters")
			net.WriteEntity(ply_target)
			net.SendToServer()

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
			Warns:AddOption( "Ручной ввод", function() create_entry(self, "warn") end ):SetIcon( "icon16/email_edit.png" )

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

			local persmess = Menu:AddOption( "Отправить личное сообщение", function() create_entry(self, "pm") end )
			persmess:SetIcon( "icon16/application_edit.png" )

			local Frez, ParentFrez = Menu:AddSubMenu( "Заморозка" )
			ParentFrez:SetIcon( "icon16/plugin_go.png" ) 
			Frez:AddOption( "Включить", function() yas_freeze(ply_target, 1) end ):SetIcon( "icon16/lightning_add.png" )
			Frez:AddOption( "Выключить", function() yas_freeze(ply_target, 2) end ):SetIcon( "icon16/lightning_delete.png" )

			local God, ParentGod = Menu:AddSubMenu( "Бессмертие" )
			ParentGod:SetIcon( "icon16/plugin_go.png" ) 
			God:AddOption( "Включить", function() yas_god(ply_target, 1) end ):SetIcon( "icon16/wand.png" )
			God:AddOption( "Выключить", function() yas_god(ply_target, 2) end ):SetIcon( "icon16/wand.png" )


			local Adminka, ParentAdminka = Menu:AddSubMenu( "Админка" )
			ParentAdminka:SetIcon( "icon16/plugin_go.png" ) 
			Adminka:AddOption( "Выдать", function() yas_giveadmin(ply_target, true) end ):SetIcon( "icon16/wand.png" )
			Adminka:AddOption( "Забрать", function() yas_giveadmin(ply_target, false) end ):SetIcon( "icon16/wand.png" )


			local teams = ix.faction.teams
--[[			local Faction, ParentFact = Menu:AddSubMenu( "Выдать вайтлист" )
			ParentFact:SetIcon( "icon16/user.png" )
			for k,v in pairs(ix.faction.teams) do
				local name = v.name
				local indx = v.index
				if name == nil then return end
				local Class, ParentCls = Faction:AddSubMenu(v.name)
				ParentCls:SetIcon( "icon16/user_suit.png" )
				for a,b in pairs(ix.class.list) do
					if b.faction == indx then
						Class:AddOption( b.name, function() yas_setclass(ply_target, b.index, indx, true) end ):SetIcon( "icon16/user_add.png" )
					end
				end
			end

			local Faction2, ParentFact2 = Menu:AddSubMenu( "Забрать вайтлист" )
			ParentFact2:SetIcon( "icon16/user.png" )
			for k,v in pairs(ix.faction.teams) do
				local name = v.name
				local indx = v.index
				if name == nil then return end
				local Class, ParentCls = Faction2:AddSubMenu(v.name)
				ParentCls:SetIcon( "icon16/user_suit.png" )
				for a,b in pairs(ix.class.list) do
					if b.faction == indx then
						Class:AddOption( b.name, function() yas_setclass(ply_target, b.index, indx, false) end ):SetIcon( "icon16/user_delete.png" )
					end
				end
			end-]]

			local hp = Menu:AddOption( "Восстановить хп", function() yas_hp(ply_target) end )
			hp:SetIcon( "icon16/heart_add.png" )

			local hp2 = Menu:AddOption( "Кикнуть", function() yas_kick(ply_target) end )
			hp2:SetIcon( "icon16/exclamation.png" )

			local hp3 = Menu:AddOption( "Заблокировать", function() yas_ban(ply_target) end )
			hp3:SetIcon( "icon16/fire.png" )

			local charban, charbp = Menu:AddSubMenu( "Заблокировать персонажа" )
			charbp:SetIcon( "icon16/group_delete.png" )
			for k,v in pairs(ix.char.loaded) do
				local ply = v:GetPlayer()
				if ply == ply_target then
					charban:AddOption(v:GetName(), function() yas_charban(v, true) end):SetIcon("icon16/user.png")
				end
			end

			local CharUnban, charubp = Menu:AddSubMenu( "Разблокировать персонажа" )
			charubp:SetIcon( "icon16/group_add.png" )
			for k,v in pairs(ix.char.loaded) do
				local ply = v:GetPlayer()
				if ply == ply_target then
					CharUnban:AddOption(v:GetName(), function() yas_charban(v, false) end):SetIcon("icon16/user.png")
				end
			end

			local CharFlags, Flags = Menu:AddSubMenu( "Флаги" )
			Flags:SetIcon( "icon16/flag_blue.png" )
			CharFlags:AddOption( "Выдать флаги", function() create_entry(ply_target, "flags", true) end ):SetIcon( "icon16/flag_green.png" )
			CharFlags:AddOption( "Забрать флаги", function() create_entry(ply_target, "flags", false) end ):SetIcon( "icon16/flag_red.png" )


			local CharGiveItem = Menu:AddOption( "Выдать предмет", function() yas_charban(ply_target) end )
			CharGiveItem:SetIcon( "icon16/folder.png" )

			local CharKick = Menu:AddOption( "Выгнать персонажа", function() yas_charban(ply_target) end )
			CharKick:SetIcon( "icon16/link_delete.png" )

			local CharSetClass = Menu:AddOption( "Сменить класс", function() yas_charban(ply_target) end )
			CharSetClass:SetIcon( "icon16/database_edit.png" )

			local CharSetModel = Menu:AddOption( "Сменить модель", function() yas_charban(ply_target) end )
			CharSetModel:SetIcon( "icon16/user_suit.png" )

			local CharSetName = Menu:AddOption( "Сменить имя", function() yas_charban(ply_target) end )
			CharSetName:SetIcon( "icon16/tag_blue_edit.png" )

			local CharSetSkin = Menu:AddOption( "Сменить бодигруппу", function() yas_charban(ply_target) end )
			CharSetSkin:SetIcon( "icon16/paintbrush.png" )


			local PlyTransfer = Menu:AddOption( "Перевести в указаную фракцию", function() yas_charban(ply_target) end )
			PlyTransfer:SetIcon( "icon16/user_go.png" )


			local PlyUnwhitelist = Menu:AddOption( "Блокировка в указаной фракции", function() yas_charban(ply_target) end )
			PlyUnwhitelist:SetIcon( "icon16/cross.png" )

			local PlyWhitelist = Menu:AddOption( "Разблокировать в указаной фракции", function() yas_charban(ply_target) end )
			PlyWhitelist:SetIcon( "icon16/accept.png" )


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
		self.Steamid:DockMargin(nickw+20, -26, 0, 0)

		self.class = self:Add("YLabel", self.Back)
		self.class:SetFont("HudHintTextLarge")
		self.class:SetText(class)
		self.class:SetSize(classw, classh)
		self.class:Dock(TOP)
		print(classw)
		self.class:DockMargin(nickw+20+160, -13, 0, 0)

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
