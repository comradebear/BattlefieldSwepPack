if not CustomizableWeaponry then return end

AddCSLuaFile()

SWEP.Base = "cw_base"

//-----------------------------------------------------------------------------
// fireAnimFunc for hip and aimed fire to use separate anims
//-----------------------------------------------------------------------------

function SWEP:fireAnimFunc()
	local suffix = ""
	
	if self:Clip1() < 2 then
		suffix = "_last"
	end
	
	if self:isAiming() then
		suffix = suffix .. "_aim"
	end
	
	self:sendWeaponAnim("fire" .. suffix)
end

//-----------------------------------------------------------------------------
// drawAnimFunc for loaded and empty draws to use separate anims
//-----------------------------------------------------------------------------

function SWEP:drawAnimFunc()
	local suffix = ""
	
	if self:Clip1() == 0 then
		suffix = "_empty"
	end
	
	self:sendWeaponAnim("draw" .. suffix)
end