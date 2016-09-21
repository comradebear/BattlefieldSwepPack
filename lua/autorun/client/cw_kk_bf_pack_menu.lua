AddCSLuaFile()

local numRigs = 5
local strCvar = "cw_kk_bf_rig"




local cvarObj = CreateClientConVar(strCvar, 1, true, false)

local function updatePanel(panel)
	panel:ClearControls()
	
	// rigs
	panel:AddControl("Slider", {
		Label = "Rig:",
		Type = "Integer",
		Min = "1",
		Max = numRigs,
		Command = strCvar
	})
end

hook.Add("PopulateToolMenu", "Client (BFP)", function()
	spawnmenu.AddToolMenuOption("Utilities",  "CW 2.0 SWEPs", "Client (BFP)", "Client (BFP)", "", "", function(panel)
		updatePanel(panel)
	end)
end)
