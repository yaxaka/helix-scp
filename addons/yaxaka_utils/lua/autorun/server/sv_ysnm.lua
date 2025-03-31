function ysn_test()

end

function ysn_int(num)
	if (num <= 3) && (num >=-4) then
		return 3
	elseif (num <= 7) && (num >=-8) then
		return 4
	elseif (num <= 15) && (num >=-16) then
		return 5
	elseif (num <= 31) && (num >=-32) then
		return 6
	elseif (num <= 127) && (num >=-128) then
		return 8
	elseif (num <= 255) && (num >=-256) then
		return 9
	end
end


function ysn_send(name, datatable, ply)
	--not (IsValid(ply))
	if (datatable == nil) or (name == nil) or not (IsValid(ply)) then return end

	ymsg_d("Starting net message " .. name)
	net.Start(name)

	for k,v in pairs(datatable) do
		local tp = type(v)

		if tp == "string" then
			net.WriteString(v)
		end

		if tp == "number" then
			local int = ysn_int(v)
			net.WriteInt(v, int)
		end

		if tp == "boolean" then
			net.WriteBool(v)
		end

		if tp == "table" then
			net.WriteTable(v)
		end

		if tp == "Player" then
			net.WritePlayer(v)
		end

		if tp == "Vector" then
			net.WriteVector(v)
		end

		if tp == "Angle" then
			net.WriteAngle(v)
		end

		if tp == "Entity" then
			net.WriteEntity(v)
		end
	end

	net.Send(ply)
	ymsg_d("Message " .. name .. " end")
end


PrintTable(ix.class.list)
