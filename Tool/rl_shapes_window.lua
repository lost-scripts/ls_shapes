-- **************************************************
-- Provide Moho with the name of this script object
-- **************************************************

ScriptName = "RL_ShapesWindow"
ScriptBirth = "20230918-0248"
ScriptBuild = "20231017-0040"

-- **************************************************
-- General information about this script
-- **************************************************

RL_ShapesWindow = {}

RL_ShapesWindow.BASE_STR = 2320

function RL_ShapesWindow:Name()
	return "Shapes Window"
end

function RL_ShapesWindow:Version()
	return "0.0.1" .. " (Build " ..  ScriptBuild .. ") for Moho® 14.0+" -- "0.0.1-20231005.1731"
end

function RL_ShapesWindow:Description()
	return MOHO.Localize("/Scripts/Tool/ShapesWindow/Description=A persistent shape palette plus helpers for better management of vectors in general and the AMAZING new \"Liquid Shapes\" in particular.")
end

function RL_ShapesWindow:Creator()
	return "Copyright © " .. ScriptBirth:sub(1,4) .. (tonumber(ScriptBuild:sub(1, 4)) > tonumber(ScriptBirth:sub(1, 4)) and "-" .. ScriptBuild:sub(1,4) or "") .. " Rai López (Lost Scripts™)"
end

function RL_ShapesWindow:UILabel()
	return(MOHO.Localize("/Scripts/Tool/ShapesWindow/ShapesWindow=Shapes Window"))
end

function RL_ShapesWindow:ColorizeIcon()
	return true
end

function RL_ShapesWindow:LoadPrefs(prefs) --print("RL_ShapesWindow:LoadPrefs(" .. tostring(prefs) .. ")", " 🕗: " .. os.clock())
	self.creationMode = prefs:GetInt("LM_CreateShape.creationMode", 2)
	self.pointsBasedSel = prefs:GetBool("RL_ShapesWindow.pointsBasedSel", false)
	self.ignoreNonRegular = prefs:GetBool("RL_ShapesWindow.ignoreNonRegular", true)
	self.showTooltips = prefs:GetBool("RL_ShapesWindow.showTooltips", true)
	self.advanced = prefs:GetBool("RL_ShapesWindow.advanced", true)
	self.halfDimensions = prefs:GetBool("RL_ShapesWindow.halfDimensions", true)
	self.showInfobar = prefs:GetBool("RL_ShapesWindow.showInfobar", true)
	self.alertCantOpen = prefs:GetInt("RL_ShapesWindow.alertCantOpen", 0)
	self.endMessage = prefs:GetBool("RL_ShapesWindow.endMessage", false)
	--self.endedByMoho = prefs:GetBool("RL_ShapesWindow.endedByApp", false)
	--self.endedByUser = prefs:GetBool("RL_ShapesWindow.endedByUser", false)
end

function RL_ShapesWindow:SavePrefs(prefs) --print("RL_ShapesWindow:SavePrefs(" .. tostring(prefs) .. ")", " 🕗: " .. os.clock())
	prefs:SetInt("LM_CreateShape.creationMode", self.creationMode)
	prefs:SetBool("RL_ShapesWindow.pointsBasedSel", self.pointsBasedSel)
	prefs:SetBool("RL_ShapesWindow.ignoreNonRegular", self.ignoreNonRegular)
	prefs:SetBool("RL_ShapesWindow.showTooltips", self.showTooltips)
	prefs:SetBool("RL_ShapesWindow.advanced", self.advanced)
	prefs:SetBool("RL_ShapesWindow.halfDimensions", self.halfDimensions)
	prefs:SetBool("RL_ShapesWindow.showInfobar", self.showInfobar)
	prefs:SetInt("RL_ShapesWindow.alertCantOpen", self.alertCantOpen)
	prefs:SetBool("RL_ShapesWindow.endMessage", true)
end

function RL_ShapesWindow:ResetPrefs()
	LM_CreateShape.creationMode = 2
	RL_ShapesWindow.pointsBasedSel = false
	RL_ShapesWindow.ignoreNonRegular = true
	RL_ShapesWindow.showTooltips = true
	RL_ShapesWindow.advanced = true
	RL_ShapesWindow.halfDimensions = true -- 0: Max, 1: Full, 2: Half, 3: Third?
	RL_ShapesWindow.showInfobar = true
	RL_ShapesWindow.alertCantOpen = 0
end

-- **************************************************
-- Recurring values
-- **************************************************

RL_ShapesWindow.name = ScriptName
RL_ShapesWindow.birth = ScriptBirth
RL_ShapesWindow.build = ScriptBuild
RL_ShapesWindow.path = debug.getinfo(1,'S')
RL_ShapesWindow.filename = (RL_ShapesWindow.path.source):match("^.*[/\\](.*).lua$")
RL_ShapesWindow.url = "https://mohoscripts.com/script/" .. RL_ShapesWindow.filename
RL_ShapesWindow.dlog = nil
RL_ShapesWindow.ack = {
"My sincere thanks to...",
"    • Stanislav Zuliy (Stan), for all his contributions & generosity.",
"    • Lukas Krepel, for paving the \"modeless\" way 🙂",
"    • Wes (synthsin75), for his support at the LM forums.",
"    • Paul (hayasidist), for all the given support there as well.",
"    • Sam (SimplSam), for helping at the LM forums too.",
"    • OpenAI/Microsoft's Bing Chat, for... erm... Why not? 🤷‍♂️",
"\n",
"And, of course, to Lost Marble and the talented Moho® team for all \nthe hard work and making all this possible (again)."}


-- **************************************************
-- Shapes Window dialog
-- **************************************************

local RL_ShapesWindowDialog = {}

RL_ShapesWindowDialog.OPTIONS_MENU			= MOHO.MSG_BASE

RL_ShapesWindowDialog.FILLED				= MOHO.MSG_BASE + 100--LM_CreateShape.CREATE or MOHO.MSG_BASE (pairs)
RL_ShapesWindowDialog.FILLED_ALT			= MOHO.MSG_BASE + 101
RL_ShapesWindowDialog.OUTLINED				= MOHO.MSG_BASE + 102
RL_ShapesWindowDialog.OUTLINED_ALT			= MOHO.MSG_BASE + 103
RL_ShapesWindowDialog.FILLEDOUTLINED		= MOHO.MSG_BASE + 104
RL_ShapesWindowDialog.FILLEDOUTLINED_ALT	= MOHO.MSG_BASE + 105
RL_ShapesWindowDialog.FILL					= MOHO.MSG_BASE + 106
RL_ShapesWindowDialog.FILL_ALT				= MOHO.MSG_BASE + 107
RL_ShapesWindowDialog.FILLCOLOR				= MOHO.MSG_BASE + 108
RL_ShapesWindowDialog.FILLCOLOR_BEGIN		= MOHO.MSG_BASE + 109
RL_ShapesWindowDialog.FILLCOLOR_END			= MOHO.MSG_BASE + 110
RL_ShapesWindowDialog.LINE					= MOHO.MSG_BASE + 111
RL_ShapesWindowDialog.LINE_ALT				= MOHO.MSG_BASE + 112
RL_ShapesWindowDialog.LINECOLOR				= MOHO.MSG_BASE + 113
RL_ShapesWindowDialog.LINECOLOR_BEGIN		= MOHO.MSG_BASE + 114
RL_ShapesWindowDialog.LINECOLOR_END			= MOHO.MSG_BASE + 115
RL_ShapesWindowDialog.LINEWIDTH				= MOHO.MSG_BASE + 116
RL_ShapesWindowDialog.ROUNDCAPS				= MOHO.MSG_BASE + 117
RL_ShapesWindowDialog.COPY					= MOHO.MSG_BASE + 118
RL_ShapesWindowDialog.PASTE					= MOHO.MSG_BASE + 119
RL_ShapesWindowDialog.RESET					= MOHO.MSG_BASE + 120
RL_ShapesWindowDialog.RESET_ALT				= MOHO.MSG_BASE + 121

RL_ShapesWindowDialog.NAME					= MOHO.MSG_BASE + 122
RL_ShapesWindowDialog.COMBINE_NORMAL		= MOHO.MSG_BASE + 123
RL_ShapesWindowDialog.COMBINE_ADD			= MOHO.MSG_BASE + 124
RL_ShapesWindowDialog.COMBINE_SUBTRACT		= MOHO.MSG_BASE + 125
RL_ShapesWindowDialog.COMBINE_INTERSECT		= MOHO.MSG_BASE + 126
RL_ShapesWindowDialog.COMBINE_BLEND_BUT		= MOHO.MSG_BASE + 127
RL_ShapesWindowDialog.COMBINE_BLEND_BUT_ALT	= MOHO.MSG_BASE + 128
RL_ShapesWindowDialog.COMBINE_BLEND			= MOHO.MSG_BASE + 129
RL_ShapesWindowDialog.BASE_SHAPE			= MOHO.MSG_BASE + 130
RL_ShapesWindowDialog.BASE_SHAPE_ALT		= MOHO.MSG_BASE + 131
RL_ShapesWindowDialog.TOP_SHAPE				= MOHO.MSG_BASE + 132
RL_ShapesWindowDialog.TOP_SHAPE_ALT			= MOHO.MSG_BASE + 133
RL_ShapesWindowDialog.MERGE					= MOHO.MSG_BASE + 134
RL_ShapesWindowDialog.RAISE					= MOHO.MSG_BASE + 135
RL_ShapesWindowDialog.RAISE_ALT				= MOHO.MSG_BASE + 136
RL_ShapesWindowDialog.LOWER					= MOHO.MSG_BASE + 137
RL_ShapesWindowDialog.LOWER_ALT				= MOHO.MSG_BASE + 138
RL_ShapesWindowDialog.CHANGE				= MOHO.MSG_BASE + 139
RL_ShapesWindowDialog.DELETE				= MOHO.MSG_BASE + 140
RL_ShapesWindowDialog.SELECTALL				= MOHO.MSG_BASE + 141
RL_ShapesWindowDialog.SELECTALL_ALT			= MOHO.MSG_BASE + 142
RL_ShapesWindowDialog.SELECTSIMILAR			= MOHO.MSG_BASE + 143
RL_ShapesWindowDialog.SELECTSIMILAR_ALT		= MOHO.MSG_BASE + 144
RL_ShapesWindowDialog.SELECTBASETOP			= MOHO.MSG_BASE + 145
RL_ShapesWindowDialog.SELECTBASETOP_ALT		= MOHO.MSG_BASE + 146

