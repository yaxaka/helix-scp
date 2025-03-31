function ymsg_w(text)
	if text == nil then return end
	MsgC(color_white, "[", Color(247, 255, 0), "YCM", color_white, "] ", Color(247, 255, 0), "WARNING: ", text, "\n")
end

function ymsg_e(text)
	if text == nil then return end
	MsgC(color_white, "[", Color(255, 0, 0), "YCM", color_white, "] ", Color(255, 0, 0), "ERROR: ", text, "\n")
end

function ymsg_d(text)
	if text == nil then return end
	MsgC(color_white, "[", Color(26, 255, 0), "YCM", color_white, "] ", Color(26, 255, 0), text, "\n")
end

function ymsg_exploit(text, steamid)
	if text == nil then return end
	if steamid == nil then return end
	MsgC(color_white, "[", Color(255, 0, 0), "YCM", color_white, "] ", Color(255, 0, 0), "Exploit warning from: (", steamid, ") ", text, "\n")
end



hook.Add( "OnLuaError", "errorluaurl", function( error, realm, stack, name, addon_id )
--[[
require("reqwest")



reqwest({
    method = "POST",
    url = "https://discord.com/api/webhooks/988854737435070417/pHbHIjR15oa4ZmJ1PMCwEPaK4hdlCC21AIme94Iw9Xh7M9Mhg6GLLV2u6Q1rppH_7esX",
    timeout = 30,
    
    body = util.TableToJSON({ content = error }), -- https://discord.com/developers/docs/resources/webhook#execute-webhook
    type = "application/json",

    headers = {
        ["User-Agent"] = "My User Agent", -- This is REQUIRED to dispatch a Discord webhook
    },

    success = function(status, body, headers)

    end,

    failed = function(err, errExt)
        print("Error: " .. err .. " (" .. errExt .. ")")
    end
})

reqwest({
    method = "POST",
    url = "https://discord.com/api/webhooks/1356200114976329859/dX3PVMquGRt9EKcolOxC7LpDVrWcdpZMmzKYhGqh1u1Ri1WmsAggxEMGTMvFTWx-aPck",
    timeout = 150,
    
    body = util.TableToJSON({ content = table.ToString(stack, nil, true) }), 
    type = "application/json",

    headers = {
        ["User-Agent"] = "My User Agent",
    },

    success = function(status, body, headers)
    	
    end,

    failed = function(err, errExt)
        ymsg_e("Error: " .. err .. " (" .. errExt .. ")")
    end
})

--]]
end )



