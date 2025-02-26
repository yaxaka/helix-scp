ytool_zones = {}

net.Receive("TBLC", function()
	local tb = net.ReadTable()
	ytool_zones = tb
end)