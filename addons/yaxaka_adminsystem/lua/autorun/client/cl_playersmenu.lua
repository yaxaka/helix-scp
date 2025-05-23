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
		local factionclr = ix.faction.Get(v:Team()).color
		local team_color = factionclr or Color(255, 255, 255)
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
		

		
		local steamidw, steamidh = Helix_YUI_GetSize(nick, "consolas_small")
		local nickw, nickh = Helix_YUI_GetSize(nick, "consolas")
		local classw, classh = Helix_YUI_GetSize(class, "consolas_small")

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

			local btnWithIcon = Menu:AddOption( ply_target:Nick(), function() SetClipboardText(ply_target:Nick()) yas_bclick() end )

			local btnWithIcon = Menu:AddOption( "Скопировать SteamID", function() SetClipboardText(ply_target:SteamID()) yas_bclick() end )
			btnWithIcon:SetIcon( "icon16/page_copy.png" )

			Menu:AddSpacer()

			local ply_control, pc = Menu:AddSubMenu( "Управление игроком" )
			pc:SetIcon( "icon16/wrench.png" )

			local Warns, Parent = ply_control:AddSubMenu( "Предупреждения" )
			Parent:SetIcon( "icon16/exclamation.png" )
			Warns:AddOption( "Телепорт в NonRP зону", function() yas_sendwarn(2, 1, ply_target) end ):SetIcon( "icon16/email_go.png" )
			Warns:AddOption( "NonRP поведение", function() yas_sendwarn(1, 2, ply_target) end ):SetIcon( "icon16/email_go.png" )
			Warns:AddOption( "Ручной ввод", function() create_entry(self, "warn") end ):SetIcon( "icon16/email_edit.png" )

			Menu:AddSpacer()

			local Teleport, Parent2 = ply_control:AddSubMenu( "Телепорт" )
			Parent2:SetIcon( "icon16/plugin_go.png" ) 
			Teleport:AddOption( "Установить точку телепорта", function() yas_tp_pos(ply_target, selfpos) end ):SetIcon( "icon16/user_edit.png" )

			if ply_target.yas_tp_pos ~= nil then
				Teleport:AddOption( "Телепортировать на точку", function() yas_tp_send(ply_target) end ):SetIcon( "icon16/user_go.png" )
			end

			if ply_target.teleported ~= nil then
				Teleport:AddOption( "Вернуть обратно", function() yas_return_send(ply_target) end ):SetIcon( "icon16/arrow_undo.png" )
			end



			local Mute, Parent3 = ply_control:AddSubMenu( "Мут" )
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

			local persmess = ply_control:AddOption( "Отправить личное сообщение", function() create_entry(self, "pm") end )
			persmess:SetIcon( "icon16/application_edit.png" )

			local Frez, ParentFrez = ply_control:AddSubMenu( "Заморозка" )
			ParentFrez:SetIcon( "icon16/plugin_go.png" ) 
			Frez:AddOption( "Включить", function() yas_freeze(ply_target, 1) end ):SetIcon( "icon16/lightning_add.png" )
			Frez:AddOption( "Выключить", function() yas_freeze(ply_target, 2) end ):SetIcon( "icon16/lightning_delete.png" )

			local God, ParentGod = ply_control:AddSubMenu( "Бессмертие" )
			ParentGod:SetIcon( "icon16/plugin_go.png" ) 
			God:AddOption( "Включить", function() yas_god(ply_target, 1) end ):SetIcon( "icon16/wand.png" )
			God:AddOption( "Выключить", function() yas_god(ply_target, 2) end ):SetIcon( "icon16/wand.png" )


			local Adminka, ParentAdminka = ply_control:AddSubMenu( "Админка" )
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

			local hp = ply_control:AddOption( "Восстановить хп", function() yas_hp(ply_target) end )
			hp:SetIcon( "icon16/heart_add.png" )

			local hp2 = ply_control:AddOption( "Кикнуть", function() yas_kick(ply_target) end )
			hp2:SetIcon( "icon16/exclamation.png" )

			local hp3 = ply_control:AddOption( "Заблокировать", function() yas_ban(ply_target) end )
			hp3:SetIcon( "icon16/fire.png" )

			local character_control, cc = Menu:AddSubMenu( "Управление персонажем" )
			cc:SetIcon( "icon16/cog.png" )

			local charban, charbp = character_control:AddSubMenu( "Заблокировать персонажа" )
			charbp:SetIcon( "icon16/group_delete.png" )
			for k,v in pairs(ix.char.loaded) do
				local ply = v:GetPlayer()
				if ply == ply_target then
					charban:AddOption(v:GetName(), function() yas_charban(v, true) end):SetIcon("icon16/user.png")
				end
			end

			local CharUnban, charubp = character_control:AddSubMenu( "Разблокировать персонажа" )
			charubp:SetIcon( "icon16/group_add.png" )
			for k,v in pairs(ix.char.loaded) do
				local ply = v:GetPlayer()
				if ply == ply_target then
					CharUnban:AddOption(v:GetName(), function() yas_charban(v, false) end):SetIcon("icon16/user.png")
				end
			end

			local CharFlags, Flags = character_control:AddSubMenu( "Флаги" )
			Flags:SetIcon( "icon16/flag_blue.png" )
			CharFlags:AddOption( "Выдать флаги", function() create_entry(ply_target, "flags", true) end ):SetIcon( "icon16/flag_green.png" )
			CharFlags:AddOption( "Забрать флаги", function() create_entry(ply_target, "flags", false) end ):SetIcon( "icon16/flag_red.png" )

			local CharKick = character_control:AddOption( "Выгнать персонажа", function() yas_charkick(ply_target) end )
			CharKick:SetIcon( "icon16/link_delete.png" )

			local Itemlist, CharGiveItem = character_control:AddSubMenu( "Выдать предмет" )
			CharGiveItem:SetIcon( "icon16/folder.png" )

			local tbl22 = {}
			for k,v in pairs(ix.item.list) do
				local cat = v.category
				if tbl22[v.category] == nil then
					if cat ~= "JArmor" && cat ~= "misc" then
						tbl22[v.category] = v.category
					end
				end
			end

			for k,v in pairs(tbl22) do
				local Itemlist2, CharGiveItem2 = Itemlist:AddSubMenu( k )
				CharGiveItem2:SetIcon("icon16/folder.png")
				Itemlist2.category = v
				print(Itemlist2.category)

				for k,v in pairs(ix.item.list) do
					if v.category == tbl22[Itemlist2.category] then
						Itemlist2:AddOption( v.name, function() create_entry(ply_target, "giveitem", v.uniqueID) end ):SetIcon( "icon16/basket_go.png" )
					end
				end
			end

			local CharSetClass,CSCParent = character_control:AddSubMenu( "Сменить класс" )
			CSCParent:SetIcon( "icon16/database_edit.png" )

			for k,v in pairs(ix.class.list) do
				if v.faction == ply_target:Team() then
					CharSetClass:AddOption( v.name, function() yas_setclass(ply_target, k) end )
				end
			end


			local CharSetModel = character_control:AddOption( "Сменить модель", function() create_entry(ply_target, "char_setmodel") end )
			CharSetModel:SetIcon( "icon16/user_suit.png" )

			local CharSetName = character_control:AddOption( "Сменить имя", function() create_entry(ply_target, "char_setname") end )
			CharSetName:SetIcon( "icon16/tag_blue_edit.png" )

			local CharSetSkin = character_control:AddOption( "Сменить бодигруппу", function() create_entry(ply_target, "char_setbodygroup") end )
			CharSetSkin:SetIcon( "icon16/paintbrush.png" )

			local PlyTransfer, PTParent = character_control:AddSubMenu( "Перевести в указаную фракцию" )
			PTParent:SetIcon( "icon16/user_go.png" )

			local PlyWhitelist, PWParent = character_control:AddSubMenu( "Выдать вайтлист указаной фракции" )
			PWParent:SetIcon( "icon16/accept.png" )

			local PlyUnwhitelist, PUWParent = character_control:AddSubMenu( "Забрать вайтлист указаной фракции" )
			PUWParent:SetIcon( "icon16/cross.png" )

			for k,v in pairs(ix.faction.teams) do
				PlyWhitelist:AddOption( v.name, function() yas_factionwhitelist(ply_target, v.index, true) end ):SetIcon("icon16/group_add.png")
				PlyUnwhitelist:AddOption( v.name, function() yas_factionwhitelist(ply_target, v.index, false) end ):SetIcon("icon16/group_delete.png")
				PlyTransfer:AddOption( v.name, function() yas_factionforce(ply_target, v.index) end ):SetIcon("icon16/group_go.png")
			end


			Menu:Open()

		end


		self.Name = self:Add("DLabel", self.Back)
		self.Name:SetText(nick)
		self.Name:SetColor(team_color)
		self.Name:SetSize(nickw, nickh)
		self.Name:SetFont("consolas")
		self.Name:Dock(TOP)
		self.Name:DockMargin(10, -25, 0, 5)





		self.Steamid = self:Add("YLabel", self.Back)
		self.Steamid:SetFont("consolas_small")
		self.Steamid:SetText("(" .. steamid .. ")")
		self.Steamid:SetSize(steamidw, steamidh)
		self.Steamid:Dock(TOP)
		self.Steamid:DockMargin(nickw+20, -26, 0, 0)

		self.class = self:Add("YLabel", self.Back)
		self.class:SetFont("consolas_small")
		self.class:SetText(class)
		self.class:SetSize(classw, classh)
		self.class:Dock(TOP)
		if steamidw < 50 then
			self.class:DockMargin(nickw+steamidw+classw/2, -14.9, 0, 0)
		else
			self.class:DockMargin(nickw+steamidw+classw+25, -14.9, 0, 0)
		end

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
