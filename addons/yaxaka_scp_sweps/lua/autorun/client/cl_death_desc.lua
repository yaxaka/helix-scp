print("t")

scp096_targetlist = {}



net.Receive("SCP096_1_Ent", function()
	local type = net.ReadInt(2)
	local ent = net.ReadEntity()
	local nick = ent:GetName()
	if (type == 1) then
		surface.PlaySound("096_spotted.wav")
		table.insert(scp096_targetlist, nick)
		chat.AddText(nick .. " LOOKED AT YOU!")
	elseif (type == 2) then
		table.RemoveByValue(scp096_targetlist, nick)
	end
end)


surface.CreateFont( "PlayerTagFont", {
	font = "Arial",
	size = 72,
} )

hook.Add( "PostPlayerDraw", "SCP096_Marker", function(ply)
	if not (IsValid(LocalPlayer())) then return end
	local wep = LocalPlayer():GetActiveWeapon():GetClass()
	if not (IsValid(wep)) then return end
	if not (wep == "scp096_swep") then return end
	if not (scp096_targetlist[ply:GetName()]) then return end

	-- Player too far, don't bother
	if ( ply:GetPos():Distance( EyePos() ) > 512 ) then return end

	-- Player is the local player in the first person, don't bother
	if ( ply == LocalPlayer() ) then return end

	-- Get the player position, and move it above their head.
	local pos = ply:GetPos() + ply:GetUp() * ( ply:OBBMaxs().z + 5 )

	-- Apply some neat bobbing animation
	pos = pos + Vector( 0, 0, math.cos( CurTime() / 2 ) )

	-- Get the angle between the local player and the target player
	local angle = ( pos - EyePos() ):GetNormalized():Angle()

	-- Only use the Yaw component of the angle
	angle = Angle( 0, angle.y, 0 )

	-- Apply some animation to the angle
	angle.y = angle.y + math.sin( CurTime() ) * 10

	-- Correct the angle so it points at the camera
	-- This is usually done by trial and error using Up(), Right() and Forward() axes
	angle:RotateAroundAxis( angle:Up(), -90 )
	angle:RotateAroundAxis( angle:Forward(), 90 )

	-- Notice the scale is small, so text looks crispier
	cam.Start3D2D( pos, angle, 0.05 )
		-- Get the size of the text we are about to draw

		surface.SetFont( "PlayerTagFont" )
		local tW, tH = surface.GetTextSize( ply:Nick() )

		-- This defines amount of padding for the box around the text
		local padX = 20
		local padY = 5

		-- Draw a rectable. This has to be done before drawing the text, to prevent overlapping
		-- Notice how we start drawing in negative coordinates
		-- This is to make sure the 3d2d display rotates around our position by its center, not left corner

		surface.SetDrawColor( 0, 0, 0, 100 )
		surface.DrawRect( -tW / 2 - padX, -padY, tW + padX * 2, tH + padY * 2 )

		-- Draw some text
		draw.SimpleText( ply:Nick(), "PlayerTagFont", -tW / 2, 0, color_white )
	cam.End3D2D()

end )