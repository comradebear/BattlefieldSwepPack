if not CustomizableWeaponry then return end

AddCSLuaFile()
AddCSLuaFile("sh_sounds.lua")
include("sh_sounds.lua")
SWEP.UseHands = nil

if CLIENT then
	SWEP.DrawCrosshair = false
	SWEP.PrintName = "L85A2"
	SWEP.CSMuzzleFlashes = false
	
	SWEP.IronsightPos = Vector(-2.85, 0, 0.319)
	SWEP.IronsightAng = Vector(0.09, 0, 0)
	
	SWEP.ViewModelMovementScale = 1.2
	
	SWEP.MuzzleEffect = "muzzleflash_m14"
	SWEP.PosBasedMuz = false
	SWEP.ShellScale = 0.7
	SWEP.ShellOffsetMul = 1
	SWEP.ShellPosOffset = {x = -2, y = 0, z = -3}
	SWEP.AimBreathingEnabled = true

	SWEP.DrawTraditionalWorldModel = false
	SWEP.WM = "models/roleplay_weapons/w_models/l85a2.mdl"
	SWEP.WMPos = Vector(-0.5, 4.2, 0.2)
	SWEP.WMAng = Vector(-3, 0, 180)
	
	function SWEP:getMuzzlePosition()
	return self.CW_VM:GetAttachment(self.CW_VM:LookupAttachment(self.MuzzleAttachmentName))
	end
	
end

SWEP.MuzzleVelocity = 940 -- in meter/s

SWEP.ADSFireAnim = true
SWEP.MuzzleAttachmentName = "muzzle"

SWEP.Attachments = {}

SWEP.Animations = {
	draw = "base_ready",
	idle = "base_idle",
	
	fire = "base_fire",
	fire_aim = {"iron_fire", "iron_fire_a", "iron_fire_b", "iron_fire_c", "iron_fire_d", "iron_fire_e", "iron_fire_f"},
	
	reload = "base_reload",
	reload_empty = "base_reloadempty",
}
	
SWEP.Sounds = {
	base_ready = {
		{time = 0.6, sound = "ROLEPLAY_L85A2_BOLTBACK"},
		{time = 1, sound = "ROLEPLAY_L85A2_BOLTRELEASE"}
	},

	base_reload = {
		{time = 0.45, sound = "ROLEPLAY_L85A2_MAGRELEASE"},
		{time = 0.55, sound = "ROLEPLAY_L85A2_MAGOUT"},
		{time = 2.2, sound = "ROLEPLAY_L85A2_MAGIN"},
		{time = 2.75, sound = "ROLEPLAY_L85A2_MAGHIT"}
	},
	
	base_reloadempty = {
		{time = 0.45, sound = "ROLEPLAY_L85A2_MAGRELEASE"},
		{time = 0.55, sound = "ROLEPLAY_L85A2_MAGOUT"},
		{time = 2.2, sound = "ROLEPLAY_L85A2_MAGIN"},
		{time = 2.6, sound = "ROLEPLAY_L85A2_HIT"},
		{time = 3.2, sound = "ROLEPLAY_L85A2_BOLTBACK"},
		{time = 3.55, sound = "ROLEPLAY_L85A2_BOLTRELEASE"}
	}
}

SWEP.SpeedDec = 30

SWEP.Slot = 3
SWEP.SlotPos = 0
SWEP.NormalHoldType = "ar2"
SWEP.RunHoldType = "passive"
SWEP.FireModes = {"auto", "semi"}
SWEP.Base = "roleplay_base"
SWEP.Category = "CW 2.0 Roleplay Rifles"

SWEP.Author			= ""
SWEP.Contact		= ""
SWEP.Purpose		= ""
SWEP.Instructions	= ""

SWEP.ViewModelFOV	= 72
SWEP.ViewModelFlip	= false
SWEP.UseHands = true
SWEP.ViewModel		= "models/roleplay_weapons/v_models/l85a2.mdl"
SWEP.WorldModel		= "models/roleplay_weapons/w_models/l85a2.mdl"

SWEP.Spawnable			= true
SWEP.AdminSpawnable		= true

SWEP.Primary.ClipSize		= 30
SWEP.Primary.DefaultClip	= 30
SWEP.Primary.Automatic		= true
SWEP.Primary.Ammo			= "5.45x39MM"

SWEP.FireSound = "ROLEPLAY_L85A2_FIRE"

SWEP.FireDelay = 0.0935
SWEP.Recoil = 1.221

SWEP.HipSpread = 0.045
SWEP.AimSpread = 0.007
SWEP.VelocitySensitivity = 1.6
SWEP.MaxSpreadInc = 0.07
SWEP.SpreadPerShot = 0.01
SWEP.SpreadCooldown = 0.16
SWEP.Shots = 1
SWEP.Damage = 34
SWEP.DeployTime = 2

SWEP.ReloadSpeed = 1
SWEP.ReloadTime = 3.7
SWEP.ReloadTime_Empty = 4.35
SWEP.ReloadHalt = 1
SWEP.ReloadHalt_Empty = 1.5

function SWEP:IndividualThink()

	self.Animations.draw = "base_draw"
	self.DeployTime = 0.51
end

function SWEP:createCustomVM(mdl)
self.CW_VM = self:createManagedCModel(mdl, RENDERGROUP_BOTH)
self.CW_VM:SetNoDraw(true)
self.CW_VM:SetupBones()

if self.ViewModelFlip then
local mtr = Matrix()
mtr:Scale(Vector(1, -1, 1))

self.CW_VM:EnableMatrix("RenderMultiply", mtr)
end
end

function SWEP:_drawViewModel()
-- draw the viewmodel
self.Owner:GetHands():SetParent(self.CW_VM)
self.Owner:GetHands():AddEffects(EF_BONEMERGE_FASTCULL)
self.Owner:GetHands():SetPos(self.CW_VM:GetPos())
self.Owner:GetHands():SetAngles(self.CW_VM:GetAngles())
--cam.IgnoreZ(false)
if self.ViewModelFlip then
render.CullMode(MATERIAL_CULLMODE_CW)
end

local POS = EyePos() - self.CW_VM:GetPos()

self.CW_VM:FrameAdvance(FrameTime())
self.CW_VM:SetupBones()
self.CW_VM:DrawModel()

if self.ViewModelFlip then
render.CullMode(MATERIAL_CULLMODE_CCW)
end

-- draw the attachments
self:drawAttachments()

-- draw the customization menu
self:drawInteractionMenu()

-- draw the unique scope behavior if it is defined
if self.reticleFunc then
self.reticleFunc(self)
end

-- and lastly, draw the custom hud if the player has it enabled
if GetConVarNumber("cw_customhud_ammo") >= 1 then
self:draw3D2DHUD()
end
end