chemlab_table = {}

util.AddNetworkString("yr_refresh")

function yr_CreateTable()
    sql.Query("CREATE TABLE IF NOT EXISTS yr_science ( ID STRING PRIMARY KEY, Tags STRING, Parents STRING, Lapki STRING, Author STRING, Name STRING )")

    sql.Query("INSERT OR REPLACE INTO yr_science ( ID, Tags, Parents, Lapki, Author, Name ) VALUES ( " ..  sql.SQLStr("0004_AAAA") .. ", " .. sql.SQLStr("ply") .. ", " .. sql.SQLStr("Nil") .. ", " .. sql.SQLStr("morphine.txt") .. ", " .. sql.SQLStr("Yaxaka") .. ", " .. sql.SQLStr("Морфин") .. " )")
end

yr_CreateTable()

function yr_localtable()
    local a = sql.Query("SELECT * FROM yr_science")
    chemlab_table = {}

    for k,v in pairs(a) do
        chemlab_table[v.ID] = v
        
    end

end

yr_localtable()

function yr_SaveElement(tags, parents, author, name, lapki)
    if tags ~= nil && name ~= nil then
        local new_id = yr_generateid()
        local filename = new_id .. ".txt"

        file.Write("yr_lapki_data/" .. filename, util.TableToJSON(lapki))

        sql.Query("INSERT OR REPLACE INTO yr_science ( ID, Tags, Parents, Lapki, Author, Name ) VALUES ( " ..  sql.SQLStr(new_id) .. ", " .. sql.SQLStr(tags) .. ", " .. sql.SQLStr(parents) .. ", " .. sql.SQLStr(filename) .. ", " .. sql.SQLStr(author) .. ", " .. sql.SQLStr(name) .. " )")
        
        yr_localtable()

        ymsg_d("Saved Element")

        yr_refresh()

    else
        ymsg_e("Cant save YR element")
    end
end

function yr_LoadElement(id)
    return chemlab_table[id]
end

function yr_DeleteElement(id)
    local el = sql.Query("SELECT * FROM yr_science WHERE ID = " .. sql.SQLStr(id))
    if el ~= nil && el ~= false then
        sql.Query("DELETE FROM yr_science WHERE ID = " .. sql.SQLStr(id))
        file.Delete(string.lower(id) .. ".txt", "DATA")
        yr_localtable()
        yr_refresh()
        ymsg_d("[YR] " .. id .. " element was deleted")
    end
end

function yr_refreshply(ply)
    local data, bytes = yr_compress(chemlab_table)

    net.Start("yr_refresh")
    net.WriteUInt(bytes, 16) 
    net.WriteData(data, bytes)
    net.Send(ply)
end

function yr_refresh()
    local data, bytes = yr_compress(chemlab_table)

    net.Start("yr_refresh")
    net.WriteUInt(bytes, 16) 
    net.WriteData(data, bytes)
    net.Broadcast()
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

function yr_compress(tbl)
    local new_tbl = util.TableToJSON(tbl)
    local send = util.Compress(new_tbl)
    return send, #send
end


function yr_tags(id)
    local el = yr_LoadElement(id)
    if el == nil then return false end
    --yr_chemtags[el.Tags].lapki
    return el.Tags
end


function yr_lapki(id)
    local el = yr_LoadElement(id)
    if el == nil then return false end

    return util.JSONToTable(file.Read("yr_lapki_data/".. el.Lapki, "DATA"))
end


function yr_compare(lapki1, lapki2)
    if lapki1 == nil or lapki2 == nil then return end
    local new_lapki = {
        lapka1 = nil,
        lapka2 = nil,
        lapka3 = nil,
    }

    local power_lapki = {
        [1] = 0,
        [2] = 0,
        [3] = 0,
    }

    for a,b in pairs(lapki1) do
        for k,v in pairs(b) do
            if k == "lapka1" then
                power_lapki[1] = v.power
                new_lapki['lapka1'] = v
            end
            if k == "lapka2" then
                power_lapki[2] = v.power
                new_lapki['lapka2'] = v
            end
            if k == "lapka3" then
                power_lapki[3] = v.power
                new_lapki['lapka3'] = v
            end
        end
    end

    for a,b in pairs(lapki2) do
        for k,v in pairs(b) do
            if k == "lapka1" then
                if v.power > power_lapki[1] then
                    power_lapki[1] = v.power
                    new_lapki['lapka1'] = v
                end
            end
            if k == "lapka2" then
                if v.power > power_lapki[2] then
                    power_lapki[2] = v.power
                    new_lapki['lapka2'] = v
                end
            end
            if k == "lapka3" then
                if v.power > power_lapki[3] then
                    power_lapki[3] = v.power
                    new_lapki['lapka3'] = v
                end
            end
        end
    end

    return new_lapki
end



function yr_mix1(id1, id2, ply, name)
    local el1 = yr_LoadElement(id1)
    local el2 = yr_LoadElement(id2)
    if el1 == nil or el2 == nil then return false end

    local lapki1 = yr_lapki(id1)
    local lapki2 = yr_lapki(id2)
    local new_element = yr_compare(lapki1, lapki2)

    PrintTable(new_element)

    if type(new_element) == type({}) && IsValid(ply) && ply:IsPlayer() then

        local parents = el1.ID .. "-to-" .. el2.ID
        local author = ply:GetCharacter():GetName()

        yr_SaveElement("ply", parents, author, name, new_element)

        return new_element
    else
        return false
    end
end