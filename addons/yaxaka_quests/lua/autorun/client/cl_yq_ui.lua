local point_min, point_max = nil, nil
local points = {}

point_color = Color(255, 0, 0, 50)

net.Receive("yq_security", function()
	local desc = net.ReadString()

	point_min = net.ReadVector()
	point_max = net.ReadVector()

	LocalPlayer():ChatNotify(desc)
end)

net.Receive("yq_reset", function()
	point_min = nil
	point_max = nil

end)


concommand.Add('reset_quests', function()
	net.Start("yq_reset")
	net.SendToServer()
end)










hook.Add( "PostDrawTranslucentRenderables", "te111st", function( bDepth, bSkybox )



	if point_min == nil then return end
	render.SetColorMaterial()
	local lpos = LocalPlayer():GetPos()

	local first = point_min.x+point_max.x
	local second = point_min.y+point_max.y
	
	local center = LerpVector(0.5, point_min, point_max)
	local min = WorldToLocal(point_min, angle_zero, center, angle_zero)
	local max = WorldToLocal(point_max - Vector(0, 0, 3), angle_zero, center, angle_zero)

	render.DrawBox(center, angle_zero, min, max, point_color)

end )

hook.Add("Think", "SSSS", function()
	if point_min == nil then return end
	local x = LocalPlayer():GetPos()
	local min = (x.x >= point_min.x && x.y >= point_min.y && x.z >= point_min.z)
	local max = (x.x <= point_max.x && x.y <= point_max.y && x.z <= point_max.z)
	if max && min then
		point_color = Color(0, 255, 0, 50)
	else
		point_color = Color(255, 0, 0, 50)
	end
end)