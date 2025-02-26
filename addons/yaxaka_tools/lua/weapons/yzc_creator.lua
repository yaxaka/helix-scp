SWEP.PrintName			= "Zone Creator"
SWEP.Author			= "Yaxaka"
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

yzc_FirstPos = nil
yzc_SecondPos = nil
yzc_min2 = nil
yzc_max2 = nil

local yzc_stage = 1

local x = Vector( 5, 5, 5 )
local pos1 = Vector( 1119, 895, 63 )
local pos2 = Vector( 656, -896, -144 )

function SWEP:Initialize()
end



function SWEP:DrawHUD()
	x, y = ScrW() / 2, ScrH() / 2
	surface.SetTextColor( 255, 255, 255 ) 
	surface.SetTextPos( x, y+100 )
	surface.SetFont("DermaLarge")
	local lkm = "ЛКМ чтобы задать первую точку"
	local pkm = "ПКМ чтобы задать вторую точку"
	local rb = "R чтобы сохранить и продолжить" 
	local w1, h1 = surface.GetTextSize(lkm)
	local w2, h2 = surface.GetTextSize(pkm)
	local w3, h3 = surface.GetTextSize(rb)

	if (yzc_stage == 1) then
		surface.SetTextPos( x-w1/2, y+100 )
		surface.DrawText(lkm)		
		surface.SetTextPos( x-w2/2, y+150 )
		surface.DrawText(pkm)
		surface.SetTextPos( x-w2/2, y+150 )
		surface.DrawText(pkm)
	elseif (yzc_stage == 2) then
		surface.SetTextPos( x-w3/2, y+150 )
		surface.DrawText(rb)
	end
end


function SWEP:PrimaryAttack(wep)
	local owner = self:GetOwner()
	yzc_FirstPos = owner:GetEyeTrace().HitPos
	if (CLIENT) then yzc_stage = 1 chat.PlaySound() end
end

function SWEP:SecondaryAttack()
	local owner = self:GetOwner()
	yzc_SecondPos = owner:GetEyeTrace().HitPos
	if (CLIENT) then yzc_stage = 2 chat.PlaySound() end
end

function SWEP:Reload()
	local owner = self:GetOwner()
	if (CLIENT) then
		yzc_stage = 1
		chat.PlaySound() 
		ytool_corner_tbl["TAB1_Zone_Corner1"] = yzc_FirstPos
		ytool_corner_tbl["TAB1_Zone_Corner2"] = yzc_SecondPos
		RunConsoleCommand("ytool")
	end
	if (SERVER) then
		owner:StripWeapon("yzc_creator")
	end
end


if (CLIENT) then

local lply = LocalPlayer()

hook.Add( "PostDrawTranslucentRenderables", "BoxxieTest2", function()
	if yzc_stage == 2 then
		local center = LerpVector(0.5, yzc_FirstPos, yzc_SecondPos)
		local min = WorldToLocal(yzc_FirstPos, angle_zero, center, angle_zero)
		local max = WorldToLocal(yzc_SecondPos, angle_zero, center, angle_zero)
    	render.SetColorMaterial() -- white material for easy coloring

    	--cam.IgnoreZ( true ) -- makes next draw calls ignore depth and draw on top
   	 	render.DrawWireframeBox(center, angle_zero, min, max, color)
    	--cam.IgnoreZ( false ) -- disables previous call
    end

end)

end