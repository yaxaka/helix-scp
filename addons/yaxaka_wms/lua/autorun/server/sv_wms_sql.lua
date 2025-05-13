ywms_table = {}

function ywms_CreateTable()
	sql.Query("CREATE TABLE IF NOT EXISTS ywms_sqltable ( uid STRING PRIMARY KEY, name STRING, reference STRING, count INT )")
	sql.Query("INSERT OR REPLACE INTO ywms_sqltable ( uid, name, reference, count ) VALUES ( " ..  sql.SQLStr("ZZZ_237-H8") .. ", " .. sql.SQLStr("Placeholder") .. "," .. sql.SQLStr("3734_HQTA") .. ", " .. 100 .. " )")
end

ywms_CreateTable()

function ywms_localtable()
	local a = sql.Query("SELECT * FROM ywms_sqltable")

	for k,v in pairs(a) do
		ywms_table[v.uid] = {
			[1] = v.name,
			[2] = v.reference,
			[3] = v.count,
		}
	end

end

ywms_localtable()

function ywms_generateid()
    local tbl = {}
    local tbl2 = {}

    for i=1,4 do
        tbl[i] = math.random(1, 9)
    end

    for i=1,4 do
        tbl2[i] = string.char(math.random(65, 65 + 25))
    end

    local word = tbl2[1] .. tbl2[2] .. tbl2[3] .. "_" .. tbl[1] .. tbl[2] .. tbl[3] .. "-" .. tbl2[4] .. tbl[4]

    if ywms_LoadItem(word) ~= nil then
        ywms_generateid()
        return
    end

    return word
end

function ywms_SaveNew(name, reference, count)
	local uid = ywms_generateid()
	sql.Query("INSERT OR REPLACE INTO ywms_sqltable ( uid, name, reference, count ) VALUES ( " .. sql.SQLStr(uid) .. ", " .. sql.SQLStr(name) .. "," .. sql.SQLStr(reference) .. ", " .. count .. " )")
	if ywms_LoadItemSQL(uid) ~= nil then
		ywms_table[uid] = {
			[1] = name,
			[2] = reference,
			[3] = count,
		}
		ymsg_d("Saved " .. uid .. " with name " .. name)
	else
		ymsg_e("Cant save ywms uid: " .. uid .. ", invalid table values!")
	end
end

function ywms_EditCount(uid, count)
	if ywms_validitem(uid) then

		local count2 = 0
		local name = ywms_table[uid][1]
		local reference = ywms_table[uid][2]
		count2 = ywms_table[uid][3] + count

		if count2 <= -1 then
			return false
		else
			sql.Query("INSERT OR REPLACE INTO ywms_sqltable ( uid, name, reference, count ) VALUES ( " .. sql.SQLStr(uid) .. ", " .. sql.SQLStr(name) .. "," .. sql.SQLStr(reference) .. ", " .. count2 .. " )")

			if ywms_LoadItemSQL(uid) ~= nil then
				ywms_table[uid] = {
					[1] = name,
					[2] = reference,
					[3] = count2,
				}
				ymsg_d("Saved " .. uid .. " with count " .. count2)
			else
				ymsg_e("Cant save ywms uid: " .. uid .. ", invalid table values!")
			end
			return true
		end
	end
end

function ywms_LoadItemSQL(uid)
	return sql.Query("SELECT * FROM ywms_sqltable WHERE uid = " .. sql.SQLStr(uid))
end

function ywms_LoadItem(uid)
	return ywms_table[uid]
end

function ywms_validitem(uid)
	if ywms_table[uid] == nil then
		ymsg_e("Invalid YAS role!")
		return false
	else
		return true
	end
end