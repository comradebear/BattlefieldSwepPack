if not CustomizableWeaponry then return end

AddCSLuaFile()

SWEP.Base = "cw_base"

//-----------------------------------------------------------------------------
// fireAnimFunc for hip and aimed fire to use separate anims
//-----------------------------------------------------------------------------

function SWEP:fireAnimFunc()
	local suffix = ""
	
	if self:isAiming() then
		suffix = "_aim"
	end
	
	if self:Clip1() < 2 then
		if self.Animations["fire_last" .. suffix] then
			suffix = "_last" .. suffix
		end
	end
	
	self:sendWeaponAnim("fire" .. suffix)
end

//-----------------------------------------------------------------------------
// IndividualThink for
// - rig setting handling
// - tbd
//-----------------------------------------------------------------------------

function SWEP:IndividualThink()
	// more shared stuff
	
	if CLIENT then
		self:updateRigModel()
		// more CL stuff
	end
end

//-----------------------------------------------------------------------------
// updateRigModel checks for cvar change and sets model on vm hands entity
//-----------------------------------------------------------------------------

if CLIENT then
	local db = {}
	local cur, old
	
	function SWEP:updateRigModel()
		if !IsValid(self.CW_HANDS_VM) then return end
		
		cur = math.Clamp(BFPACK._cvRigCvar:GetInt(), 1, BFPACK._numRigs)
		old = db[self] or cur
		db[self] = cur
		
		if cur != old then
			self.CW_HANDS_VM:SetModel(BFPACK.tblRigModels[cur])
		end
	end
end

//-----------------------------------------------------------------------------
// createCustomVM edited to initialize additional entity for vm hands
//-----------------------------------------------------------------------------

if CLIENT then
	function SWEP:createCustomVM(mdl)
		self.CW_VM = self:createManagedCModel(mdl, RENDERGROUP_BOTH)
		self.CW_VM:SetNoDraw(true)
		self.CW_VM:SetupBones()
		
		local handsId = math.Clamp(BFPACK._cvRigCvar:GetInt(), 1, BFPACK._numRigs)
		local handsMdl = BFPACK.tblRigModels[handsId]
		
		self.CW_HANDS_VM = self:createManagedCModel(self.initHandsMdl or handsMdl, RENDERGROUP_BOTH)
		self.CW_HANDS_VM:SetNoDraw(true)
		self.CW_HANDS_VM:SetupBones()
		
		self.CW_HANDS_VM:SetParent(self.CW_VM)
		self.CW_HANDS_VM:AddEffects(EF_BONEMERGE)
		-- self.CW_HANDS_VM:AddEffects(EF_BONEMERGE_FASTCULL)
		
		if self.ViewModelFlip then
			local mtr = Matrix()
			mtr:Scale(Vector(1, -1, 1))
			
			self.CW_VM:EnableMatrix("RenderMultiply", mtr)
			self.CW_HANDS_VM:EnableMatrix("RenderMultiply", mtr)
		end
	end
end

//-----------------------------------------------------------------------------
// _drawViewModel edited to draw additional entity for vm hands
//-----------------------------------------------------------------------------

if CLIENT then
	local cvar3D2D = CreateClientConVar("cw_customhud_ammo", 0, true, true)
	
	function SWEP:_drawViewModel()
		if self.ViewModelFlip then
			render.CullMode(MATERIAL_CULLMODE_CW)
		end
		
		local POS = EyePos() - self.CW_VM:GetPos()
		
		self.CW_VM:FrameAdvance(FrameTime())
		self.CW_VM:SetupBones()
		self.CW_VM:DrawModel()
		
		self.CW_HANDS_VM:DrawModel()
		
		if self.ViewModelFlip then
			render.CullMode(MATERIAL_CULLMODE_CCW)
		end
		
		self:drawAttachments()
		self:drawInteractionMenu()
		
		if self.reticleFunc then
			self.reticleFunc(self)
		end
		
		if cvar3D2D:GetInt() >= 1 then
			self:draw3D2DHUD()
		end
	end
end
