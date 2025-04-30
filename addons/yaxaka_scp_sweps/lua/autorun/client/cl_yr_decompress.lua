yr_chemlab_table = {}

net.Receive("yr_refresh", function()
	local bytes_amount = net.ReadUInt(16)
	local compressed_message = net.ReadData(bytes_amount) 
	local message = util.Decompress(compressed_message)

	yr_chemlab_table = util.JSONToTable(message)
end)

