-- **************************************************
-- Provide Moho with the name of this script object
-- **************************************************

ScriptName = "LS_Shapes"
ScriptBirth = "20220918-0248"
ScriptBuild = "20250908-2000"

-- **************************************************
-- General information about this script
-- **************************************************

LS_Shapes = LS_Shapes or {}

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