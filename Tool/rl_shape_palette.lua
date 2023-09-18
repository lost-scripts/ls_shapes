-- **************************************************
-- Provide Moho with the name of this script object
-- **************************************************

ScriptName = "LM_SelectShape"

-- **************************************************
-- General information about this script
-- **************************************************

LM_SelectShape = {}

LM_SelectShape.BASE_STR = 2320

function LM_SelectShape:Name()
	return "Select Shape"
end

function LM_SelectShape:Version()
	return "6.0"
end

function LM_SelectShape:IsBeginnerScript()
	return true
end

function LM_SelectShape:Description()
	return MOHO.Localize("/Scripts/Tool/SelectShape/Description=Click on a shape to select it (hold <shift> to select additional shapes, <alt> to deselect shapes, <cmd/ctrl> to invoke the Eyedropper tool)")
end

function LM_SelectShape:BeginnerDescription()
	return MOHO.Localize("/Scripts/Tool/SelectShape/BeginnerDescription=Click on an existing shape to select it. Quickly choose a Fill color from the color swatch at the bottom of the Style window (Window > Style) or right-click a color swatch to change the Stroke color.")
end

function LM_SelectShape:BeginnerDisabledDescription()
	return MOHO.Localize("/Scripts/Tool/SelectShape/BeginnerDisabledDescription=You need to create a shape first using the 'Create Shape' or 'Paint Bucket' tool before you can use this tool.")
end

function LM_SelectShape:Creator()
	return "Lost Marble LLC, mod. by Rai López (RL)"
end

function LM_SelectShape:UILabel()
	return(MOHO.Localize("/Scripts/Tool/SelectShape/SelectShape=Select Shape"))
end

-- **************************************************
-- Recurring values
-- **************************************************

LM_SelectShape.prevMousePt = LM.Point:new_local()
LM_SelectShape.prevSelID = -1
LM_SelectShape.handleRadius = 0.03
LM_SelectShape.dragMode = -1 --0:shape picker, 1:center point, 2:handle point
LM_SelectShape.eyedropperMode = false
LM_SelectShape.selShape = nil
LM_SelectShape.startVec = LM.Vector2:new_local()
LM_SelectShape.lastVec = LM.Vector2:new_local()
LM_SelectShape.effectScale = 1.0

-- **************************************************
-- The guts of this script
-- **************************************************

function LM_SelectShape:IsEnabled(moho)
	if (moho:CountShapes() > 0) then
		return true
	end
	return false
end

function LM_SelectShape:IsRelevant(moho)
	local mesh = moho:DrawingMesh()
	if (mesh == nil) then
		return false
	end
	return true
end

function LM_SelectShape:HideConstructionCurves(moho)
	return true
end

function LM_SelectShape:SupportsGPUMode(moho)
	if (self.eyedropperMode) then
		return false
	else
		return true
	end
end

function LM_SelectShape:OnMouseDown(moho, mouseEvent)
	self.eyedropperMode = false
	if (mouseEvent.ctrlKey) then
		mouseEvent.ctrlKey = false
		self.eyedropperMode = true
		LM_Eyedropper:OnMouseDown(moho, mouseEvent)
		return
	end

	local mesh = moho:DrawingMesh()
	if (mesh == nil) then
		return
	end

	self.prevMousePt:Set(mouseEvent.pt)
	self.prevSelID = mouseEvent.view:PickShape(mouseEvent.pt)
	self.selShape = nil

	self.dragMode = 0 -- shape picker (default)
	-- cycle through shapes and see if the user clicked on an effect handle
	local g = mouseEvent.view:Graphics()
	local matrix = LM.Matrix:new_local()
	moho.drawingLayer:GetFullTransform(moho.frame, matrix, moho.document)
	g:Push()
	g:ApplyMatrix(matrix)
	local graphicsScale = g:CurrentScale(false)
	g:Pop()

	for i = 0, mesh:CountShapes() - 1 do
		local shape = mesh:Shape(i)
		if (shape:HasPositionDependentStyles()) then
			local center = shape:EffectHandle1()
			local handleLocation = shape:EffectHandle2()

			self.effectScale = shape.fEffectScale.value
			if ((center - mouseEvent.drawingVec):Mag() < self.handleRadius / graphicsScale) then
				self.dragMode = 1
				self.selShape = shape
				self.startVec:Set(shape.fEffectOffset.value)
				break
			elseif ((handleLocation - mouseEvent.drawingVec):Mag() < self.handleRadius / graphicsScale) then
				self.dragMode = 2
				self.selShape = shape
				self.startVec:Set(handleLocation)
				self.lastVec:Set(mouseEvent.drawingVec)
				break
			end
		end
	end

	if (self.dragMode == 0) then -- shape picker
		if (not mouseEvent.shiftKey and not mouseEvent.altKey) then
			for i = 0, mesh:CountShapes() - 1 do
				mesh:Shape(i).fSelected = false
			end
		end
		if (self.prevSelID >= 0) then
			if (mouseEvent.altKey) then
				mesh:Shape(self.prevSelID).fSelected = false
			else
				mesh:Shape(self.prevSelID).fSelected = true
			end
		end
		moho:UpdateSelectedChannels()
	elseif (self.dragMode == 1 or self.dragMode == 2) then -- move an effect handle
		moho.document:PrepUndo(moho.drawingLayer)
		moho.document:SetDirty()
	end

	mouseEvent.view:DrawMe()
