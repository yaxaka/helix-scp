SWEP.PrintName			= "SCP-096"
SWEP.Author			= "Yaxaka"
SWEP.Category        = "Yaxaka's SCP SWEPs"
SWEP.Instructions		= "TF"
SWEP.Spawnable = false
SWEP.AdminOnly = true
SWEP.UseHands = true
SWEP.DrawAmmo = false


SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
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


	local target = ent:GetEyeTrace().Entity
	local dist = selfpos:Distance(target:GetPos())

	if dist > 66 then return end
	if SERVER then
		if IsValid(target) and target:IsNPC() or target:IsPlayer() then
			ent:ChatPrint("Target: " .. target:GetClass())
			scp096_attack(target, ent)
			ent:Remove()
		end
	end


end

function SWEP:SecondaryAttack()
--

end

