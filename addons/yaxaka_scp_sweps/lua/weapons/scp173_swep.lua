SWEP.PrintName			= "SCP-173"
SWEP.Author			= "Yaxaka"
SWEP.Category        = "Yaxaka's SCP SWEPs"
SWEP.Instructions		= "TF"
SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.UseHands = true
SWEP.DrawAmmo = false
SWEP.Base = "weapon_base"


SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip =  -1
SWEP.Primary.Automatic		= false
SWEP.Primary.Ammo		= "none"

SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.DefaultClip	=  -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo		= "none"

SWEP.Weight			= 100
SWEP.AutoSwitchTo		= true
SWEP.AutoSwitchFrom		= false

SWEP.Slot			= 1
SWEP.SlotPos			= 1
SWEP.DrawAmmo			= false
SWEP.DrawCrosshair		= true

SWEP.ViewModel			= "models/weapons/c_arms.mdl"
SWEP.WorldModel			= "models/weapons/c_arms.mdl"




function SWEP:Initialize()
	self:SetHoldType("none")
end



function SWEP:PrimaryAttack()

	local ent = self:GetOwner()
	local selfpos = ent:GetPos()

	if scp_173_canmove && #scp_173_watchers <= 2 then
		scp_173_prop:SetPos(selfpos)
		scp_173_move()
		local sphere = ents.FindInSphere(selfpos, 200)
		for k,v in pairs(sphere) do
			if (v:IsPlayer()) && (v ~= ent) then
				scp_173_scream(v)
			end
		end
	end
end

function SWEP:SecondaryAttack()
	local ent = self:GetOwner()
	local selfpos = ent:GetPos()

	if scp_173_canmove && #scp_173_watchers <= 2 then
		scp_173_prop:SetPos(selfpos)
		scp_173_move()
		local sphere = ents.FindInSphere(selfpos, 50)
		for k,v in pairs(sphere) do
			if (v:IsPlayer()) && (v ~= ent) then
				v:TakeDamage(50, ent, self)
			end
		end
	end
end
