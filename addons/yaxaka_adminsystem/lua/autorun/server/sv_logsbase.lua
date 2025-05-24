yas_logs_table = {}

function yas_logs_CreateTable()
	sql.Query("CREATE TABLE IF NOT EXISTS yas_logs ( SteamID64 INTEGER PRIMARY KEY, Character STRING, Time INT, Info STRING )")
	sql.Query("INSERT OR REPLACE INTO yas_logs ( SteamID, Time ) VALUES ( " ..  sql.SQLStr("STEAM:000") .. ", " .. sql.SQLStr("0") .. " )")
end

function yas_logs_localtable()
	local a = sql.Query("SELECT * FROM yas_roles")
	local b = sql.Query("SELECT * FROM yas_ban")

	for k,v in pairs(a) do
		yas_logs_table[k] = v
	end

end

function yas_logs_WriteNew()

end