end

function LM_SelectShape:OnMouseMoved(moho, mouseEvent)
	if (self.eyedropperMode) then
		mouseEvent.ctrlKey = false
		LM_Eyedropper:OnMouseMoved(moho, mouseEvent)
		return
	end

	local mesh = moho:DrawingMesh()
	if (mesh == nil) then
		return
	end

	self.prevMousePt:Set(mouseEvent.pt)
	self.prevSelID = mouseEvent.view:PickShape(mouseEvent.pt)

	if (self.dragMode == 0) then -- shape picker
		if (not mouseEvent.shiftKey and not mouseEvent.altKey) then
			for i = 0, mesh:CountShapes() - 1 do
				mesh:Shape(i).fSelected = false
			end
		end
		if (self.prevSelID >= 0) then
			if (mouseEvent.altKey) then
				mesh:Shape(self.prevSelID).fSelected = false
			else
				mesh:Shape(self.prevSelID).fSelected = true
			end
		end
		moho:UpdateSelectedChannels()
	elseif (self.dragMode == 1 or self.dragMode == 2) then -- move an effect handle
		if (self.selShape ~= nil) then
			if (self.dragMode == 1) then
				self.selShape.fEffectOffset:SetValue(moho.drawingLayerFrame, self.startVec + (mouseEvent.drawingVec - mouseEvent.drawingStartVec))
			else
				local center = self.selShape:EffectHandle1()
				local handleLocation = self.selShape:EffectHandle2()
				local min = LM.Vector2:new_local()
				local max = LM.Vector2:new_local()
				self.selShape:ShapeBounds(min, max, 0)
				handleLocation = self.startVec + (mouseEvent.drawingVec - mouseEvent.drawingStartVec)
				local v = handleLocation - center
				local v1 = self.lastVec - center
				local v2 = mouseEvent.drawingVec - center
				v2:Rotate(-math.atan(v1.y, v1.x))
				local angle = math.atan(v2.y, v2.x)
				angle = angle + self.selShape.fEffectRotation.value
				self.lastVec:Set(mouseEvent.drawingVec)
				self.selShape.fEffectRotation:SetValue(moho.drawingLayerFrame, angle)
				if (mouseEvent.shiftKey) then
					self.selShape.fEffectRotation:SetValue(moho.drawingLayerFrame, self.selShape.fEffectRotation.value / (math.pi / 4))
					self.selShape.fEffectRotation:SetValue(moho.drawingLayerFrame, (math.pi / 4) * LM.Round(self.selShape.fEffectRotation.value))
				end
				if (mouseEvent.ctrlKey) then
					self.selShape.fEffectScale:SetValue(moho.drawingLayerFrame, self.effectScale)
				else
					if (max.y - min.y > max.x - min.x) then
						self.selShape.fEffectScale:SetValue(moho.drawingLayerFrame, v:Mag() / ((max.y - min.y) / 2.0))
					else
						self.selShape.fEffectScale:SetValue(moho.drawingLayerFrame, v:Mag() / ((max.x - min.x) / 2.0))
					end
				end
			end
			moho:NewKeyframe(CHANNEL_FXXFORM)
			moho:UpdateSelectedChannels()
		end
	end

	mouseEvent.view:DrawMe()
end

function LM_SelectShape:OnMouseUp(moho, mouseEvent)
	if (self.eyedropperMode) then
		mouseEvent.ctrlKey = false
		LM_Eyedropper:OnMouseUp(moho, mouseEvent)
		self.eyedropperMode = false
		return
	end
	self.eyedropperMode = false
end

function LM_SelectShape:OnKeyDown(moho, keyEvent)
	local mesh = moho:DrawingMesh()
	if (mesh == nil) then
		return
	end

	if (keyEvent.keyCode == LM.GUI.KEY_UP) then
		if (keyEvent.ctrlKey) then -- select higher in the stacking order
			self.prevSelID = self.prevSelID + 1
			local id = keyEvent.view:PickShape(self.prevMousePt, self.prevSelID)
			for i = 0, mesh:CountShapes() - 1 do
				mesh:Shape(i).fSelected = false
			end
			if (id >= 0) then
				mesh:Shape(id).fSelected = true
			end
			moho:UpdateSelectedChannels()
		elseif (keyEvent.shiftKey) then -- raise shape to top
			moho.document:PrepUndo(moho.drawingLayer)
			moho.document:SetDirty()
			for i = 0, mesh:CountShapes() - 1 do
				if (mesh:Shape(i).fSelected) then
					mesh:RaiseShape(i, true)
				end
			end
		else -- raise shape
			moho.document:PrepUndo(moho.drawingLayer)
			moho.document:SetDirty()
			for i = mesh:CountShapes() - 1, 0, -1 do
				if (mesh:Shape(i).fSelected) then
					mesh:RaiseShape(i, false)
				end
			end
		end
		keyEvent.view:DrawMe()
	elseif (keyEvent.keyCode == LM.GUI.KEY_DOWN) then
		if (keyEvent.ctrlKey) then -- select lower in the stacking order
			self.prevSelID = self.prevSelID - 1
			id = keyEvent.view:PickShape(self.prevMousePt, self.prevSelID)
			for i = 0, mesh:CountShapes() - 1 do
				mesh:Shape(i).fSelected = false
			end
			if (id >= 0) then
				mesh:Shape(id).fSelected = true
			end
			moho:UpdateSelectedChannels()
		elseif (keyEvent.shiftKey) then -- lower shape to bottom
			moho.document:PrepUndo(moho.drawingLayer)
			moho.document:SetDirty()
			for i = 0, mesh:CountShapes() - 1 do
				if (mesh:Shape(i).fSelected) then
					mesh:LowerShape(i, true)
				end
			end
		else -- lower shape
			moho.document:PrepUndo(moho.drawingLayer)
			moho.document:SetDirty()
			for i = 0, mesh:CountShapes() - 1 do
				if (mesh:Shape(i).fSelected) then
					mesh:LowerShape(i, false)
				end
			end
		end
		keyEvent.view:DrawMe()
	elseif ((keyEvent.keyCode == LM.GUI.KEY_DELETE) or (keyEvent.keyCode == LM.GUI.KEY_BACKSPACE)) then
		moho.document:PrepUndo(moho.drawingLayer)
		moho.document:SetDirty()
		local i = 0
		while i < mesh:CountShapes() do
			if (mesh:Shape(i).fSelected) then
				mesh:DeleteShape(i)
			else
				i = i + 1
			end
		end
		keyEvent.view:DrawMe()
	end
