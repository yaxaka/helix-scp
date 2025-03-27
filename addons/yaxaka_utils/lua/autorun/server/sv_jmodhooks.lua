util.AddNetworkString("Shifrator")

function shifrator_control(item, ply, bool)
	if not item.Shifrator then return end
	local timerid = ply:Nick() .. "_ShifrError"
	local timerid2 = ply:Nick() .. "_ViewShifr"

	if ply.shifrator_attached == nil then
		ply.shifrator_attached = false
	end

	if (bool) then 
		ysn_send("Shifrator", {ply.shifrator_attached}, ply)
		ply.Ignore096 = true
	elseif not (bool) then
		ysn_send("Shifrator", {false}, ply)
		ply.Ignore096 = false
		timer.Remove(timerid)
		timer.Remove(timerid2)
	end

end

hook.Add("Shifrator", "Controller", function(item, ply)
	local hp = item.hp
	local timerid = ply:Nick() .. "_ShifrError"
	local timerid2 = ply:Nick() .. "_ViewShifr"

	if hp == nil then return end

	timer.Create(timerid2, 5, 0, function()
		if hp <= 29 then
			timer.Create(timerid, 5, 0, function()
				if (ply.Ignore096 == true) then
					ply.Ignore096 = false
				else
					ply.Ignore096 = true
				end
			
			end)
		end
	end)
end)

local function GetAreSlotsClear(currentArmorItems, newArmorName)
	local NewArmorInfo = JMod.ArmorTable[newArmorName]
	local RequiredSlots = NewArmorInfo.slots

	for id, currentArmorData in pairs(currentArmorItems) do
		local CurrentArmorInfo = JMod.ArmorTable[currentArmorData.name]

		for newSlotName, newCoverage in pairs(RequiredSlots) do
			for oldSlotName, oldCoverage in pairs(CurrentArmorInfo.slots) do
				if oldSlotName == newSlotName then return false, id end
			end
		end
	end

	return true, nil
end

local function getjmodid(ply, name)
	for id,v in pairs(ply.EZarmor.items) do
		if (id == nil or id == false) then return false end
		if v.name == name then
			return id
		end
	end
end

function JmodRemoveArmorByIDHelix(ply, ID, broken)
	local Info = ply.EZarmor.items[ID]
	if not Info then return end
	local Specs = JMod.ArmorTable[Info.name]

	if Specs.eff and Specs.eff.weapon then
		local Wep = ply:GetWeapon(Specs.eff.weapon)

		if IsValid(Wep) then
			local PastSwep = ply:GetPreviousWeapon()
			if IsValid(PastSwep) and (ply:GetActiveWeapon() == Wep) then ply:SelectWeapon(PastSwep:GetClass()) end
			Wep:Remove()
		end
	end

	timer.Simple(math.Rand(0, .5), function()
		if broken then
			ply:EmitSound("snds_jack_gmod/armorbreak.ogg", 60, math.random(80, 120))
			ply:PrintMessage(HUD_PRINTTALK, Info.name .. " has been destroyed")
		else
			if Specs.snds and Specs.snds.uneq then
				ply:EmitSound(Specs.snds.uneq, 60, math.random(80, 120))
			else
				if EquipSounds == nil then return end
				ply:EmitSound(table.Random(EquipSounds), 60, math.random(80, 120))
			end
		end
	end)

	local Ent -- This is for if we can stow stuff in the armor when it's unequpped

	if broken then
		if Specs.eff and Specs.eff.explosive then
			local FireAmt = (Info.chrg and Info.chrg.fuel and math.random(2, 4)) or 0
			JMod.EnergeticsCookoff(ply:GetPos(), game.GetWorld(), 1, 1, 0, FireAmt)
		end
	end

	if Specs.plymdl then
		-- if this is a suit, we need to reset the player's model when he takes it off
		if ply.EZoriginalPlayerModel then
			JMod.SetPlayerModel(ply, ply.EZoriginalPlayerModel)
		end

		ply:SetColor(Color(255, 255, 255))
		ply.EZarmor.suited = false
		ply.EZarmor.bodygroups = nil
	end

	ply.EZarmor.items[ID] = nil
	
	local StowItems = not(broken) and Specs.storage and IsValid(Ent)

	local RemovedItems = JMod.UpdateInv(ply, StowItems, true)

	if StowItems and not(table.IsEmpty(RemovedItems)) then
		for _, v in ipairs(RemovedItems) do
			timer.Simple(0, function()
				local Success = JMod.AddToInventory(Ent, v)
			end)
		end
	end

	-- if this armor piece increased ammo carry limit, we need to go through and strip extra ammo now
	if (Specs.ammoCarryMult) then
		if not(broken) then
			Ent.ammoStored = {}
		end
		for k, v in pairs(ply:GetAmmo()) do
			local Max = game.GetAmmoMax(k)
			if (v > Max) then
				local AmountToRemove = v - Max
				ply:RemoveAmmo(AmountToRemove, k)
				if not(broken) then
					Ent.ammoStored[k] = (Ent.ammoStored[k] or 0) + (AmountToRemove)
				end
			end
		end
	end

	hook.Run("JMod_ArmorRemoved", ply, Info, Specs, Ent, broken)

	return Ent
