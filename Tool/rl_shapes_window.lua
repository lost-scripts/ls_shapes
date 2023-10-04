-- **************************************************
-- Provide Moho with the name of this script object
-- **************************************************

ScriptName = "RL_ShapesWindow"

--[[ ***** Licence & Warranty *****

	Copyright © 2022 - Rai López (Lost Scripts™)

	Licensed under the Apache License, Version 2.0 (the "License");
	you may not use this file except in compliance with the License.
	You may obtain a copy of the License at:

		http://www.apache.org/licenses/LICENSE-2.0

	Conditions require preservation of copyright and license notices.

	You must retain, in the Source form of any Derivative Works that
	You distribute, all copyright, patent, trademark, and attribution
	notices from the Source form of the Work, excluding those notices
	that do not pertain to any part of the Derivative Works.

	You can:
		Use   - use/reuse freely, even commercially
		Adapt - remix, transform, and build upon for any purpose
		Share - redistribute the material in any medium or format

	Adapt / Share under the following terms:
		Attribution - You must give appropriate credit, provide a link to
		the Apache 2.0 license, and indicate if changes were made. You may
		do so in any reasonable manner, but not in any way that suggests
		the licensor endorses you or your use.

	Licensed works, modifications and larger works may be distributed
	under different License terms and without source code.

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

	The Developer Rai López will not be liable for any direct,
	indirect or consequential loss of actual or anticipated - data, revenue,
	profits, business, trade or goodwill that is suffered as a result of the
	use of the software provided.
--]]

-- **************************************************
-- General information about this script
-- **************************************************

RL_ShapesWindow = {}

RL_ShapesWindow.BASE_STR = 2320

function RL_ShapesWindow:Name()
	return "Shapes Window"
end

function RL_ShapesWindow:Version()
	return "0.0.1.20230927.0409"
end

function RL_ShapesWindow:Description()
	return MOHO.Localize("/Scripts/Tool/SelectShape/Description=\"Shapes Window\" says it all :)")
end

function RL_ShapesWindow:Creator()
	return "©2023 Rai López (Lost Scripts™)" --Rai López (Lost Scripts™)
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
	self.halfDimensions = prefs:GetBool("RL_ShapesWindow.halfDimensions", true)
	self.showTooltips = prefs:GetBool("RL_ShapesWindow.showTooltips", true)
	self.showInfobar = prefs:GetBool("RL_ShapesWindow.showInfobar", true)
	self.alertCantOpen = prefs:GetInt("RL_ShapesWindow.alertCantOpen", 0)
end

function RL_ShapesWindow:SavePrefs(prefs)
	prefs:SetInt("LM_CreateShape.creationMode", self.creationMode)
	prefs:SetBool("RL_ShapesWindow.advancedMode", self.advancedMode)
	prefs:SetBool("RL_ShapesWindow.halfDimensions", self.halfDimensions)
	prefs:SetBool("RL_ShapesWindow.showTooltips", self.showTooltips)
	prefs:SetBool("RL_ShapesWindow.showInfobar", self.showInfobar)
	prefs:SetInt("RL_ShapesWindow.alertCantOpen", self.alertCantOpen)
end

function RL_ShapesWindow:ResetPrefs()
	LM_CreateShape.creationMode = 2
	RL_ShapesWindow.halfDimensions = true --0: Max, 1: Full, 2: Half, 3: Third?
	RL_ShapesWindow.advancedMode = true
	RL_ShapesWindow.showTooltips = true
	RL_ShapesWindow.showInfobar = true
	RL_ShapesWindow.alertCantOpen = 0
end

-- **************************************************
-- Recurring values
-- **************************************************

RL_ShapesWindow.dlog = nil

-- **************************************************
-- Shapes Window dialog
-- **************************************************

local RL_ShapesWindowDialog = {}

RL_ShapesWindowDialog.FILLED				= MOHO.MSG_BASE --LM_CreateShape.CREATE or MOHO.MSG_BASE (pairs)
RL_ShapesWindowDialog.FILLED_ALT			= MOHO.MSG_BASE + 1
RL_ShapesWindowDialog.OUTLINED				= MOHO.MSG_BASE + 2
RL_ShapesWindowDialog.OUTLINED_ALT			= MOHO.MSG_BASE + 3
RL_ShapesWindowDialog.FILLEDOUTLINED		= MOHO.MSG_BASE + 4
RL_ShapesWindowDialog.FILLEDOUTLINED_ALT	= MOHO.MSG_BASE + 5
RL_ShapesWindowDialog.FILL					= MOHO.MSG_BASE + 6
RL_ShapesWindowDialog.FILLCOLOR				= MOHO.MSG_BASE + 7
RL_ShapesWindowDialog.LINE					= MOHO.MSG_BASE + 8
RL_ShapesWindowDialog.LINECOLOR				= MOHO.MSG_BASE + 9
RL_ShapesWindowDialog.LINEWIDTH				= MOHO.MSG_BASE + 10
RL_ShapesWindowDialog.ROUNDCAPS				= MOHO.MSG_BASE + 11
RL_ShapesWindowDialog.RESET					= MOHO.MSG_BASE + 12
RL_ShapesWindowDialog.RESET_ALT				= MOHO.MSG_BASE + 13

RL_ShapesWindowDialog.NAME					= MOHO.MSG_BASE + 14
RL_ShapesWindowDialog.COMBINE_NORMAL		= MOHO.MSG_BASE + 15
RL_ShapesWindowDialog.COMBINE_ADD			= MOHO.MSG_BASE + 16
RL_ShapesWindowDialog.COMBINE_SUBTRACT		= MOHO.MSG_BASE + 17
RL_ShapesWindowDialog.COMBINE_INTERSECT		= MOHO.MSG_BASE + 18
RL_ShapesWindowDialog.COMBINE_BLEND_BUT		= MOHO.MSG_BASE + 19
RL_ShapesWindowDialog.COMBINE_BLEND_BUT_ALT	= MOHO.MSG_BASE + 20
RL_ShapesWindowDialog.COMBINE_BLEND			= MOHO.MSG_BASE + 21
RL_ShapesWindowDialog.BASE_SHAPE			= MOHO.MSG_BASE + 22
RL_ShapesWindowDialog.BASE_SHAPE_ALT		= MOHO.MSG_BASE + 23
RL_ShapesWindowDialog.TOP_SHAPE				= MOHO.MSG_BASE + 24
RL_ShapesWindowDialog.TOP_SHAPE_ALT			= MOHO.MSG_BASE + 25
RL_ShapesWindowDialog.MERGE					= MOHO.MSG_BASE + 26
RL_ShapesWindowDialog.RAISE					= MOHO.MSG_BASE + 27
RL_ShapesWindowDialog.RAISE_ALT				= MOHO.MSG_BASE + 28
RL_ShapesWindowDialog.LOWER					= MOHO.MSG_BASE + 29
RL_ShapesWindowDialog.LOWER_ALT				= MOHO.MSG_BASE + 30
RL_ShapesWindowDialog.CHANGE				= MOHO.MSG_BASE + 31
RL_ShapesWindowDialog.DELETE				= MOHO.MSG_BASE + 32
RL_ShapesWindowDialog.SELECTALL				= MOHO.MSG_BASE + 33
RL_ShapesWindowDialog.SELECTALL_ALT			= MOHO.MSG_BASE + 34
RL_ShapesWindowDialog.SELECTBASETOP			= MOHO.MSG_BASE + 35
RL_ShapesWindowDialog.SELECTBASETOP_ALT		= MOHO.MSG_BASE + 36
RL_ShapesWindowDialog.OPTIONS_MENU			= MOHO.MSG_BASE + 37

