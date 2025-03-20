yas_roles = {
	{	name = "User",
		flags = nil,
		superadmin = false,
		color = Color(255, 255, 255),
		hierarchy = 0,	},

	{	name = "Moderator",
		flags = 'watch,reports',
		superadmin = false,
		color = Color(41, 26, 114),
		hierarchy = 2,	},

	{	name = "Superadmin",
		flags = 'watch,reports,full',
		superadmin = true,
		color = Color(108, 0, 0),
		hierarchy = 1024,	},

	{	name = "Tester",
		flags = 'watch,reports,full',
		superadmin = true,
		color = Color(108, 0, 0),
		hierarchy = 1,	},

}

table.SortByMember( yas_roles, "hierarchy" )

yas_config = {
	DiscordLogs = false,
	WarnBeforeTP = true,
	DataBase = nil,
}