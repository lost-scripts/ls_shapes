-- **************************************************
-- Provide Moho with the name of this script object
-- **************************************************

ScriptName = "LS_ShapesWindow"
ScriptBirth = "20220918-0248"
ScriptBuild = "20240209-0047"

-- **************************************************
-- General information about this script
-- **************************************************

LS_ShapesWindow = LS_ShapesWindow or {}

-- **************************************************
-- Recurring values
-- **************************************************

LS_ShapesWindow.LM_SelectShape = {}
LS_ShapesWindow.LM_SelectShape.dragMode = -1

-- **************************************************
-- The guts of this script
-- **************************************************

LS_ShapesWindow.OMU = LM_SelectShape.OnMouseUp
function LM_SelectShape:OnMouseUp(moho, mouseEvent)
	LS_ShapesWindow.LM_SelectShape.dragMode = self.dragMode or -1
	LS_ShapesWindow.OMU(self, moho, mouseEvent)
end