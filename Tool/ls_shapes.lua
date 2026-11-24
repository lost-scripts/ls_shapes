-- **************************************************
-- Provide Moho with the name of this script object
-- **************************************************

ScriptName = "LS_Shapes"
ScriptBirth = "20220918-0248"
ScriptBuild = "20261114-0446"

-- **************************************************
-- General information about this script
-- **************************************************

LS_Shapes = LS_Shapes or {}

if LS_Shapes.Name then -- Or MOHO.ScriptInterface:IsPro()?
	goto LOADED -- Ensure basic info when main script not loaded, e.g. under Live Playback Only
end

function LS_Shapes:Name()
	return "Shapes Window"
end

function LS_Shapes:Description()
	return MOHO.Localize("/LS/ScriptNotLoaded=Script not loaded...")
end

function LS_Shapes:Creator()
	return "Rai López"
end

function LS_Shapes:ColorizeIcon()
	return true
end

::LOADED::

-- **************************************************
-- Recurring values
-- **************************************************

LS_Shapes.LM_SelectShape = {}
LS_Shapes.LM_SelectShape.dragMode = -1

-- **************************************************
-- The guts of this script
-- **************************************************

LS_Shapes.OMU = LM_SelectShape.OnMouseUp
function LM_SelectShape:OnMouseUp(moho, mouseEvent)
	LS_Shapes.LM_SelectShape.dragMode = self.dragMode or -1
	LS_Shapes.OMU(self, moho, mouseEvent)
end