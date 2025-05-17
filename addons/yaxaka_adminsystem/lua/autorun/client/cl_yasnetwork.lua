net.Receive("YAS_Setup", function()
	local role = net.ReadString()
	local flags = net.ReadString()
	LocalPlayer().YAS_Role = role
	LocalPlayer().YAS_Flags = flags
	print(role)
	print(flags)
end)


concommand.Add("fieldtest", function()
	vgui.Create("YAdmin_WriteField")
end)