end

function LM_SelectShape:DrawMe(moho, view)
	if (self.eyedropperMode) then
		LM_Eyedropper:DrawMe(moho, view)
		return
	end

	local mesh = moho:DrawingMesh()
	if (mesh == nil) then
		return
	end

	local g = view:Graphics()
	local matrix = LM.Matrix:new_local()

	g:SetSmoothing(true)
	g:SetBezierTolerance(2.0)

	moho.drawingLayer:GetFullTransform(moho.frame, matrix, moho.document)
	g:Push()
	g:ApplyMatrix(matrix)

	local graphicsScale = g:CurrentScale(false)

	for i = 0, mesh:CountShapes() - 1 do
		local shape = mesh:Shape(i)
		if (shape:HasPositionDependentStyles()) then
			local center = shape:EffectHandle1()
			local handleLocation = shape:EffectHandle2()
			local handleColor = MOHO.MohoGlobals.ElemCol
			if (shape.fSelected) then
				handleColor = MOHO.MohoGlobals.SelCol
			end

			g:SetColor(handleColor.r, handleColor.g, handleColor.b, 96)
			g:FillCircle(center, self.handleRadius / graphicsScale)
			g:SetColor(handleColor)
			g:FrameCircle(center, self.handleRadius / graphicsScale)
			g:FrameCircle(handleLocation, self.handleRadius / graphicsScale)

			local v = handleLocation - center
			v:NormMe()
			v = v * self.handleRadius / graphicsScale
			center = center + v
			handleLocation = handleLocation - v
			g:DrawLine(center.x, center.y, handleLocation.x, handleLocation.y)
		end
	end

	g:Pop()
	g:SetSmoothing(false)
end

-- **************************************************
-- Select Shape dialog
-- **************************************************

local LM_SelectShapeDialog = {}

function LM_SelectShapeDialog:new()
	local d = LM.GUI.SimpleDialog(MOHO.Localize("/Scripts/Tool/SelectShape/ShapePalette=ShapePalette"), LM_SelectShapeDialog)
	local l = d:GetLayout()

	d.shapeTable = {}
	d.skipBlock = false
	d.height = d.height and d.height - 132 or 726
	--d.shapes = d.shapes and LM.Clamp(d.shapes + 2, 10, 40) or 20

	l:PushV(LM.GUI.ALIGN_LEFT, 0)
		l:PushH(LM.GUI.ALIGN_FILL, 0)
			l:AddChild(LM.GUI.StaticText(MOHO.Localize("/Scripts/Tool/SelectShape/Name=Name")), LM.GUI.ALIGN_LEFT)
			l:AddPadding(0)
			d.shapeName = LM.GUI.TextControl(0, "Room For Long Name", LM_SelectShape.DLOG_CHANGE_NAME, LM.GUI.FIELD_TEXT)
			d.shapeName:SetValue("")
			l:AddChild(d.shapeName, LM.GUI.ALIGN_RIGHT)
		l:Pop()
		l:AddPadding(4)

		l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL)
		l:AddPadding(5)

		l:PushH(LM.GUI.ALIGN_CENTER, 4)
			d.raise = LM.GUI.Button("⬆", LM_SelectShape.DLOG_CHANGE_RAISE)
			d.raise:SetAlternateMessage(LM_SelectShape.DLOG_CHANGE_RAISE_ALT)
			d.raise:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/RaiseShape=Raise Shape (<alt> to raise to front)"))
			l:AddChild(d.raise, LM.GUI.ALIGN_LEFT)

			d.lower = LM.GUI.Button("⬇", LM_SelectShape.DLOG_CHANGE_LOWER)
			d.lower:SetAlternateMessage(LM_SelectShape.DLOG_CHANGE_LOWER_ALT)
			d.lower:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/LowerShape=Lower Shape (<alt> to lower to back)"))
			l:AddChild(d.lower, LM.GUI.ALIGN_LEFT)
		l:Pop()
		l:AddPadding(4)

		local iHeight = d.shapeName:Height()
		local wHeight = d.height % iHeight == 0 and d.height or d.height + (iHeight - d.height % iHeight) + 2 --try to ensure last item always fits
		--local wHeight = (d.shapeName:Height() * d.shapes < d.height) and d.shapeName:Height() * d.shapes or d.height --try to addapt to viewpor height
		d.shapeList = LM.GUI.ImageTextList(175, wHeight, LM_SelectShape.DLOG_CHANGE)
		l:AddChild(d.shapeList, LM.GUI.ALIGN_LEFT)
		d.shapeList:SetAllowsMultipleSelection(true)
		d.shapeList:SetDrawsPrimarySelection(true)
		d.shapeList:AddItem("                    " .. MOHO.Localize("/Scripts/Tool/SelectShape/None=<None>"), false)
		d.shapeList:ScrollItemIntoView(d.shapeID or 0, false)
		l:AddPadding()

		l:PushH(LM.GUI.ALIGN_RIGHT, 0)
		l:AddChild(LM.GUI.Button(MOHO.Localize("/Scripts/Tool/SelecShape/Close=Close"), LM.GUI.MSG_CANCEL))
	l:Pop()

	return d
