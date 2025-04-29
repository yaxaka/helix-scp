chemlab_table = {}

function yr_CreateTable()
    sql.Query("CREATE TABLE IF NOT EXISTS yr_science ( ID STRING PRIMARY KEY, Tags STRING, Parents STRING, Author STRING )")
    sql.Query("INSERT OR REPLACE INTO yr_science ( ID, Tags, Parents, Author ) VALUES ( " ..  sql.SQLStr("2485_ZNCB") .. ", " .. sql.SQLStr("GovnoEnaDa") .. ", " .. sql.SQLStr("Nil") .. ", " .. sql.SQLStr("Yaxaka") .. " )")
end

yr_CreateTable()

function yr_localtable()
    local a = sql.Query("SELECT * FROM yr_science")

    for k,v in pairs(a) do
        chemlab_table[v.ID] = v
        print(v)
    end

end

yr_localtable()

function yr_SaveElement(tags, parents, author)
    if tags ~= nil then
        sql.Query("INSERT OR REPLACE INTO yr_science ( ID, Tags, Parents, Author ) VALUES ( " ..  sql.SQLStr(yr_generateid()) .. ", " .. sql.SQLStr(tags) .. ", " .. sql.SQLStr(parents) .. ", " .. sql.SQLStr(author) .. " )")
        ymsg_d("Saved Element")
    else
        ymsg_e("Cant save YR element")
    end
end

function yr_LoadElement(id)
    return chemlab_table[id]
end

function yr_generateid()
    local tbl = {}
    local tbl2 = {}

    for i=1,4 do
        tbl[i] = math.random(1, 9)
    end

    for i=1,4 do
        tbl2[i] = string.char(math.random(65, 65 + 25))
    end

    local word = tbl[1] .. tbl[2] .. tbl[3] .. tbl[4] .. "_" .. tbl2[1] .. tbl2[2] .. tbl2[3] .. tbl2[4]

    if yr_LoadElement(word) ~= nil then
        yr_generateid()
        return
    end

    return word
end