function RL_ShapesWindowDialog:new(moho) --print("RL_ShapesWindowDialog:new(" .. tostring(moho) .. "): ", " 🕗: " .. os.clock()) -- This print makes the window get closed upon closing the LCW!
	local d = LM.GUI.SimpleDialog("☰  " .. MOHO.Localize("/Windows/Style/Shapes=Shapes"), RL_ShapesWindowDialog) --RL_ShapesWindow:UILabel()
	local l = d:GetLayout()
	local wWidth = 132

	d.v = moho.view
	d.w = {} -- widgets, wTable?
	d.msg = MOHO.MSG_BASE
	d.isNewRun = true
	d.count = 0
	d.skipBlock = false
	d.shapeTable = {}
	d.tempShape = moho:NewShapeProperties()
	d.vHeight = d.v and math.floor((d.v:Height() / (RL_ShapesWindow.halfDimensions and 2 or 1))) - 214 or 648 --d.vHeight = d.vHeight and d.vHeight - 132 or 726
	d.showTooltips = RL_ShapesWindow.showTooltips
	d.editingColor = false
	--d.shapes = d.shapes and LM.Clamp(d.shapes + 2, 10, 40) or 20
	l:AddPadding(-12)
	l:Unindent(6)

	l:AddPadding(-16) ---14 (if modeBut)
	l:PushV(LM.GUI.ALIGN_LEFT, 0)
		l:AddPadding(-4) -- Comment if modeBut
		d.optionsMenu = LM.GUI.Menu("…") --⁝☰⚙…
		d.optionsPopup = LM.GUI.PopupMenu(22, false)
		--d.optionsPopup:SetToolTip(MOHO.Localize("/Dialogs/LayerSettings/GeneralTab/Options=Options"))
		d.optionsPopup:SetMenu(d.optionsMenu)
		l:AddChild(d.optionsPopup, LM.GUI.ALIGN_LEFT, 6)
		d.optionsMenu:AddItem(MOHO.Localize("/Scripts/Tool/ShapesWindow/PointsBasedSelection=Points-Based Selection") .. " [🧪]", 0, self.OPTIONS_MENU)
		d.optionsMenu:AddItem(MOHO.Localize("/Scripts/Tool/ShapesWindow/IgnoreNonRegularVectorLayers=Ignore Non-Regular Vector Layers"), 0, self.OPTIONS_MENU + 1)
		d.optionsMenu:AddItem(MOHO.Localize(""), 0, 0)
		d.optionsMenu:AddItem(MOHO.Localize("/Windows/LayerComps/ShowComp=Show") .. " " .. "All Tooltips", 0, self.OPTIONS_MENU + 2)
		d.optionsMenu:AddItem(MOHO.Localize(""), 0, 0)
		d.optionsMenu:AddItem(MOHO.Localize("/Windows/Style/Advanced=Advanced") .. " (" .. MOHO.Localize("/Scripts/Tool/SelectPoints/Create=Create") .. ")", 0, self.OPTIONS_MENU + 3) d.optionsMenu:SetEnabled(self.OPTIONS_MENU + 3, true)
		d.optionsMenu:AddItem(MOHO.Localize("/Dialogs/ExportSettings/HalfDimensions=Half Dimensions (%dx%d)"):match("[^%(]+"), 0, self.OPTIONS_MENU + 4)
		d.optionsMenu:AddItem(MOHO.Localize("/Windows/LayerComps/ShowComp=Show") .. " " .. "Infobar", 0, self.OPTIONS_MENU + 5)
		--d.optionsMenu:AddItem(MOHO.Localize("/Scripts/Tool/ShapesWindow/ResizeAndReopen=Resize & Reopen"), 0, self.OPTIONS_MENU + 6)
		d.optionsMenu:AddItem(MOHO.Localize(""), 0, 0)
		d.optionsMenu:AddItem(MOHO.Localize("/Dialogs/ProjectSettings/RestoreDefaults=Restore Defaults") .. " [?]", 0, self.OPTIONS_MENU + 6)
		d.optionsMenu:AddItem(MOHO.Localize(""), 0, 0)
		--d.optionsMenu:AddItem(MOHO.Localize("/Menus/Help/Help=Help") ..  "...", 0, self.OPTIONS_MENU + 7)
		--d.optionsMenu:AddItem(MOHO.Localize(""), 0, 0)
		d.optionsMenu:AddItem(MOHO.Localize("/Menus/Application/About=About") .. " " .. RL_ShapesWindow:UILabel() .. "...", 0, self.OPTIONS_MENU + 7)
		--d.optionsMenu:AddItem("...", 0, self.OPTIONS_MENU + self:CountRealItems(d.optionsMenu)) --d.optionsMenu:SetEnabled(self.OPTIONS_MENU + self:CountRealItems(d.optionsMenu), false) -- Last (Testground!)
	
		l:Indent(6)
		l:AddPadding(4)
		--[[20231010-1630: Don't try to support Style management, yet...
		l:AddPadding(-26)
		l:PushH(LM.GUI.ALIGN_CENTER, 0)
			l:AddPadding(10)
			d.modeBut = LM.GUI.ShortButton("Room For Label", 0)
			d.modeBut:SetToolTip(MOHO.Localize("/Scripts/Tool/ShapesWindow/Mode=Mode"))
			l:AddChild(d.modeBut, LM.GUI.ALIGN_FILL, 0)
		l:Pop() --H
		l:AddPadding(4)
		--]]
		l:PushH(LM.GUI.ALIGN_LEFT, 0)
			d.itemNameLabel = LM.GUI.DynamicText("    ", 18) --"🏷"
			d.itemNameLabel:SetToolTip(MOHO.Localize("/Windows/Style/Name=Name")) -- .. " (Tab key to confirm)"
			l:AddChild(d.itemNameLabel, LM.GUI.ALIGN_CENTER)

			d.itemName = LM.GUI.TextControl(wWidth - 2, "Room For Name", self.NAME, LM.GUI.FIELD_TEXT)
			d.itemName:SetValue("")
			l:AddChild(d.itemName, LM.GUI.ALIGN_LEFT)
		l:Pop() --H

		--l:AddPadding(4)
		--l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, 0)
		--l:AddPadding(3)

		l:AddPadding(4)
		d.dummyList = LM.GUI.ImageTextList(0, 1, LM.GUI.MSG_CANCEL)
		d.dummyList:AddItem("", false)
		l:AddChild(d.dummyList, LM.GUI.ALIGN_FILL, 0)
		l:AddPadding(3)

		l:PushH(LM.GUI.ALIGN_LEFT, 0)
			d.liquidShapesLabel = LM.GUI.DynamicText("    ", 18) --" 💧"
			--d.liquidShapesLabel:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/LiquidShapes=Liquid Shapes"))
			l:AddChild(d.liquidShapesLabel, LM.GUI.ALIGN_CENTER)
			l:PushV(LM.GUI.ALIGN_FILL, 0)
				l:PushH(LM.GUI.ALIGN_FILL, 1)
					d.combineNormal = LM.GUI.ImageButton("ScriptResources/combine_normal", MOHO.Localize("/Scripts/Tool/SelectShape/Normal=Normal"), true, self.COMBINE_NORMAL, true)
					d.combineNormal.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.combineNormal)
					l:AddChild(d.combineNormal, LM.GUI.ALIGN_FILL, 0)
					d.combineAdd = LM.GUI.ImageButton("ScriptResources/combine_add", MOHO.Localize("/Scripts/Tool/SelectShape/Add=Add"), true, self.COMBINE_ADD, true)
					d.combineAdd.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.combineAdd)
					l:AddChild(d.combineAdd, LM.GUI.ALIGN_FILL, 0)
					d.combineSubtract = LM.GUI.ImageButton("ScriptResources/combine_subtract", MOHO.Localize("/Scripts/Tool/SelectShape/Subtract=Subtract"), true, self.COMBINE_SUBTRACT, true)
					d.combineSubtract.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.combineSubtract)
					l:AddChild(d.combineSubtract, LM.GUI.ALIGN_FILL, 0)
					d.combineIntersect = LM.GUI.ImageButton("ScriptResources/combine_intersect", MOHO.Localize("/Scripts/Tool/SelectShape/Clip=Clip"), true, self.COMBINE_INTERSECT, true)
					d.combineIntersect.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.combineIntersect)
					l:AddChild(d.combineIntersect, LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(2)
					l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL)
					l:AddPadding(0)

					d.mergeBut = LM.GUI.ImageButton("ScriptResources/../mesh_type", MOHO.Localize("/Scripts/Tool/SelectShape/MergeCluster=Merge a Liquid Shape into a single shape"), false, self.MERGE, true) --ↀ⊖⋈⩇⩉θΣϴϻϺ
					d.mergeBut.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.mergeBut)
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
					d.combineBlendBut.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.combineBlendBut)
					l:AddChild(d.combineBlendBut, LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(-1)
					d.combineBlend = LM.GUI.TextControl(0, "00.0", self.COMBINE_BLEND, LM.GUI.FIELD_UFLOAT) --≈≋
					--d.combineBlend:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/Blend=Blend:"):gsub("[^%w]$", "")) --Remove any non-alphanumeric ending character
					d.combineBlend:SetPercentageMode(true)
					d.combineBlend:SetWheelInc(1.0)
					d.combineBlend.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.combineBlend)
					l:AddChild(d.combineBlend)
					--d.combineBlendLabel = LM.GUI.StaticText(" ≈")
					--d.combineBlendLabel:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/Blend=Blend:"):gsub("[^%w]$", ""))
					--l:AddChild(d.combineBlendLabel, LM.GUI.ALIGN_CENTER, 0)
					l:AddPadding(0)

					d.baseBut = LM.GUI.ImageButton("ScriptResources/select_cluster_bottom", MOHO.Localize("/Scripts/Tool/SelectShape/SelectBottomOfCluster=Select bottom of Liquid Shape") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All") .. ")", false, self.BASE_SHAPE, true)
					d.baseBut:SetAlternateMessage(self.BASE_SHAPE_ALT)
					--d.baseBut:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/SelectBottomOfCluster=Select bottom of Liquid Shape"))
					d.baseBut.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.baseBut)
					l:AddChild(d.baseBut, LM.GUI.ALIGN_FILL, 0)
			
					d.topBut = LM.GUI.ImageButton("ScriptResources/select_cluster_top", MOHO.Localize("/Scripts/Tool/SelectShape/SelectTopOfCluster=Select top of Liquid Shape") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All") .. ")", false, self.TOP_SHAPE, true)
					d.topBut:SetAlternateMessage(self.TOP_SHAPE_ALT)
					--d.topBut:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/SelectTopOfCluster=Select top of Liquid Shape"))
					d.topBut.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.topBut)
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
				l:PushV(LM.GUI.ALIGN_FILL, 0) -- Necessary to allow the widget get disabled accordingly to layout state!
					l:AddPadding(-d.itemName:Height())
					d.dumbLabel1 = LM.GUI.DynamicText("", d.itemName:Width())
					l:AddChild(d.dumbLabel1, LM.GUI.ALIGN_CENTER)
				l:Pop() --V
			l:Pop() --V
		l:Pop() --H

		l:AddPadding(4)
		l:Unindent(6)

		l:PushH(LM.GUI.ALIGN_FILL, 4)
			l:Indent(6)
			--l:AddPadding(-3)
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
					d.selectAllBut = LM.GUI.ImageButton("ScriptResources/../fbf_type", MOHO.Localize("/Scripts/Tool/ShapesWindow/SelectAll=Select All") .. " (<alt> " .. MOHO.Localize("/Menus/Edit/SelectInverse=Select Inverse") .. ")", false, self.SELECTALL, false) --<alt> Select Cluster --ScriptResources/../../Support/Scripts/Tool/lm_create_shape_cursor
					d.selectAllBut:SetAlternateMessage(self.SELECTALL_ALT)
					l:AddChild(d.selectAllBut, LM.GUI.ALIGN_FILL)
				l:Pop() --H
				l:AddPadding(2)
				l:PushH(LM.GUI.ALIGN_CENTER, 0)
					l:AddPadding(-1)
					l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL, 2)
					d.selectSimilarBut = LM.GUI.ImageButton("ScriptResources/../../Support/Scripts/Tool/lm_eyedropper_cursor", MOHO.Localize("/Scripts/Tool/ShapesWindow/SelectSimilar=Select Similar") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/ShapesWindow/IncludingStyles=Including styles") .. ")", false, self.SELECTSIMILAR, false)
					d.selectSimilarBut:SetAlternateMessage(self.SELECTSIMILAR_ALT)
					l:AddChild(d.selectSimilarBut, LM.GUI.ALIGN_FILL)
				l:Pop() --H

				l:AddPadding(4)
				l:PushH(LM.GUI.ALIGN_RIGHT, 8)
					l:AddPadding(-8)
					l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, 0)
				l:Pop() --H
				l:AddPadding(4)

				l:PushH(LM.GUI.ALIGN_CENTER, 0)
					l:AddPadding(-1)
					l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL, 2)
					d.deleteBut = LM.GUI.ImageButton("ScriptResources/../channel_off", MOHO.Localize("/Scripts/Tool/DeleteShape/DeleteShape=Delete Shape") .. "/s", false, self.DELETE, true) --"<alt> Delete entire Liquid Shape"? --"ScriptResources/../channel_off" --"ScriptResources/../action_del" 
					l:AddChild(d.deleteBut, LM.GUI.ALIGN_FILL, 0)
				l:Pop() --H

				if RL_ShapesWindow.advanced then
					l:AddPadding(4)
					l:PushH(LM.GUI.ALIGN_RIGHT, 8)
						l:AddPadding(-8)
						l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, 0)
					l:Pop() --H
					l:AddPadding(4)

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
						d.resetBut = LM.GUI.ImageButton("ScriptResources/../lm_widgets/refreshButtonImage_1" , MOHO.Localize("/Windows/Style/Reset=Reset"), false, self.RESET, true) --"ScriptResources/../../Support/Scripts/Tool_pro/lm_orbit_workspace_cursor" --ScriptResources/rotate_cursor
						l:AddChild(d.resetBut, LM.GUI.ALIGN_FILL, 0)
					l:Pop() --H
				end
			l:Pop() --V

			l:AddPadding(-10)
			l:PushH(LM.GUI.ALIGN_LEFT, 0)
				local itemHeight = d.itemName:Height() -- 22 / 27
				local listHeight = LM.Clamp(d.vHeight % itemHeight == 0 and d.vHeight or d.vHeight + (itemHeight - d.vHeight % itemHeight) + 2, 340, 648) -- Try to ensure last item always fits (Min: 296?)
				--local listHeight = (d.itemName:Height() * d.shapes < d.vHeight) and d.itemName:Height() * d.shapes or d.vHeight -- Try to addapt to viewport height
				--l:AddPadding(-1)
				d.shapeList = LM.GUI.ImageTextList(wWidth, listHeight, self.CHANGE) --175
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

		if RL_ShapesWindow.advanced then
			l:PushH(LM.GUI.ALIGN_LEFT, 0)
				d.shapeCreationLabel = LM.GUI.DynamicText("    ", 18) --" ©"
				d.shapeCreationLabel:SetToolTip(MOHO.Localize("/Scripts/Tool/CreateShape/CreateShape=Create Shape") .." (" .. MOHO.Localize("/Windows/Style/Advanced=Advanced") .. ")")
				l:AddChild(d.shapeCreationLabel, LM.GUI.ALIGN_CENTER, 0)
				l:PushV(LM.GUI.ALIGN_FILL, 0)
					l:PushH(LM.GUI.ALIGN_FILL, 0)
						d.fillCheck = LM.GUI.ImageButton("ScriptResources/../lib_moho/channel_fill", MOHO.Localize("/Scripts/Tool/SelectShape/Fill=Fill:"):gsub("[^%w]$", "") .. " (<alt>" .. MOHO.Localize("/Scripts/Tool/ShapesWindow/AnimateVisibility=Animate its visibility instead"), true, self.FILL, true)
						d.fillCheck:SetAlternateMessage(self.FILL_ALT)
						l:AddChild(d.fillCheck, LM.GUI.ALIGN_FILL)
						l:AddPadding(-1)
						l:PushH(LM.GUI.ALIGN_FILL, 0)
							l:AddPadding(-20)
							d.fillCol = LM.GUI.ShortColorSwatch(true, self.FILLCOLOR)
							d.fillCol:SetConstantMessages(true)
							d.fillCol:SetModalMessages(self.FILLCOLOR_BEGIN, self.FILLCOLOR_END)
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
						d.lineCheck = LM.GUI.ImageButton("ScriptResources/../lib_moho/channel_line", MOHO.Localize("/Scripts/Tool/SelectShape/Stroke=Stroke:"):gsub("[^%w]$", "") .. " (<alt>" .. MOHO.Localize("/Scripts/Tool/ShapesWindow/AnimateVisibility=Animate its visibility instead"), true, self.LINE, true)
						d.lineCheck:SetAlternateMessage(self.LINE_ALT)
						l:AddChild(d.lineCheck, LM.GUI.ALIGN_FILL)
						l:AddPadding(-1)
						l:PushH(LM.GUI.ALIGN_FILL, 0)
							l:AddPadding(-20)
							d.lineCol = LM.GUI.ShortColorSwatch(true, self.LINECOLOR)
							d.lineCol:SetConstantMessages(true)
							d.lineCol:SetModalMessages(self.LINECOLOR_BEGIN, self.LINECOLOR_END)
							l:AddChild(d.lineCol)
						l:Pop() --H

						d.widthLabel = LM.GUI.DynamicText("ø", 0)
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
		end

		if RL_ShapesWindow.showInfobar then
			if RL_ShapesWindow.advanced then
				l:AddPadding(4)
				d.dummyList2 = LM.GUI.ImageTextList(0, 1, LM.GUI.MSG_CANCEL)
				l:AddChild(d.dummyList2, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(-2)
			else
				l:AddPadding(-4)
			end
			l:PushV(LM.GUI.ALIGN_FILL, 0)
				--[[20231011-1700: A try to make it look a little better when text doesn't fit...
				d.infobarDots = LM.GUI.StaticText("…", 0)
				l:AddChild(d.infobarDots, LM.GUI.ALIGN_RIGHT, 0)
				l:AddPadding(-d.infobarDots:Height())
				--]]
				d.infobar = LM.GUI.DynamicText("ℹ Room For Some Info...", 0) --d.infobar:Enable(false) --d.infobar = LM.GUI.TextControl(wWidth - 2, "Room For Name", 0, LM.GUI.FIELD_TEXT, " ℹ")
				l:AddChild(d.infobar, LM.GUI.ALIGN_FILL, 2)
			l:Pop() --V
		end
	l:Pop() --V

	return d
end

--function RL_ShapesWindowDialog:UpdateWidgets(moho) --print("RL_ShapesWindowDialog:UpdateWidgets(" .. tostring(moho) .. "): ", " 🕗: " .. os.clock())
	-- This only run once upon opening the dialog even if its modeless, so using "Update()" function bellow for al purposes instead. 🤔 Not sure if at some point it may have some use...
--end

function RL_ShapesWindowDialog:Update(moho) --print("RL_ShapesWindowDialog:Update(" .. tostring(moho) .. "): ", " 🕗: " .. os.clock())
	--local caller = debug.getinfo(5) and debug.getinfo(5).name or "NULL" print(caller) --0: getinfo, 1: Update, 2: func, 3: NULL/NULL, 4: NULL/UpdateUI, 5: NULL/NULL
	local helper = MOHO.ScriptInterfaceHelper:new_local()
	local moho = helper:MohoObject() --moho or helper:MohoObject() -- TBC!
	local pro = MOHO.IsMohoPro()
	local doc = moho.document
	local tool = moho:CurrentTool()
	local toolsDisabled = moho:DisableDrawingTools()
	local l = self:GetLayout()
	local msg = self.msg ~= nil and self.msg or MOHO.MSG_BASE
	local info = {} --[1] = "ℹ ", [2] = "🆔 ", [3] = "#️⃣ ", [4] = "♒ "
	local itemsSel = math.floor(self.shapeList:NumSelectedItems())

	local style = moho:CurrentEditStyle() --print(tostring(style) .. ": ", tostring(style.fFillCol.value.r), ", ", tostring(style.fFillCol.value.g), ", ", tostring(style.fFillCol.value.b))
	local styleUUID = style and style.fUUID:Buffer() or "?" --doc:StyleByID(i) print(iStyle.fUUID:Buffer())
	local styles = doc and math.floor(doc:CountStyles()) or 0
	local styleName = ""

	if (doc ~= nil and style ~= nil) then
		if shape and shape.MyStyle ~= style then
			--self.tempShape
		end
		if RL_ShapesWindow.advanced then
			self.fillCol:SetValue(style.fFillCol.value)
			self.lineCol:SetValue(style.fLineCol.value)
			self.lineWidth:SetValue(style.fLineWidth * doc:Height())
			self.capsBut:SetValue(style.fLineCaps == 1 and true or false)
		end
		styleName = style.fName:Buffer()
		if styleName == "" then
			--self.modeBut:SetLabel(MOHO.Localize("/Windows/Style/DefaultsForNewShapes=DEFAULTS (For new shapes)"):gsub("%s+%b()", "")) self.modeBut:Redraw() --:match("%w+"))
			info[1] = "ℹ " .. MOHO.Localize("/Windows/Style/DefaultsForNewShapes=DEFAULTS (For new shapes)"):gsub("%s+%b()", "") --:match("%w+") -- Exclude everything between the patenthesis, including the preceding space, instead?
			info[2] = moho:CountShapes() > 0 and "#️⃣ " .. math.floor(moho:CountShapes()) or nil
		else
			--self.modeBut:SetLabel(MOHO.Localize("/Windows/Style/STYLE=STYLE")) self.modeBut:Redraw()
			info[1] = "ℹ " .. MOHO.Localize("/Windows/Style/STYLE=STYLE")
			info[2] = styleName and "🏷 " .. styleName or "?"
			info[3] = styles > 0 and "#️⃣ " .. itemsSel .. "/" .. styles or  "#️⃣ " .. styles
			info[4] = "🔣 " .. styleUUID
		end
	end

	local layer = moho.layer
	local lFrame = moho.layerFrame
	local lDrawing = moho.drawingLayer and moho:LayerAsVector(moho.drawingLayer) or nil
	local lDrawingUUID = lDrawing and lDrawing:UUID() or ""
	local mesh = moho:DrawingMesh()

	self.itemNameLabel:SetValue(" 🏷")
	self.itemNameLabel:Enable(true)
	self.liquidShapesLabel:SetValue(" 💧")
	if RL_ShapesWindow.advanced then
		self.shapeCreationLabel:SetValue(" ©")
		self.shapeCreationLabel:Enable(not toolsDisabled)
		for i, but in ipairs(self.shapeButtons) do
			but:Enable(not toolsDisabled)
		end
	end

	---[[20231014-1955: Try to move all this to DoLayout? They may not need to be updated all the time after all...
	--if (msg >= self.OPTIONS_MENU and msg <= self.OPTIONS_MENU + self:CountRealItems(self.optionsMenu) - 1) then -- Do nothing else than update the menu?
		self.optionsMenu:SetChecked(self.OPTIONS_MENU, RL_ShapesWindow.pointsBasedSel)
		self.optionsMenu:SetChecked(self.OPTIONS_MENU + 1, RL_ShapesWindow.ignoreNonRegular)
		self.optionsMenu:SetChecked(self.OPTIONS_MENU + 2, RL_ShapesWindow.showTooltips)
		self.optionsMenu:SetChecked(self.OPTIONS_MENU + 3, RL_ShapesWindow.advanced)
		self.optionsMenu:SetChecked(self.OPTIONS_MENU + 4, RL_ShapesWindow.halfDimensions)
		self.optionsMenu:SetChecked(self.OPTIONS_MENU + 5, RL_ShapesWindow.showInfobar)
		--helper:delete()
		--return
	--end
	--]]

	if (mesh == nil) or ((lDrawing and lDrawing:IsCurver()) or (lDrawing:IsWarpLayer() and (lDrawing:ContinuousTriangulation() or RL_ShapesWindow.ignoreNonRegular))) then -- Disable everything irrelevant if no valid/drawing layer is active (Ignore Non-Regular makes e.g. non-continuously-triangulated layers be also ignored).
		l:Enable(false)
		self.itemName:SetValue("")
		self.combineNormal:SetValue(false)
		self.combineAdd:SetValue(false)
		self.combineSubtract:SetValue(false)
		self.combineIntersect:SetValue(false)
		self.combineBlendBut:SetValue(false)
		self.combineBlend:SetValue(0)
		self.baseBut:SetValue(false)
		self.topBut:SetValue(false)

		self.skipBlock = true
		for i = self.shapeList:CountItems(), 1, -1 do
			self.shapeList:RemoveItem(i, false)
		end
		self.skipBlock = false
		self.shapeList:Enable(false)
		self.shapeList:Redraw()

		self.optionsPopup:Enable(true)
		if RL_ShapesWindow.advanced then
			self.shapeCreationLabel:Enable(false)
			self.fillCheck:Enable(false)
			self.fillCol:Enable(true)
			self.lineCheck:Enable(false)
			self.lineCol:Enable(true)
			self.widthLabel:Enable(true)
			self.lineWidth:Enable(true)
			self.capsBut:Enable(true)
		end
		if (RL_ShapesWindow.showInfobar and self.infobar ~= nil) then
			self.infobar:SetValue(table.concat(info, " • "))
		end

		if (doc == nil) then -- Disable everything else irrelevant if there is no document open
			self.optionsMenu:SetEnabled(self.OPTIONS_MENU + 3, false) -- Advanced (Create)
			self.optionsMenu:SetEnabled(self.OPTIONS_MENU + 4, false) -- Half Dimensions
			self.optionsMenu:SetEnabled(self.OPTIONS_MENU + 5, false) -- Show Infobar
			if RL_ShapesWindow.advanced then
				self.fillCol:Enable(false)
				self.lineCol:Enable(false)
				self.widthLabel:Enable(false)
				self.lineWidth:Enable(false)
				self.capsBut:Enable(false)
			end
		end

		helper:delete()
		return
	else -- Enable everything relevant if a valid/drawing layer is active
		l:Enable(true)
		self.optionsMenu:SetEnabled(self.OPTIONS_MENU + 3, true) -- Advanced (Create)
		self.optionsMenu:SetEnabled(self.OPTIONS_MENU + 4, true) -- Half Dimensions
		self.optionsMenu:SetEnabled(self.OPTIONS_MENU + 5, true) -- Show Infobar
		if RL_ShapesWindow.advanced then
			self.shapeList:Enable(true)
			self.shapeList:Redraw()
			self.shapeCreationLabel:Enable(not toolsDisabled)
			for i, but in ipairs(self.shapeButtons) do
				but:Enable(not toolsDisabled)
			end
		end
	end

	---[[20231006-1745: Before selecting items in list much bellow, do here the "Points-Based Selection" thing if active (so then you can rely on shape/shapeID/etc. kind of values)
	if mesh ~= nil and not (lDrawing:IsCurver() or lDrawing:IsWarpLayer()) then
		if (RL_ShapesWindow.pointsBasedSel and not tool:find("SelectShape")) then
			if moho:CountSelectedPoints() > 1 then
				for i = 0, mesh:CountShapes() - 1 do
					local shape = mesh:Shape(i)
					if shape:AllPointsSelected() == true then
						shape.fSelected = true
					else
						shape.fSelected = false
					end
				end
			end
		end
	end
	--]]

	local shape = moho:SelectedShape()
	local shapeID = shape and math.floor(mesh:ShapeID(shape)) or -1
	local shapeLUID = shape and math.floor(shape:ShapeID()) or -1 -- LUID: Layer Unique ID
	local shapeName = shape and shape:Name() or ""
	local shapes = mesh and math.floor(mesh:CountShapes()) or 0
	local shapesSel = math.floor(moho:CountSelectedShapes(true)) -- Use this instead LM_SelectShape:CountSelectedShapes??

	if (shape ~= nil) then
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
					info[4] = "♒ ".. position .. "/" .. total --≈≋💧
				else
					--self.combineBlendLabel:SetValue(shape.fComboBlend.value > 0 and " 💧" or " 🩸") --??
					--self.baseTopBut:Enable(false)
					self.baseBut:Enable(false)
					self.topBut:Enable(false)
					self.mergeBut:Enable(LM_SelectShape:CountSelectedShapes(moho) > 1)
					info[4] = nil
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
				info[4] = nil
			end
		end

		self.itemNameLabel:Enable(not shape.fHidden)
		if RL_ShapesWindow.advanced then
			self.fillCheck:SetValue(shape.fHasFill)
			self.fillCheck:Enable(shape.fFillAllowed)
			self.fillCol:Enable(shape.fHasFill)
			self.lineCheck:SetValue(shape.fHasOutline)
			self.lineCheck:Enable(true)
			self.lineCol:Enable(shape.fHasOutline)
		end
		self.deleteBut:Enable(true)
		info[1] = "ℹ " .. MOHO.Localize("/Windows/Style/SHAPE=SHAPE")
		--self.modeBut:SetLabel(MOHO.Localize("/Windows/Style/SHAPE=SHAPE")) self.modeBut:Redraw()
		info[2] = shapeLUID > -1 and "🆔 " .. shapeLUID or "🆔 " .. "?" --string.format("%d", shape:ShapeID())
		info[3] = shapes > 0 and "#️⃣ " .. shapesSel .. "/" .. shapes or shapes
	else
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
		end

		self.deleteBut:Enable(false)
		if RL_ShapesWindow.advanced then
			self.fillCheck:SetValue(false)
			self.fillCheck:Enable(false)
			self.lineCheck:SetValue(false)
			self.lineCheck:Enable(false)
		end
		--if (self.shapeID ~= nil) then
			--self.shapeID:SetValue("ShapeID: X")
		--end
	end

	local infoContent = table.concat(info, " • ") --•·∙⸱∣
	if (RL_ShapesWindow.showInfobar) and self.infobar then
		self.infobar:SetValue(infoContent) --self.infobar:SetValue(#infoContent > 30 and (infoContent):sub(1, 30) .. "…" or infoContent) -- 2023101011-1530: Discarted for now, since string.sub can "destroy" emojis and cause problems! 
		self.infobar:SetToolTip(#infoContent > 36 and infoContent or "")
		self.infobar:Enable(false)
	else
		if self.infobar then
			self.infobar:SetValue("")
		end
		self.itemNameLabel:SetToolTip(MOHO.Localize("/Windows/Style/Name=Name") .. " (" .. infoContent .. ")")
	end

	if self.skipBlock == true then -- if self.skipBlock == true and tool:find("SelectPoints") then -- 20231007-1730: Perform ONLY widget updates above when called from HandlMessage/UpdateUI in order to avoid entering into endless loop!
		return
	end

	local shapeTable = {}
	for i = 1, shapes do -- Current shapes state
		local shape = mesh:Shape(i - 1)
		shapeTable[0] = lDrawingUUID
		shapeTable[i] = shape:Name() .. shape.fComboMode
	end
	--print(#self.shapeTable, ":", table.concat(self.shapeTable, ", "))
	if self.shapeList:CountItems() == 1 or self.shapeTable and (#self.shapeTable ~= #shapeTable or table.concat(self.shapeTable) ~= table.concat(shapeTable)) then
		self.skipBlock = true
		for i = self.shapeList:CountItems(), 1, -1 do
			self.shapeList:RemoveItem(i, false)
		end

		for i = shapes - 1, 0, -1 do
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
			self.shapeList:SetSelItem(self.shapeList:GetItem(shapes - i + 1), false, first) -- 20231008-0037: Changing redraw (2nd ar.) to false in a try to improve performace... (TBD) 
			first = true
		end
	end
	if shapeID and shapeID >= 0 then
		self.itemName:Enable(true)
		self.itemName:SetValue(mesh:Shape(shapeID):Name()) --self.itemName:Redraw()
		self.shapeList:ScrollItemIntoView(shapes - shapeID, true)
	else
		--[[20231010-1630: Don't try to support Style management, yet...
		if styleName ~= "" then
			self.itemName:Enable(true)
			self.itemName:SetValue(styleName)
		else
			self.itemName:Enable(false)
			self.itemName:SetValue("")
		end
		--]]
		self.itemName:Enable(false)
		self.itemName:SetValue("")
		self.shapeList:SetSelItem(self.shapeList:GetItem(0), true, false) -- 20230920-1605: Had to pass false for redraw (2nd arg.) to avoid items deselection! 20231008-0036: Passing true again, otherwise <None> item isn't selected upon e.g. deselecting all
		self.shapeList:ScrollItemIntoView(0, true) -- It doesn't seem to scroll to item 0
	end
	self.skipBlock = false

	self.raise:Enable(self.shapeList:SelItem() > 1) --print(self.shapeList:SelItem(), ", ", self.shapeList:SelItemLabel())
	self.lower:Enable(self.shapeList:SelItem() > 0 and self.shapeList:SelItem() < self.shapeList:CountItems() - 1)

	self.selectAllBut:Enable(shapes > 0)
	--self.selectAllBut:SetLabel(LM_SelectShape:CountSelectedShapes(moho) == mesh:CountShapes() and "✅" or "☑", false) -- 20230922: It seems to tail some text??
	--self.selectAllBut:Redraw()
	self.selectSimilarBut:Enable(shape ~= nil and shapesSel == 1 and shapes > 1)

	self.deleteBut:SetCursor(LM.GUI.Cursor("ScriptResources/../../Support/Scripts/Tool/lm_delete_shape_cursor", 0, 0))
	--self.selectAllBut:SetCursor(LM.GUI.Cursor("ScriptResources/../../Support/Scripts/Tool/lm_create_shape_cursor", 0, 0)) --lm_select_shape_cursor
	--self.resetBut:SetCursor(LM.GUI.Cursor("ScriptResources/../../Support/Scripts/Tool/lm_roll_camera_cursor", 0, 0))
	if RL_ShapesWindow.advanced then 
		for i, but in ipairs(self.shapeButtons) do
			but:SetCursor(LM.GUI.Cursor("ScriptResources/../../Support/Scripts/Tool/lm_select_shape_cursor", 0, 0))
		end
	end

	if (RL_ShapesWindow.showTooltips ~= self.showTooltips) or self.isNewRun then --print("1: " .. tostring(RL_ShapesWindow.showTooltips), ", ", tostring(self.showTooltips))
		self.optionsPopup:SetToolTip(RL_ShapesWindow.showTooltips and MOHO.Localize("/Dialogs/LayerSettings/GeneralTab/Options=Options") or "")
		--self.itemNameLabel:SetToolTip(MOHO.Localize("/Windows/Style/Name=Name"))
		self.liquidShapesLabel:SetToolTip(RL_ShapesWindow.showTooltips and MOHO.Localize("/Scripts/Tool/SelectShape/LiquidShapes=Liquid Shapes") or "")
		self.combineBlend:SetToolTip(RL_ShapesWindow.showTooltips and MOHO.Localize("/Scripts/Tool/SelectShape/Blend=Blend:"):gsub("[^%w]$", "") .. " (" .. MOHO.Localize("/Dialogs/NudgeDlog/Amount=Amount") ..")" or "") -- Remove any non-alphanumeric ending character
		self.baseBut:SetToolTip(RL_ShapesWindow.showTooltips and MOHO.Localize("/Scripts/Tool/SelectShape/SelectBottomOfCluster=Select bottom of Liquid Shape") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All") .. ")" or "")
		self.topBut:SetToolTip(RL_ShapesWindow.showTooltips and MOHO.Localize("/Scripts/Tool/SelectShape/SelectTopOfCluster=Select top of Liquid Shape") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All") .. ")" or "")
		--self.shapePaletteLabel:SetToolTip(RL_ShapesWindow.showTooltips and MOHO.Localize("/Scripts/Tool/ShapesWindow/ShapePalette=Shape Palette") or "")
		--self.shapeCreationLabel:SetToolTip(RL_ShapesWindow.showTooltips and MOHO.Localize("/Scripts/Tool/CreateShape/CreateShape=Create Shape") .." (" .. MOHO.Localize("/Windows/Style/Advanced=Advanced") .. ")" or "")

		self.showTooltips = RL_ShapesWindow.showTooltips
	end
	
	for k, v in ipairs(self.w) do --print(tostring(k), ", ", tostring(v), ", ", type(v))
		if type(v) == "userdata" and not MOHO.IsMohoPro() then
			if tostring(v):find("Button") then
				v:SetValue(false)
			elseif tostring(v):find("TextControl") then
				v:SetValue("0")
			end
			v:Enable(v.pro and v.pro == pro or false)
			v:SetToolTip(MOHO.Localize("/Application/Exporter/MohoExporterIsAProLevelFeatureOnly=The Moho Exporter is a Pro level feature. You must upgrade to gain access to this feature."):match("(Pro[^%w].*)"))
			v:SetCursor(LM.GUI.Cursor("ScriptResources/disabled_cursor", 0, 0))
		end
	end
	
	shapes = mesh and mesh:CountShapes() or 0
	for i = 0, #self.shapeTable do -- Ensure the table is empty before updating! Otherwise if it had more elements, they will remain and the system will think there are more shapes than actually are (force an unnecessary list update).
		self.shapeTable[i] = nil
	end
	for i = 1, shapes do -- Previous shapes state
		local shape = mesh:Shape(i - 1)
		self.shapeTable[0] = moho.drawingLayer:UUID()
		self.shapeTable[i] = shape:Name() .. shape.fComboMode
	end

	self.isNewRun = false
	helper:delete()
end

function RL_ShapesWindowDialog:OnOK() --print("RL_ShapesWindowDialog:OnOK(): ", " 🕗: " .. os.clock()) LM.Snooze(3000)
	local helper = MOHO.ScriptInterfaceHelper:new_local()
	local moho = helper:MohoObject()

	if RL_ShapesWindow.dlog == nil then -- Reopen the just auto-closed window
		RL_ShapesWindow:Run(moho)
	else
		RL_ShapesWindow.dlog = nil -- Mark the window closed
	end

	moho:UpdateUI()
	helper:delete()
end

function RL_ShapesWindowDialog_Update(moho) --print("RL_ShapesWindowDialog_Update(" .. moho .."): ", " 🕗: " .. os.clock())
	if RL_ShapesWindow.dlog then
		RL_ShapesWindow.dlog:Update(moho)
	end
end

-- Register the dialog to be updated when changes are made
table.insert(MOHO.UpdateTable, RL_ShapesWindowDialog_Update)

function RL_ShapesWindowDialog:HandleMessage(msg) --print("RL_ShapesWindowDialog:HandleMessage(" .. math.floor(msg) .. "): " .. RL_ShapesWindowDialog:WhatMsg(msg), " 🕗: " .. os.clock())
	--local caller = debug.getinfo(3) and debug.getinfo(3).name or "NULL" print(caller) --0: getinfo, 1: NULL/NULL, 2: SetSelItem/NULL, 3: NULL/Update, 4: NULL/func, 5: NULL/NULL
	local helper = MOHO.ScriptInterfaceHelper:new_local()
	local moho = helper:MohoObject()
	local doc = moho.document
	local tool = moho:CurrentTool()
	local l = self:GetLayout()
	--local vHeight, vWidth = moho.view:Height(), moho.view:Width()
	self.msg = msg or MOHO.MSG_BASE


	if (msg >= self.OPTIONS_MENU and msg <= self.OPTIONS_MENU + self:CountRealItems(self.optionsMenu) - 1) then -- Process first of all stuff that can be accesed even without an open document.
		if (doc == nil) then -- Since there doesn't seem to be possible to trigger anything upon closing last document... well try to disable irrelevant widgets as soon as user click any menu entry.  
			self:Update()
		end
		if (msg == self.OPTIONS_MENU) then -- Points-Based Selection
			RL_ShapesWindow.pointsBasedSel = not RL_ShapesWindow.pointsBasedSel
		elseif (msg == self.OPTIONS_MENU + 1) then -- Ignore Non-Regular Vector Layers
			RL_ShapesWindow.ignoreNonRegular = not RL_ShapesWindow.ignoreNonRegular
		elseif (msg == self.OPTIONS_MENU + 2) then -- Show Tooltips
			RL_ShapesWindow.showTooltips = not RL_ShapesWindow.showTooltips
		elseif (msg >= self.OPTIONS_MENU + 3 and msg <= self.OPTIONS_MENU + 5) then -- Try to encompass here options which require auto-reopening.
			if (msg == self.OPTIONS_MENU + 3) and doc ~= nil then -- Advanced (Create)
				RL_ShapesWindow.advanced = not RL_ShapesWindow.advanced
				--self.optionsMenu:SetChecked(msg, RL_ShapesWindow.advanced) -- Not necessary in this case, but another possibility of update entries' checkmarks...
			elseif (msg == self.OPTIONS_MENU + 4) and doc ~= nil then -- Half Dimensions
				RL_ShapesWindow.halfDimensions = not RL_ShapesWindow.halfDimensions
			elseif (msg == self.OPTIONS_MENU + 5) and doc ~= nil then -- Show Infobar
				RL_ShapesWindow.showInfobar = not RL_ShapesWindow.showInfobar
			end
			if doc ~= nil then
				--print("1: (msg >= self.OPTIONS_MENU + 3 and msg <= self.OPTIONS_MENU + 5)")
				self.dummyList:SetSelItem(self.dummyList:GetItem(0), false)
				--print("2: (msg >= self.OPTIONS_MENU + 3 and msg <= self.OPTIONS_MENU + 5)")
				if (RL_ShapesWindow.dlog) then
					RL_ShapesWindow.dlog = nil
				end
			end
			helper:delete()
			return
		elseif (msg == self.OPTIONS_MENU + 6) then -- Restore Defaults [?]
			local alert = LM.GUI.Alert(LM.GUI.ALERT_QUESTION,
			RL_ShapesWindow:UILabel() .. ": " .. MOHO.Localize("/Dialogs/Preferences/ToolPrefs/RestoreDefaults=Restore Factory Defaults") .. "?",
			MOHO.Localize(doc ~= nil and "/Scripts/Tool/ShapesWindow/TheWindowWillReopen=The window will reopen if necessary." or "/Scripts/Tool/ShapesWindow/TheWindowWillClose=The window will close if necessary."), nil,
			MOHO.Localize("/Dialogs/ProjectSettings/RestoreDefaults=Restore Defaults"):gmatch("%w+")(), MOHO.Localize("/Strings/Cancel=Cancel")) --Restore: 0, Cancel: 1
			if alert == 0 then
				RL_ShapesWindow:ResetPrefs()
				if RL_ShapesWindow.advanced ~= self.optionsMenu:IsChecked(self.OPTIONS_MENU + 3) or RL_ShapesWindow.halfDimensions ~= self.optionsMenu:IsChecked(self.OPTIONS_MENU + 4) or RL_ShapesWindow.showInfobar ~= self.optionsMenu:IsChecked(self.OPTIONS_MENU + 5) then -- Only Reopen window if necessary.
					--print("1: (msg == self.OPTIONS_MENU + 6)")
					self.dummyList:SetSelItem(self.dummyList:GetItem(0), false)
					--print("2: (msg == self.OPTIONS_MENU + 6)")
					if (RL_ShapesWindow.dlog) and doc ~= nil then -- It may be better not try to reopen without an open document, otherwise the lack of view (among other things) will make it open weirdly.
						RL_ShapesWindow.dlog = nil
					end
					helper:delete()
					return
				end
			else
				helper:delete()
				return
			end
		elseif (msg == self.OPTIONS_MENU + 7) then -- About...
			local block1a = RL_ShapesWindow:UILabel() .. " " .. RL_ShapesWindow:Version()
			local block1b = "\n" ..  RL_ShapesWindow:Creator() .. ", All Rights Reserved."
			--local blockSep = "\n" ..  ("_"):rep(math.max(block1a and #block1a or 0, block1b and #block1b or 0))
			local block2 = RL_ShapesWindow:Description() .. "\n\n"
			local block3 = "Licensed under the Apache License, Version 2.0"
			local alert = LM.GUI.Alert(LM.GUI.ALERT_INFO, block1a .. block1b, block2, block3, MOHO.Localize("/Menus/Help/CheckForUpdates=Check For Updates..."), MOHO.Localize("/Scripts/Tool/ShapesWindow/Acknowledgements=Acknowledgements"), MOHO.Localize("/Menus/File/CloseRender=Close")) --This script is freeware and released under the GNU General Public License. --Licensed under the MIT License.
			if alert == 0 then
				os.execute('start "" ' .. RL_ShapesWindow.url) --os.execute('start "" "https://mohoscripts.com/script/"' .. (info.source):match("^.*[/\\](.*).lua$"))
			elseif alert == 1 then
				local alert = LM.GUI.Alert(LM.GUI.ALERT_INFO, RL_ShapesWindow.ack[1], table.concat(RL_ShapesWindow.ack, "    \n\n", 2, #RL_ShapesWindow.ack - 1) , RL_ShapesWindow.ack[#RL_ShapesWindow.ack], MOHO.Localize("/Menus/File/CloseRender=Close"))
			end
		elseif (msg == self.OPTIONS_MENU + self:CountRealItems(self.optionsMenu) - 1) then -- Last (Testground!)
			--print("...")
		end

		--if (doc ~= nil) then
			self:Update()
			MOHO.Redraw()
		--end
		helper:delete()
		return
	end

	if (doc == nil) then -- Ensure nothing is run from here on after closing last document (or things like LayerAsVector will make Moho crash).
		self:Update()
		helper:delete()
		return
	end

	local mesh = moho:DrawingMesh()
	local layer = moho.layer
	local lFrame = moho.layerFrame
	local lDrawing = moho:LayerAsVector(moho.drawingLayer)
	local lDrawingFrame = moho.drawingLayerFrame
	local shape = moho:SelectedShape()
	local shapeID = shape and mesh:ShapeID(shape) or -1
	local shapeName = shape and shape:Name() or ""
	local shapes = mesh and mesh:CountShapes() or 0
	local shapesSel = moho:CountSelectedShapes(true) -- Use this instead LM_SelectShape:CountSelectedShapes??
	local style = moho:CurrentEditStyle()
	local styleName = "" --style and style.fName:Buffer() or "" -- 20231010-0554: This doesn't seem to work! (See bellow).

	if (style ~= nil) then
		styleName = style.fName:Buffer()
		style = moho:CurrentEditStyle() -- 20231010-0554: For some reason, reassign this seems necessary! Otherwise is not possible to access style properties afterwards??
	end

	if mesh == nil or (style == nil and shape == nil) then
		if msg > self.OPTIONS_MENU + self:CountRealItems(self.optionsMenu) - 1 then --print(msg, ", ", self.OPTIONS_MENU + self:CountRealItems(self.optionsMenu) - 1) -- If doc but not object, exit should msg was other than options menu's
			helper:delete()
			return
		end
	end

	local undoable = true
	if ((msg >= self.OPTIONS_MENU and msg < self.FILLED) or msg == self.CHANGE or msg == self.BASE_SHAPE or msg == self.BASE_SHAPE_ALT or msg == self.TOP_SHAPE or msg == self.TOP_SHAPE_ALT or msg == self.SELECTALL or msg == self.SELECTALL_ALT or msg == self.SELECTSIMILAR or msg == self.SELECTSIMILAR_ALT or msg == self.COPY or (msg >= self.FILLCOLOR and msg <= self.FILLCOLOR_END) or (msg >= self.LINECOLOR and msg <= self.LINECOLOR_END)) then
		undoable = false
	end
	if (undoable) then
		doc:PrepUndo(moho.drawingLayer)
		doc:SetDirty()
	end

	if (msg == self.CHANGE) then
		if self.skipBlock == true then -- Try to avoid unwanted call to Update/UpdateWidgets bellow upon selecting, no matter how, a list item!
			if (RL_ShapesWindow.pointsBasedSel and not tool:find("SelectShape")) then --if (RL_ShapesWindow.pointsBasedSel and tool:find("SelectPoints")) then
				if shapesSel == 0 then
					self.count = 0
				end
				if self.count and self.count == shapesSel then
					self:Update()
					if tool:find("SelectShape") then -- Use this solution (when possible) instead UpdateUI() bellow to avoid updating unnecesary UI elements and thus performance loss!
						LM_SelectShape:UpdateWidgets(moho)
					end
					--moho:UpdateUI()
					self.count = 0
				end
				self.count = self.count + 1
			end
			helper:delete()
			return -- 20230920-2103: Commented, since it seems to make dialog widgets not update propertly... 20231006-2004: But now it's uncommented and works? 🤔
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
		---[=[Experimental Points-Based Selection Mode...
		if (RL_ShapesWindow.pointsBasedSel and not tool:find("SelectShape")) then
			for i = 0, mesh:CountShapes() - 1 do
				local shape = mesh:Shape(i)
				if shape.fSelected == true then -- Select selected shape's points
					shape:SelectAllPoints()
				else
					for pID = shape:CountPoints() - 1, 0, -1 do -- De-select unselected shape's points
						local point = mesh:Point(shape:GetPoint(pID))
						point.fSelected = false
					end
				end
			end
		end
		--]=]
		--[=[20231010-0414: It doesn't seem really necessary to set/update these widgets also from here, but keep an eye on it...
		self.itemName:Enable(self.shapeList:SelItem() > 0)
		self.itemName:SetValue(self.shapeList:SelItem() > 0 and mesh:Shape(mesh:CountShapes() - self.shapeList:SelItem()):Name() or "")
		self.raise:Enable(self.shapeList:SelItem() > 1)
		self.lower:Enable(self.shapeList:SelItem() > 0 and self.shapeList:SelItem() < self.shapeList:CountItems() - 1)
		--]=]
		MOHO.Redraw()
		self:Update()
		if tool:find("SelectShape") then -- Use this solution (when possible) instead UpdateUI() bellow to avoid updating unnecesary UI elements and thus performance loss!
			LM_SelectShape:UpdateWidgets(moho)
		end
		--moho:UpdateUI()
	elseif (msg == self.NAME) then
		if shapeID and shapeID >= 0 then
			local shape = mesh:Shape(shapeID)
			shape:SetName(self.itemName:Value())
		--[=[20231010-1630: Don't try to support Style management, yet...
		elseif style ~= nil then
			style.fName:Set(self.itemName:Value())
			--[=[
			local iStyle
			for i = 0, doc:CountStyles() - 1 do
				iStyle = doc:StyleByID(i) print(iStyle.fUUID:Buffer())
				if tostring(iStyle) == tostring(style) then -- 20231010-0520: For some reason, this is the only way Moho allows me to rename current style. Well...
					iStyle.fName:Set(self.itemName:Value())
				end
			end
			--]=]
		end
		--]=]
		moho:UpdateUI()
	elseif (msg == self.COMBINE_NORMAL) then
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fComboMode = MOHO.COMBO_NORMAL
			end
		end
		--lDrawing:UpdateCurFrame(false)
		--moho.view:DrawMe()
		MOHO.Redraw()
		--self:Update()
		moho:UpdateUI()
	elseif (msg == self.COMBINE_ADD) then
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fComboMode = MOHO.COMBO_ADD
			end
		end
		--lDrawing:UpdateCurFrame(false)
		--moho.view:DrawMe()
		MOHO.Redraw()
		--self:Update()
		moho:UpdateUI()
	elseif (msg == self.COMBINE_SUBTRACT) then
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fComboMode = MOHO.COMBO_SUBTRACT
			end
		end
		--lDrawing:UpdateCurFrame(false)
		--moho.view:DrawMe()
		MOHO.Redraw()
		--self:Update()
		moho:UpdateUI()
	elseif (msg == self.COMBINE_INTERSECT) then
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fComboMode = MOHO.COMBO_INTERSECT
			end
		end
		--lDrawing:UpdateCurFrame(false)
		--moho.view:DrawMe()
		MOHO.Redraw()
		--self:Update()
		moho:UpdateUI()
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
		--lDrawing:UpdateCurFrame(false) -- 20231011-1933: It doesn't seem unnecessary...
		--moho.view:DrawMe()
		MOHO.Redraw()
		--self:Update() -- 20231011-1933: It doesn't seem unnecessary...
		--LM_SelectShape:UpdateWidgets(moho) -- 20231011-1933: This indeed updates Select Shapes tool toolbar's "Blend" widget, but little less!
		moho:UpdateUI() -- 20231011-1933: It only seems necessary to update Timeline and Select Shapes tool toolbar's "Blend" widget? So let's try the above...
	elseif (msg == self.BASE_SHAPE) then
		--LM_SelectShape:HandleMessage(moho, moho.view, LM_SelectShape.BASE_SHAPE)
		if (shape ~= nil and shape:IsInCluster()) then
			local clusterBaseShape = shape:BottomOfCluster()
			mesh:SelectNone()
			clusterBaseShape.fSelected = true
			if (RL_ShapesWindow.pointsBasedSel and not tool:find("SelectShape")) then
				clusterBaseShape:SelectAllPoints()
			end
		end
		MOHO.Redraw()
		moho:UpdateUI()
	elseif (msg == self.TOP_SHAPE) then
		--LM_SelectShape:HandleMessage(moho, moho.view, LM_SelectShape.TOP_SHAPE)
		if (shape ~= nil and shape:IsInCluster()) then
			local clusterBaseShape = shape:TopOfCluster()
			mesh:SelectNone()
			clusterBaseShape.fSelected = true
			if (RL_ShapesWindow.pointsBasedSel and not tool:find("SelectShape")) then
				clusterBaseShape:SelectAllPoints()
			end
		end
		MOHO.Redraw()
		moho:UpdateUI()
	elseif (msg == self.BASE_SHAPE_ALT or msg == self.TOP_SHAPE_ALT) then -- TODO: Use ALT for moving above/bellow the upper/under cluster instead??
		if (shape:IsInCluster()) then
			local clusterShape = shape:BottomOfCluster()
			while (clusterShape ~= nil) do
				clusterShape.fSelected = true
				if (RL_ShapesWindow.pointsBasedSel and not tool:find("SelectShape")) then
					clusterShape:SelectAllPoints()
				end
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
	elseif (msg == self.FILL_ALT) then
		local shapeFillCol = LM.ColorVector:new_local()
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shapeFillCol:Set(shape.fMyStyle.fFillCol:GetValue(lDrawingFrame))
				if lDrawingFrame ~= 0 then
					shape.fMyStyle.fFillCol:SetValue(lDrawingFrame - 1, shapeFillCol)
				end
				shapeFillCol:Set(shapeFillCol.r, shapeFillCol.g, shapeFillCol.b, shapeFillCol:IsTransparent() and 1 or 0)
				shape.fMyStyle.fFillCol:SetValue(lDrawingFrame, shapeFillCol)
			end
		end
		MOHO.Redraw()
		moho:UpdateUI()
	elseif (msg == self.FILLCOLOR) then
		if (not self.editingColor) then
			moho.document:PrepUndo(moho.drawingLayer)
			moho.document:SetDirty()
		end
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
		if (not self.editingColor) then
			moho:NewKeyframe(CHANNEL_FILL)
			moho:UpdateUI()
		end
	elseif (msg == self.FILLCOLOR_BEGIN) then
		self.editingColor = true
		self:HandleMessage(self.FILLCOLOR)
	elseif (msg == self.FILLCOLOR_END) then
		self.editingColor = false
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
	elseif (msg == self.LINE_ALT) then
		local shapeLineCol = LM.ColorVector:new_local()
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shapeLineCol:Set(shape.fMyStyle.fLineCol:GetValue(lDrawingFrame))
				if lDrawingFrame ~= 0 then
					shape.fMyStyle.fLineCol:SetValue(lDrawingFrame - 1, shapeLineCol)
				end
				shapeLineCol:Set(shapeLineCol.r, shapeLineCol.g, shapeLineCol.b, shapeLineCol:IsTransparent() and 1 or 0)
				shape.fMyStyle.fLineCol:SetValue(lDrawingFrame, shapeLineCol)
			end
		end
		MOHO.Redraw()
		moho:UpdateUI()
	elseif (msg == self.LINECOLOR) then
		if (not self.editingColor) then
			moho.document:PrepUndo(moho.drawingLayer)
			moho.document:SetDirty()
		end
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
		if (not self.editingColor) then
			moho:NewKeyframe(CHANNEL_LINE)
			moho:UpdateUI()
		end
	elseif (msg == self.LINECOLOR_BEGIN) then
		self.editingColor = true
		self:HandleMessage(self.LINECOLOR)
	elseif (msg == self.LINECOLOR_END) then
		self.editingColor = false
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
	elseif (msg >= self.FILLED and msg <= self.FILLEDOUTLINED_ALT) then
		local m = msg - self.FILLED
		local creationMode = LM_CreateShape.creationMode
		LM_CreateShape.creationMode = math.floor(m / 2) --- #self.shapeButtons
		LM_CreateShape:HandleMessage(moho, moho.view, msg % 2 == 0 and LM_CreateShape.CREATE or LM_CreateShape.CREATE_CONNECTED)
		LM_CreateShape.creationMode = creationMode
		moho:UpdateUI()
	elseif (msg == self.SELECTALL or msg == self.SELECTALL_ALT) then -- 🤔 What if click once selected all, another click deselected all and holding <alt> selected similar?
		if (msg == self.SELECTALL and shapes == shapesSel) then 
			LM.Beep()
			helper:delete()
			return
		end
		for i = 0, mesh:CountShapes() - 1 do
			local shape = mesh:Shape(i)
			shape.fSelected = (msg == self.SELECTALL and true) or not shape.fSelected
			if (RL_ShapesWindow.pointsBasedSel and not tool:find("SelectShape")) then
				if shape.fSelected then
					shape:SelectAllPoints()
				else
					for pID = shape:CountPoints() - 1, 0, -1 do -- De-select the just de-selected shape's points
						local point = mesh:Point(shape:GetPoint(pID))
						point.fSelected = false
					end
				end
			end
		end
		self:Update()
		MOHO.Redraw()
	elseif (msg == self.SELECTSIMILAR or msg == self.SELECTSIMILAR_ALT) then
		local count = 0
		for i = 0, mesh:CountShapes() - 1 do
			local iShape = mesh:Shape(i)
			if (mesh:ShapeID(iShape) ~= shapeID) and iShape:ArePropertiesEqual(shape) then
				iShape.fSelected = true
				if (RL_ShapesWindow.pointsBasedSel and not tool:find("SelectShape")) then
					iShape:SelectAllPoints()
				end
				count = count + 1
			end
		end
		if count < 1 then
			LM.Beep()
		else
			self:Update()
			MOHO.Redraw()
		end
	elseif (msg == self.DELETE) then
		local i = 0
		while i < mesh:CountShapes() do
			if (mesh:Shape(i).fSelected) then
				mesh:DeleteShape(i)
			else
				i = i + 1
			end
		end
		--self:Update()
		moho:UpdateUI() -- Contrary to self:Update(), it correctly updates infobar e.g. upon deleting shapes while Select Shape tool is active, but does it worth? 🤔
		moho.view:DrawMe()
	elseif (msg == self.COPY or msg == self.PASTE) then
		if shape ~= nil then
			if msg == self.COPY then
				self.tempShape = moho:NewShapeProperties()
			else -- PASTE
				if self.tempShape then
					for i = 0, mesh:CountShapes() - 1 do
						local shape = mesh:Shape(i)
						if (shape.fSelected) then
							shape:CopyStyleProperties(self.tempShape, false, false)
						end
					end
				end
			end
		else
			if style ~= nil then
				if msg == self.COPY then
					self.tempShape = moho:NewShapeProperties()
				else -- PASTE
					if self.tempShape then
						moho:PickStyleProperties(self.tempShape)
					end
				end
			end
		end
		MOHO.Redraw()
		moho:UpdateUI()
	elseif (msg == self.RESET) or (msg == self.RESET_ALT) then
		local MohoLineWidth = 0.005556 -- Factory default value * 2 = 8px (No MohoGlobal??)
		if (style ~= nil) then
			style.fFillCol:SetValue(moho.drawingLayerFrame, MOHO.MohoGlobals.FillCol)
			style.fLineCol:SetValue(moho.drawingLayerFrame, MOHO.MohoGlobals.LineCol)
			style.fLineWidth = MohoLineWidth * 2
			style.fLineCaps = 1
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
	elseif LM.GUI.MSG_CANCEL then
		--return
		--helper:delete()
	end
	--moho:UpdateUI()
	helper:delete()
end

function RL_ShapesWindowDialog:WhatMsg(msg, t)
	t = t or self
	local what = "<NONE>"
	for k, v in pairs(t) do
		if v == msg then
			what = k
		end
	end
	return what
end

function RL_ShapesWindowDialog:CountRealItems(w, msg)
	msg = msg or MOHO.MSG_BASE
	local n = 0
	if tostring(w):find("Menu") and msg ~= nil then
		for i = msg, msg + w:CountItems() - 1 do --print(w:ItemLabel(i))
			if w:ItemLabel(i) ~= "" then
				n = n + 1
			end
		end
	end
	return n
end

-- **************************************************
-- The guts of this script
-- **************************************************

function RL_ShapesWindow:IsEnabled(moho) --print("RL_ShapesWindow:IsEnabled(" .. tostring(moho.document) .. ")", " 🕗: " .. os.clock())
	if (RL_ShapesWindow.dlog == nil) then
		return true
	end
	return false
end

function RL_ShapesWindow:IsRelevant(moho) --print("RL_ShapesWindow:IsRelevant(" .. tostring(moho.document) .. ")", " 🕗: " .. os.clock())
	if self:CompareVersion(moho:AppVersion(), 14.0) < 0 then
		return false
	end
	return true
end

function RL_ShapesWindow:Run(moho)
	if self.dlog == nil then
		--[[20230929-2230: Throw a warning, for now, if current tool has a dialog to avoid both get messed up... 20231004-1430: See dlogBypass patch bellow! :D
		local reminder = ""
		if self.prevClock and (os.clock() - self.prevClock) * 1000 < 300 * (speedFactor or 1) then
			reminder = "Reminder: "
		end
		local tool = moho:CurrentTool()
		for _, v in pairs(_G[tool]) do --if _G[moho:CurrentTool()].dlog then
			if type(v) == "userdata" and tostring(v):find("SimpleDialog") then -- Throw a warning...
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

		self.dlog = RL_ShapesWindowDialog:new(moho)
		self.dlogBypass = RL_ShapesWindowDialog:new(moho) self.dlogBypass = nil -- dlogGuard, dlogShield, dlogBait, dlogTrap, dlogPatch...
		self.dlog:DoModeless()
	else
		--print(self.dlog.itemNameLabel:Height())
		LM.Beep()
	end

end

function RL_ShapesWindow:CompareVersion(a, b) -- Sorting an array of semantic versions or SemVer (https://medium.com/geekculture/sorting-an-array-of-semantic-versions-in-typescript-55d65d411df2)
	local a1, b1 = {}, {}
	for part in tostring(a):gmatch("[^.]+") do table.insert(a1, part) end
	for part in tostring(b):gmatch("[^.]+") do table.insert(b1, part) end

	for i = 0, math.min(#a1, #b1) do -- 2. Look through each version number and compare (math.min is for contingency in case there's a 4th or 5th version)
		local a2, b2 = tonumber(a1[i]) or 0, tonumber(b1[i]) or 0
		if (a2 ~= b2) then
			return a2 > b2 and 1 or -1 -- ALT: return a2 > b2 and true or false -- ORIG: return a2 > b2 ? 1 : -1; (Javascript ternary operation)
		end
	end
	return #b1 - #a1 -- 3. We hit this if the all checked versions so far are equal (0 = equal version, + = 1st > 2nd, - = 1st < 2nd)
end --print(tostring(RL_ShapesWindow:CompareVersion("13.5.6", "14.0")))

function RL_ShapesWindow.LineBreaker(s, numSpaces, sep)
	s, numSpaces, sep = s or "", numSpaces or 1, sep or " "
	local result, currentPart, sepCount = "", "", 0
	for char in s:gmatch(".") do
		currentPart = currentPart .. char
		sepCount = char == sep and sepCount + 1 or sepCount
		if sepCount == numSpaces then
			result = result .. currentPart .. "\n"
			currentPart = ""
			sepCount = 0
		end
	end
	return #currentPart > 0 and result .. currentPart or result
end

function RL_ShapesWindow.Abbreviator(s)
	local num = 0
	local abrev = string.gsub(s, "%a+", function(w) if #w > 4 then num = num + 1 return string.sub(w, 1, 3) .. "." else return w end end)
	return abrev, num
end

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