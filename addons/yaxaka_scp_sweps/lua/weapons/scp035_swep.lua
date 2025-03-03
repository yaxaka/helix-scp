SWEP.PrintName			= "SCP-035"
SWEP.Author			= "Yaxaka"
SWEP.Category        = "Yaxaka's SCP SWEPs"
SWEP.Instructions		= "TF"
SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.UseHands = true
SWEP.DrawAmmo = false


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
SWEP.Mode035 = 0



function SWEP:Initialize()
	self:SetHoldType("none")
	local owner = self:GetOwner()
end



function SWEP:PrimaryAttack()
	local owner = self:GetOwner()
	if SERVER then
		if self.Mode035 == 1 then
			scp035_psyradius(owner)
		end
	end
end

function SWEP:SecondaryAttack()
	local owner = self:GetOwner()
	if SERVER then
		
	end
end

local delay = 0
function SWEP:Reload()
	if CurTime() < delay then return end
	if (CLIENT) then surface.PlaySound("UI/buttonclick.wav") end
	local owner = self:GetOwner()
	if self.Mode035 == 2 then
		self.Mode035 = 0
	else
		self.Mode035 = self.Mode035 + 1
	end
	delay = CurTime() + 1
end


function SWEP:DrawHUD()
	local owner = self:GetOwner()
	surface.SetTextColor(255, 0, 0)
	surface.SetFont("DermaLarge")
	local mode_text = nil
	if self.Mode035 == 0 then
		mode_text = "Пассивный режим"
		owner.scp035_additional = false
		owner.scp035_radiusdraws = false
	elseif self.Mode035 == 1 then
		mode_text = "Воздействие по области"
		owner.scp035_additional = false
		owner.scp035_radiusdraws = true
	elseif self.Mode035 == 2 then
		mode_text = "Выборочное воздействие"
		owner.scp035_radiusdraws = false
		owner.scp035_additional = true
	end
	local w, h = surface.GetTextSize(mode_text)
	surface.SetTextPos(ScrW()/2-w/2, ScrH()-h-20)
	surface.DrawText(mode_text)
end
