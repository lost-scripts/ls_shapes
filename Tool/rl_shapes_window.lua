-- **************************************************
-- Provide Moho with the name of this script object
-- **************************************************

ScriptName = "RL_ShapesWindow"

-- **************************************************
-- General information about this script
-- **************************************************

RL_ShapesWindow = {}

RL_ShapesWindow.BASE_STR = 2320

function RL_ShapesWindow:Name()
	return "Shapes Window"
end

function RL_ShapesWindow:Version()
	return "0.0"
end

function RL_ShapesWindow:Description()
	return MOHO.Localize("/Scripts/Tool/SelectShape/Description=Open a shape window for managing them and visualize Liquid Shape interactions.")
end

function RL_ShapesWindow:Creator()
	return "Rai López (Lost Scripts)"
end

function RL_ShapesWindow:UILabel()
	return(MOHO.Localize("/Scripts/Tool/ShapesWindow/ShapesWindow=Shapes Window"))
end

function RL_ShapesWindow:ColorizeIcon()
	return true
end

function RL_ShapesWindow:LoadPrefs(prefs)
	self.creationMode = prefs:GetInt("LM_CreateShape.creationMode", 2)
	self.advancedMode = prefs:GetBool("RL_ShapesWindow.advancedMode", true)
	self.showTooltips = prefs:GetBool("RL_ShapesWindow.showTooltips", true)
	self.showInfobar = prefs:GetBool("RL_ShapesWindow.showInfobar", true)
end

function RL_ShapesWindow:SavePrefs(prefs)
	prefs:SetInt("LM_CreateShape.creationMode", self.creationMode)
	prefs:SetBool("LM_CreateShape.advancedMode", self.advancedMode)
	prefs:SetBool("LM_CreateShape.showTooltips", self.showTooltips)
	prefs:SetBool("LM_CreateShape.showInfobar", self.showInfobar)
end

function RL_ShapesWindow:ResetPrefs()
	LM_CreateShape.creationMode = 2
	RL_ShapesWindow.windowHeight = 0
	RL_ShapesWindow.advancedMode = true
	RL_ShapesWindow.showTooltips = true
	RL_ShapesWindow.showInfobar = true
end

-- **************************************************
-- Recurring values
-- **************************************************

RL_ShapesWindow.dlog = nil
RL_ShapesWindow.creationMode = 2
RL_ShapesWindow.windowHeight = 0
RL_ShapesWindow.advancedMode = true
RL_ShapesWindow.showTooltips = true
RL_ShapesWindow.showInfobar = true

-- **************************************************
-- Shapes Window dialog
-- **************************************************

local RL_ShapesWindowDialog = {}

RL_ShapesWindowDialog.FILL				= MOHO.MSG_BASE --LM_CreateShape.CREATE or MOHO.MSG_BASE (pairs)
RL_ShapesWindowDialog.FILL_ALT			= MOHO.MSG_BASE + 1
RL_ShapesWindowDialog.OUTLINE			= MOHO.MSG_BASE + 2
RL_ShapesWindowDialog.OUTLINE_ALT		= MOHO.MSG_BASE + 3
RL_ShapesWindowDialog.FILLOUTLINE		= MOHO.MSG_BASE + 4
RL_ShapesWindowDialog.FILLOUTLINE_ALT	= MOHO.MSG_BASE + 5
RL_ShapesWindowDialog.FILLED			= MOHO.MSG_BASE + 6
RL_ShapesWindowDialog.FILLEDCOLOR		= MOHO.MSG_BASE + 7
RL_ShapesWindowDialog.LINED				= MOHO.MSG_BASE + 8
RL_ShapesWindowDialog.LINEDCOLOR		= MOHO.MSG_BASE + 9
RL_ShapesWindowDialog.LINEWIDTH			= MOHO.MSG_BASE + 10
RL_ShapesWindowDialog.ROUNDCAPS			= MOHO.MSG_BASE + 11
RL_ShapesWindowDialog.RESETSTYLE		= MOHO.MSG_BASE + 12

RL_ShapesWindowDialog.NAME				= MOHO.MSG_BASE + 13
RL_ShapesWindowDialog.COMBINE_NORMAL	= MOHO.MSG_BASE + 14
RL_ShapesWindowDialog.COMBINE_ADD		= MOHO.MSG_BASE + 15
RL_ShapesWindowDialog.COMBINE_SUBTRACT	= MOHO.MSG_BASE + 16
RL_ShapesWindowDialog.COMBINE_INTERSECT	= MOHO.MSG_BASE + 17
RL_ShapesWindowDialog.COMBINE_BLEND		= MOHO.MSG_BASE + 18
RL_ShapesWindowDialog.BASE_SHAPE		= MOHO.MSG_BASE + 19
RL_ShapesWindowDialog.TOP_SHAPE			= MOHO.MSG_BASE + 20
RL_ShapesWindowDialog.MERGE				= MOHO.MSG_BASE + 21
RL_ShapesWindowDialog.RAISE				= MOHO.MSG_BASE + 22
RL_ShapesWindowDialog.RAISE_ALT			= MOHO.MSG_BASE + 23
RL_ShapesWindowDialog.LOWER				= MOHO.MSG_BASE + 24
RL_ShapesWindowDialog.LOWER_ALT			= MOHO.MSG_BASE + 25
RL_ShapesWindowDialog.CHANGE			= MOHO.MSG_BASE + 26
RL_ShapesWindowDialog.DELETE			= MOHO.MSG_BASE + 27
RL_ShapesWindowDialog.SELECTALL			= MOHO.MSG_BASE + 28
RL_ShapesWindowDialog.SELECTALL_ALT		= MOHO.MSG_BASE + 29
RL_ShapesWindowDialog.SELECTBASETOP		= MOHO.MSG_BASE + 30
RL_ShapesWindowDialog.SELECTBASETOP_ALT	= MOHO.MSG_BASE + 31
RL_ShapesWindowDialog.OPTIONS_MENU		= MOHO.MSG_BASE + 32

