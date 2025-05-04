yas_roles = {
	['User'] = {	
		name = "User",
		flags = nil,
		superadmin = false,
		color = Color(255, 255, 255),
		hierarchy = 0,	
	},

	['Moderator'] = {	
		name = "Moderator",
		flags = 'warn,tp,pm',
		superadmin = false,
		color = Color(41, 26, 114),
		hierarchy = 2,	
	},

	['Superadmin'] = {	
		name = "Superadmin",
		flags = 'warn,tp,full',
		superadmin = true,
		color = Color(108, 0, 0),
		hierarchy = 1024,	
	},

	['Tester'] = {	
		name = "Tester",
		flags = 'warn,tp,full,pm',
		superadmin = true,
		color = Color(108, 0, 0),
		hierarchy = 1,	
	},

}

table.SortByMember( yas_roles, "hierarchy" )

yas_config = {
	DiscordLogs = false,
	WarnBeforeTP = true,
	DataBase = nil,
	text_nonrp = "Внимание! Ваши действия являются неадекватными, и вам стоит прекратить. Если вы продолжите, вы можете получить блокировку на длительный срок",
	text_nonrpzone = "Внимание! Просьба не выходить из сервера и найти укромное место для телепортации Вас в NONRP зону!",
}