end



function jmod_sec_delay(ply)
	if ply.jmodsdelay == nil then
		ply.jmodsdelay = CurTime() + 0.3
		return true
	elseif ply.jmodsdelay > CurTime() then
		return false
	elseif ply.jmodsdelay < CurTime() then
		ply.jmodsdelay = CurTime() + 0.3
		return true
	end
end

function jmod_sec_delay2(ply)
	if ply.jmodsdelay2 == nil then
		ply.jmodsdelay2 = CurTime() + 0.3
		return true
	elseif ply.jmodsdelay2 > CurTime() then
		return false
	elseif ply.jmodsdelay2 < CurTime() then
		ply.jmodsdelay2 = CurTime() + 0.3
		return true
	end
end


hook.Add("JmodCanEquip", "CanEquipCheck", function(ply, armorname)
	local clear, conflictid = GetAreSlotsClear(ply.EZarmor.items, armorname)
	if (clear) then
		return true
	else
		return false
	end
end)


hook.Add("JmodEquip", "EquipBeta", function(ply, armorname, item)
	if IsValid(ply) && item ~= nil && armorname ~= nil then
		local allowed = jmod_sec_delay(ply)
		if allowed then
			local clear, conflictid = GetAreSlotsClear(ply.EZarmor.items, armorname)
			if (clear) then
				JMod.EZ_Equip_Armor(ply, armorname)
				shifrator_control(item, ply, true)
			else
				local itemname = tostring(ply.EZarmor.items[conflictid].name)
				ply:Notify("Вы не можете надеть это поверх " .. itemname)
				item:SetData("equip", false)
				return false
			end
		elseif not allowed then
			item:SetData("equip", false)
			ply:Notify("Вы делаете это слишком быстро")
		end
	end
end)

hook.Add("JmodUnEquip", "EquipBet2a", function(ply, armorname, item)
	if IsValid(ply) && (item ~= nil) && (armorname ~= nil) then
		local allowed = jmod_sec_delay2(ply)
		if allowed then
			local jitem = getjmodid(ply, armorname)
			if (jitem == false) then return end
			shifrator_control(item, ply, false)
			JmodRemoveArmorByIDHelix(ply, jitem, false)
		elseif not allowed then
			item:SetData("equip", true)
			ply:Notify("Вы делаете это слишком быстро")
		end
	end
end)


function JmodArmorDestroyed(ply, Info)
	local inv = ply:GetCharacter():GetInventory()
	local a = inv:GetItemsByBase("base_jmodarmor")
	for k,v in pairs(a) do
		local jname = v.Jname
		if jname == Info.name then
			local item = inv:GetItemByID(v.id)
			local equipped = v.data.equip
			if equipped then
				item:Remove()
			end
		end
	end
end


hook.Add("JMod_ArmorRemoved", "RemoveFromInventory", function(ply, Info, Specs, Ent, broken)
	if broken then
		JmodArmorDestroyed(ply, Info)
	end
end)

hook.Add("PlayerDeath", "DeleteInv", function(ply)
	local inv = ply:GetCharacter():GetInventory()
	local items = inv:GetItems(false)
	for k,v in pairs(items) do
		v:Remove()
	end
end)	