function RL_ShapesWindowDialog:new(moho)
	local d = LM.GUI.SimpleDialog("☰  " .. MOHO.Localize("/Windows/Style/Shapes=Shapes"), RL_ShapesWindowDialog)
	local l = d:GetLayout()
	local w = 132

	d.isNewRun = true
	d.shapeTable = {}
	d.proTable = {}
	d.widgets = {} --wTable?
	d.skipBlock = false
	d.vHeight = moho.view and moho.view:Height() / (RL_ShapesWindow.halfDimensions and 2 or 1) - 132 or 726 --d.vHeight = d.vHeight and d.vHeight - 132 or 726
	d.showTooltips = RL_ShapesWindow.showTooltips
	d.info = ""
	--d.shapes = d.shapes and LM.Clamp(d.shapes + 2, 10, 40) or 20
	l:AddPadding(-12)
	l:Unindent(6)

	l:AddPadding(-18)
	l:PushV(LM.GUI.ALIGN_LEFT, 0)
		l:AddPadding(-4)
		d.optionsMenu = LM.GUI.Menu("…") --⁝☰⚙…
		d.optionsPopup = LM.GUI.PopupMenu(28, false) --56
		--d.optionsPopup:SetToolTip(MOHO.Localize("/Dialogs/LayerSettings/GeneralTab/Options=Options"))
		d.optionsPopup:SetMenu(d.optionsMenu)
		l:AddChild(d.optionsPopup, LM.GUI.ALIGN_LEFT, 0)
		d.optionsMenu:AddItem(MOHO.Localize("/Windows/Style/Advanced=Advanced") .. " (" .. MOHO.Localize("/Scripts/Tool/SelectPoints/Create=Create") .. ")", 0, self.OPTIONS_MENU) d.optionsMenu:SetEnabled(self.OPTIONS_MENU, true)
		d.optionsMenu:AddItem(MOHO.Localize(""), 0, 0)
		d.optionsMenu:AddItem(MOHO.Localize("/Dialogs/ExportSettings/HalfDimensions=Half Dimensions (%dx%d)"):match("[^%(]+"), 0, self.OPTIONS_MENU + 1)
		d.optionsMenu:AddItem(MOHO.Localize(""), 0, 0)
		d.optionsMenu:AddItem(MOHO.Localize("/Windows/LayerComps/ShowComp=Show") .. " " .. "Tooltips", 0, self.OPTIONS_MENU + 2)
		d.optionsMenu:AddItem(MOHO.Localize("/Windows/LayerComps/ShowComp=Show") .. " " .. "Infobar", 0, self.OPTIONS_MENU + 3)
		d.optionsMenu:AddItem(MOHO.Localize(""), 0, 0)
		d.optionsMenu:AddItem(MOHO.Localize("/Dialogs/ProjectSettings/RestoreDefaults=Restore Defaults") .. " [?]", 0, self.OPTIONS_MENU + 4)
		d.optionsMenu:AddItem(MOHO.Localize(""), 0, 0)
		d.optionsMenu:AddItem(MOHO.Localize("/Menus/Help/CheckForUpdates=Check For Updates..."), 0, self.OPTIONS_MENU + 5)
		d.optionsMenu:AddItem(MOHO.Localize(""), 0, 0)
		d.optionsMenu:AddItem(MOHO.Localize("/Scripts/Tool/SelectShape/Acknowledgements=Acknowledgements..."), 0, self.OPTIONS_MENU + 6)
		d.optionsMenu:AddItem(MOHO.Localize("/Menus/Application/About=About") .. "...", 0, self.OPTIONS_MENU + 7)
	
		l:Indent(6)
		l:AddPadding(4)

		l:PushH(LM.GUI.ALIGN_LEFT, 0)
			d.shapeNameLabel = LM.GUI.DynamicText("    ", 18) --"🏷"
			d.shapeNameLabel:SetToolTip(MOHO.Localize("/Windows/Style/Name=Name")) -- .. " (Tab key to confirm)"
			l:AddChild(d.shapeNameLabel, LM.GUI.ALIGN_CENTER)

			d.shapeName = LM.GUI.TextControl(w - 2, "Room For Name", self.NAME, LM.GUI.FIELD_TEXT) --LM.GUI.MSG_OK
			d.shapeName:SetValue("")
			l:AddChild(d.shapeName, LM.GUI.ALIGN_LEFT)
		l:Pop() --H

		l:AddPadding(4)
		l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, 0)
		l:AddPadding(3)

		l:PushH(LM.GUI.ALIGN_LEFT, 0)
			d.liquidShapesLabel = LM.GUI.DynamicText("    ", 18) --" 💧"
			--d.liquidShapesLabel:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/LiquidShapes=Liquid Shapes"))
			l:AddChild(d.liquidShapesLabel, LM.GUI.ALIGN_CENTER)
			l:PushV(LM.GUI.ALIGN_FILL, 0)
				l:PushH(LM.GUI.ALIGN_FILL, 1)
					d.combineNormal = LM.GUI.ImageButton("ScriptResources/combine_normal", MOHO.Localize("/Scripts/Tool/SelectShape/Normal=Normal"), true, self.COMBINE_NORMAL, true)
					d.combineNormal.prop = {v = 14, m = "pro", tooltip = false} table.insert(d.widgets, d.combineNormal)
					l:AddChild(d.combineNormal, LM.GUI.ALIGN_FILL, 0)
					d.combineAdd = LM.GUI.ImageButton("ScriptResources/combine_add", MOHO.Localize("/Scripts/Tool/SelectShape/Add=Add"), true, self.COMBINE_ADD, true)
					d.combineAdd.prop = {v = 14, m = "pro", tooltip = false} table.insert(d.widgets, d.combineAdd)
					l:AddChild(d.combineAdd, LM.GUI.ALIGN_FILL, 0)
					d.combineSubtract = LM.GUI.ImageButton("ScriptResources/combine_subtract", MOHO.Localize("/Scripts/Tool/SelectShape/Subtract=Subtract"), true, self.COMBINE_SUBTRACT, true)
					table.insert(d.proTable, d.combineSubtract)
					l:AddChild(d.combineSubtract, LM.GUI.ALIGN_FILL, 0)
					d.combineIntersect = LM.GUI.ImageButton("ScriptResources/combine_intersect", MOHO.Localize("/Scripts/Tool/SelectShape/Clip=Clip"), true, self.COMBINE_INTERSECT, true)
					table.insert(d.proTable, d.combineIntersect)
					l:AddChild(d.combineIntersect, LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(2)
					l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL)
					l:AddPadding(0)

					d.mergeBut = LM.GUI.ImageButton("ScriptResources/../mesh_type", MOHO.Localize("/Scripts/Tool/SelectShape/MergeCluster=Merge a Liquid Shape into a single shape"), false, self.MERGE, true) --ↀ⊖⋈⩇⩉θΣϴϻϺ
					table.insert(d.proTable, d.mergeBut)
					l:AddChild(d.mergeBut, LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(1)
				l:Pop() --H
				l:AddPadding(4)
				l:PushH(LM.GUI.ALIGN_FILL, 0)
					--d.baseTopBut = LM.GUI.ImageButton("ScriptResources/../curs_vresize", MOHO.Localize("/Scripts/Tool/SelectShape/SelectTopOfCluster=Select top of Liquid Shape") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/SelectShape/SelectBottomOfCluster=Select bottom of Liquid Shape") .. ")", false, self.SELECTBASETOP, false)
					--d.baseTopBut:SetAlternateMessage(self.SELECTBASETOP_ALT)
					--l:AddChild(d.baseTopBut, LM.GUI.ALIGN_FILL, 0)
					d.combineBlendBut = LM.GUI.ImageButton("ScriptResources/../lib_moho/channel_blend", MOHO.Localize("/Scripts/Tool/SelectShape/Blend=Blend:"):gsub("[^%w]$", "") .. " (<alt> " .. MOHO.Localize("/Windows/Style/Reset=Reset") .. ")", true, self.COMBINE_BLEND_BUT, true) --<alt> Select Cluster
					d.combineBlendBut:SetAlternateMessage(self.COMBINE_BLEND_BUT_ALT)
					l:AddChild(d.combineBlendBut, LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(-1)
					d.combineBlend = LM.GUI.TextControl(0, "00.0", self.COMBINE_BLEND, LM.GUI.FIELD_UFLOAT) --≈≋
					--d.combineBlend:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/Blend=Blend:"):gsub("[^%w]$", "")) --Remove any non-alphanumeric ending character
					d.combineBlend:SetPercentageMode(true)
					d.combineBlend:SetWheelInc(1.0)
					table.insert(d.proTable, d.combineBlend)
					l:AddChild(d.combineBlend)
					--d.combineBlendLabel = LM.GUI.StaticText(" ≈")
					--d.combineBlendLabel:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/Blend=Blend:"):gsub("[^%w]$", ""))
					--l:AddChild(d.combineBlendLabel, LM.GUI.ALIGN_CENTER, 0)
					l:AddPadding(0)

					d.baseBut = LM.GUI.ImageButton("ScriptResources/select_cluster_bottom", MOHO.Localize("/Scripts/Tool/SelectShape/SelectBottomOfCluster=Select bottom of Liquid Shape") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All") .. ")", false, self.BASE_SHAPE, true)
					d.baseBut:SetAlternateMessage(self.BASE_SHAPE_ALT)
					--d.baseBut:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/SelectBottomOfCluster=Select bottom of Liquid Shape"))
					table.insert(d.proTable, d.baseBut)
					l:AddChild(d.baseBut, LM.GUI.ALIGN_FILL, 0)
			
					d.topBut = LM.GUI.ImageButton("ScriptResources/select_cluster_top", MOHO.Localize("/Scripts/Tool/SelectShape/SelectTopOfCluster=Select top of Liquid Shape") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All") .. ")", false, self.TOP_SHAPE, true)
					d.topBut:SetAlternateMessage(self.TOP_SHAPE_ALT)
					--d.topBut:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/SelectTopOfCluster=Select top of Liquid Shape"))
					table.insert(d.proTable, d.topBut)
					l:AddChild(d.topBut, LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(1)

					--[[
					l:AddPadding(4)
					l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(0)

					d.selectAllBut = LM.GUI.ImageButton("ScriptResources/../lib_moho/channel_shape_order", MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All") .. " (<alt> " .. MOHO.Localize("/Menus/Edit/SelectConnected=Select Connected") .. ")", false, self.SELECTALL, true) --<alt> Select Cluster
					d.selectAllBut:SetAlternateMessage(self.SELECTALL_ALT)
					l:AddChild(d.selectAllBut, LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(4)

					d.deleteBut = LM.GUI.ImageButton("ScriptResources/../action_del", MOHO.Localize("/Scripts/Tool/DeleteShape/DeleteShape=Delete Shape") .. "/s", false, self.DELETE, true) --ScriptResources/../layer_mask_minus@2x --"<alt> Delete entire Liquid Shape"
					l:AddChild(d.deleteBut, LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(1)
					--]]
				l:Pop() --H
				l:AddPadding(-d.shapeName:Height())
				d.dumbLabel1 = LM.GUI.DynamicText("", d.shapeName:Width())
				l:AddChild(d.dumbLabel1, LM.GUI.ALIGN_CENTER)
			l:Pop() --V
		l:Pop() --H

		l:AddPadding(4)
		l:Unindent(6)

		l:PushH(LM.GUI.ALIGN_FILL, 4)
			l:Indent(6)
			--l:AddPadding(-3) --20231003
			l:PushV(LM.GUI.ALIGN_TOP, 0)
				--l:AddPadding(-2)
				--d.shapePaletteLabel = LM.GUI.DynamicText(" ≡", 0)
				--d.shapePaletteLabel:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/ShapePalette=Shape Palette"))
				--l:AddChild(d.shapePaletteLabel, LM.GUI.ALIGN_CENTER, 4)
				--l:AddPadding(2)
				l:PushH(LM.GUI.ALIGN_CENTER, 0)
					l:AddPadding(-1)
					l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL, 24)
					d.raise = LM.GUI.ImageButton("ScriptResources/../curs_vresize_up", MOHO.Localize("/Menus/Draw/RaiseShape=Raise Shape") .. " (<alt> " .. MOHO.Localize("/Menus/Draw/RaiseToFront=Raise To Front") .. ")", false, self.RAISE, false)
					d.raise:SetAlternateMessage(self.RAISE_ALT)
					l:AddChild(d.raise, LM.GUI.ALIGN_FILL, 0)

				l:Pop() --H
				l:PushH(LM.GUI.ALIGN_CENTER, 0)
					l:AddPadding(-1)
					l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL, 24)
					d.lower = LM.GUI.ImageButton("ScriptResources/../curs_vresize_down", MOHO.Localize("/Menus/Draw/LowerShape=Lower Shape") .. " (<alt> " .. MOHO.Localize("/Menus/Draw/LowerToBack=Lower To Back") .. ")", false, self.LOWER, false)
					d.lower:SetAlternateMessage(self.LOWER_ALT)
					l:AddChild(d.lower, LM.GUI.ALIGN_FILL, 0)
				l:Pop() --H
				l:AddPadding(-1)
				--l:PushH(LM.GUI.ALIGN_RIGHT, 8)
					--l:AddPadding(-8)
					--l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, 0)
				--l:Pop() --H
			l:Pop() --V
			l:AddPadding(-d.raise:Width() - 11)
			l:PushV(LM.GUI.ALIGN_BOTTOM, 0)
				l:PushH(LM.GUI.ALIGN_CENTER, 0)
					l:AddPadding(-1)
					l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL, 2)
					d.selectAllBut = LM.GUI.ImageButton("ScriptResources/../fbf_type", MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All") .. " (<alt> " .. MOHO.Localize("/Menus/Edit/SelectInverse=Select Inverse") .. ")", false, self.SELECTALL, false) --<alt> Select Cluster --ScriptResources/../../Support/Scripts/Tool/lm_create_shape_cursor
					d.selectAllBut:SetAlternateMessage(self.SELECTALL_ALT)
					l:AddChild(d.selectAllBut, LM.GUI.ALIGN_FILL)
				l:Pop() --H
				l:AddPadding(6)
				l:PushH(LM.GUI.ALIGN_CENTER, 0)
					l:AddPadding(-1)
					l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL, 2)
					--d.deleteBut = LM.GUI.ImageButton("ScriptResources/../action_del", MOHO.Localize("/Scripts/Tool/DeleteShape/DeleteShape=Delete Shape") .. "/s", false, self.DELETE, true) --"<alt> Delete entire Liquid Shape"
					d.deleteBut = LM.GUI.ImageButton("ScriptResources/../channel_off", MOHO.Localize("/Scripts/Tool/DeleteShape/DeleteShape=Delete Shape") .. "/s", false, self.DELETE, true)
					l:AddChild(d.deleteBut, LM.GUI.ALIGN_FILL, 0)
				l:Pop() --H

				l:AddPadding(6)
				l:PushH(LM.GUI.ALIGN_RIGHT, 8)
					l:AddPadding(-8)
					l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, 0)
				l:Pop() --H
				l:AddPadding(6)

				l:PushH(LM.GUI.ALIGN_CENTER, 0)
					l:AddPadding(-1)
					l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL, 2)
					d.copyBut = LM.GUI.ImageButton("ScriptResources/../dragCursor", MOHO.Localize("/Windows/Library/Copy=Copy"), false, self.COPY, false)
					l:AddChild(d.copyBut, LM.GUI.ALIGN_FILL, 0)
				l:Pop() --H
				l:AddPadding(2)
				l:PushH(LM.GUI.ALIGN_CENTER, 0)
					l:AddPadding(-1)
					l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL, 2)
					d.pasteBut = LM.GUI.ImageButton("ScriptResources/../dropCursor", MOHO.Localize("/Windows/Style/Paste=Paste"), false, self.PASTE, false)
					l:AddChild(d.pasteBut, LM.GUI.ALIGN_FILL, 0)
				l:Pop() --H
				l:AddPadding(2)
				l:PushH(LM.GUI.ALIGN_CENTER, 0)
					l:AddPadding(-1)
					l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL, 2)
					d.resetBut = LM.GUI.ImageButton("ScriptResources/../lm_widgets/refreshButtonImage_1", MOHO.Localize("/Windows/Style/Reset=Reset"), false, self.RESET, true) --ScriptResources/rotate_cursor
					l:AddChild(d.resetBut, LM.GUI.ALIGN_FILL, 0)
				l:Pop() --H
			l:Pop() --V

			l:AddPadding(-10)
			l:PushH(LM.GUI.ALIGN_LEFT, 0)
				local iHeight = d.shapeName:Height()
				local wHeight = d.vHeight % iHeight == 0 and d.vHeight or d.vHeight + (iHeight - d.vHeight % iHeight) + 2 --try to ensure last item always fits
				--local wHeight = (d.shapeName:Height() * d.shapes < d.vHeight) and d.shapeName:Height() * d.shapes or d.vHeight --try to addapt to viewport height
				--l:AddPadding(-1)
				d.shapeList = LM.GUI.ImageTextList(w, wHeight, self.CHANGE) --175
				d.shapeList:SetAllowsMultipleSelection(true)
				d.shapeList:SetDrawsPrimarySelection(true)
				d.shapeList:AddItem((" "):rep(11) .. MOHO.Localize("/Windows/Style/None=<Nada>"), false)
				d.shapeList:ScrollItemIntoView(d.shapeID or 0, false)
				l:AddChild(d.shapeList, LM.GUI.ALIGN_FILL)
			l:Pop() --H
		l:Pop() --H
		--l:AddPadding(-1)
		--l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, 0)
		l:AddPadding(4)

		l:PushH(LM.GUI.ALIGN_LEFT, 0)
			d.shapeCreationLabel = LM.GUI.DynamicText("    ", 18) --" ©"
			--d.shapeCreationLabel:SetToolTip(MOHO.Localize("/Scripts/Tool/CreateShape/CreateShape=Create Shape") .." (" .. MOHO.Localize("/Windows/Style/Advanced=Advanced") .. ")")
			l:AddChild(d.shapeCreationLabel, LM.GUI.ALIGN_CENTER, 0)
			l:PushV(LM.GUI.ALIGN_FILL, 0)
				l:PushH(LM.GUI.ALIGN_FILL, 0)
					d.fillCheck = LM.GUI.ImageButton("ScriptResources/../lib_moho/channel_fill", MOHO.Localize("/Scripts/Tool/SelectShape/Fill=Fill:"):gsub("[^%w]$", ""), true, self.FILL, true)
					l:AddChild(d.fillCheck, LM.GUI.ALIGN_FILL)
					l:AddPadding(-1)
					l:PushH(LM.GUI.ALIGN_FILL, 0)
						l:AddPadding(-20)
						d.fillCol = LM.GUI.ShortColorSwatch(true, self.FILLCOLOR)
						l:AddChild(d.fillCol)
					l:Pop() --H

					l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL)
					l:AddPadding(2)

					d.shapeButtons = {}
					table.insert(d.shapeButtons, LM.GUI.ImageButton("ScriptResources/../lib_moho/channel_fill", MOHO.Localize("/Scripts/Tool/SelectPoints/Create=Create") .. " " .. MOHO.Localize("/Scripts/Tool/CreateShape/Fill=Fill") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/CreateShape/ConnectAndCreate=Connect And Create") .. ")", false, self.FILLED, true))
					table.insert(d.shapeButtons, LM.GUI.ImageButton("ScriptResources/../lib_moho/channel_line", MOHO.Localize("/Scripts/Tool/SelectPoints/Create=Create") .. " " .. MOHO.Localize("/Scripts/Tool/CreateShape/Stroke=Stroke") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/CreateShape/ConnectAndCreate=Connect And Create") .. ")", false, self.OUTLINED, false))
					table.insert(d.shapeButtons, LM.GUI.ImageButton("ScriptResources/../lib_moho/channel_fill", MOHO.Localize("/Scripts/Tool/SelectPoints/Create=Create") .. " " .. MOHO.Localize("/Scripts/Tool/CreateShape/Both=Both") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/CreateShape/ConnectAndCreate=Connect And Create") .. ")", false, self.FILLEDOUTLINED, false))
					l:AddPadding(0)

					for i, but in ipairs(d.shapeButtons) do
						l:AddChild(but, LM.GUI.ALIGN_FILL)
						but:SetAlternateMessage(self.FILLED + (i * 2 - 1))
						l:AddPadding(i < #d.shapeButtons and -2 or 0)
					end
				l:Pop() --H
				l:AddPadding(4)

				l:PushH(LM.GUI.ALIGN_FILL, 0)
					d.lineCheck = LM.GUI.ImageButton("ScriptResources/../lib_moho/channel_line", MOHO.Localize("/Scripts/Tool/SelectShape/Stroke=Stroke:"):gsub("[^%w]$", ""), true, self.LINE, true)
					l:AddChild(d.lineCheck, LM.GUI.ALIGN_FILL)
					l:AddPadding(-1)
					l:PushH(LM.GUI.ALIGN_FILL, 0)
						l:AddPadding(-20)
						d.lineCol = LM.GUI.ShortColorSwatch(true, self.LINECOLOR)
						l:AddChild(d.lineCol)
					l:Pop() --H

					d.widthLabel = LM.GUI.StaticText("ø")
					d.widthLabel:SetToolTip(MOHO.Localize("/Dialogs/InsertText/BalloonWidth=Stroke Width"))
					l:AddChild(d.widthLabel, LM.GUI.ALIGN_CENTER, 0)
					l:AddPadding(-1)
					d.lineWidth = LM.GUI.TextControl(0, "00.00", self.LINEWIDTH, LM.GUI.FIELD_UFLOAT) --ø
					d.lineWidth:SetUnits(LM.GUI.UNIT_PIXELS)
					d.lineWidth:SetWheelInc(1.0)
					d.lineWidth:SetWheelInteger(true)
					l:AddChild(d.lineWidth)
					l:AddPadding(0)
					d.capsBut = LM.GUI.ImageButton("ScriptResources/../timeline/mute_channel_on@2x", MOHO.Localize("/Windows/Style/RoundCaps=Round caps"), true, self.ROUNDCAPS, true)
					l:AddChild(d.capsBut, LM.GUI.ALIGN_FILL)
					l:AddPadding(1)

					--[[
					l:AddPadding(4)
					l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(0)

					d.resetStyleBut = LM.GUI.ImageButton("ScriptResources/../lm_widgets/path_delete", MOHO.Localize("/Windows/Style/Reset=Reset"), false, self.RESET, true) --lm_widgets/refreshButtonImage_1 --ScriptResources/rotate_cursor
					d.resetStyleBut:SetAlternateMessage(self.RESET_ALT)
					l:AddChild(d.resetStyleBut, LM.GUI.ALIGN_FILL)
					l:AddPadding(1) --refreshButtonImage_1
					--]]
				l:Pop() --H
			l:Pop() --V
		l:Pop() --H

		if RL_ShapesWindow.showInfobar then
			l:AddPadding(4)
			d.dummyList = LM.GUI.ImageTextList(0, 1, 0)
			l:AddChild(d.dummyList, LM.GUI.ALIGN_FILL, LM.GUI.MSG_CANCEL)
			l:AddPadding(-2)

			l:PushH(LM.GUI.ALIGN_FILL, 2)
				l:AddChild(LM.GUI.StaticText(" ℹ"), LM.GUI.ALIGN_LEFT)
				l:AddPadding(-4)
				d.infobar = LM.GUI.DynamicText("Room For Some Info......", 0)
				l:AddChild(d.infobar, LM.GUI.ALIGN_LEFT, 0)
			l:Pop() --H
		end
	l:Pop() --V

	return d
end

function RL_ShapesWindowDialog:Update(moho) print("RL_ShapesWindowDialog:Update(moho): ", os.clock())
	local helper = MOHO.ScriptInterfaceHelper:new_local()
	local moho = helper:MohoObject()
	local doc = moho.document
	local layer = moho.layer
	local lFrame = moho.layerFrame
	local mesh = moho:DrawingMesh()
	local l = self:GetLayout()

	self.info = ""
	self.optionsMenu:SetChecked(self.OPTIONS_MENU, RL_ShapesWindow.advancedMode)
	self.optionsMenu:SetChecked(self.OPTIONS_MENU + 1, RL_ShapesWindow.halfDimensions)
	self.optionsMenu:SetChecked(self.OPTIONS_MENU + 2, RL_ShapesWindow.showTooltips)
	self.optionsMenu:SetChecked(self.OPTIONS_MENU + 3, RL_ShapesWindow.showInfobar)
	self.shapeNameLabel:Enable(true)
	self.shapeNameLabel:SetValue("🏷")
	self.liquidShapesLabel:SetValue(" 💧")
	self.shapeCreationLabel:SetValue(" ©")

	if (mesh == nil) then
		--l:Enable(false)
		--self.optionsPopup:Enable(true)
		helper:delete()
		return
	else
		--l:Enable(true)
	end

	local shape = moho:SelectedShape()
	local shapes = mesh:CountShapes()
	local shapesSel = moho:CountSelectedShapes(false) --Use this instead LM_SelectShape:CountSelectedShapes??
	local shapeID = shape and mesh:ShapeID(shape) or -1
	local style = moho:CurrentEditStyle()
	if (style ~= nil) then
		self.fillCol:SetValue(style.fFillCol.value)
		self.lineCol:SetValue(style.fLineCol.value)
		self.lineWidth:SetValue(style.fLineWidth * moho.document:Height())
	end

	if (shape ~= nil) then
		self.shapeNameLabel:Enable(not shape.fHidden)
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
					self.combineBlendBut:Enable(lFrame ~= 0)
					self.combineBlendBut:SetValue(shape.fComboBlend:HasKey(lFrame))
					self.combineBlend:Enable(true)
					self.combineBlend:SetValue(shape.fComboBlend.value)
				else
					self.combineBlendBut:Enable(false)
					self.combineBlendBut:SetValue(false)
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
					--self.combineBlendLabel:SetValue(shape.fComboBlend.value > 0 and " 🩸" or " 💧") --??
					--self.baseTopBut:Enable(position > 1 or position < total)
					self.baseBut:Enable(position > 1)
					self.topBut:Enable(position < total)
					self.mergeBut:Enable(true)
					self.info = position .. " / " .. total --self.infobar:SetValue(position .. " / " .. total)
				else
					--self.combineBlendLabel:SetValue(shape.fComboBlend.value > 0 and " 💧" or " 🩸") --??
					--self.baseTopBut:Enable(false)
					self.baseBut:Enable(false)
					self.topBut:Enable(false)
					self.mergeBut:Enable(LM_SelectShape:CountSelectedShapes(moho) > 1)
					self.info = "" --self.infobar:SetValue("")
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
				self.combineBlendBut:Enable(false)
				self.combineBlendBut:SetValue(false)
				self.combineBlend:Enable(false)
				self.combineBlend:SetValue(0.0)
				--self.baseTopBut:Enable(false)
				self.baseBut:Enable(false)
				self.topBut:Enable(false)
				self.mergeBut:Enable(false)
				if self.infobar then
					self.infobar:SetValue("")
				end
			end
		end

		self.deleteBut:Enable(true)
		self.info = (self.info ~= "" and self.info .. " ⸱ " or "")  .. "ID: " .. math.floor(shape:ShapeID()) --string.format("%d", shape:ShapeID()) --•·⸱
		if (RL_ShapesWindow.showInfobar) then
			if self.infobar then
				self.infobar:SetValue(self.info)
			end
		else
			if self.infobar then
				self.infobar:SetValue("")
			end
			self.shapeNameLabel:SetToolTip(MOHO.Localize("/Windows/Style/Name=Name") .. " (" .. self.info .. ")")
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
			self.combineBlendBut:Enable(false)
			self.combineBlendBut:SetValue(false)
			self.combineBlend:Enable(false)
			self.combineBlend:SetValue(0.0)
			--self.baseTopBut:Enable(false)
			self.baseBut:Enable(false)
			self.topBut:Enable(false)
			self.mergeBut:Enable(false)
			if self.infobar then
				self.infobar:SetValue("")
			end
		end

		self.deleteBut:Enable(false)
		--if (self.shapeID ~= nil) then
			--self.shapeID:SetValue("ShapeID: X")
		--end
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
	--self.selectAllBut:SetCursor(LM.GUI.Cursor("ScriptResources/../../Support/Scripts/Tool/lm_create_shape_cursor", 0, 0)) --lm_select_shape_cursor
	--self.resetBut:SetCursor(LM.GUI.Cursor("ScriptResources/../../Support/Scripts/Tool/lm_roll_camera_cursor", 0, 0))

	if (RL_ShapesWindow.showTooltips ~= self.showTooltips) or self.isNewRun then --print("1: " .. tostring(RL_ShapesWindow.showTooltips), ", ", tostring(self.showTooltips))
		self.optionsPopup:SetToolTip(RL_ShapesWindow.showTooltips and MOHO.Localize("/Dialogs/LayerSettings/GeneralTab/Options=Options") or "")
		--self.shapeNameLabel:SetToolTip(MOHO.Localize("/Windows/Style/Name=Name"))
		self.liquidShapesLabel:SetToolTip(RL_ShapesWindow.showTooltips and MOHO.Localize("/Scripts/Tool/SelectShape/LiquidShapes=Liquid Shapes") or "")
		self.combineBlend:SetToolTip(RL_ShapesWindow.showTooltips and MOHO.Localize("/Scripts/Tool/SelectShape/Blend=Blend:"):gsub("[^%w]$", "") .. " (" .. MOHO.Localize("/Dialogs/NudgeDlog/Amount=Amount") ..")" or "") --Remove any non-alphanumeric ending character
		self.baseBut:SetToolTip(RL_ShapesWindow.showTooltips and MOHO.Localize("/Scripts/Tool/SelectShape/SelectBottomOfCluster=Select bottom of Liquid Shape") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All") .. ")" or "")
		self.topBut:SetToolTip(RL_ShapesWindow.showTooltips and MOHO.Localize("/Scripts/Tool/SelectShape/SelectTopOfCluster=Select top of Liquid Shape") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All") .. ")" or "")
		--self.shapePaletteLabel:SetToolTip(RL_ShapesWindow.showTooltips and MOHO.Localize("/Scripts/Tool/SelectShape/ShapePalette=Shape Palette") or "")
		self.shapeCreationLabel:SetToolTip(RL_ShapesWindow.showTooltips and MOHO.Localize("/Scripts/Tool/CreateShape/CreateShape=Create Shape") .." (" .. MOHO.Localize("/Windows/Style/Advanced=Advanced") .. ")" or "")


		self.showTooltips = RL_ShapesWindow.showTooltips
	end

	--[[
	if not MOHO.IsMohoPro() then
		for k, v in ipairs(self.proTable) do --print(tostring(k), ", ", tostring(v), ", ", type(v))
			if type(v) == "userdata" then
				if tostring(v):find("Button") then
					v:SetValue(false)
				elseif tostring(v):find("TextControl") then
					v:SetValue("0")
				end
			end
			v:Enable(false)
			v:SetToolTip(MOHO.Localize("/Application/Exporter/MohoExporterIsAProLevelFeatureOnly=The Moho Exporter is a Pro level feature. You must upgrade to gain access to this feature."):match("(Pro[^%w].*)"))
			v:SetCursor(LM.GUI.Cursor("ScriptResources/disabled_cursor", 0, 0))
		end
	end
	--]]
	
	for k, v in ipairs(self.widgets) do --print(tostring(k), ", ", tostring(v), ", ", type(v))
		if type(v) == "userdata" and not MOHO.IsMohoPro() then
			if tostring(v):find("Button") then
				v:SetValue(false)
			elseif tostring(v):find("TextControl") then
				v:SetValue("0")
			end
		end
		v:Enable(v.moho and v.moho == "pro" or true)
		v:SetToolTip(MOHO.Localize("/Application/Exporter/MohoExporterIsAProLevelFeatureOnly=The Moho Exporter is a Pro level feature. You must upgrade to gain access to this feature."):match("(Pro[^%w].*)"))
		v:SetCursor(LM.GUI.Cursor("ScriptResources/disabled_cursor", 0, 0))
	end

	--[[
	if not MOHO.IsMohoPro() then
		self.shapeNameLabel:Enable(false)
		self.combineNormal:Enable(false)
		self.combineAdd:Enable(false)
		self.combineSubtract:Enable(false)
		self.combineIntersect:Enable(false)
		self.combineBlend:Enable(false)
		self.baseBut:Enable(false)
		self.topBut:Enable(false)
		self.mergeBut:Enable(false)
	end
	--]]
	
	for i = 1, mesh:CountShapes() do --previous shapes state
		local shape = mesh:Shape(i - 1)
		self.shapeTable[i] = shape:Name() .. shape.fComboMode
	end

	self.isNewRun = false
	helper:delete()
end

function RL_ShapesWindowDialog:OnOK()
	local helper = MOHO.ScriptInterfaceHelper:new_local()
	local moho = helper:MohoObject()

	RL_ShapesWindow.dlog = nil -- mark the window closed
	moho:UpdateUI()
	helper:delete()
end

function RL_ShapesWindowDialog_Update(moho) --print("RL_ShapesWindowDialog_Update(moho): ", os.clock())
	if RL_ShapesWindow.dlog then
		RL_ShapesWindow.dlog:Update(moho)
	end
end

-- register the dialog to be updated when changes are made
table.insert(MOHO.UpdateTable, RL_ShapesWindowDialog_Update)

function RL_ShapesWindowDialog:HandleMessage(msg) --print("RL_ShapesWindowDialog:HandleMessage(msg) ", msg)
	local helper = MOHO.ScriptInterfaceHelper:new_local()
	local moho = helper:MohoObject()
	local doc = moho.document
	local layer = moho.layer
	local lFrame = moho.layerFrame
	local lDrawing = moho:LayerAsVector(moho.drawingLayer)
	local lDrawingFrame = moho.drawingLayerFrame
	local mesh = moho:DrawingMesh()
	--local vHeight = moho.view:Height()
	
	if (mesh == nil) then
		helper:delete()
		return
	end

	local style = moho:CurrentEditStyle()
	local shape = moho:SelectedShape()
	local shapes = mesh:CountShapes()
	local shapeID = shape and mesh:ShapeID(shape) or -1
	if (style == nil and shape == nil) then
		helper:delete()
		return
	end

	local undoable = true
	if (msg == self.CHANGE or msg == self.BASE_SHAPE or msg == self.BASE_SHAPE_ALT or msg == self.TOP_SHAPE or msg == self.TOP_SHAPE_ALT or msg == self.SELECTALL or msg == self.SELECTALL_ALT) then
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
		--[=[Other tries of updating the toolbar without any success...
		--self:UpdateWidgets()
		--doc:Refresh()
		--doc:PrepUndo(layer, true)
		--doc:Undo()
		--moho:SetCurFrame(0)
		--moho:UpdateUI()
		--]=]
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
	elseif (msg == self.COMBINE_BLEND_BUT or msg == self.COMBINE_BLEND_BUT_ALT) then
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				if (msg == self.COMBINE_BLEND_BUT) then
					if not shape.fComboBlend:HasKey(lDrawingFrame) then
						shape.fComboBlend:StoreValue()
						MOHO.NewKeyframe(CHANNEL_BLEND_SEL)
					else
						shape.fComboBlend:DeleteKey(lDrawingFrame)
					end
				else
					shape.fComboBlend:SetValue(lDrawingFrame, shape.fComboBlend:GetValue(0))
				end
			end
		end
		--[[
		if not shape.fComboBlend:HasKey(lDrawingFrame) then
			shape.fComboBlend:StoreValue()
			MOHO.NewKeyframe(CHANNEL_BLEND_SEL)
		else
			if (lDrawingFrame ~= 0) then
				shape.fComboBlend:DeleteKey(lDrawingFrame)
			end
		end
		--]]
		self:Update()
		moho:UpdateUI()
	elseif (msg == self.COMBINE_BLEND) then
		local blend = self.combineBlend:FloatValue()
		blend = LM.Clamp(blend, 0.0, 1.0)
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fComboBlend:SetValue(lDrawingFrame, blend)
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
	elseif (msg == self.BASE_SHAPE_ALT or msg == self.TOP_SHAPE_ALT) then --TODO: Use ALT for moving above/bellow the upper/under cluster instead??
		if (shape:IsInCluster()) then
			local clusterShape = shape:BottomOfCluster()
			while (clusterShape ~= nil) do
				clusterShape.fSelected = true
				clusterShape = clusterShape:NextInCluster()
			end
		else
			LM.Beep()
		end
		MOHO.Redraw()
		self:Update()
	elseif (msg == self.MERGE) then
		LM_SelectShape:MergeShapes(moho, moho.view)
		MOHO.Redraw()
	elseif (msg == self.RAISE or msg == self.RAISE_ALT) then
		for i = mesh:CountShapes() - 1, 0, -1 do
			if (mesh:Shape(i).fSelected) then
				mesh:RaiseShape(i, msg == self.RAISE_ALT)
			end
		end
		self:Update()
		MOHO.Redraw()
	elseif (msg == self.LOWER or msg == self.LOWER_ALT) then
		for i = 0, mesh:CountShapes() - 1 do
			if (mesh:Shape(i).fSelected) then
				mesh:LowerShape(i, msg == self.LOWER_ALT)
			end
		end
		self:Update()
		MOHO.Redraw()
	elseif (msg == self.FILL) then
		---[=[LM_SelectShape:HandleMessage(moho, moho.view, LM_SelectShape.FILL)
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
		--]=]
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
		MOHO.Redraw()
		moho:UpdateUI()
	elseif (msg == self.LINE) then
		---[=[LM_SelectShape:HandleMessage(moho, moho.view, LM_SelectShape.LINE)
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
		--]=]
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
	elseif (msg == self.RESET) or (msg == self.RESET_ALT) then
		local MohoLineWidth = 0.005556 --Factory default value * 2 = 8px (No MohoGlobal??)
		if (style ~= nil) then
			--style.fFillCol:SetValue(moho.drawingLayerFrame, MOHO.MohoGlobals.FillCol)
			--style.fLineCol:SetValue(moho.drawingLayerFrame, MOHO.MohoGlobals.LineCol)
			--style.fLineWidth = MohoLineWidth * 2
			--style.fLineCaps = 1
		end
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				if moho.drawingLayerFrame == 0 then
					shape.fMyStyle.fFillCol:SetValue(moho.drawingLayerFrame, MOHO.MohoGlobals.FillCol)
					shape.fMyStyle.fLineCol:SetValue(moho.drawingLayerFrame, MOHO.MohoGlobals.LineCol)
					shape.fMyStyle.fLineWidth = MohoLineWidth * 2
					shape.fMyStyle.fLineCaps = 1
					shape.f3DThickness:SetValue(moho.drawingLayerFrame, 0.1250)
					if msg == self.RESET_ALT then
						shape:MakePlain() --shape:RemoveStyles()
					end
				else
					if shape.fHasFill == true then
						shape.fMyStyle.fFillCol:SetValue(moho.drawingLayerFrame, shape.fMyStyle.fFillCol:GetValue(0))
						if msg == self.RESET_ALT then
							shape.fMyStyle.fFillCol:SetValue(moho.drawingLayerFrame, MOHO.MohoGlobals.FillCol)
						end
					end
					if shape.fHasOutline == true then
						shape.fMyStyle.fLineCol:SetValue(moho.drawingLayerFrame, shape.fMyStyle.fLineCol:GetValue(0))
						if msg == self.RESET_ALT then
							shape.fMyStyle.fLineCol:SetValue(moho.drawingLayerFrame, MOHO.MohoGlobals.LineCol)
						end
					end
					if (lDrawing.f3DMode ~= MOHO.VECTOR3D_NONE and lDrawing.f3DMode ~= MOHO.VECTOR3D_LATHE) then
						if msg == self.RESET_ALT then
							shape.f3DThickness:SetValue(moho.drawingLayerFrame, 0.1250) -- */ moho.document:Height())
						else
							if shape.f3DThickness:Duration() > 0 and (shape.f3DThickness:GetValue(moho.drawingLayerFrame) ~= shape.f3DThickness:GetValue(0)) then
								shape.f3DThickness:SetValue(moho.drawingLayerFrame, shape.f3DThickness:GetValue(0))
							end
						end
					end
					if shape.fEffectOffset:Duration() > 0 then
						shape.fEffectOffset:SetValue(moho.drawingLayerFrame, shape.fEffectOffset:GetValue(0))
					end
					if shape.fEffectRotation:Duration() > 0 then
						shape.fEffectRotation:SetValue(moho.drawingLayerFrame, shape.fEffectRotation:GetValue(0))
					end
					if shape.fEffectScale:Duration() > 0 then
						shape.fEffectScale:SetValue(moho.drawingLayerFrame, shape.fEffectScale:GetValue(0))
					end
				end
			end
		end
		MOHO.Redraw()
		moho:UpdateUI()
	elseif (msg >= self.FILLED and msg <= self.FILLEDOUTLINED_ALT) then
		local m = msg - self.FILLED
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
	elseif (msg == self.SELECTALL or msg == self.SELECTALL_ALT) then
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			shape.fSelected = (msg == self.SELECTALL and true) or not shape.fSelected
		end
		self:Update()
		MOHO.Redraw()
	elseif (msg >= self.OPTIONS_MENU and msg <= self.OPTIONS_MENU + 7) then
		if (msg == self.OPTIONS_MENU) then --Advanced
			RL_ShapesWindow.advancedMode = not RL_ShapesWindow.advancedMode
		elseif (msg == self.OPTIONS_MENU + 1) then --Half Dimensions
			RL_ShapesWindow.halfDimensions = not RL_ShapesWindow.halfDimensions
		elseif (msg == self.OPTIONS_MENU + 2) then --Show Tooltips
			RL_ShapesWindow.showTooltips = not RL_ShapesWindow.showTooltips
		elseif (msg == self.OPTIONS_MENU + 3) then --Show Infobar
			RL_ShapesWindow.showInfobar = not RL_ShapesWindow.showInfobar
			--self:Update()
		elseif (msg == self.OPTIONS_MENU + 4) then --Restore Defaults [?]
			local alert = LM.GUI.Alert(LM.GUI.ALERT_QUESTION, RL_ShapesWindow:UILabel() .. ": " .. MOHO.Localize("/Dialogs/Preferences/ToolPrefs/RestoreDefaults=Restore Factory Defaults") .. "?", nil, nil, MOHO.Localize("/Dialogs/ProjectSettings/RestoreDefaults=Restore Defaults"):gmatch("%w+")(), MOHO.Localize("/Strings/Cancel=Cancel"), nil) --OK: 0, Cancel: 1
			if alert == 0 then
				RL_ShapesWindow:ResetPrefs()
			end
		elseif (msg == self.OPTIONS_MENU + 5) then --Check For Updates...
		elseif (msg == self.OPTIONS_MENU + 6) then -- Acknowledgements...
			local alert = LM.GUI.Alert(LM.GUI.ALERT_INFO, "My sincere thanks to... ", "    - Lukas Krepel \n\n    - Stan (from 2danimator.ru) \n\n    - Wes (synthsin75) \n\n    - Paul (hayasidist) \n\n    - Sam (SimplSam) \n\n    - Yeah, OpenAI/Microsoft's Bing AI... \n\n", "\nAnd, of course, to the Lost Marble & Moho® Team.", MOHO.Localize("/Menus/File/CloseRender=Close"))
		elseif (msg == self.OPTIONS_MENU + 7) then -- About...
			local alert = LM.GUI.Alert(LM.GUI.ALERT_INFO, RL_ShapesWindow:UILabel(), "    - Version: " .. RL_ShapesWindow:Version() .. " \n\n " .. "    - Creator: " .. RL_ShapesWindow:Creator() .. " \n\n ", "\nLicensed under the Apache License, Version 2.0", MOHO.Localize("/Menus/File/CloseRender=Close")) --This script is freeware and released under the GNU General Public License. --Licensed under the MIT License.
		end
		self:Update()
	end
	--moho:UpdateUI()
	helper:delete()
end

-- **************************************************
-- The guts of this script
-- **************************************************

function RL_ShapesWindow:IsEnabled(moho)
	if (RL_ShapesWindow.dlog == nil) then
		return true
	end
	return false
end

function RL_ShapesWindow:IsRelevant(moho)
	if self:CompareVersion(moho:AppVersion(), 14.0) < 0 then
		return false
	end
	return true
end

function RL_ShapesWindow:Run(moho)
	if self.dlog == nil then
		---[[20230929-2230: Throw warning test (WIP)
		local reminder = ""
		if self.prevClock and (os.clock() - self.prevClock) * 1000 < 300 * (speedFactor or 1) then
			reminder = "Reminder: "
		end
		local tool = moho:CurrentTool()
		for _, v in pairs(_G[tool]) do --if _G[moho:CurrentTool()].dlog then
			if type(v) == "userdata" and tostring(v):find("SimpleDialog") then --Throw a warning...
				if self.alertCantOpen ~= 1 or reminder ~= "" then 
					self.alertCantOpen = LM.GUI.Alert(LM.GUI.ALERT_INFO, reminder .. "The \"" .. RL_ShapesWindow:UILabel() .. "\" couldn't be opened due to currently active tool (\"" .. _G[tool]:UILabel() .. "\" in this case) has a dialog and that may cause problems.", "Please, select a different one in \"Tools\" palette with that in mind and try again... Once \"" .. RL_ShapesWindow:UILabel() .. "\" is open, you are free to activate and work breezily with any tool.", nil, "OK", (reminder == "" and "Got it!" or nil), nil) --OK: 0, Got it: 1
					self.alertCantOpen = reminder ~= "" and 1 or self.alertCantOpen
				else
					LM.Beep()
				end
				self.prevClock = os.clock()
				return
			end
		end
		--]]
		--[[20230930-0010: Try to cheat Moho...
		local tool = moho:CurrentTool()
		if tool ~= "" then
			for k, v in pairs(_G[tool]) do --if _G[moho:CurrentTool()].dlog then
				if type(v) == "userdata" and tostring(v):find("SimpleDialog") then --print(tostring(v))
					--print(k, ", ", v)
					local dlogTmp = v print(tostring(dlogTmp))
					_G[tool][k] = nil print(tostring(_G[tool][k]))
					self.dlog = RL_ShapesWindowDialog:new(moho)
					self.dlog:DoModeless()
					--_G[tool][k] = dlogTmp print(tostring(_G[tool][k]))
				end
			end
			return
		end
		--]]

		self.dlog = RL_ShapesWindowDialog:new(moho)
		self.dlog:DoModeless()
	else
		--print(self.dlog.shapeNameLabel:Height())
		LM.Beep()
	end

end

function RL_ShapesWindow:CompareVersion(a, b) --Sorting an array of semantic versions or SemVer (https://medium.com/geekculture/sorting-an-array-of-semantic-versions-in-typescript-55d65d411df2)
	local a1, b1 = {}, {}
	for part in tostring(a):gmatch("[^.]+") do table.insert(a1, part) end
	for part in tostring(b):gmatch("[^.]+") do table.insert(b1, part) end

	for i = 0, math.min(#a1, #b1) do -- 2. Look through each version number and compare (math.min is for contingency in case there's a 4th or 5th version)
		local a2, b2 = tonumber(a1[i]) or 0, tonumber(b1[i]) or 0
		if (a2 ~= b2) then
			return a2 > b2 and 1 or -1 --ALT: return a2 > b2 and true or false --ORIG: return a2 > b2 ? 1 : -1; (Javascript ternary operation)
		end
	end
	return #b1 - #a1 -- 3. We hit this if the all checked versions so far are equal (0 = equal version, + = 1st > 2nd, - = 1st < 2nd)
end --print(tostring(RL_ShapesWindow:CompareVersion("13.5.6", "14.0")))


function RL_ShapesWindow.Abbreviate(s)
	local num = 0
	local abrev = string.gsub(s, "%a+", function(w) if #w > 4 then num = num + 1 return string.sub(w, 1, 3) .. "." else return w end end)
	return abrev, num
end
