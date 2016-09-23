AddCSLuaFile()

BFPACK = BFPACK or {}

//-----------------------------------------------------------------------------
// content
//-----------------------------------------------------------------------------

BFPACK.strRigCvar = "cw_kk_bf_rig"
BFPACK.tblRigModels = {
	"models/weapons/bfpack/hands/hands_pilot_bf4.mdl",
	"models/weapons/bfpack/hands/hands_rus_bf3.mdl",
	"models/weapons/bfpack/hands/hands_rus_bf4.mdl",
	"models/weapons/bfpack/hands/hands_sp_shanghi_bf4.mdl",
	"models/weapons/bfpack/hands/hands_swat_mastermind_bfh.mdl",
	"models/weapons/bfpack/hands/hands_swat_professional_bfh.mdl",
	"models/weapons/bfpack/hands/hands_swat_technician_bf4.mdl",
	"models/weapons/bfpack/hands/hands_usa_bf3.mdl",
	"models/weapons/bfpack/hands/hands_usa_bf4.mdl",
	"models/weapons/bfpack/hands/hands_blackburn_bf3.mdl",
	"models/weapons/bfpack/hands/hands_gang_enforcer_bf4.mdl",
	"models/weapons/bfpack/hands/hands_gang_operator_bf4.mdl",
	"models/weapons/bfpack/hands/hands_gang_operator_bfh.mdl",
	"models/weapons/bfpack/hands/hands_chn_bf4.mdl",
}

//-----------------------------------------------------------------------------
// init for SpawnMenu tab and base think
//-----------------------------------------------------------------------------

BFPACK._numRigs = table.Count(BFPACK.tblRigModels)
BFPACK._cvRigCvar = CreateClientConVar(BFPACK.strRigCvar, 1, true, false)

local function updatePanel(panel)
	panel:ClearControls()
	
	// rigs
	panel:AddControl("Slider", {
		Label = "Rig:",
		Type = "Integer",
		Min = "1",
		Max = BFPACK._numRigs,
		Command = BFPACK.strRigCvar
	})
end

hook.Add("PopulateToolMenu", "Client (BFP)", function()
	spawnmenu.AddToolMenuOption("Utilities",  "CW 2.0 SWEPs", "Client (BFP)", "Client (BFP)", "", "", function(panel)
		updatePanel(panel)
	end)
end)