end

function LM_SelectShapeDialog:UpdateWidgets(moho)
	if (self.document and self.layer and self.mesh) then
		local shapeTable = {}
		for i = 1, self.mesh:CountShapes() do --current shapes state
			local shape = self.mesh:Shape(i - 1)
			shapeTable[i] = shape:Name() .. shape.fComboMode
		end

		if self.shapeList:CountItems() == 1 or self.shapeTable and (#self.shapeTable ~= #shapeTable or table.concat(self.shapeTable) ~= table.concat(shapeTable)) then
			self.skipBlock = true
			for i = self.shapeList:CountItems(), 1, -1 do
				self.shapeList:RemoveItem(i, false)
			end

			for i = self.mesh:CountShapes() - 1, 0, -1 do
				local shape = self.mesh:Shape(i)
				local cMode = (shape.fComboMode == MOHO.COMBO_ADD and "+") or (shape.fComboMode == MOHO.COMBO_SUBTRACT and "- ") or (shape.fComboMode == MOHO.COMBO_INTERSECT and "×") or "  " --⊕⊝⊖⊗⊘

				if shape == shape:BottomOfCluster() then
					self.shapeList:AddItem("↳  " .. cMode .. " " .. shape:Name(), false)
				elseif shape == shape:TopOfCluster() then
					self.shapeList:AddItem("↱  " .. cMode .. " " .. shape:Name(), false)
				else
					if shape:IsInCluster() then
						self.shapeList:AddItem("    " .. cMode .. " " .. shape:Name(), false)
					else
						self.shapeList:AddItem(shape:Name(), false)
					end
				end
			end
			self.skipBlock = false
		end

		self.skipBlock = true
		local first = false
		for i = 1, self.shapeList:CountItems() -1 do
			local shape = self.mesh:Shape(i - 1)
			if shape.fSelected == true then
				self.shapeList:SetSelItem(self.shapeList:GetItem(self.mesh:CountShapes() - i + 1), true, first) --moho:SelectedShape()
				first = true
			end
		end
		if self.shapeID and self.shapeID >= 0 then
			self.shapeName:Enable(true)
			self.shapeName:SetValue(self.mesh:Shape(self.shapeID):Name())
			self.shapeList:ScrollItemIntoView(self.mesh:CountShapes() - self.shapeID, true)
		else
			self.shapeName:Enable(false)
			self.shapeName:SetValue("")
			self.shapeList:SetSelItem(self.shapeList:GetItem(0), true, false)
			self.shapeList:ScrollItemIntoView(0, true) --It doesn't seem to scroll to item 0
		end
		self.skipBlock = false

		self.raise:Enable(self.shapeList:SelItem() > 1)
		self.lower:Enable(self.shapeList:SelItem() > 0 and self.shapeList:SelItem() < self.shapeList:CountItems() - 1)

		for i = 1, self.mesh:CountShapes() do --previous shapes state
			local shape = self.mesh:Shape(i - 1)
			self.shapeTable[i] = shape:Name() .. shape.fComboMode
		end
	end
end

function LM_SelectShapeDialog:OnOK()
	self:HandleMessage(LM_SelectShape.DLOG_CHANGE) -- send this final message in case the user is in the middle of editing some value
end

function LM_SelectShapeDialog:HandleMessage(msg)
	if (not (self.document and self.layer and self.mesh)) then
		return
	end

	if (msg == LM_SelectShape.DLOG_CHANGE) then
		if self.skipBlock == true then -- Try to avoid unwanted call to UpdateWidgets bellow upon selecting, no matter how, a list item!
			return
		end

		self.shapeID = self.shapeList:SelItem() > 0 and self.mesh:CountShapes() - self.shapeList:SelItem() or -1
		for i = 1, self.shapeList:CountItems() - 1 do
			local shape = self.mesh:Shape(self.mesh:CountShapes() - i)
			if self.shapeList:IsItemSelected(i) then
				if shape ~= nil then
					shape.fSelected = true
				end
			else
				if shape ~= nil then
					shape.fSelected = false
				end
			end
		end

		self.shapeName:Enable(self.shapeList:SelItem() > 0)
		self.shapeName:SetValue(self.shapeList:SelItem() > 0 and self.mesh:Shape(self.mesh:CountShapes() - self.shapeList:SelItem()):Name() or "")
		self.raise:Enable(self.shapeList:SelItem() > 1)
		self.lower:Enable(self.shapeList:SelItem() > 0 and self.shapeList:SelItem() < self.shapeList:CountItems() - 1)
		--self.layer:UpdateCurFrame(true)
		--self.layer:UpdateCurFrame()
		
		MOHO.Redraw()
		--[[Other tries of updating the toolbar without any success...
		--self:UpdateWidgets()
		--self.document:Refresh()
		--self.document:PrepUndo(self.layer, true)
		--self.document:Undo()
		--self.moho:SetCurFrame(0)
		--self.moho:UpdateUI()
		--]]
	elseif (msg == LM_SelectShape.DLOG_CHANGE_NAME) then
		self.document:PrepUndo(self.layer)
		self.document:SetDirty()
		if self.shapeID and self.shapeID >= 0 then
			local shape = self.mesh:Shape(self.shapeID)
			shape:SetName(self.shapeName:Value())
		end
		self:UpdateWidgets()
	elseif (msg == LM_SelectShape.DLOG_CHANGE_RAISE or msg == LM_SelectShape.DLOG_CHANGE_RAISE_ALT) then
		self.document:PrepUndo(self.layer)
		self.document:SetDirty()
		for i = self.mesh:CountShapes() - 1, 0, -1 do
			if (self.mesh:Shape(i).fSelected) then
				self.mesh:RaiseShape(i, msg == LM_SelectShape.DLOG_CHANGE_RAISE_ALT)
			end
		end
		self:UpdateWidgets()
		MOHO.Redraw()
	elseif (msg == LM_SelectShape.DLOG_CHANGE_LOWER or msg == LM_SelectShape.DLOG_CHANGE_LOWER_ALT) then
		self.document:PrepUndo(self.layer)
		self.document:SetDirty()
		for i = 0, self.mesh:CountShapes() - 1 do
			if (self.mesh:Shape(i).fSelected) then
				self.mesh:LowerShape(i, msg == LM_SelectShape.DLOG_CHANGE_LOWER_ALT)
			end
		end
		self:UpdateWidgets()
		MOHO.Redraw()
	end
end

-- **************************************************
-- Tool options - create and respond to tool's UI
-- **************************************************

LM_SelectShape.CHANGE = MOHO.MSG_BASE
LM_SelectShape.DLOG_BEGIN = MOHO.MSG_BASE + 1
LM_SelectShape.DLOG_CHANGE = MOHO.MSG_BASE + 2
LM_SelectShape.DLOG_CHANGE_NAME = MOHO.MSG_BASE + 3
LM_SelectShape.DLOG_CHANGE_RAISE = MOHO.MSG_BASE + 4
LM_SelectShape.DLOG_CHANGE_RAISE_ALT = MOHO.MSG_BASE + 5
LM_SelectShape.DLOG_CHANGE_LOWER = MOHO.MSG_BASE + 6
LM_SelectShape.DLOG_CHANGE_LOWER_ALT = MOHO.MSG_BASE + 7
LM_SelectShape.FILL = MOHO.MSG_BASE + 8
LM_SelectShape.FILLCOLOR = MOHO.MSG_BASE + 9
LM_SelectShape.LINE = MOHO.MSG_BASE + 10
LM_SelectShape.LINECOLOR = MOHO.MSG_BASE + 11
LM_SelectShape.LINEWIDTH = MOHO.MSG_BASE + 12
LM_SelectShape.SELECTALL = MOHO.MSG_BASE + 13
LM_SelectShape.COMBINE_NORMAL = MOHO.MSG_BASE + 14
LM_SelectShape.COMBINE_ADD = MOHO.MSG_BASE + 15
LM_SelectShape.COMBINE_SUBTRACT = MOHO.MSG_BASE + 16
LM_SelectShape.COMBINE_INTERSECT = MOHO.MSG_BASE + 17
LM_SelectShape.COMBINE_BLEND = MOHO.MSG_BASE + 18
LM_SelectShape.BASE_SHAPE = MOHO.MSG_BASE + 19
LM_SelectShape.TOP_SHAPE = MOHO.MSG_BASE + 20
LM_SelectShape.MERGE = MOHO.MSG_BASE + 21

function LM_SelectShape:DoLayout(moho, layout)
	if (MOHO.IsMohoPro()) then
		layout:AddChild(LM.GUI.DynamicText(MOHO.Localize("/Scripts/Tool/SelectShape/Shapes=   Shapes:"), 56))
		self.dlog = LM_SelectShapeDialog:new()
		self.popup = LM.GUI.PopupDialog(MOHO.Localize("/Scripts/Tool/SelectShape/ShapePalette=☰"), true, self.DLOG_BEGIN)
		self.popup:SetDialog(self.dlog)
		self.popup:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/OpenPalette=Open Palette..."))
		layout:AddChild(self.popup)
		layout:AddPadding()
	end

	self.fillCheck = LM.GUI.CheckBox(MOHO.Localize("/Scripts/Tool/SelectShape/Fill=Fill:"), self.FILL)
	layout:AddChild(self.fillCheck)
	self.fillCol = LM.GUI.ShortColorSwatch(true, self.FILLCOLOR)
	layout:AddChild(self.fillCol)

	self.lineCheck = LM.GUI.CheckBox(MOHO.Localize("/Scripts/Tool/SelectShape/Stroke=Stroke:"), self.LINE)
	layout:AddChild(self.lineCheck)
	self.lineCol = LM.GUI.ShortColorSwatch(true, self.LINECOLOR)
	layout:AddChild(self.lineCol)

	layout:AddChild(LM.GUI.StaticText(MOHO.Localize("/Scripts/Tool/SelectShape/Width=Width:")))
	self.lineWidth = LM.GUI.TextControl(0, "00.0000", self.LINEWIDTH, LM.GUI.FIELD_UFLOAT)
	self.lineWidth:SetUnits(LM.GUI.UNIT_PIXELS)
	self.lineWidth:SetWheelInc(1.0)
	self.lineWidth:SetWheelInteger(true)
	layout:AddChild(self.lineWidth)

	self.selectAllBut = LM.GUI.Button(MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All"), self.SELECTALL)
	layout:AddChild(self.selectAllBut)

	if (MOHO.IsMohoPro()) then
		layout:AddPadding()
		layout:AddPadding()

		self.combineNormal = LM.GUI.ImageButton("ScriptResources/combine_normal", MOHO.Localize("/Scripts/Tool/SelectShape/Normal=Normal"), true, self.COMBINE_NORMAL, true)
		layout:AddChild(self.combineNormal)

		self.combineAdd = LM.GUI.ImageButton("ScriptResources/combine_add", MOHO.Localize("/Scripts/Tool/SelectShape/Add=Add"), true, self.COMBINE_ADD, true)
		layout:AddChild(self.combineAdd)

		self.combineSubtract = LM.GUI.ImageButton("ScriptResources/combine_subtract", MOHO.Localize("/Scripts/Tool/SelectShape/Subtract=Subtract"), true, self.COMBINE_SUBTRACT, true)
		layout:AddChild(self.combineSubtract)

		self.combineIntersect = LM.GUI.ImageButton("ScriptResources/combine_intersect", MOHO.Localize("/Scripts/Tool/SelectShape/Clip=Clip"), true, self.COMBINE_INTERSECT, true)
		layout:AddChild(self.combineIntersect)

		layout:AddChild(LM.GUI.StaticText(MOHO.Localize("/Scripts/Tool/SelectShape/Blend=Blend:")))
		self.combineBlend = LM.GUI.TextControl(0, "00.0000", self.COMBINE_BLEND, LM.GUI.FIELD_UFLOAT)
		self.combineBlend:SetPercentageMode(true)
		self.combineBlend:SetWheelInc(1.0)
		layout:AddChild(self.combineBlend)

		self.baseBut = LM.GUI.ImageButton("ScriptResources/select_cluster_bottom", MOHO.Localize("/Scripts/Tool/SelectShape/SelectBottomShape=Select Bottom Shape"), true, self.BASE_SHAPE, true)
		self.baseBut:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/SelectBottomOfCluster=Select bottom of Liquid Shape"))
		layout:AddChild(self.baseBut)

		self.topBut = LM.GUI.ImageButton("ScriptResources/select_cluster_top", MOHO.Localize("/Scripts/Tool/SelectShape/SelectTopShape=Select Top Shape"), true, self.TOP_SHAPE, true)
		self.topBut:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/SelectTopOfCluster=Select top of Liquid Shape"))
		layout:AddChild(self.topBut)

		self.clusterInfo = LM.GUI.DynamicText("100 / 100")
		layout:AddChild(self.clusterInfo)
		self.clusterInfo:SetValue("")

		self.mergeBut = LM.GUI.Button(MOHO.Localize("/Scripts/Tool/CreateShape/Merge=Merge"), self.MERGE)
		self.mergeBut:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/MergeCluster=Merge a Liquid Shape into a single shape"))
		layout:AddChild(self.mergeBut)
	end

	if (false) then -- make this true to show shape ID's in the tool options bar (useful for debugging)
		self.shapeID = LM.GUI.DynamicText("ShapeID: 0000 (Room For a Long Name)")
		layout:AddChild(self.shapeID)
	else
		self.shapeID = nil
	end
end

function LM_SelectShape:UpdateWidgets(moho)
	local mesh = moho:DrawingMesh()
	if (mesh == nil) then
		return
	end

	local style = moho:CurrentEditStyle()
	if (style ~= nil) then
		self.fillCol:SetValue(style.fFillCol.value)
		self.lineCol:SetValue(style.fLineCol.value)
		self.lineWidth:SetValue(style.fLineWidth * moho.document:Height())
	end

	local shape = moho:SelectedShape()
	if (shape ~= nil) then
		self.fillCheck:SetValue(shape.fHasFill)
		self.fillCheck:Enable(shape.fFillAllowed)
		self.fillCol:Enable(shape.fHasFill)
		self.lineCheck:SetValue(shape.fHasOutline)
		self.lineCheck:Enable(true)
		self.lineCol:Enable(shape.fHasOutline)

		if (MOHO.IsMohoPro()) then
			if (shape.fHasFill) then
				self.combineNormal:Enable(true)
				self.combineNormal:SetValue(shape.fComboMode == MOHO.COMBO_NORMAL)
				self.combineAdd:Enable(true)
				self.combineAdd:SetValue(shape.fComboMode == MOHO.COMBO_ADD)
				self.combineSubtract:Enable(true)
				self.combineSubtract:SetValue(shape.fComboMode == MOHO.COMBO_SUBTRACT)
				self.combineIntersect:Enable(true)
				self.combineIntersect:SetValue(shape.fComboMode == MOHO.COMBO_INTERSECT)
				if (shape.fComboMode == MOHO.COMBO_ADD or shape.fComboMode == MOHO.COMBO_SUBTRACT) then
					self.combineBlend:Enable(true)
					self.combineBlend:SetValue(shape.fComboBlend.value)
				else
					self.combineBlend:Enable(false)
					self.combineBlend:SetValue(0.0)
				end

				if (shape:IsInCluster()) then				
					local position = 0
					local total = 0
					local clusterShape = shape:BottomOfCluster()
					while (clusterShape ~= nil) do
						total = total + 1
						if (shape == clusterShape) then
							position = total
						end
						clusterShape = clusterShape:NextInCluster()
					end
					self.clusterInfo:SetValue(position .. " / " .. total)
					
					self.baseBut:Enable(position > 1)
					self.topBut:Enable(position < total)
					self.mergeBut:Enable(true)
				else
					self.baseBut:Enable(false)
					self.topBut:Enable(false)
					self.clusterInfo:SetValue("")
					self.mergeBut:Enable(self:CountSelectedShapes(moho) > 1)
				end
			else
				self.combineNormal:Enable(false)
				self.combineNormal:SetValue(false)
				self.combineAdd:Enable(false)
				self.combineAdd:SetValue(false)
				self.combineSubtract:Enable(false)
				self.combineSubtract:SetValue(false)
				self.combineIntersect:Enable(false)
				self.combineIntersect:SetValue(false)
				self.combineBlend:Enable(false)
				self.combineBlend:SetValue(0.0)
				self.baseBut:Enable(false)
				self.topBut:Enable(false)
				self.clusterInfo:SetValue("")
				self.mergeBut:Enable(false)
			end
		end

		if (self.shapeID ~= nil) then
			self.shapeID:SetValue("ShapeID: " .. shape:ShapeID() .. " (" .. shape:Name() .. ")")
		end
	else
		self.fillCheck:SetValue(false)
		self.fillCheck:Enable(false)
		self.lineCheck:SetValue(false)
		self.lineCheck:Enable(false)

		if (MOHO.IsMohoPro()) then
			self.combineNormal:Enable(false)
			self.combineNormal:SetValue(false)
			self.combineAdd:Enable(false)
			self.combineAdd:SetValue(false)
			self.combineSubtract:Enable(false)
			self.combineSubtract:SetValue(false)
			self.combineIntersect:Enable(false)
			self.combineIntersect:SetValue(false)
			self.combineBlend:Enable(false)
			self.combineBlend:SetValue(0.0)
			self.baseBut:Enable(false)
			self.topBut:Enable(false)
			self.clusterInfo:SetValue("")
			self.mergeBut:Enable(false)
		end

		if (self.shapeID ~= nil) then
			self.shapeID:SetValue("ShapeID: X")
		end
	end

	if (MOHO.IsMohoPro()) then
		self.dlog.moho = moho
		self.dlog.document = moho.document
		self.dlog.layer = moho.layer
		self.dlog.layerFrame = moho.layerFrame
		self.dlog.mesh = mesh
		self.dlog.shape = shape
		self.dlog.shapeID = shape and mesh:ShapeID(shape) or -1
		self.dlog.height = moho.view:Height()
		self.dlog:UpdateWidgets(moho)
	end
end

function LM_SelectShape:HandleMessage(moho, view, msg)
	local mesh = moho:DrawingMesh()
	if (mesh == nil) then
		return
	end

	local style = moho:CurrentEditStyle()
	local shape = moho:SelectedShape()
	if (style == nil and shape == nil) then
		return
	end

	local undoable = true
	if (msg == self.SELECTALL or msg == self.BASE_SHAPE or msg == self.TOP_SHAPE) then
		undoable = false
	end
	if (undoable) then
		moho.document:PrepUndo(moho.drawingLayer)
		moho.document:SetDirty()
	end

	if (msg == self.FILL) then
		if (shape ~= nil) then
			if (shape.fFillAllowed) then
				shape.fHasFill = self.fillCheck:Value()
			end
			if (shape:IsInCluster() and shape.fComboMode ~= MOHO.COMBO_INTERSECT) then
				shape:BottomOfCluster().fHasFill = self.fillCheck:Value()
			end
		end
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				if (shape.fFillAllowed) then
					shape.fHasFill = self.fillCheck:Value()
				end
			end
		end
		moho:UpdateUI()
	elseif (msg == self.FILLCOLOR) then
		if (style ~= nil) then
			style.fFillCol:SetValue(moho.drawingLayerFrame, self.fillCol:Value())
		end
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fMyStyle.fFillCol:SetValue(moho.drawingLayerFrame, self.fillCol:Value())
			end
		end
		moho:UpdateUI()
	elseif (msg == self.LINE) then
		if (shape ~= nil) then
			shape.fHasOutline = self.lineCheck:Value()
			if (shape:IsInCluster() and shape.fComboMode ~= MOHO.COMBO_INTERSECT) then
				shape:BottomOfCluster().fHasOutline = self.lineCheck:Value()
			end
		end
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fHasOutline = self.lineCheck:Value()
			end
		end
		moho:UpdateUI()
	elseif (msg == self.LINECOLOR) then
		if (style ~= nil) then
			style.fLineCol:SetValue(moho.drawingLayerFrame, self.lineCol:Value())
		end
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fMyStyle.fLineCol:SetValue(moho.drawingLayerFrame, self.lineCol:Value())
			end
		end
		moho:UpdateUI()
	elseif (msg == self.LINEWIDTH) then
		if (style ~= nil) then
			local lineWidth = self.lineWidth:FloatValue()
			lineWidth = LM.Clamp(lineWidth, 0.25, 256)
			style.fLineWidth = lineWidth / moho.document:Height()
		end
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				local lineWidth = self.lineWidth:FloatValue()
				lineWidth = LM.Clamp(lineWidth, 0.25, 256)
				shape.fMyStyle.fLineWidth = lineWidth / moho.document:Height()
			end
		end
		moho:UpdateUI()
	elseif (msg == self.SELECTALL) then
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			shape.fSelected = true
		end
		moho:UpdateUI()
	elseif (msg == self.COMBINE_NORMAL) then
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fComboMode = MOHO.COMBO_NORMAL
			end
		end
		moho:UpdateUI()
	elseif (msg == self.COMBINE_ADD) then
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fComboMode = MOHO.COMBO_ADD
			end
		end
		moho:UpdateUI()
	elseif (msg == self.COMBINE_SUBTRACT) then
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fComboMode = MOHO.COMBO_SUBTRACT
			end
		end
		moho:UpdateUI()
	elseif (msg == self.COMBINE_INTERSECT) then
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fComboMode = MOHO.COMBO_INTERSECT
			end
		end
		moho:UpdateUI()
	elseif (msg == self.COMBINE_BLEND) then
		local blend = self.combineBlend:FloatValue()
		blend = LM.Clamp(blend, 0.0, 1.0)
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fComboBlend:SetValue(moho.drawingLayerFrame, blend)
			end
		end
		moho:UpdateUI()
	elseif (msg == self.BASE_SHAPE) then
		if (shape ~= nil and shape:IsInCluster()) then
			local clusterBaseShape = shape:BottomOfCluster()
			for i = 0, mesh:CountShapes() - 1 do
				local shape = mesh:Shape(i)
				shape.fSelected = false
			end
			clusterBaseShape.fSelected = true
		end
		moho:UpdateUI()
	elseif (msg == self.TOP_SHAPE) then
		if (shape ~= nil and shape:IsInCluster()) then
			local clusterBaseShape = shape:TopOfCluster()
			for i = 0, mesh:CountShapes() - 1 do
				local shape = mesh:Shape(i)
				shape.fSelected = false
			end
			clusterBaseShape.fSelected = true
		end
		moho:UpdateUI()
	elseif (msg == self.MERGE) then
		self:MergeShapes(moho, view)
	elseif (msg == self.DLOG_BEGIN) then
		self.dlog.moho = moho
		self.dlog.document = moho.document
		self.dlog.layer = moho.layer
		self.dlog.layerFrame = moho.layerFrame
		self.dlog.mesh = mesh
		self.dlog.shape = shape
		self.dlog.shapeID = shape and mesh:ShapeID(shape) or -1
		self.dlog.height = view:Height()
		--self.dlog.shapes = mesh:CountShapes()
	--elseif (msg == self.DLOG_CHANGE) then --??
		-- Nothing really happens here - it is a message that came from the popup dialog.
		-- However, the important thing is that this message then flows back into the Moho app, forcing a redraw.
		--moho:UpdateUI()
	end
end

function LM_SelectShape:CountSelectedShapes(moho)
	local mesh = moho:DrawingMesh()
	if (mesh == nil) then
		return 0
	end

	local count = 0

	for i = 0, mesh:CountShapes() - 1 do
		local shape = mesh:Shape(i)
		if (shape.fSelected) then
			count = count + 1
		end
	end

	return count
end

function LM_SelectShape:MergeShapes(moho, view)
	local mesh = moho:DrawingMesh()
	if (mesh == nil) then
		return
	end

	-- First Pass: Merge any cluster that has a selected shape in it
	local doAgain = true
	while (doAgain) do
		doAgain = false
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected and shape.fHasFill and shape:IsInCluster()) then
				local newShapeID = mesh:BakeCombinedShapes(shape, false)
				if (newShapeID >= 0) then
					mesh:Shape(newShapeID).fSelected = true
					doAgain = true
				end
				break
			end
		end
	end

	-- Second Pass: Merge any selected shapes that are not already in a cluster
	local baseShape = nil
	local baseShapeID = -1
	for i = 0, mesh:CountShapes() - 1 do
		local shape = mesh:Shape(i)
		if (shape.fSelected and shape.fHasFill) then
			if (baseShape == nil) then
				baseShape = shape
				baseShapeID = mesh:ShapeID(shape)
			else
				shape.fComboMode = MOHO.COMBO_ADD
				shape.fComboBlend.value = 0
				mesh:PlaceShapeAbove(mesh:ShapeID(shape), baseShapeID);
			end
		end
	end
	if (baseShape ~= nil and baseShape:IsInCluster()) then
		local newShapeID = mesh:BakeCombinedShapes(baseShape, false)
		if (newShapeID >= 0) then
			mesh:Shape(newShapeID).fSelected = true
		end
	end

	moho:UpdateUI()
end