function RL_ShapesWindowDialog:new(moho)
	local d = LM.GUI.SimpleDialog("☰  " .. MOHO.Localize("/Windows/Style/Shapes=Shapes"), RL_ShapesWindowDialog)
	local l = d:GetLayout()

	d.shapeTable = {}
	d.skipBlock = false
	d.vHeight = moho.view and moho.view:Height() / 2 - 132 or 726 --d.vHeight = d.vHeight and d.vHeight - 132 or 726
	--d.shapes = d.shapes and LM.Clamp(d.shapes + 2, 10, 40) or 20
	l:AddPadding(-12)
	l:Unindent(6)

	l:AddPadding(-14)
	l:PushV(LM.GUI.ALIGN_LEFT, 0)
		l:PushH(LM.GUI.ALIGN_FILL, 0)
			--l:AddPadding(-12)
			d.optionsMenu = LM.GUI.Menu("") --⁝☰⚙
			d.optionsPopup = LM.GUI.PopupMenu(22, false) --56
			d.optionsPopup:SetToolTip(MOHO.Localize("/Dialogs/LayerSettings/GeneralTab/Options=Options"))
			d.optionsPopup:SetMenu(d.optionsMenu)
			l:AddChild(d.optionsPopup)
			d.optionsMenu:AddItem(MOHO.Localize("/Windows/Style/Advanced=Advanced"), 0, self.OPTIONS_MENU) d.optionsMenu:SetEnabled(self.OPTIONS_MENU, true)
			d.optionsMenu:AddItem(MOHO.Localize(""), 0, 0)
			d.optionsMenu:AddItem(MOHO.Localize("/Scripts/Tool/SelectShape/HalfHeight=Half Height"), 0, self.OPTIONS_MENU + 1)
			d.optionsMenu:AddItem(MOHO.Localize(""), 0, 0)
			d.optionsMenu:AddItem(MOHO.Localize("/Windows/LayerComps/ShowComp=Show") .. " " .. "Tooltips", 0, self.OPTIONS_MENU + 2)
			d.optionsMenu:AddItem(MOHO.Localize("/Windows/LayerComps/ShowComp=Show") .. " " .. "Infobar", 0, self.OPTIONS_MENU + 3)
			d.optionsMenu:AddItem(MOHO.Localize(""), 0, 0)
			d.optionsMenu:AddItem(MOHO.Localize("/Dialogs/ProjectSettings/RestoreDefaults=Restore Defaults") .. " [?]", 0, self.OPTIONS_MENU + 4)
			d.optionsMenu:AddItem(MOHO.Localize(""), 0, 0)
			d.optionsMenu:AddItem(MOHO.Localize("/Scripts/Tool/SelectShape/Acknowledgements=Acknowledgements..."), 0, self.OPTIONS_MENU + 5) --Acknowledgements...
			d.optionsMenu:AddItem(MOHO.Localize("/Scripts/Tool/SelectShape/About=About..."), 0, self.OPTIONS_MENU + 6)
		l:Pop() --H

		l:Indent(6)
		l:AddPadding(3)
		l:PushH(LM.GUI.ALIGN_FILL, 0)
			l:AddPadding(2)
			d.shapeNameLabel = LM.GUI.DynamicText("🏷", 0)
			d.shapeNameLabel:SetToolTip(MOHO.Localize("/Windows/Style/Name=Name") .. " (Tab key to confirm)")
			l:AddChild(d.shapeNameLabel, LM.GUI.ALIGN_LEFT)
			l:AddPadding(-2)

			d.shapeName = LM.GUI.TextControl(0, "Room For Long Name.", self.NAME, LM.GUI.FIELD_TEXT)
			d.shapeName:SetValue("")
			l:AddChild(d.shapeName, LM.GUI.ALIGN_LEFT)
			--l:AddPadding(8)
		l:Pop() --H

		l:AddPadding(4)
		l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, 0)
		l:AddPadding(3)

		l:PushH(LM.GUI.ALIGN_LEFT, 0)
			--l:AddPadding(2)
			d.combineBlendLabel = LM.GUI.DynamicText("💧", 0)
			d.combineBlendLabel:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/LiquidShapes=Liquid Shapes")) --Remove any non-alphanumeric ending character
			l:AddChild(d.combineBlendLabel, LM.GUI.ALIGN_CENTER, 5)
			l:AddPadding(2)
			l:PushV(LM.GUI.ALIGN_FILL, 0)
				l:PushH(LM.GUI.ALIGN_FILL, 0)
					d.combineNormal = LM.GUI.ImageButton("ScriptResources/combine_normal", MOHO.Localize("/Scripts/Tool/SelectShape/Normal=Normal"), true, self.COMBINE_NORMAL, true)
					l:AddChild(d.combineNormal, LM.GUI.ALIGN_FILL, 0)
					d.combineAdd = LM.GUI.ImageButton("ScriptResources/combine_add", MOHO.Localize("/Scripts/Tool/SelectShape/Add=Add"), true, self.COMBINE_ADD, true)
					l:AddChild(d.combineAdd, LM.GUI.ALIGN_FILL, 0)
					d.combineSubtract = LM.GUI.ImageButton("ScriptResources/combine_subtract", MOHO.Localize("/Scripts/Tool/SelectShape/Subtract=Subtract"), true, self.COMBINE_SUBTRACT, true)
					l:AddChild(d.combineSubtract, LM.GUI.ALIGN_FILL, 0)
					d.combineIntersect = LM.GUI.ImageButton("ScriptResources/combine_intersect", MOHO.Localize("/Scripts/Tool/SelectShape/Clip=Clip"), true, self.COMBINE_INTERSECT, true)
					l:AddChild(d.combineIntersect, LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(4)

					d.combineBlend = LM.GUI.TextControl(0, "00.0", self.COMBINE_BLEND, LM.GUI.FIELD_UFLOAT)
					d.combineBlend:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/Blend=Blend:"):gsub("[^%w]$", ""))
					d.combineBlend:SetPercentageMode(true)
					d.combineBlend:SetWheelInc(1.0)
					l:AddChild(d.combineBlend)
				l:Pop() --H
				l:AddPadding(4)
				l:PushH(LM.GUI.ALIGN_FILL, 0)
					--d.baseTopBut = LM.GUI.ImageButton("ScriptResources/../curs_vresize", MOHO.Localize("/Scripts/Tool/SelectShape/SelectTopOfCluster=Select top of Liquid Shape") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/SelectShape/SelectBottomOfCluster=Select bottom of Liquid Shape") .. ")", false, self.SELECTBASETOP, false)
					--d.baseTopBut:SetAlternateMessage(self.SELECTBASETOP_ALT)
					--l:AddChild(d.baseTopBut, LM.GUI.ALIGN_FILL, 0)

					d.baseBut = LM.GUI.ImageButton("ScriptResources/select_cluster_bottom", MOHO.Localize("/Scripts/Tool/SelectShape/SelectBottomOfCluster=Select bottom of Liquid Shape"), false, self.BASE_SHAPE, true)
					d.baseBut:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/SelectBottomOfCluster=Select bottom of Liquid Shape"))
					l:AddChild(d.baseBut, LM.GUI.ALIGN_FILL, 0)
			
					d.topBut = LM.GUI.ImageButton("ScriptResources/select_cluster_top", MOHO.Localize("/Scripts/Tool/SelectShape/SelectTopOfCluster=Select top of Liquid Shape"), false, self.TOP_SHAPE, true)
					d.topBut:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/SelectTopOfCluster=Select top of Liquid Shape"))
					l:AddChild(d.topBut, LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(4)

					d.mergeBut = LM.GUI.ImageButton("ScriptResources/../mesh_type", MOHO.Localize("/Scripts/Tool/SelectShape/MergeCluster=Merge a Liquid Shape into a single shape"), false, self.MERGE, true) --ↀ⊖⋈⩇⩉θΣϴϻϺ
					l:AddChild(d.mergeBut, LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(4)

					l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(0)

					d.selectAllBut = LM.GUI.ImageButton("ScriptResources/../lib_moho/channel_shape_order", MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All") .. " (<alt> " .. MOHO.Localize("/Menus/Edit/SelectConnected=Select Connected") .. ")", false, self.SELECTALL, true) --<alt> Select Cluster
					d.selectAllBut:SetAlternateMessage(self.SELECTALL_ALT)
					l:AddChild(d.selectAllBut, LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(4)

					d.deleteBut = LM.GUI.ImageButton("ScriptResources/../action_del", MOHO.Localize("/Scripts/Tool/DeleteShape/DeleteShape=Delete Shape") .. "/s", false, self.DELETE, true) --"<alt> Delete entire Liquid Shape"
					l:AddChild(d.deleteBut, LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(1)
				l:Pop() --H
			l:Pop() --V
		l:Pop() --H

		l:AddPadding(4)
		l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, 0)
		l:AddPadding(-2)

		l:Unindent(6)
		l:PushH(LM.GUI.ALIGN_FILL, 0)
			l:Indent(6)
			l:PushV(LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(-4)
				d.shapeOrderLabel = LM.GUI.DynamicText(" ≡", 0)
				d.shapeOrderLabel:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/ShapePalette=Shape Palette"))
				l:AddChild(d.shapeOrderLabel, LM.GUI.ALIGN_CENTER, 4)
				l:AddPadding(3)
				l:PushH(LM.GUI.ALIGN_FILL, 0)
					d.raise = LM.GUI.ImageButton("ScriptResources/../curs_vresize_up", MOHO.Localize("/Menus/Draw/RaiseShape=Raise Shape") .. " (<alt> " .. MOHO.Localize("/Menus/Draw/RaiseToFront=Raise To Front") .. ")", false, self.RAISE, false)
					d.raise:SetAlternateMessage(self.RAISE_ALT)
					l:AddChild(d.raise,LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(-1)
					l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL, 25)
				l:Pop() --H

				--l:AddPadding(-6)
				--d.shapeOrderLabel = LM.GUI.DynamicText("  ≡", 0)
				--d.shapeOrderLabel:SetToolTip(MOHO.Localize("/Animation/Channels/ShapeOrder=Shape Order"))
				--l:AddChild(d.shapeOrderLabel, LM.GUI.ALIGN_CENTER, 2)
				--l:AddPadding(-4)
				l:PushH(LM.GUI.ALIGN_FILL, 0)
					d.lower = LM.GUI.ImageButton("ScriptResources/../curs_vresize_down", MOHO.Localize("/Menus/Draw/LowerShape=Lower Shape") .. " (<alt> " .. MOHO.Localize("/Menus/Draw/LowerToBack=Lower To Back") .. ")", false, self.LOWER, false)
					d.lower:SetAlternateMessage(self.LOWER_ALT)
					l:AddChild(d.lower,LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(-1)
					l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL, 25)
				l:Pop() --H
				--[[
				l:AddPadding(8)
				l:PushH(LM.GUI.ALIGN_FILL, 0)
					--d.deleteBut = LM.GUI.ImageButton("ScriptResources/../action_del", MOHO.Localize("/Scripts/Tool/DeleteShape/DeleteShape=Delete Shape") .. "/s", false, self.DELETE, true) --"<alt> Delete entire Liquid Shape"
					d.deleteBut = LM.GUI.ImageButton("ScriptResources/../channel_off", MOHO.Localize("/Scripts/Tool/DeleteShape/DeleteShape=Delete Shape") .. "/s", false, self.DELETE, true)
					l:AddChild(d.deleteBut, LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(-1)
					l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL, 6)
				l:Pop() --H
				l:AddPadding(4)
				l:PushH(LM.GUI.ALIGN_FILL, 0)
					d.selectAllBut = LM.GUI.ImageButton("ScriptResources/../fbf_type", MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All") .. " (<alt> " .. MOHO.Localize("/Menus/Edit/SelectConnected=Select Connected") .. ")", false, self.SELECTALL, true) --<alt> Select Cluster
					d.selectAllBut:SetAlternateMessage(self.SELECTALL_ALT)
					l:AddChild(d.selectAllBut, LM.GUI.ALIGN_FILL)
					l:AddPadding(-1)
					l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL, 4)
				l:Pop() --H
				--]]
			l:Pop() --V

			l:AddPadding(-2)

			local iHeight = d.shapeName:Height()
			local wHeight = d.vHeight % iHeight == 0 and d.vHeight or d.vHeight + (iHeight - d.vHeight % iHeight) + 2 --try to ensure last item always fits
			--local wHeight = (d.shapeName:Height() * d.shapes < d.vHeight) and d.shapeName:Height() * d.shapes or d.vHeight --try to addapt to viewport height
			d.shapeList = LM.GUI.ImageTextList(138, wHeight, self.CHANGE) --175
			d.shapeList:SetAllowsMultipleSelection(true)
			d.shapeList:SetDrawsPrimarySelection(true)
			d.shapeList:AddItem((" "):rep(13) .. MOHO.Localize("/Windows/Style/None=<Nada>"), false)
			d.shapeList:ScrollItemIntoView(d.shapeID or 0, false)
			l:AddChild(d.shapeList, LM.GUI.ALIGN_FILL)
		l:Pop()
		l:AddPadding(-1)
		l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, 0)
		l:AddPadding(4)

		--[[
		l:PushH(LM.GUI.ALIGN_CENTER, 4)
			d.createButLabels = {[0] = "⚫", "⚪", "🔘"}
			d.createBut = LM.GUI.ShortButton(d.createButLabels[0], self.CREATE)
			d.createBut:SetToolTip(MOHO.Localize("/Scripts/Tool/CreateShape/CreateShape=Create Shape"))
			l:AddChild(d.createBut, LM.GUI.ALIGN_LEFT)
			l:AddPadding(-9)
			d.createMenu = LM.GUI.Menu("")
			d.createPopup = LM.GUI.PopupMenu(21, true)
			d.createPopup:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectPoints/Create=Create") .. " " .. MOHO.Localize("/Dialogs/LayerSettings/GeneralTab/Options=Options"))
			d.createPopup:SetMenu(d.createMenu)
			l:AddChild(d.createPopup)
			d.createMenu:AddItem(MOHO.Localize("/Scripts/Tool/CreateShape/Fill=Fill"), 0, self.CREATE_FILL)
			d.createMenu:AddItem(MOHO.Localize("/Scripts/Tool/CreateShape/Stroke=Stroke"), 0, self.CREATE_FILL + 1)
			d.createMenu:AddItem(MOHO.Localize("/Scripts/Tool/CreateShape/Both=Both"), 0, self.CREATE_FILL + 2)

			--d.deleteText = string.gsub(MOHO.Localize("/Windows/Style/Delete=Delete"), "%a+", function(w) return #w > 4 and string.sub(w, 1, 4) .. "." or w end) --Try to abbreviate...
			--d.deleteBut = LM.GUI.ShortButton("🗑", self.DELETE) --MOHO.Localize("/Windows/Style/Delete=Eliminar")
			--d.deleteBut:SetToolTip(MOHO.Localize("/Scripts/Tool/DeleteShape/DeleteShape=Delete Shape") .. "/s")
			--l:AddChild(d.deleteBut)

			l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL)

			--d.selectAllText = string.gsub(MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All"), "%a+", function(w) return #w > 4 and string.sub(w, 1, 3) .. "." or w end) --Try to abbreviate...
			--d.selectAllBut = LM.GUI.ShortButton("✅", self.SELECTALL)
			--d.selectAllBut:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All"))
			--l:AddChild(d.selectAllBut, LM.GUI.ALIGN_LEFT)
		l:Pop() --H
		--]]

		--[[TEST 1!
		--self.fillCheck = LM.GUI.CheckBox(MOHO.Localize("/Scripts/Tool/SelectShape/Fill=Fill:"), self.FILL)
		--l:AddChild(self.fillCheck)
		l:PushH(LM.GUI.ALIGN_FILL, 0)
			--d.fillCheck = LM.GUI.ImageButton("ScriptResources/../timeline/mute_channel_on@2x", MOHO.Localize("/Scripts/Tool/SelectShape/Fill=Fill:"), true, 0, true)
			--l:AddChild(d.fillCheck, LM.GUI.ALIGN_TOP)
			l:PushH(LM.GUI.ALIGN_FILL, 0)
				--l:AddPadding(-16)
				l:PushV(LM.GUI.ALIGN_FILL, 0)
					l:PushH(LM.GUI.ALIGN_FILL, 0)
						d.fillCheck = LM.GUI.ImageButton("ScriptResources/../timeline/mute_channel_on@2x", MOHO.Localize("/Scripts/Tool/SelectShape/Fill=Fill:"):sub(1, -2), true, 0, true)
						l:AddChild(d.fillCheck, LM.GUI.ALIGN_FILL)
						l:PushH(LM.GUI.ALIGN_FILL, 0)
							l:AddPadding(-16)
							l:PushV(LM.GUI.ALIGN_FILL, 0)
								l:AddPadding(-12)
								self.fillCol = LM.GUI.ShortColorSwatch(true, self.FILLCOLOR)
								l:AddChild(self.fillCol)
							l:Pop() --V
						l:Pop() --H
					l:Pop() --H
					l:AddPadding(2)
					local swatchHeight = self.fillCol:Height()
					l:PushH(LM.GUI.ALIGN_FILL, 0)
						d.lineCheck = LM.GUI.ImageButton("ScriptResources/../layer_mask_minus@2x", MOHO.Localize("/Scripts/Tool/SelectShape/Stroke=Stroke:"):sub(1, -2), true, 0, true)
						l:AddChild(d.lineCheck, LM.GUI.ALIGN_FILL)
						l:PushH(LM.GUI.ALIGN_FILL, 0)
							l:AddPadding(-16)
							l:PushV(LM.GUI.ALIGN_FILL, 0)
								l:AddPadding(-12)
								self.lineCol = LM.GUI.ShortColorSwatch(true, self.LINECOLOR)
								l:AddChild(self.lineCol)
							l:Pop() --V
						l:Pop() --H
					l:Pop() --H
				l:Pop() --V
			l:Pop() --H

			--l:AddChild(LM.GUI.StaticText(MOHO.Localize("/Scripts/Tool/SelectShape/Width=Width:")))
			self.lineWidth = LM.GUI.TextControl(0, "00.00", self.LINEWIDTH, LM.GUI.FIELD_UFLOAT)
			self.lineWidth:SetUnits(LM.GUI.UNIT_PIXELS)
			self.lineWidth:SetWheelInc(1.0)
			self.lineWidth:SetWheelInteger(true)
			l:AddChild(self.lineWidth)
		l:Pop() --H
		l:AddPadding(3)
		--]]

		--[[TEST 2!
		l:PushH(LM.GUI.ALIGN_CENTER, 0)
			d.fillCheck = LM.GUI.ImageButton("ScriptResources/../timeline/mute_channel_on@2x", MOHO.Localize("/Scripts/Tool/SelectShape/Fill=Fill:"), true, 0, true)
			l:AddChild(d.fillCheck, LM.GUI.ALIGN_FILL)
			l:AddPadding(-1)
			l:PushH(LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(-16)
				self.fillCol = LM.GUI.ShortColorSwatch(true, self.FILLCOLOR)
				l:AddChild(self.fillCol)
			l:Pop() --H

			--l:AddPadding(3)

			d.lineCheck = LM.GUI.ImageButton("ScriptResources/../channel_nomute", MOHO.Localize("/Scripts/Tool/SelectShape/Stroke=Stroke:"), true, 0, true)
			l:AddChild(d.lineCheck, LM.GUI.ALIGN_FILL)
			l:AddPadding(-1)
			l:PushH(LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(-16)
				self.lineCol = LM.GUI.ShortColorSwatch(true, self.LINECOLOR)
				l:AddChild(self.lineCol)
			l:Pop() --H

			--l:AddChild(LM.GUI.StaticText(MOHO.Localize("/Scripts/Tool/SelectShape/Width=Width:")))
			self.lineWidth = LM.GUI.TextControl(0, "00.0", self.LINEWIDTH, LM.GUI.FIELD_UFLOAT)
			self.lineWidth:SetUnits(LM.GUI.UNIT_PIXELS)
			self.lineWidth:SetWheelInc(1.0)
			self.lineWidth:SetWheelInteger(true)
			l:AddChild(self.lineWidth)
		l:Pop() --H

		l:AddPadding(3)
		--]]

		---[[TEST 3!
		l:PushH(LM.GUI.ALIGN_LEFT, 0)
			l:AddPadding(-4)
			d.shapeCreationLabel = LM.GUI.DynamicText("  © ", 24)
			d.shapeCreationLabel:SetToolTip(MOHO.Localize("/Scripts/Tool/CreateShape/CreateShape=Create Shape") .." (" .. MOHO.Localize("/Windows/Style/Advanced=Advanced") .. ")")
			l:AddChild(d.shapeCreationLabel, LM.GUI.ALIGN_CENTER, 0)
			l:AddPadding(-4)
			l:PushV(LM.GUI.ALIGN_FILL, 0)
				l:PushH(LM.GUI.ALIGN_FILL, 0)
					d.fillCheck = LM.GUI.ImageButton("ScriptResources/../lib_moho/channel_fill", MOHO.Localize("/Scripts/Tool/SelectShape/Fill=Fill:"):sub(1, -2), true, self.FILLED, true)
					l:AddChild(d.fillCheck, LM.GUI.ALIGN_FILL)
					l:AddPadding(-1)
					l:PushH(LM.GUI.ALIGN_FILL, 0)
						l:AddPadding(-20)
						d.fillCol = LM.GUI.ShortColorSwatch(true, self.FILLEDCOLOR)
						l:AddChild(d.fillCol)
					l:Pop() --H

					l:AddPadding(1)
					l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL)
					l:AddPadding(3)

					d.shapeButtons = {}
					table.insert(d.shapeButtons, LM.GUI.ImageButton("ScriptResources/../lib_moho/channel_fill", MOHO.Localize("/Scripts/Tool/SelectPoints/Create=Create") .. " " .. MOHO.Localize("/Scripts/Tool/CreateShape/Fill=Fill") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/CreateShape/ConnectAndCreate=Connect And Create") .. ")", false, self.FILL, true))
					table.insert(d.shapeButtons, LM.GUI.ImageButton("ScriptResources/../lib_moho/channel_line", MOHO.Localize("/Scripts/Tool/SelectPoints/Create=Create") .. " " .. MOHO.Localize("/Scripts/Tool/CreateShape/Stroke=Stroke") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/CreateShape/ConnectAndCreate=Connect And Create") .. ")", false, self.OUTLINE, false))
					table.insert(d.shapeButtons, LM.GUI.ImageButton("ScriptResources/../lib_moho/channel_fill", MOHO.Localize("/Scripts/Tool/SelectPoints/Create=Create") .. " " .. MOHO.Localize("/Scripts/Tool/CreateShape/Both=Both") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/CreateShape/ConnectAndCreate=Connect And Create") .. ")", false, self.FILLOUTLINE, false))
					l:AddPadding(0)

					for i, but in ipairs(d.shapeButtons) do
						l:AddChild(but, LM.GUI.ALIGN_FILL)
						but:SetAlternateMessage(self.FILL + (i * 2 - 1))
						--l:AddPadding(i < #d.shapeButtons and -2 or 0)
					end
					l:AddPadding(1)
				l:Pop() --H
				l:AddPadding(4)

				l:PushH(LM.GUI.ALIGN_FILL, 0)
					d.lineCheck = LM.GUI.ImageButton("ScriptResources/../lib_moho/channel_line", MOHO.Localize("/Scripts/Tool/SelectShape/Stroke=Stroke:"):sub(1, -2), true, self.LINED, true)
					l:AddChild(d.lineCheck, LM.GUI.ALIGN_FILL)
					l:AddPadding(-1)
					l:PushH(LM.GUI.ALIGN_FILL, 0)
						l:AddPadding(-20)
						d.lineCol = LM.GUI.ShortColorSwatch(true, self.LINEDCOLOR)
						l:AddChild(d.lineCol)
					l:Pop() --H

					d.widthLabel = LM.GUI.StaticText("ø")
					d.widthLabel:SetToolTip(MOHO.Localize("/Dialogs/InsertText/BalloonWidth=Stroke Width"))
					l:AddChild(d.widthLabel, LM.GUI.ALIGN_CENTER, 0)
					l:AddPadding(-1)
					d.lineWidth = LM.GUI.TextControl(0, "00.0", self.LINEWIDTH, LM.GUI.FIELD_UFLOAT) --ø
					d.lineWidth:SetUnits(LM.GUI.UNIT_PIXELS)
					d.lineWidth:SetWheelInc(1.0)
					d.lineWidth:SetWheelInteger(true)
					l:AddChild(d.lineWidth)

					d.capsBut = LM.GUI.ImageButton("ScriptResources/../timeline/mute_channel_on@2x", MOHO.Localize("/Windows/Style/RoundCaps=Round caps"), true, self.ROUNDCAPS, true)
					l:AddChild(d.capsBut, LM.GUI.ALIGN_FILL)

					l:AddPadding(4)
					l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(0)

					d.resetBut = LM.GUI.ImageButton("ScriptResources/../lm_widgets/path_delete", MOHO.Localize("/Windows/Style/Reset=Reset"), false, self.RESETSTYLE, true) --lm_widgets/refreshButtonImage_1
					l:AddChild(d.resetBut, LM.GUI.ALIGN_FILL)
					l:AddPadding(1) --refreshButtonImage_1
				l:Pop() --H
			l:Pop() --V
		l:Pop() --H
		--]]

		l:AddPadding(4)
		d.dummyList = LM.GUI.ImageTextList(0, 1, 0)
		l:AddChild(d.dummyList, LM.GUI.ALIGN_FILL, 0)
		--l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL)
		l:AddPadding(-2)

		l:PushH(LM.GUI.ALIGN_FILL, 2)
			l:AddChild(LM.GUI.StaticText(" ℹ"), LM.GUI.ALIGN_LEFT)
			l:AddPadding(-4)
			d.infobar = LM.GUI.DynamicText("Room For Some Info...", 0)
			l:AddChild(d.infobar, LM.GUI.ALIGN_LEFT, 0)
		l:Pop() --H

		--l:PushH(LM.GUI.ALIGN_RIGHT, 0)
			--l:AddChild(LM.GUI.Button(MOHO.Localize("/Scripts/Tool/SelecShape/Close=Close"), LM.GUI.MSG_CANCEL))
		--l:Pop()
	l:Pop() --V

	return d
end

function RL_ShapesWindowDialog:Update(moho) --print("RL_ShapesWindowDialog:Update(moho): ", os.clock())
	local helper = MOHO.ScriptInterfaceHelper:new_local()
	local moho = helper:MohoObject()
	local doc = moho.document
	local layer = moho.layer
	local lFrame = moho.layerFrame
	local mesh = moho:DrawingMesh()
	local shape = moho:SelectedShape()
	local shapes = mesh:CountShapes()
	local shapesSel = moho:CountSelectedShapes(false) --Use this instead LM_SelectShape:CountSelectedShapes??
	local shapeID = shape and mesh:ShapeID(shape) or -1

	if (mesh == nil) then
		helper:delete()
		return
	end

	local style = moho:CurrentEditStyle()
	if (style ~= nil) then
		self.fillCol:SetValue(style.fFillCol.value)
		self.lineCol:SetValue(style.fLineCol.value)
		self.lineWidth:SetValue(style.fLineWidth * moho.document:Height())
	end

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
					self.combineBlendLabel:SetValue(shape.fComboBlend.value > 0 and " 🩸" or " 💧") --??
					--self.baseTopBut:Enable(position > 1 or position < total)
					self.baseBut:Enable(position > 1)
					self.topBut:Enable(position < total)
					self.mergeBut:Enable(true)
					self.infobar:SetValue(position .. " / " .. total)
				else
					self.combineBlendLabel:SetValue(shape.fComboBlend.value > 0 and " 💧" or " 🩸") --??
					--self.baseTopBut:Enable(false)
					self.baseBut:Enable(false)
					self.topBut:Enable(false)
					self.mergeBut:Enable(LM_SelectShape:CountSelectedShapes(moho) > 1)
					self.infobar:SetValue("")
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
				--self.baseTopBut:Enable(false)
				self.baseBut:Enable(false)
				self.topBut:Enable(false)
				self.mergeBut:Enable(false)
				self.infobar:SetValue("")
			end
		end

		self.deleteBut:Enable(true)
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
			--self.baseTopBut:Enable(false)
			self.baseBut:Enable(false)
			self.topBut:Enable(false)
			self.mergeBut:Enable(false)
			self.infobar:SetValue("")
		end

		self.deleteBut:Enable(false)
		if (self.shapeID ~= nil) then
			self.shapeID:SetValue("ShapeID: X")
		end
	end

	--self.createBut:SetLabel(self.createButLabels[LM_CreateShape.creationMode])
	--self.createBut:Redraw()
	--self.createMenu:UncheckAll()
	--self.createMenu:SetChecked(self.CREATE_FILL + LM_CreateShape.creationMode, true)
	--self.createPopup:Redraw()

	self.selectAllBut:Enable(shapes > 0)
	--self.selectAllBut:SetLabel(LM_SelectShape:CountSelectedShapes(moho) == mesh:CountShapes() and "✅" or "☑", false) --20230922: It seems to tail some text??
	--self.selectAllBut:Redraw()

	local shapeTable = {}
	for i = 1, mesh:CountShapes() do --current shapes state
		local shape = mesh:Shape(i - 1)
		shapeTable[i] = shape:Name() .. shape.fComboMode
	end
	--print(#self.shapeTable, ":", table.concat(self.shapeTable, ", "))
	if self.shapeList:CountItems() == 1 or self.shapeTable and (#self.shapeTable ~= #shapeTable or table.concat(self.shapeTable) ~= table.concat(shapeTable)) then
		self.skipBlock = true
		for i = self.shapeList:CountItems(), 1, -1 do
			self.shapeList:RemoveItem(i, false)
		end

		for i = mesh:CountShapes() - 1, 0, -1 do
			local shape = mesh:Shape(i)
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
		local shape = mesh:Shape(i - 1)
		if shape.fSelected == true then
			self.shapeList:SetSelItem(self.shapeList:GetItem(mesh:CountShapes() - i + 1), true, first) --moho:SelectedShape()
			first = true
		end
	end
	if shapeID and shapeID >= 0 then
		self.shapeName:Enable(true)
		self.shapeName:SetValue(mesh:Shape(shapeID):Name()) --self.shapeName:Redraw()
		self.shapeList:ScrollItemIntoView(mesh:CountShapes() - shapeID, true)
	else
		self.shapeName:Enable(false)
		self.shapeName:SetValue("")
		self.shapeList:SetSelItem(self.shapeList:GetItem(0), true, false) --20230920-1605: Had to pass false for redraw (2nd arg.) to avoid items deselection!
		self.shapeList:ScrollItemIntoView(0, true) --It doesn't seem to scroll to item 0
	end
	self.skipBlock = false

	self.raise:Enable(self.shapeList:SelItem() > 1) --print(self.shapeList:SelItem(), ", ", self.shapeList:SelItemLabel())
	self.lower:Enable(self.shapeList:SelItem() > 0 and self.shapeList:SelItem() < self.shapeList:CountItems() - 1)

	--self.shapeButtons[1]:SetCursor(LM.GUI.Cursor("ScriptResources/../../Support/Scripts/Tool/lm_select_shape_cursor", 0, 0))
	--self.shapeButtons[2]:SetCursor(LM.GUI.Cursor("ScriptResources/../../Support/Scripts/Tool/lm_select_shape_cursor", 0, 0))
	--self.shapeButtons[3]:SetCursor(LM.GUI.Cursor("ScriptResources/../../Support/Scripts/Tool/lm_select_shape_cursor", 0, 0))

	for i, but in ipairs(self.shapeButtons) do
		but:SetCursor(LM.GUI.Cursor("ScriptResources/../../Support/Scripts/Tool/lm_select_shape_cursor", 0, 0))
	end

	self.deleteBut:SetCursor(LM.GUI.Cursor("ScriptResources/../../Support/Scripts/Tool/lm_delete_shape_cursor", 0, 0))
	self.selectAllBut:SetCursor(LM.GUI.Cursor("ScriptResources/../../Support/Scripts/Tool/lm_create_shape_cursor", 0, 0)) --lm_select_shape_cursor

	for i = 1, mesh:CountShapes() do --previous shapes state
		local shape = mesh:Shape(i - 1)
		self.shapeTable[i] = shape:Name() .. shape.fComboMode
	end

	helper:delete()
end

function RL_ShapesWindowDialog:OnOK()
	RL_ShapesWindow.dlog = nil -- mark the window closed
end

function RL_ShapesWindowDialog_Update(moho) --print("RL_ShapesWindowDialog_Update(moho): ", os.clock())
	if RL_ShapesWindow.dlog then
		RL_ShapesWindow.dlog:Update(moho)
	end
end

-- register the dialog to be updated when changes are made
table.insert(MOHO.UpdateTable, RL_ShapesWindowDialog_Update)

function RL_ShapesWindowDialog:HandleMessage(msg)
	local helper = MOHO.ScriptInterfaceHelper:new_local()
	local moho = helper:MohoObject()
	local doc = moho.document
	local layer = moho.layer
	local lDrawing = moho.drawingLayer
	local lFrame = moho.layerFrame
	local mesh = moho:DrawingMesh()
	local shape = moho:SelectedShape()
	local shapes = mesh:CountShapes()
	local shapeID = shape and mesh:ShapeID(shape) or -1
	--local vHeight = moho.view:Height()
	
	if (mesh == nil) then
		helper:delete()
		return
	end

	local style = moho:CurrentEditStyle()
	local shape = moho:SelectedShape()
	if (style == nil and shape == nil) then
		return
	end

	local undoable = true
	if (msg == self.CHANGE or msg == self.BASE_SHAPE or msg == self.TOP_SHAPE or msg == self.SELECTALL or msg == self.SELECTALL_ALT or (msg >= self.FILL and msg <= self.FILLOUTLINE_ALT)) then
		undoable = false
	end
	if (undoable) then
		doc:PrepUndo(moho.drawingLayer)
		doc:SetDirty()
	end

	--if (msg == self.BEGIN) then
		--self.dlog.shapes = mesh:CountShapes()
	--elseif (msg == self.CHANGE) then --??
		-- Nothing really happens here - it is a message that came from the popup dialog.
		-- However, the important thing is that this message then flows back into the Moho app, forcing a redraw.
		--moho:UpdateUI()
	--end

	if (msg == self.CHANGE) then
		if self.skipBlock == true then -- Try to avoid unwanted call to Update/UpdateWidgets bellow upon selecting, no matter how, a list item!
			return --20230920-2103: Commented, since it seems to make dialog widgets not update propertly... 
		end

		shapeID = self.shapeList:SelItem() > 0 and mesh:CountShapes() - self.shapeList:SelItem() or -1
		for i = 1, self.shapeList:CountItems() - 1 do
			local shape = mesh:Shape(mesh:CountShapes() - i)
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
		self.shapeName:SetValue(self.shapeList:SelItem() > 0 and mesh:Shape(mesh:CountShapes() - self.shapeList:SelItem()):Name() or "")
		self.raise:Enable(self.shapeList:SelItem() > 1)
		self.lower:Enable(self.shapeList:SelItem() > 0 and self.shapeList:SelItem() < self.shapeList:CountItems() - 1)
		--layer:UpdateCurFrame(true)
		--layer:UpdateCurFrame()
		
		MOHO.Redraw()
		moho:UpdateUI()
		--[[Other tries of updating the toolbar without any success...
		--self:UpdateWidgets()
		--doc:Refresh()
		--doc:PrepUndo(layer, true)
		--doc:Undo()
		--moho:SetCurFrame(0)
		--moho:UpdateUI()
		--]]
	elseif (msg == self.NAME) then
		--doc:PrepUndo(layer)
		--doc:SetDirty()
		if shapeID and shapeID >= 0 then
			local shape = mesh:Shape(shapeID)
			shape:SetName(self.shapeName:Value())
		end
		self:Update()
	elseif (msg == self.COMBINE_NORMAL) then
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fComboMode = MOHO.COMBO_NORMAL
			end
		end
		lDrawing:UpdateCurFrame(false)
		self:Update()
		moho:UpdateUI()
		moho.view:DrawMe()
		MOHO.Redraw()
	elseif (msg == self.COMBINE_ADD) then
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fComboMode = MOHO.COMBO_ADD
			end
		end
		lDrawing:UpdateCurFrame(false)
		self:Update()
		moho:UpdateUI()
		moho.view:DrawMe()
		MOHO.Redraw()
	elseif (msg == self.COMBINE_SUBTRACT) then
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fComboMode = MOHO.COMBO_SUBTRACT
			end
		end
		lDrawing:UpdateCurFrame(false)
		self:Update()
		moho:UpdateUI()
		moho.view:DrawMe()
		MOHO.Redraw()
	elseif (msg == self.COMBINE_INTERSECT) then
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fComboMode = MOHO.COMBO_INTERSECT
			end
		end
		lDrawing:UpdateCurFrame(false)
		self:Update()
		moho:UpdateUI()
		moho.view:DrawMe()
		MOHO.Redraw()
	elseif (msg == self.COMBINE_BLEND) then
		local blend = self.combineBlend:FloatValue()
		blend = LM.Clamp(blend, 0.0, 1.0)
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fComboBlend:SetValue(moho.drawingLayerFrame, blend)
			end
		end
		lDrawing:UpdateCurFrame(false)
		self:Update()
		moho:UpdateUI()
		moho.view:DrawMe()
		MOHO.Redraw()
	elseif (msg == self.BASE_SHAPE) then
		LM_SelectShape:HandleMessage(moho, moho.view, LM_SelectShape.BASE_SHAPE)
		moho:UpdateUI()
	elseif (msg == self.TOP_SHAPE) then
		LM_SelectShape:HandleMessage(moho, moho.view, LM_SelectShape.TOP_SHAPE)
	elseif (msg == self.MERGE) then
		LM_SelectShape:MergeShapes(moho, moho.view)
	elseif (msg == self.RAISE or msg == self.RAISE_ALT) then
		doc:PrepUndo(layer)
		doc:SetDirty()
		for i = mesh:CountShapes() - 1, 0, -1 do
			if (mesh:Shape(i).fSelected) then
				mesh:RaiseShape(i, msg == self.RAISE_ALT)
			end
		end
		self:Update()
		MOHO.Redraw()
	elseif (msg == self.LOWER or msg == self.LOWER_ALT) then
		doc:PrepUndo(layer)
		doc:SetDirty()
		for i = 0, mesh:CountShapes() - 1 do
			if (mesh:Shape(i).fSelected) then
				mesh:LowerShape(i, msg == self.LOWER_ALT)
			end
		end
		self:Update()
		MOHO.Redraw()

	elseif (msg == self.FILLED) then
		---[[LM_SelectShape:HandleMessage(moho, moho.view, LM_SelectShape.FILL)
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
		MOHO.Redraw()
		moho:UpdateUI()
		--]]
	elseif (msg == self.FILLEDCOLOR) then
		if (style ~= nil) then
			style.fFillCol:SetValue(moho.drawingLayerFrame, self.fillCol:Value())
		end
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fMyStyle.fFillCol:SetValue(moho.drawingLayerFrame, self.fillCol:Value())
			end
		end
		MOHO.Redraw()
		moho:UpdateUI()
	elseif (msg == self.LINED) then
		---[[LM_SelectShape:HandleMessage(moho, moho.view, LM_SelectShape.LINE)
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
		MOHO.Redraw()
		moho:UpdateUI()
		--]]
	elseif (msg == self.LINEDCOLOR) then
		if (style ~= nil) then
			style.fLineCol:SetValue(moho.drawingLayerFrame, self.lineCol:Value())
		end
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fMyStyle.fLineCol:SetValue(moho.drawingLayerFrame, self.lineCol:Value())
			end
		end
		MOHO.Redraw()
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
		MOHO.Redraw()
		moho:UpdateUI()
	elseif (msg == self.ROUNDCAPS) then
		if (style ~= nil) then
			style.fLineCaps = self.capsBut:Value() and 1 or 0
		end
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fMyStyle.fLineCaps = self.capsBut:Value() and 1 or 0
			end
		end
		MOHO.Redraw()
		moho:UpdateUI()
	elseif (msg == self.RESETSTYLE) then
		LM.Beep()
	elseif (msg >= self.FILL and msg <= self.FILLOUTLINE_ALT) then
		local m = msg - self.FILL
		local creationMode = LM_CreateShape.creationMode
		LM_CreateShape.creationMode = math.floor(m / 2) --- #self.shapeButtons
		LM_CreateShape:HandleMessage(moho, moho.view, msg % 2 == 0 and LM_CreateShape.CREATE or LM_CreateShape.CREATE_CONNECTED)
		LM_CreateShape.creationMode = creationMode
		moho:UpdateUI()
	elseif (msg == self.DELETE) then
		local i = 0
		while i < mesh:CountShapes() do
			if (mesh:Shape(i).fSelected) then
				mesh:DeleteShape(i)
			else
				i = i + 1
			end
		end
		self:Update()
		moho.view:DrawMe()
	elseif (msg == self.SELECTALL) then
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			shape.fSelected = true
		end
		self:Update()
		MOHO.Redraw()
		--moho:UpdateUI()
	elseif (msg == self.SELECTALL_ALT) then
		--"TO-DO")
	elseif (msg == self.OPTIONS_MENU) then
	elseif (msg == self.OPTIONS_MENU + 1) then
	elseif (msg == self.OPTIONS_MENU + 2) then
	elseif (msg == self.OPTIONS_MENU + 3) then
	elseif (msg == self.OPTIONS_MENU + 4) then --Restore Defaults
		local alert = LM.GUI.Alert(LM.GUI.ALERT_QUESTION, MOHO.Localize("/Dialogs/Preferences/ToolPrefs/RestoreDefaults=Restore Factory Defaults") .. "?", nil, nil, MOHO.Localize("/Dialogs/ProjectSettings/RestoreDefaults=Restore Defaults"):gmatch("%w+")(), MOHO.Localize("/Strings/Cancel=Cancel"), nil) --OK: 0, Cancel: 1
		if alert == 0 then
			RL_ShapesWindow:ResetPrefs()
		end
	elseif (msg == self.OPTIONS_MENU + 5) then -- Acknowledgements
		local alert = LM.GUI.Alert(LM.GUI.ALERT_INFO, "My sincere thanks to... ", "    - Lukas Krepel \n\n    - Stan (from 2danimator.ru) \n\n    - Wes (synthsin75) \n\n    - Paul (hayasidist) \n\n    - Sam (SimplSam) \n\n    - And, yeah, Microsoft's Bing AI... \n\n", "\n And, of course, to the Lost Marble & Moho® Team.", MOHO.Localize("/Menus/File/CloseRender=Close"), nil, nil)
	elseif (msg == self.OPTIONS_MENU + 6) then -- About...
	end
	--moho:UpdateUI()
	helper:delete()
end

-- **************************************************
-- The guts of this script
-- **************************************************

function RL_ShapesWindow:IsEnabled(moho)
	if (moho:CountShapes() > 0) then
		return true
	end
	return false
end

function RL_ShapesWindow:IsRelevant(moho)
	local mesh = moho:DrawingMesh()
	if (mesh == nil) then
		return false
	end
	return true
end

function RL_ShapesWindow:Run(moho)
	if self.dlog == nil then
		self.dlog = RL_ShapesWindowDialog:new(moho)
		--self.dlog.shapeTable = {}
		self.dlog:DoModeless()
	end
end

function RL_ShapesWindow.Abbreviate(s)
	local num = 0
	local abrev = string.gsub(s, "%a+", function(w) if #w > 4 then num = num + 1 return string.sub(w, 1, 3) .. "." else return w end end)
	return abrev, num
end
