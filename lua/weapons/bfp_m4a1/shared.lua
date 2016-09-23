if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "M4A1"
	SWEP.CSMuzzleFlashes = true
	
	SWEP.IronsightPos = Vector(-2.244, -3.343, 0.653)
	SWEP.IronsightAng = Vector(0.55, 0.019, 0)
	
	SWEP.ViewModelMovementScale = 1.2
	
	SWEP.MuzzleEffect = "muzzleflash_m14"
	SWEP.PosBasedMuz = false
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -3}
	SWEP.SightWithRail = true
	SWEP.AimBreathingEnabled = true

	-- SWEP.DrawTraditionalWorldModel = false
	-- SWEP.WM = "models/worldmodels/w_ak74.mdl"
	-- SWEP.WMPos = Vector(-0.8, 4.2, 0.5)
	-- SWEP.WMAng = Vector(-4, 0, 180)
	
end

SWEP.MuzzleVelocity = 880 -- in meter/s

SWEP.ADSFireAnim = true

SWEP.Attachments = {}

SWEP.Animations = {
	fire = {"base_fire"},
	reload = "base_reload",
	reload_empty = "base_reloadempty",
	idle = "base_idle",
	draw = "base_ready"
}
	
SWEP.Sounds = {
	base_ready = {
		{time = 0.5, sound = "ROLEPLAY_AKS74U_ROF"},
		{time = 1.2, sound = "ROLEPLAY_AK74_BOLTBACK"},
		{time = 1.4, sound = "ROLEPLAY_AK74_BOLTRELEASE"}
	},

	base_reload = {
		{time = 0.4, sound = "ROLEPLAY_AK74_MAGOUT"},
		{time = 2, sound = "ROLEPLAY_AK74_MAGIN"}
	},
	
	base_reloadempty = {
		{time = 0.4, sound = "ROLEPLAY_AK74_MAGOUT"},
		{time = 2, sound = "ROLEPLAY_AK74_MAGIN"},
		{time = 3.4, sound = "ROLEPLAY_AK74_BOLTBACK"},
		{time = 3.6, sound = "ROLEPLAY_AK74_BOLTRELEASE"}
	}
}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "cw_base"
SWEP.Category = "Roleplay Rifles - C"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 65
SWEP.ViewModelFlip	= false
SWEP.ViewModel		= "models/weapons/v_ak74.mdl"
SWEP.WorldModel		= "models/worldmodels/w_ak47.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.45x39MM"

SWEP.FireSound = "BFPROJECT_M4A1_FIRE"
SWEP.FireSoundSuppressed = "BFPROJECT_M4A1_FIRE"

SWEP.FireDelay = 0.0922
SWEP.Recoil = 1.223

SWEP.HipSpread = 0.043
SWEP.AimSpread = 0.005
SWEP.VelocitySensitivity = 1.6
SWEP.MaxSpreadInc = 0.05
SWEP.SpreadPerShot = 0.008
SWEP.SpreadCooldown = 0.14
SWEP.Shots = 1
SWEP.Damage = 33
SWEP.DeployTime = 2

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3
SWEP.ReloadTime_Empty = 4.2
SWEP.ReloadHalt = 1.5
SWEP.ReloadHalt_Empty = 1.5

function SWEP:IndividualThink()
	self.Animations.draw = "base_draw"
	self.DeployTime = 0.3
end
