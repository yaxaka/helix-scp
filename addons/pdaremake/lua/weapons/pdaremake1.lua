SWEP.PrintName = "PDA"
SWEP.Author = "Yaxaka"
SWEP.Instructions = "RMB"
SWEP.Category = "PDA"
SWEP.DrawAmmo = false
SWEP.Slot = 5

SWEP.DrawCrosshair = false
SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.UseHands = true
SWEP.ViewModel = "models/v_item_pda.mdl"
SWEP.WorldModel = "models/v_item_pda.mdl"
SWEP.ViewModelFOV = 80
SWEP.SwayScale = 0.1
SWEP.BobScale = 0.1

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

local lastAngles = Angle(0, 0, 0)
local equipped = false

function SWEP:Initialize()
    self:SetHoldType("slam")
end

function SWEP:Deploy()
	local VModel = self:GetOwner():GetViewModel()
	VModel:SetSequence(ACT_VM_HOLSTER)
	equipped = false
end

function SWEP:Holster()
    self:GetOwner():SetEyeTarget(Vector(0, 0, 0))
    return true
end

function SWEP:SecondaryAttack()
	if not equipped then
		self:CustomEquip(true)
	else
		self:CustomEquip(false)
	end
end

function SWEP:CustomEquip(bool)
	if bool then
        if timer.Exists("Timerpda1") then timer.Remove("Timerpda1") end

		timer.Create("Timerpda1", 0.1, 1, function()
			equipped = true
		end)
    	self:SendWeaponAnim(ACT_VM_DRAW)
    	self:ResetSequence(self:LookupSequence("Draw"))
		self:EmitSound("Stalker2.PDAEquip")
		self:GetOwner():SetEyeTarget(self:GetPos())
	elseif not bool then
        if timer.Exists("Timerpda2") then timer.Remove("Timerpda2") end

    	self:SendWeaponAnim(ACT_VM_HOLSTER)
    	self:ResetSequence(self:LookupSequence("Holster"))
		self:EmitSound("Stalker2.PDAUnequip")
		self:GetOwner():SetEyeTarget(Vector(0, 0, 0))
		timer.Create("Timerpda2", 0.8, 1, function()
			equipped = false
		end)		
	end		
end

function SWEP:CalcView(player, pos, viewAngles, fov)
    local VModel = self:GetOwner():GetViewModel()
    local attachmentID = self:LookupAttachment("1")
    local attachment = self:GetAttachment(attachmentID)

    if attachment then
        if VModel:GetSequenceActivity(VModel:GetSequence()) == ACT_VM_DRAW then
            local newAngle = attachment.Ang - self:GetAngles()
            lastAngles = LerpAngle(0.1, lastAngles, newAngle)
            viewAngles:Add(lastAngles)
        elseif VModel:GetSequenceActivity(VModel:GetSequence()) == ACT_VM_HOLSTER then
            local newAngle = Angle(0, 0, 0)
            lastAngles = LerpAngle(0.1, lastAngles, newAngle)
            viewAngles:Add(lastAngles)
        end
    end
    return pos, viewAngles, fov
end


function SWEP:ShouldDrawViewModel()
	if not equipped then return false else return true end
end


if CLIENT then
    local WorldModel = ClientsideModel(SWEP.WorldModel)
    WorldModel:SetNoDraw(true)

    function SWEP:DrawWorldModel()
        local _Owner = self:GetOwner()

        if (IsValid(_Owner)) then
            -- Specify a good position
            local offsetVec = Vector(3, -6, -6)
            local offsetAng = Angle(-50, -10, -165)
            
            local boneid = _Owner:LookupBone("ValveBiped.Bip01_R_Hand") -- Right Hand
            if not boneid then return end

            local matrix = _Owner:GetBoneMatrix(boneid)
            if not matrix then return end

            local newPos, newAng = LocalToWorld(offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles())

            WorldModel:SetPos(newPos)
            WorldModel:SetAngles(newAng)

            WorldModel:SetupBones()
        else
            WorldModel:SetPos(self:GetPos())
            WorldModel:SetAngles(self:GetAngles())
        end

        WorldModel:DrawModel()
    end
end
