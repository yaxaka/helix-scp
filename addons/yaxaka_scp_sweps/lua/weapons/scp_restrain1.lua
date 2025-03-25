AddCSLuaFile()

SWEP.Base = "weapon_cuff_base"

SWEP.Category = "SCP Utility"
SWEP.Author = "my_hat_stinks"
SWEP.Instructions = "Подойди и надень!."

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.AdminSpawnable = true

SWEP.Slot = 3
SWEP.PrintName = "Мешок для SCP-096"

//
// Handcuff Vars
SWEP.CuffTime = 0.1 // Seconds to handcuff
SWEP.CuffSound = Sound( "buttons/lever7.wav" )

SWEP.CuffMaterial = "models/props_pipes/GutterMetal01a"
SWEP.CuffRope = "models/effects/vol_light001"
SWEP.CuffStrength = 1.0
SWEP.CuffRegen = 2.0
SWEP.RopeLength = 50
SWEP.CuffReusable = true

SWEP.CuffBlindfold = false
SWEP.CuffGag = false

SWEP.CuffStrengthVariance = 0.08 // Randomise strangth
SWEP.CuffRegenVariance = 0.08 // Randomise regen