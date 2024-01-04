-- **************************************************
-- Provide Moho with the name of this script object
-- **************************************************

ScriptName = "LS_ShapesWindow"
ScriptBirth = "20220918-0248"
ScriptBuild = "20240104-0230"

-- **************************************************
-- General information about this script
-- **************************************************

LS_ShapesWindow = {}

LS_ShapesWindow.BASE_STR = 2320

function LS_ShapesWindow:Name()
	return "Shapes Window"
end

function LS_ShapesWindow:Version()
	return "0.2.0" .. " BETA (Build " ..  ScriptBuild .. ") for Moho® 14.1+ Pro" -- "0.0.1.20231005.1731"
end

function LS_ShapesWindow:Description()
	return MOHO.Localize("/LS/ShapesWindow/Description=A persistent shape palette plus helpers for better management of Moho® vectors in general and the AMAZING new \"Liquid Shapes\" in particular.")
end

function LS_ShapesWindow:Creator()
	return "Copyright © " .. ScriptBirth:sub(1,4) .. (tonumber(ScriptBuild:sub(1, 4)) > tonumber(ScriptBirth:sub(1, 4)) and "-" .. ScriptBuild:sub(1,4) or "") .. " Rai López (Lost Scripts™)"
end

function LS_ShapesWindow:UILabel() -- Note: Runs upon window opening
	return(MOHO.Localize("/LS/ShapesWindow/ShapesWindow=Shapes Window"))
end

function LS_ShapesWindow:ColorizeIcon()
	return true
end

function LS_ShapesWindow:LoadPrefs(prefs) --print("LS_ShapesWindow:LoadPrefs(" .. tostring(prefs) .. ")", " 🕗: " .. os.clock())
	self.creationMode = prefs:GetInt("LM_CreateShape.creationMode", 2)
	self.pointsBasedSel = prefs:GetBool("LS_ShapesWindow.pointsBasedSel", false)
	self.ignoreNonRegular = prefs:GetBool("LS_ShapesWindow.ignoreNonRegular", true)
	self.linkToStyle = prefs:GetBool("LS_ShapesWindow.linkToStyle", true)
	self.openOnStartup = prefs:GetBool("LS_ShapesWindow.openOnStartup", false)
	self.shouldOpen = prefs:GetBool("LS_ShapesWindow.shouldOpen", true)
	self.showInTools = prefs:GetBool("LS_ShapesWindow.showInTools", true)
	self.showAllTooltips = prefs:GetBool("LS_ShapesWindow.showAllTooltips", true) -- Basic Tooltips Only
	self.advanced = prefs:GetBool("LS_ShapesWindow.advanced", true)
	self.largeButtons = prefs:GetBool("LS_ShapesWindow.largeButtons", false)
	self.largePalette = prefs:GetBool("LS_ShapesWindow.largePalette", false)
	self.showInfobar = prefs:GetBool("LS_ShapesWindow.showInfobar", true)
	self.swatch = prefs:GetInt("LS_ShapesWindow.swatch", -1)
	self.swatchDoc = prefs:GetInt("LS_ShapesWindow.swatchDoc", 1)
	self.swatchLayer = prefs:GetInt("LS_ShapesWindow.swatchLayer", 1)
	self.swatchPath = prefs:GetString("LS_ShapesWindow.swatchPath", "")
	self.alertCantOpen = prefs:GetInt("LS_ShapesWindow.alertCantOpen", 0)
	self.lastMOHO = prefs:GetString("LS_ShapesWindow.lastMOHO", tostring(0))
	--self.endedByMoho = prefs:GetBool("LS_ShapesWindow.endedByApp", false)
	--self.endedByUser = prefs:GetBool("LS_ShapesWindow.endedByUser", false)

	self.DarkHighlight = prefs:GetString("DarkHighlight", "105 169 161 255") --224 160 0 255
	self.FirstRun2 = prefs:GetInt("FirstRun2", 0)
	self.HighlightColor = prefs:GetString("HighlightColor", "34 124 175 255") --224 160 0 255?
	self.LightHighlight = prefs:GetString("LightHighlight", "34 124 175 255") --34 124 175 255
	self.MohoLineWidth = prefs:GetFloat("MohoLineWidth", 0.005556) --0.011111
	self.UILightness_v12beta = prefs:GetFloat("UILightness_v12beta", 0.088000) --0.207000
end

function LS_ShapesWindow:SavePrefs(prefs) --print("LS_ShapesWindow:SavePrefs(" .. tostring(prefs) .. ")", " 🕗: " .. os.clock()) LM.Snooze(1500)
	prefs:SetInt("LM_CreateShape.creationMode", self.creationMode)
	prefs:SetBool("LS_ShapesWindow.pointsBasedSel", self.pointsBasedSel)
	prefs:SetBool("LS_ShapesWindow.ignoreNonRegular", self.ignoreNonRegular)
	prefs:SetBool("LS_ShapesWindow.linkToStyle", self.linkToStyle)
	prefs:SetBool("LS_ShapesWindow.openOnStartup", self.openOnStartup)
	prefs:SetBool("LS_ShapesWindow.shouldOpen", true)
	prefs:SetBool("LS_ShapesWindow.showInTools", self.showInTools)
	prefs:SetBool("LS_ShapesWindow.showAllTooltips", self.showAllTooltips)
	prefs:SetBool("LS_ShapesWindow.advanced", self.advanced)
	prefs:SetBool("LS_ShapesWindow.largeButtons", self.largeButtons)
	prefs:SetBool("LS_ShapesWindow.largePalette", self.largePalette)
	prefs:SetBool("LS_ShapesWindow.showInfobar", self.showInfobar)
	prefs:SetInt("LS_ShapesWindow.swatch", self.swatch)
	prefs:SetInt("LS_ShapesWindow.swatchDoc", self.swatchDoc)
	prefs:SetInt("LS_ShapesWindow.swatchLayer", self.swatchLayer)
	prefs:SetString("LS_ShapesWindow.swatchPath", self.swatchPath)
	prefs:SetInt("LS_ShapesWindow.alertCantOpen", self.alertCantOpen)
	prefs:SetInt("LS_ShapesWindow.FirstRun2", self.FirstRun2)
	prefs:SetString("LS_ShapesWindow.lastMOHO", tostring(MOHO))
	prefs:SetBool("LS_Message_end", true)
end

function LS_ShapesWindow:ResetPrefs()
	LM_CreateShape.creationMode = 2
	LS_ShapesWindow.pointsBasedSel = false
	LS_ShapesWindow.ignoreNonRegular = true
	LS_ShapesWindow.linkToStyle = true
	LS_ShapesWindow.openOnStartup = false
	LS_ShapesWindow.showInTools = true
	LS_ShapesWindow.showAllTooltips = true
	LS_ShapesWindow.advanced = true
	LS_ShapesWindow.largeButtons = false
	LS_ShapesWindow.largePalette = false -- 0: Max, 1: Full, 2: Half, 3: Third?
	LS_ShapesWindow.showInfobar = true
	LS_ShapesWindow.alertCantOpen = 0
	LS_ShapesWindow.swatch = -1
	LS_ShapesWindow.swatchDoc = 1
	LS_ShapesWindow.swatchLayer = 1
	LS_ShapesWindow.swatchPath = ""
end

-- **************************************************
-- Recurring values
-- **************************************************

LS_ShapesWindow.name = ScriptName
LS_ShapesWindow.birth = ScriptBirth
LS_ShapesWindow.build = ScriptBuild
LS_ShapesWindow.UUID = "f5350aae-a7ad-4080-9685-a5ef32bd6faa" --ac74b0a7-3e7c-2f59-2f78-f69ac973cf6c
LS_ShapesWindow.path = debug.getinfo(1,'S')
LS_ShapesWindow.filename = (LS_ShapesWindow.path.source):match("^.*[/\\](.*).lua$")
LS_ShapesWindow.url = "https://bitbucket.org/lostscripts/" .. LS_ShapesWindow.filename
--LS_ShapesWindow.url = "https://github.com/lost-scripts/" .. LS_ShapesWindow.filename
--LS_ShapesWindow.url = "https://mohoscripts.com/script/" .. LS_ShapesWindow.filename
LS_ShapesWindow.doc = nil
LS_ShapesWindow.docList = {}
LS_ShapesWindow.docPath = ""
LS_ShapesWindow.docsLoaded = false
LS_ShapesWindow.dlog = nil
LS_ShapesWindow.shouldOpen = false --print("LS_ShapesWindow.shouldOpen", " 🕗: " .. os.clock())
LS_ShapesWindow.mode = 0 -- 0: DEFAULT, 1: SHAPE, 2: STYLE / Style Management
LS_ShapesWindow.ack = {
"My sincere thanks to...",
"    • Stanislav Zuliy (Stan), for all his contributions & generosity.",
"    • Lukas Krepel, for paving the \"modeless\" way 🙂",
"    • Wes (synthsin75), for his support at the LM forums.",
"    • Paul (hayasidist), for all the given support there as well.",
"    • Sam (SimplSam), for helping at the LM forums too.",
"    • OpenAI/Microsoft's Bing Chat, for... erm... Why not? 🤷‍♂️",
"\n",
"And, of course, to Lost Marble and the talented Moho® team for all \nthe hard work and making all this possible (again)."}

--LS_ShapesWindow.DarkHighlight = "224 160 0 255" --224 160 0 255
--LS_ShapesWindow.FirstRun2 = 0
---LS_ShapesWindow.HighlightColor = "224 160 0 255" --224 160 0 255
--LS_ShapesWindow.LightHighlight = "34 124 175 255" --34 124 175 255
--LS_ShapesWindow.MohoLineWidth = 0.005556
--LS_ShapesWindow.UILightness_v12beta = 0.088000 --0.207000

-- **************************************************
-- Shapes Window dialog
-- **************************************************

local LS_ShapesWindowDialog = {}

LS_ShapesWindowDialog.MENU1					= MOHO.MSG_BASE
LS_ShapesWindowDialog.MENU2					= MOHO.MSG_BASE + 20 --TODO: Put at the end!

LS_ShapesWindowDialog.FILLED				= MOHO.MSG_BASE + 100 --LM_CreateShape.CREATE or MOHO.MSG_BASE (pairs)
LS_ShapesWindowDialog.FILLED_ALT			= MOHO.MSG_BASE + 101
LS_ShapesWindowDialog.OUTLINED				= MOHO.MSG_BASE + 102
LS_ShapesWindowDialog.OUTLINED_ALT			= MOHO.MSG_BASE + 103
LS_ShapesWindowDialog.FILLEDOUTLINED		= MOHO.MSG_BASE + 104
LS_ShapesWindowDialog.FILLEDOUTLINED_ALT	= MOHO.MSG_BASE + 105
LS_ShapesWindowDialog.FILL					= MOHO.MSG_BASE + 106
LS_ShapesWindowDialog.FILL_ALT				= MOHO.MSG_BASE + 107
LS_ShapesWindowDialog.FILLCOLOR				= MOHO.MSG_BASE + 108
LS_ShapesWindowDialog.FILLCOLOR_BEGIN		= MOHO.MSG_BASE + 109
LS_ShapesWindowDialog.FILLCOLOR_END			= MOHO.MSG_BASE + 110
LS_ShapesWindowDialog.FILLCOLOROVER			= MOHO.MSG_BASE + 111
LS_ShapesWindowDialog.LINE					= MOHO.MSG_BASE + 112
LS_ShapesWindowDialog.LINE_ALT				= MOHO.MSG_BASE + 113
LS_ShapesWindowDialog.LINECOLOR				= MOHO.MSG_BASE + 114
LS_ShapesWindowDialog.LINECOLOR_BEGIN		= MOHO.MSG_BASE + 115
LS_ShapesWindowDialog.LINECOLOR_END			= MOHO.MSG_BASE + 116
LS_ShapesWindowDialog.LINECOLOROVER			= MOHO.MSG_BASE + 117
LS_ShapesWindowDialog.LINEWIDTH				= MOHO.MSG_BASE + 118
LS_ShapesWindowDialog.LINEWIDTHOVER			= MOHO.MSG_BASE + 119
LS_ShapesWindowDialog.ROUNDCAPS				= MOHO.MSG_BASE + 120
LS_ShapesWindowDialog.COPY					= MOHO.MSG_BASE + 121
LS_ShapesWindowDialog.PASTE					= MOHO.MSG_BASE + 122
LS_ShapesWindowDialog.RESET					= MOHO.MSG_BASE + 123
LS_ShapesWindowDialog.RESET_ALT				= MOHO.MSG_BASE + 124

LS_ShapesWindowDialog.MODE					= MOHO.MSG_BASE + 125
LS_ShapesWindowDialog.NAME					= MOHO.MSG_BASE + 126
LS_ShapesWindowDialog.VIS					= MOHO.MSG_BASE + 127
LS_ShapesWindowDialog.COMBINE_NORMAL		= MOHO.MSG_BASE + 128
LS_ShapesWindowDialog.COMBINE_ADD			= MOHO.MSG_BASE + 129
LS_ShapesWindowDialog.COMBINE_SUBTRACT		= MOHO.MSG_BASE + 130
LS_ShapesWindowDialog.COMBINE_INTERSECT		= MOHO.MSG_BASE + 131
LS_ShapesWindowDialog.COMBINE_BLEND_BUT		= MOHO.MSG_BASE + 132
LS_ShapesWindowDialog.COMBINE_BLEND_BUT_ALT	= MOHO.MSG_BASE + 133
LS_ShapesWindowDialog.COMBINE_BLEND			= MOHO.MSG_BASE + 134
LS_ShapesWindowDialog.BASE_SHAPE			= MOHO.MSG_BASE + 135
LS_ShapesWindowDialog.BASE_SHAPE_ALT		= MOHO.MSG_BASE + 136
LS_ShapesWindowDialog.TOP_SHAPE				= MOHO.MSG_BASE + 137
LS_ShapesWindowDialog.TOP_SHAPE_ALT			= MOHO.MSG_BASE + 138
LS_ShapesWindowDialog.MERGE					= MOHO.MSG_BASE + 139
LS_ShapesWindowDialog.RAISE					= MOHO.MSG_BASE + 140
LS_ShapesWindowDialog.RAISE_ALT				= MOHO.MSG_BASE + 141
LS_ShapesWindowDialog.LOWER					= MOHO.MSG_BASE + 142
LS_ShapesWindowDialog.LOWER_ALT				= MOHO.MSG_BASE + 143
LS_ShapesWindowDialog.DELETE				= MOHO.MSG_BASE + 144
LS_ShapesWindowDialog.SELECTALL				= MOHO.MSG_BASE + 145
LS_ShapesWindowDialog.SELECTALL_ALT			= MOHO.MSG_BASE + 146
LS_ShapesWindowDialog.SELECTSIMILAR			= MOHO.MSG_BASE + 147
LS_ShapesWindowDialog.SELECTSIMILAR_ALT		= MOHO.MSG_BASE + 148
LS_ShapesWindowDialog.CHECKERSEL			= MOHO.MSG_BASE + 149
LS_ShapesWindowDialog.COLORSLIDER			= MOHO.MSG_BASE + 150
LS_ShapesWindowDialog.CHANGE				= MOHO.MSG_BASE + 151
LS_ShapesWindowDialog.DUMMY					= MOHO.MSG_BASE + 152
LS_ShapesWindowDialog.SELECTSTYLE1			= MOHO.MSG_BASE + 250
LS_ShapesWindowDialog.SELECTSTYLE2			= MOHO.MSG_BASE + 1250 -- extremely unlikely to have anything close to 1000 styles
LS_ShapesWindowDialog.MSG_LIMIT				= MOHO.MSG_BASE + 2250 -- extremely unlikely to have anything close to 1000 styles

function LS_ShapesWindowDialog:new(moho) --print("LS_ShapesWindowDialog:new(" .. tostring(moho) .. "): ", " 🕗: " .. os.clock()) -- This print makes the window get closed upon closing the LCW!
	local d = LM.GUI.SimpleDialog(MOHO.Localize("/Windows/Style/Shapes=Shapes"), LS_ShapesWindowDialog) --LS_ShapesWindow:UILabel()
	local l = d:GetLayout()
	local doc = moho.document
	local docH = doc and doc:Height() or 240
	local mohoLineWidth = 0.005556 * 2
	local style = moho:CurrentEditStyle()

	local mainW = 140 --132
	local padH, padV = 3, 3
	local butW = 16
	local butW1 = LS_ShapesWindow.largeButtons and 6 or 0
	local menuW = 22

	d.v = moho.view
	d.w = {} -- widgets, wTable?
	d.msg = MOHO.MSG_BASE
	d.isNewRun = true
	d.mode = 0
	d.count = 0
	d.countFactory = 0
	d.swatches = {}
	d.skipBlock = false
	d.shapeTable = {}
	d.styleTable = {}
	d.selItem = 0
	--d.shapes = d.shapes and LM.Clamp(d.shapes + 2, 10, 40) or 20
	d.vHeight = d.v and math.floor((d.v:Height() / (LS_ShapesWindow.largePalette and 1 or 2))) - 214 or 648 --d.vHeight = d.vHeight and d.vHeight - 132 or 726
	d.showAllTooltips = LS_ShapesWindow.showAllTooltips
	d.editingColor = false
	d.tempShape = moho:NewShapeProperties() --MOHO.MohoGlobals.NewShapeProperties

	l:AddPadding(-12)
	l:Unindent(8)

	l:AddPadding(-12) ---14 (if modeBut)
	l:PushV(LM.GUI.ALIGN_LEFT, 0)
		--l:AddPadding(-4) -- Comment if modeBut
		l:PushH(LM.GUI.ALIGN_LEFT, 0)
			l:AddPadding(LS_ShapesWindow.largeButtons and padH or 0) --l:AddPadding(-7)
			d.menu1 = LM.GUI.Menu("") --☰⁝⚙…
			d.menu1Popup = LM.GUI.PopupMenu(menuW, false)
			--d.menu1Popup:SetToolTip(MOHO.Localize("/Dialogs/LayerSettings/General=General")) --"/Dialogs/LayerSettings/GeneralTab/Options=Options"
			d.menu1Popup:SetMenu(d.menu1)
			l:AddChild(d.menu1Popup, LM.GUI.ALIGN_LEFT, 6)
			d.menu1:AddItem(MOHO.Localize("/LS/ShapesWindow/PointsBasedSelection=Points-Based Selection") .. " [🧪]", 0, self.MENU1)
			d.menu1:AddItem(MOHO.Localize("/LS/ShapesWindow/IgnoreNonRegularVectorLayers=Ignore Non-Regular Vector Layers"), 0, self.MENU1 + 1)
			d.menu1:AddItem(MOHO.Localize("/LS/ShapesWindow/LinkToStyleWindow=Link To Style Window"), 0, self.MENU1 + 2)
			d.menu1:AddItem("", 0, 0)
			d.menu1:AddItem(MOHO.Localize("/LS/ShapesWindow/OpenOnStartup=Open On Startup"), 0, self.MENU1 + 3)
			d.menu1:AddItem(MOHO.Localize("/LS/ShapesWindow/ShowInTools=Show In \"Tools\" Palette"), 0, self.MENU1 + 4)
			d.menu1:AddItem(MOHO.Localize("/Windows/LayerComps/ShowComp=Show") .. " " .. "All Tooltips", 0, self.MENU1 + 5)
			d.menu1:AddItem("", 0, 0)
			d.menu1:AddItem(MOHO.Localize("/Windows/Style/Advanced=Advanced") .. " (" .. MOHO.Localize("/Scripts/Tool/SelectPoints/Create=Create") .. ")", 0, self.MENU1 + 6) d.menu1:SetEnabled(self.MENU1 + 6, true)
			d.menu1:AddItem(MOHO.Localize("/LS/ShapesWindow/UseLargeButtons=Use Large Buttons"), 0, self.MENU1 + 7)
			d.menu1:AddItem(MOHO.Localize("/LS/ShapesWindow/UseLargePalette=Use Large Palette (%d Items)"):match("[^%(]+"), 0, self.MENU1 + 8) --MOHO.Localize("/Dialogs/ExportSettings/HalfDimensions=Use Large Palette (%dx%d)"):match("[^%(]+")
			d.menu1:AddItem(MOHO.Localize("/Windows/LayerComps/ShowComp=Show") .. " " .. "Infobar", 0, self.MENU1 + 9)
			--d.menu1:AddItem(MOHO.Localize("/LS/ShapesWindow/ResizeAndReopen=Resize & Reopen"), 0, self.MENU1 + 9)
			d.menu1:AddItem("", 0, 0)
			d.menu1:AddItem(MOHO.Localize("/Dialogs/ProjectSettings/RestoreDefaults=Restore Defaults") .. " [?]", 0, self.MENU1 + 10)
			d.menu1:AddItem("", 0, 0)
			--d.menu1:AddItem(MOHO.Localize("/Menus/Help/Help=Help") ..  "...", 0, self.MENU1 + 9)
			d.menu1:AddItem(MOHO.Localize("/Menus/Help/CheckForUpdates=Check For Updates..."), 0, self.MENU1 + 11)
			--d.menu1:AddItem("", 0, 0)
			d.menu1:AddItem(MOHO.Localize("/Menus/Application/About=About") .. " " .. LS_ShapesWindow:UILabel() .. "...", 0, self.MENU1 + 12)
			--d.menu1:AddItem("...", 0, self.MENU1 + self:CountRealItems(d.menu1)) --d.menu1:SetEnabled(self.MENU1 + self:CountRealItems(d.menu1), false) -- Last (Testground!)
			--[[
			l:AddPadding(0) --l:AddPadding(-2)
			
			d.menu2 = LM.GUI.Menu("") --🎨⊞▦▩⩩⩨ - "/Windows/Style/Swatches=Swatches"
			d.menu2Popup = LM.GUI.PopupMenu(menuW, false)
			--d.menu2Popup:SetToolTip(MOHO.Localize("/Menus/Window/Window=Window")) --"/Menus/Draw/Draw=Draw"
			d.menu2Popup:SetMenu(d.menu2)
			l:AddChild(d.menu2Popup, LM.GUI.ALIGN_LEFT, 6)

			--[=[
			l:AddPadding(-2)
			d.menu3 = LM.GUI.Menu("…") --?
			d.menu3Popup = LM.GUI.PopupMenu(menuW, false)
			--d.menu3Popup:SetToolTip(MOHO.Localize("/Windows/Library/More=More:"):gsub("[^%w]$", "")) --"/Tools/Group/Other=Other"
			d.menu3Popup:SetMenu(d.menu3)
			l:AddChild(d.menu3Popup, LM.GUI.ALIGN_LEFT, 6)
			--d.menu3:AddItem(MOHO.Localize("/Windows/Style/Swatches=Swatches"), 0, self.MENU2)
			--d.menu3:AddItem(MOHO.Localize("/Windows/Style/Swatches=Swatches"), 0, self.MENU2 + 1)
			--]=]
			l:AddPadding(1)
			--]]
		l:Pop() --H

		l:Indent(8)
		---[[20231010-1630: Don't try to support Style management, yet...
		l:AddPadding(-22)
		l:PushH(LM.GUI.ALIGN_CENTER, 0)
			l:AddPadding(9)
			d.modeBut = LM.GUI.ShortButton("Room 4 Label", self.MODE)
			l:AddChild(d.modeBut)
		l:Pop() --H
		l:AddPadding(4)
		--]]
		l:PushH(LM.GUI.ALIGN_LEFT, 0)
			--d.itemNameLabel = LM.GUI.DynamicText("    ", 18)
			--d.itemNameLabel:SetValue(" 🏷") -- Set labels text this way for full control over width.
			--d.itemNameLabel:SetToolTip(MOHO.Localize("/Windows/Style/Name=Name")) -- .. " (Tab key to confirm)"
			--l:AddChild(d.itemNameLabel, LM.GUI.ALIGN_CENTER)
			d.itemPreview = MOHO.MeshPreview(butW + butW1 + padH * 2, LS_ShapesWindow.largeButtons and 24 or butW + butW1 + padH * 2)
			--d.itemPreview:SetToolTip(MOHO.Localize("/Windows/Style/SHAPE=SHAPE"):lower():gsub("^%l", string.upper))
			l:AddChild(d.itemPreview)

			d.itemVisCheck = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_vis_" .. (math.random() < 0.5 and 0 or math.random(1, 5)), MOHO.Localize("/LS/ShapesWindow/ShapeVisibility=Shape Visibility (Hide/Unhide)"), true, self.VIS, false)
			d.itemName = LM.GUI.TextControl(mainW - d.itemVisCheck:Width() - 3, "Room For Name", self.NAME, LM.GUI.FIELD_TEXT)
			d.itemName:SetValue("")
			l:AddChild(d.itemName, LM.GUI.ALIGN_FILL, 0)
			l:AddChild(d.itemVisCheck, LM.GUI.ALIGN_FILL, 0)
		l:Pop() --H

		--l:AddPadding(4)
		--l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, 0)
		--l:AddPadding(3)

		l:AddPadding(2)
		l:Unindent(8)

		l:AddPadding(-1)
		l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, 0)
		l:AddPadding(-2)

		l:PushH(LM.GUI.ALIGN_FILL, 0)
			l:Indent(8)
			l:AddPadding(3)
			l:PushV(LM.GUI.ALIGN_TOP, 0)
				--[[
				l:AddPadding(-2)
				d.shapePaletteLabel = LM.GUI.DynamicText(" ≡", 0)
				d.shapePaletteLabel:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/ShapePalette=Shape Palette"))
				l:AddChild(d.shapePaletteLabel, LM.GUI.ALIGN_CENTER, 4)
				--]]
				l:AddPadding(3)
				d.raise = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_raise", "", false, self.RAISE, true)
				d.raise:SetAlternateMessage(self.RAISE_ALT)
				l:AddChild(d.raise, LM.GUI.ALIGN_FILL, 0)

				--butW = LM.Clamp(butW, d.raise:Width(), 24) --??
				if LS_ShapesWindow.largeButtons then  l:AddChild(LM.GUI.TextList(butW + butW1, 0, 0), LM.GUI.ALIGN_FILL, 0) end

				d.lower = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_lower", "", false, self.LOWER, true)
				d.lower:SetAlternateMessage(self.LOWER_ALT)
				l:AddChild(d.lower, LM.GUI.ALIGN_FILL, 0)
			l:Pop() --V
			l:AddPadding(-butW - butW1)

			l:PushV(LM.GUI.ALIGN_BOTTOM, 0)
				d.selectAllBut = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_sel_all", MOHO.Localize("/Menus/Edit/SelectAll=Select All") .. " (<alt> " .. MOHO.Localize("/Menus/Edit/SelectInverse=Select Inverse") .. ")", false, self.SELECTALL, true) --<alt> Select Cluster
				d.selectAllBut:SetAlternateMessage(self.SELECTALL_ALT)
				l:AddChild(d.selectAllBut, LM.GUI.ALIGN_FILL)
				l:AddPadding(3)

				d.selectSimilarBut = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_sel_similar", "", false, self.SELECTSIMILAR, true)
				d.selectSimilarBut:SetAlternateMessage(self.SELECTSIMILAR_ALT)
				l:AddChild(d.selectSimilarBut, LM.GUI.ALIGN_FILL)
				l:AddPadding(3)

				d.checkerSelBut = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_checker_sel", MOHO.Localize("/Windows/Style/CheckerSelection=Checker selection"), true, self.CHECKERSEL, true)
				l:AddChild(d.checkerSelBut, LM.GUI.ALIGN_FILL)

				l:AddPadding(4)
				l:AddChild(LM.GUI.TextList(butW + butW1, 1, 0), LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(4)

				d.mergeBut = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_merge", MOHO.Localize("/Scripts/Tool/SelectShape/MergeCluster=Merge a Liquid Shape into a single shape"), false, self.MERGE, true) --ↀ⊖⋈⩇⩉θΣϴϻϺ
				d.mergeBut.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.mergeBut)
				l:AddChild(d.mergeBut, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(3)

				d.deleteBut = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_delete", MOHO.Localize("/Scripts/Tool/DeleteShape/DeleteShape=Delete Shape") .. "/s", false, self.DELETE, true) --"<alt> Delete entire Liquid Shape"? --"ScriptResources/../channel_off" --"ScriptResources/../action_del" 
				l:AddChild(d.deleteBut, LM.GUI.ALIGN_FILL, 0)

				l:AddPadding(4)
				l:AddChild(LM.GUI.TextList(butW + butW1, 1, 0), LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(4)

				d.copyBut = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_copy", MOHO.Localize("/Windows/Library/Copy=Copy"), false, self.COPY, true)
				l:AddChild(d.copyBut, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(3)

				d.pasteBut = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_paste", MOHO.Localize("/Windows/Style/Paste=Paste"), false, self.PASTE, true)
				l:AddChild(d.pasteBut, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(3)

				d.resetBut = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_reset" , MOHO.Localize("/Windows/Style/Reset=Reset"), false, self.RESET, true) --"ScriptResources/../../Support/Scripts/Tool_pro/lm_orbit_workspace_cursor" --ScriptResources/rotate_cursor
				d.resetBut:SetAlternateMessage(self.RESET_ALT)
				d.resetBut:SetToolTip(MOHO.Localize("/Windows/Style/Reset=Reset") .. " (<alt> " .. MOHO.Localize("/LS/ShapesWindow/Full=Full") .. ")")
				l:AddChild(d.resetBut, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(3)
			l:Pop() --V

			l:AddPadding(2)
			l:PushH(LM.GUI.ALIGN_LEFT, 0)
				l:AddPadding(-1)
				local itemHeight = d.itemName:Height() -- 22 / 27
				local listHeight = LM.Clamp(d.vHeight % itemHeight == 0 and d.vHeight or d.vHeight + (itemHeight - d.vHeight % itemHeight) + 2, 340, 648) -- Try to ensure last item always fits (Min: 296?)
				--local listHeight = (d.itemName:Height() * d.shapes < d.vHeight) and d.itemName:Height() * d.shapes or d.vHeight -- Try to addapt to viewport height
				--l:AddPadding(-1)
				d.itemList = LM.GUI.ImageTextList(mainW, listHeight, self.CHANGE) --175
				d.itemList:SetAllowsMultipleSelection(true)
				d.itemList:SetDrawsPrimarySelection(true)
				d.itemList:AddItem((" "):rep(12) .. MOHO.Localize("/Windows/Style/None=<None>"), false)
				d.itemList:ScrollItemIntoView(d.shapeID or 0, false)
				l:AddChild(d.itemList, LM.GUI.ALIGN_FILL)
			l:Pop() --H
		l:Pop() --H

		l:Unindent(8)
		l:AddPadding(-1)
		l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, 0)
		l:Indent(8)
		l:AddPadding(3)

		l:PushH(LM.GUI.ALIGN_FILL, 2)
			l:AddPadding(1)
			l:PushV(LM.GUI.ALIGN_CENTER, 0)
				d.combineNormal = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_combine_normal", MOHO.Localize("/Scripts/Tool/SelectShape/Normal=Normal"), true, self.COMBINE_NORMAL, true)
				d.combineNormal.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.combineNormal)
				l:AddChild(d.combineNormal, LM.GUI.ALIGN_FILL, 0)
				if LS_ShapesWindow.largeButtons then l:AddChild(LM.GUI.TextList(butW + butW1, 0, 0), LM.GUI.ALIGN_FILL, 0) end
			l:Pop() --V
			l:PushV(LM.GUI.ALIGN_CENTER, 0)
				d.combineAdd = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_combine_add", "⊕ " .. MOHO.Localize("/Scripts/Tool/SelectShape/Add=Add"), true, self.COMBINE_ADD, true) --" (+)"
				d.combineAdd.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.combineAdd)
				l:AddChild(d.combineAdd, LM.GUI.ALIGN_FILL, 0)
				if LS_ShapesWindow.largeButtons then l:AddChild(LM.GUI.TextList(butW + butW1, 0, 0), LM.GUI.ALIGN_FILL, 0) end
			l:Pop() --V
			l:PushV(LM.GUI.ALIGN_CENTER, 0)
				d.combineSubtract = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_combine_subtract", "⊖ " .. MOHO.Localize("/Scripts/Tool/SelectShape/Subtract=Subtract"), true, self.COMBINE_SUBTRACT, true) --⊝" (-)"
				d.combineSubtract.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.combineSubtract)
				l:AddChild(d.combineSubtract, LM.GUI.ALIGN_FILL, 0)
				if LS_ShapesWindow.largeButtons then l:AddChild(LM.GUI.TextList(butW + butW1, 0, 0), LM.GUI.ALIGN_FILL, 0) end
			l:Pop() --V
			l:PushV(LM.GUI.ALIGN_CENTER, 0)
				d.combineIntersect = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_combine_intersect", "⊗ " .. MOHO.Localize("/Scripts/Tool/SelectShape/Clip=Clip"), true, self.COMBINE_INTERSECT, true) --" (×)"
				d.combineIntersect.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.combineIntersect)
				l:AddChild(d.combineIntersect, LM.GUI.ALIGN_FILL, 0)
				if LS_ShapesWindow.largeButtons then l:AddChild(LM.GUI.TextList(butW + butW1, 0, 0), LM.GUI.ALIGN_FILL, 0) end
			l:Pop() --V
			l:AddPadding(2)

			if LS_ShapesWindow.largeButtons then l:AddPadding(0) end
			d.combineBlendBut = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_combine_blend", MOHO.Localize("/Scripts/Tool/SelectShape/Blend=Blend:"):gsub("[^%w]$", "") .. " (<alt> " .. MOHO.Localize("/Windows/Style/Reset=Reset") .. ")", true, self.COMBINE_BLEND_BUT, true) --Remove any non-alphanumeric ending character
			d.combineBlendBut:SetAlternateMessage(self.COMBINE_BLEND_BUT_ALT)
			d.combineBlendBut.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.combineBlendBut)
			l:AddChild(d.combineBlendBut, LM.GUI.ALIGN_FILL, 0)
			l:AddPadding(-4)
			d.combineBlend = LM.GUI.TextControl(0, "0.00", self.COMBINE_BLEND, LM.GUI.FIELD_UFLOAT) --≈≋
			d.combineBlend:SetPercentageMode(true)
			d.combineBlend:SetWheelInc(1.0)
			d.combineBlend.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.combineBlend)
			l:AddChild(d.combineBlend, LM.GUI.ALIGN_FILL, 0)
			if not LS_ShapesWindow.largeButtons then l:AddPadding(0) end

			l:PushV(LM.GUI.ALIGN_CENTER, 0)
				d.topBut = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_select_cluster_top", MOHO.Localize("/Scripts/Tool/SelectShape/SelectTopOfCluster=Select top of Liquid Shape") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All") .. ")", false, self.TOP_SHAPE, true)
				d.topBut:SetAlternateMessage(self.TOP_SHAPE_ALT)
				--d.topBut:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/SelectTopOfCluster=Select top of Liquid Shape"))
				d.topBut.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.topBut)
				if not LS_ShapesWindow.largeButtons then l:AddChild(d.topBut, LM.GUI.ALIGN_FILL, 0) end

				d.baseBut = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_select_cluster_bottom", MOHO.Localize("/Scripts/Tool/SelectShape/SelectBottomOfCluster=Select bottom of Liquid Shape") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All") .. ")", false, self.BASE_SHAPE, true)
				d.baseBut:SetAlternateMessage(self.BASE_SHAPE_ALT)
				--d.baseBut:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/SelectBottomOfCluster=Select bottom of Liquid Shape"))
				d.baseBut.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.baseBut)
				if not LS_ShapesWindow.largeButtons then l:AddChild(d.baseBut, LM.GUI.ALIGN_FILL, 0) end
			l:Pop() --V
			l:AddPadding(1)

			--[[20231128-0208: Commented upon UI redo, since I don't think layout disabling is been used anymore?
			l:PushV(LM.GUI.ALIGN_FILL, 0) -- Necessary patch to allow the widget get disabled accordingly to layout state!
				l:AddPadding(-d.itemName:Height())
				d.dumbLabel1 = LM.GUI.DynamicText("", d.itemName:Width() + 6)
				l:AddChild(d.dumbLabel1, LM.GUI.ALIGN_CENTER)
			l:Pop() --V
			--]]
		l:Pop() --H

		l:AddPadding(4)
		d.dummyList = LM.GUI.ImageTextList(0, 1, LM.GUI.MSG_CANCEL)
		d.dummyList:AddItem("", false)
		l:AddChild(d.dummyList, LM.GUI.ALIGN_FILL, 0)
		l:AddPadding(LS_ShapesWindow.advanced and 4 or 0)

		if LS_ShapesWindow.advanced then
			--d.shapeCreationLabel = LM.GUI.DynamicText("    ", 18 + (math.abs(butW + butW1 - 18)))
			--d.shapeCreationLabel:SetValue(" ©")
			--d.shapeCreationLabel:SetToolTip(MOHO.Localize("/Scripts/Tool/CreateShape/CreateShape=Create Shape") .." (" .. MOHO.Localize("/Windows/Style/Advanced=Advanced") .. ")")
			--l:AddChild(d.shapeCreationLabel, LM.GUI.ALIGN_CENTER, 0)
			l:PushH(LM.GUI.ALIGN_FILL, 1)
				l:AddPadding(2)
				d.fillCheck = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_fill", MOHO.Localize("/Scripts/Tool/SelectShape/Fill=Fill:"):gsub("[^%w]$", "") .. " (<alt>" .. MOHO.Localize("/LS/ShapesWindow/AnimateVisibility=Animate its visibility instead"), true, self.FILL, true)
				d.fillCheck:SetAlternateMessage(self.FILL_ALT)
				l:AddChild(d.fillCheck, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(1)
				l:PushH(LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(-18)
					d.fillCol = LM.GUI.ShortColorSwatch(true, self.FILLCOLOR)
					d.fillCol:SetConstantMessages(true)
					d.fillCol:SetModalMessages(self.FILLCOLOR_BEGIN, self.FILLCOLOR_END)
					d.fillCol:SetValue(style ~= nil and style.fFillCol or MOHO.MohoGlobals.FillCol)
					l:AddChild(d.fillCol, LM.GUI.ALIGN_FILL, 0)
				l:Pop() --H
				l:AddPadding(-2)
				d.fillColOverride = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_override", MOHO.Localize("/LS/ShapesWindow/FillOverride=Fill Color Override"), true, self.FILLCOLOROVER, true)
				l:AddChild(d.fillColOverride, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(2)
				l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(2)

				d.shapeButtons = {}
				table.insert(d.shapeButtons, LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_create_fill", MOHO.Localize("/Scripts/Tool/SelectPoints/Create=Create") .. " " .. MOHO.Localize("/Scripts/Tool/CreateShape/Fill=Fill") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/CreateShape/ConnectAndCreate=Connect And Create") .. ")", false, self.FILLED, true))
				table.insert(d.shapeButtons, LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_create_line", MOHO.Localize("/Scripts/Tool/SelectPoints/Create=Create") .. " " .. MOHO.Localize("/Scripts/Tool/CreateShape/Stroke=Stroke") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/CreateShape/ConnectAndCreate=Connect And Create") .. ")", false, self.OUTLINED, true))
				table.insert(d.shapeButtons, LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_create_both", MOHO.Localize("/Scripts/Tool/SelectPoints/Create=Create") .. " " .. MOHO.Localize("/Scripts/Tool/CreateShape/Both=Both") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/CreateShape/ConnectAndCreate=Connect And Create") .. ")", false, self.FILLEDOUTLINED, true))
				l:AddPadding(0)

				for i, but in ipairs(d.shapeButtons) do
					l:PushV(LM.GUI.ALIGN_CENTER, 0)
						l:AddChild(but, LM.GUI.ALIGN_FILL, 0)
						if LS_ShapesWindow.largeButtons then l:AddChild(LM.GUI.TextList(butW + butW1, 0, 0), LM.GUI.ALIGN_CENTER, 0) end
					l:Pop() --V
					but:SetAlternateMessage(self.FILLED + (i * 2 - 1))
					l:AddPadding(i < #d.shapeButtons and 1 or 0)
				end
				--[[
				l:AddPadding(4)
				l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(4)

				d.styleNewBut = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_style_new", MOHO.Localize("/LS/ShapesWindow/NewStyle=New Style"), false, self.NEWSTYLE, true)
				l:AddChild(d.styleNewBut, LM.GUI.ALIGN_CENTER, 0)
				--]]
				l:AddPadding(1)
			l:Pop() --H
			l:AddPadding(4)

			l:PushH(LM.GUI.ALIGN_FILL, 1)
				l:AddPadding(2)
				d.lineCheck = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_line", MOHO.Localize("/Scripts/Tool/SelectShape/Stroke=Stroke:"):gsub("[^%w]$", "") .. " (<alt>" .. MOHO.Localize("/LS/ShapesWindow/AnimateVisibility=Animate its visibility instead"), true, self.LINE, true)
				d.lineCheck:SetAlternateMessage(self.LINE_ALT)
				l:AddChild(d.lineCheck, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(1)
				l:PushH(LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(-18)
					d.lineCol = LM.GUI.ShortColorSwatch(true, self.LINECOLOR)
					d.lineCol:SetConstantMessages(true)
					d.lineCol:SetModalMessages(self.LINECOLOR_BEGIN, self.LINECOLOR_END)
					d.lineCol:SetValue(style ~= nil and style.fLineCol or MOHO.MohoGlobals.LineCol)
					l:AddChild(d.lineCol, LM.GUI.ALIGN_FILL, 0)
				l:Pop() --H
				l:AddPadding(-3)
				d.lineColOverride = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_override", MOHO.Localize("/LS/ShapesWindow/FillOverride=Line Color Override"), true, self.LINECOLOROVER, true)
				l:AddChild(d.lineColOverride, LM.GUI.ALIGN_FILL, 0)
				--l:AddPadding(2)
				--l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(2)
				l:AddPadding(0)

				d.widthLabel = LM.GUI.DynamicText("ø", 0)
				d.widthLabel:SetToolTip(MOHO.Localize("/Dialogs/InsertText/BalloonWidth=Stroke Width"))
				l:AddChild(d.widthLabel, LM.GUI.ALIGN_CENTER, 0)
				l:AddPadding(-3)
				d.lineWidth = LM.GUI.TextControl(0, "0.0.0", self.LINEWIDTH, LM.GUI.FIELD_UFLOAT) --ø
				d.lineWidth:SetUnits(LM.GUI.UNIT_PIXELS)
				d.lineWidth:SetWheelInc(1.0)
				d.lineWidth:SetWheelInteger(true)
				d.lineWidth:SetValue(style ~= nil and style.fLineWidth or mohoLineWidth * docH)
				l:AddChild(d.lineWidth, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(-2)
				d.lineWidthOverride = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_override", MOHO.Localize("/LS/ShapesWindow/FillOverride=Line Width Override"), true, self.LINEWIDTHOVER, true)
				l:AddChild(d.lineWidthOverride, LM.GUI.ALIGN_FILL, 0)
				--l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(4)

				d.capsBut = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_round_caps", MOHO.Localize("/Windows/Style/RoundCaps=Round caps"), true, self.ROUNDCAPS, true)
				d.capsBut:SetValue(style == nil or style.fLineCaps == 1)
				l:AddChild(d.capsBut, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(1)
			l:Pop() --H
		end

		if LS_ShapesWindow.advanced then
			l:AddPadding(4)
			l:AddChild(LM.GUI.TextList(0, 1), LM.GUI.ALIGN_FILL, 0)
			l:PushH(LM.GUI.ALIGN_FILL, 1)
				l:Unindent(3)
				d.menuStyle1 = LM.GUI.Menu("Style 1")
				d.menuStyle1Popup = LM.GUI.PopupMenu(math.floor((mainW + butW + butW1 + padH - menuW - 6) / 2), true)
				--d.menuStyle1Popup:SetToolTip(MOHO.Localize("/Windows/Style/Style1=Style 1") .. " (" ..  MOHO.Localize("/LS/ShapesWindow/AppliesAbove=Applies Above") .. ")")
				d.menuStyle1Popup:SetMenu(d.menuStyle1)
				l:AddChild(d.menuStyle1Popup, LM.GUI.ALIGN_LEFT, 0)

				d.menuStyle2 = LM.GUI.Menu("Style 2")
				d.menuStyle2Popup = LM.GUI.PopupMenu(math.floor((mainW + butW + butW1 + padH - menuW - 6) / 2), true)
				--d.menuStyle2Popup:SetToolTip(MOHO.Localize("/Windows/Style/Style2=Style 2") .. " (" ..  MOHO.Localize("/LS/ShapesWindow/AppliesBelow=Applies Below") .. ")")
				d.menuStyle2Popup:SetMenu(d.menuStyle2)
				l:AddChild(d.menuStyle2Popup, LM.GUI.ALIGN_LEFT, 0)
				l:AddPadding(4)

				d.menu2 = LM.GUI.Menu("🎨") --🎨⊞▦▩⩩⩨ - "/Windows/Style/Swatches=Swatches"
				d.menu2Popup = LM.GUI.PopupMenu(menuW, false) --8 + 2?
				d.menu2Popup:SetMenu(d.menu2)
				l:AddChild(d.menu2Popup, LM.GUI.ALIGN_LEFT, 0)
				l:Indent(3)
			l:Pop() --H

			if LS_ShapesWindow.swatch ~= -1 then
				l:AddPadding(4)
				--[[
				l:PushH(LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(-2)
					--d.dummySlider = LM.GUI.Slider(math.ceil(mainW / 1.111), true, true, 0) --LM.GUI.FOLLOW_LEFT
					d.colorSlider = LM.GUI.Slider(mainW / 1.3, true, false, LS_ShapesWindowDialog.COLORSLIDER) --LM.GUI.FOLLOW_LEFT
					d.colorSlider:SetToolTip("Color Slider")
					d.colorSlider:SetRange(-255, 0)
					d.colorSlider:SetValue(-255)
					d.colorSlider:SetSnapToTicks(false)
					l:AddChild(d.colorSlider, LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(-1)
					d.colorPreview = MOHO.MeshPreview(mainW - 2, mainW / 1.6)
					l:AddChild(d.colorPreview)
				l:Pop() --H
				--]]
				l:PushH(LM.GUI.ALIGN_LEFT, 0)
					l:AddPadding(-31)
					l:PushV(LM.GUI.ALIGN_LEFT, 0)
						--d.dummySlider = LM.GUI.Slider(math.ceil(mainW / 1.111), true, true, 0) --LM.GUI.FOLLOW_LEFT
						d.colorSlider = LM.GUI.Slider((mainW + butW + butW1) / 1.6, true, false, LS_ShapesWindowDialog.COLORSLIDER) --LM.GUI.FOLLOW_LEFT
						d.colorSlider:SetToolTip("Color Slider")
						d.colorSlider:SetRange(-255, 0)
						d.colorSlider:SetValue(-255)
						d.colorSlider:SetSnapToTicks(false)
						d.colorSlider:Enable(false)
						l:AddChild(d.colorSlider, LM.GUI.ALIGN_FILL, 0)
						d.dummySpacer = LM.GUI.DynamicText("", 50)
						l:AddPadding(-d.dummySpacer:Height())
						l:AddChild(d.dummySpacer, LM.GUI.ALIGN_LEFT, 0)
					l:Pop() --H
					l:AddPadding(-19)
					d.colorPreview = MOHO.MeshPreview(mainW + butW + butW1 + padH, (mainW + butW + butW1 + padH) / 1.6)
					l:AddChild(d.colorPreview, LM.GUI.ALIGN_CENTER)
				l:Pop() --H
			end
		end
		if LS_ShapesWindow.showInfobar then
			if LS_ShapesWindow.advanced then 
				--l:AddPadding(-1)
				--d.dummyList2 = LM.GUI.ImageTextList(0, 1, 0) -- Keep it just in case a separator be more necessary at some point... 
				--l:AddChild(d.dummyList2, LM.GUI.ALIGN_FILL, 0)
				--l:AddPadding(-2)
				l:AddPadding(LS_ShapesWindow.swatch == -1 and 2 or 0)
			else
				--l:AddPadding(-4)
			end
			l:PushV(LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(-2)
				--[[20231011-1700: A try to make it look a little better when text doesn't fit...
				d.infobarDots = LM.GUI.StaticText("…", 0)
				l:AddChild(d.infobarDots, LM.GUI.ALIGN_RIGHT, 0)
				l:AddPadding(-d.infobarDots:Height())
				--]]
				d.infobar = LM.GUI.DynamicText("ℹ Room For Some Info", 0) --d.infobar:Enable(false) --d.infobar = LM.GUI.TextControl(mainW - 2, "Room For Name", 0, LM.GUI.FIELD_TEXT, " ℹ")
				l:AddChild(d.infobar, LM.GUI.ALIGN_FILL, 4)
			l:Pop() --V
		end
	l:Pop() --V

	return d
end

--function LS_ShapesWindowDialog:UpdateWidgets(moho) --print("LS_ShapesWindowDialog:UpdateWidgets(" .. tostring(moho) .. "): ", " 🕗: " .. os.clock())
	-- This only run once upon opening the dialog even if its modeless, so using "Update()" function bellow for al purposes instead. 🤔 Not sure if at some point it may have some use...
--end

function LS_ShapesWindowDialog:Update() --print("LS_ShapesWindowDialog:Update(" .. tostring(moho) .. "): ", " 🕗: " .. os.clock())
	--local caller = debug.getinfo(5) and debug.getinfo(5).name or "NULL" print(caller) --0: getinfo, 1: Update, 2: func, 3: NULL/NULL, 4: NULL/UpdateUI, 5: NULL/NULL
	local helper = MOHO.ScriptInterfaceHelper:new_local()
	local moho = helper:MohoObject()
	local pro = MOHO.IsMohoPro()
	local doc = moho.document --print("UP: " .. (doc and doc:Name()) or "No Doc") --20240103-1809: Back to normality after fixing the casue of opening document mess? (TBO!)
	--local doc = (LS_ShapesWindow.defDoc and LS_ShapesWindow.defDoc ~= moho.document) and LS_ShapesWindow.defDoc or moho.document --print("UP: " .. (doc and doc:Name()) or "No Doc") --20240102-1638: A try to fix/patch the new opening document mess for now... (TBO!)
	local docName = doc and doc:Name() or nil
	local docH = doc and doc:Height() or 240
	local tool = (doc ~= nil and doc:Name() ~= "-") and moho:CurrentTool() or "" --20231223-2350: Extra-checking is for avoiding crashes upon auto-opening
	local toolsDisabled = moho:DisableDrawingTools()
	local mode = LS_ShapesWindow.mode
	local modes = {[0] = "/Windows/Style/DefaultsForNewShapes=DEFAULTS (For new shapes)", "/Windows/Style/SHAPE=SHAPE", "/Windows/Style/STYLE=STYLE"}
	local l = self.GetLayout and self:GetLayout() or nil --20231223-2350: Extra-checking is for avoiding crashes upon auto-opening
	local msg = self.msg ~= nil and self.msg or MOHO.MSG_BASE
	local info = {sep = " • "} --[1] = "ℹ ", [2] = "🆔 ", [3] = "#️⃣ ", [4] = "♒ " --sep: •·∙⸱∣
	local itemsSel = self.itemList and math.floor(self.itemList:NumSelectedItems()) or 0
	self.tempShape = moho:NewShapeProperties() or MOHO.MohoGlobals.NewShapeProperties

	local styleName = moho:CurrentEditStyle() and tostring(moho:CurrentEditStyle().fName:Buffer()) or ""
	local style = moho:CurrentEditStyle() -- 20231010-0554: For some reason, "styleName" must be gathered before this assignment, otherwise it won't be possible to access "style" properties afterwards!
	local styleID = -1	--print(styleName .. " (" .. tostring(style) .. "): ", tostring(style.fFillCol.value.r), ", ", tostring(style.fFillCol.value.g), ", ", tostring(style.fFillCol.value.b))
	local styleUUID = style and style.fUUID:Buffer() or "" --doc:StyleByID(i) print(iStyle.fUUID:Buffer())
	local styles = doc and math.floor(doc:CountStyles()) or 0
	local stylesSel = self.itemList and (math.floor(self.itemList:NumSelectedItems() + (self.itemList:IsItemSelected(0) == true and -1 or 0))) or 0
	local style1Name, style2Name = (self.tempShape and self.tempShape.fInheritedStyle) and tostring(self.tempShape.fInheritedStyle.fName:Buffer()) or "", (self.tempShape and self.tempShape.fInheritedStyle2) and tostring(self.tempShape.fInheritedStyle2.fName:Buffer()) or "" -- See note 20231010-0554 above!
	local style1, style2 = self.tempShape and self.tempShape.fInheritedStyle or nil, self.tempShape and self.tempShape.fInheritedStyle2 or nil
	local style1UUID, style2UUID = style1 and style1.fUUID:Buffer() or nil, style2 and style2.fUUID:Buffer() or nil
	local style1ID, style2ID = LS_ShapesWindow:StyleID(doc, style1), LS_ShapesWindow:StyleID(doc, style2)

	if (style ~= nil) then
		if LS_ShapesWindow.advanced then
			self.fillCol:SetValue(style.fFillCol and style.fFillCol.value or MOHO.MohoGlobals.FillCol)
			self.lineCol:SetValue(style.fLineCol and style.fLineCol.value or MOHO.MohoGlobals.LineCol)
			self.lineWidth:SetValue((style.fLineWidth ~= nil and style.fLineWidth or moho:NewShapeLineWidth()) * docH)
			self.capsBut:SetValue(style.fLineCaps == nil or style.fLineCaps == 1) --style.fLineCaps ~= nil and (style.fLineCaps == 1 and true or false)
			--self.capsBut:SetValue(style.fLineCaps == 1 and true or false)
			--print(self.colorSliderVal, ", ", self.colorSlider and self.colorSlider:Value() or "?")
			if LS_ShapesWindow.swatch ~= -1 and LS_ShapesWindow.swatch ~= self.swatch then
				self:UpdateColor(moho)
			end
		end
		if styleName == "" then
			LS_ShapesWindow.mode = LS_ShapesWindow.mode ~= 2 and 0 or LS_ShapesWindow.mode
			if LS_ShapesWindow.mode == 0 then
				self.modeBut:SetLabel(MOHO.Localize(modes[LS_ShapesWindow.mode]):gsub("%s+%b()", "")) self.modeBut:Redraw()  --Mode: 0 (DEFAULTS) --:match("%w+")) -- Exclude everything between the patenthesis, including the preceding space, instead?
				--self.itemName:SetValue("")
			elseif LS_ShapesWindow.mode == 2 then
				self.modeBut:SetLabel(MOHO.Localize(modes[LS_ShapesWindow.mode])) self.modeBut:Redraw() --Mode: 2 (STYLE)
			end
			info[1] = moho:DrawingMesh() and "🦠" or "ℹ " .. MOHO.Localize("/LS/ShapesWindow/NotAVectorLayer=Not a vector layer...") --"" .. MOHO.Localize("/Windows/Style/DefaultsForNewShapes=DEFAULTS (For new shapes)"):gsub("%s+%b()", "")
			info[2] = moho:DrawingMesh() and "#️⃣ " .. math.floor(moho:CountShapes()) or nil --info[2] = moho:CountShapes() > 0 and "#️⃣ " .. math.floor(moho:CountShapes()) or nil
		else
			LS_ShapesWindow.mode = 2
			self.modeBut:SetLabel(MOHO.Localize(modes[LS_ShapesWindow.mode])) self.modeBut:Redraw() --Mode: 2 (STYLE)
			self.itemName:SetValue(styleName or "?")
			info[1] = doc and "🔘" or  "ℹ " .. MOHO.Localize("/LS/ShapesWindow/NoDocumentOpen=No document open...") --"" .. MOHO.Localize("/Windows/Style/STYLE=STYLE")
			--info[2] = shapeLUID > -1 and "🆔 " .. shapeLUID or "🆔 " .. "?" --string.format("%d", shape:ShapeID())
			info[2] = "🆔 " .. styleID
			info[3] = styles > 0 and "#️⃣ " .. itemsSel .. "/" .. styles or  "#️⃣ " .. styles
			info[4] = "🔣 " .. styleUUID ~= "" and styleUUID or "?"
		end
		for i = 0, styles - 1 do
			local iStyle = doc:StyleByID(i)
			if iStyle == style then
				styleID = math.floor(i)
				break
			elseif iStyle.fSelected then
				styleID = math.floor(i)
			end
		end
	end

	local layer = moho.layer
	local lFrame = moho.layerFrame
	local lDrawing = moho.drawingLayer and moho:LayerAsVector(moho.drawingLayer) or nil
	local lDrawingUUID = lDrawing and lDrawing:UUID() or ""
	local mesh = moho:DrawingMesh()
	local edges = moho:CountEdges()

	---[[20231014-1955: Try to move all this to DoLayout? They may not need to be updated all the time after all...
	--if (msg >= self.MENU1 and msg <= self.MENU1 + self:CountRealItems(self.menu1) - 1) then -- Do nothing else than update the menu?
		self.menu1:SetChecked(self.MENU1, LS_ShapesWindow.pointsBasedSel)
		self.menu1:SetChecked(self.MENU1 + 1, LS_ShapesWindow.ignoreNonRegular)
		self.menu1:SetChecked(self.MENU1 + 2, LS_ShapesWindow.linkToStyle)
		self.menu1:SetChecked(self.MENU1 + 3, LS_ShapesWindow.openOnStartup)
		self.menu1:SetChecked(self.MENU1 + 4, LS_ShapesWindow.showInTools)
		self.menu1:SetChecked(self.MENU1 + 5, LS_ShapesWindow.showAllTooltips)
		self.menu1:SetChecked(self.MENU1 + 6, LS_ShapesWindow.advanced)
		self.menu1:SetChecked(self.MENU1 + 7, LS_ShapesWindow.largeButtons)
		self.menu1:SetChecked(self.MENU1 + 8, LS_ShapesWindow.largePalette)
		self.menu1:SetChecked(self.MENU1 + 9, LS_ShapesWindow.showInfobar)
		--helper:delete()
		--return
	--end
	--]]

	--self.itemNameLabel:Enable(true)
	if LS_ShapesWindow.advanced then
		if self.menu2:CountItems() == 0 then
			self.menu2:AddItem(MOHO.Localize("/Windows/Layers/None=None"), 0, self.MENU2)
			--d.menu2:AddItem(MOHO.Localize("/Windows/Style/Default=Default"):upper() .. " " .. MOHO.Localize("/Windows/Style/Swatches=Swatches"):upper(), 0, self.MENU2 + 3) d.menu2:SetEnabled(self.MENU2 + 3, false) --"/Windows/Style/Swatches=Swatches"
			self.menu2:AddItem("", 0, 0)
			local count = self.MENU2
			for i, doc in ipairs(LS_ShapesWindow.docList) do
				local swatchCount = 0
				local owner = doc:Path():find(moho:UserAppDir() .. "\\Scripts\\ScriptResources\\ls_shapes_window\\Swatches\\") and " (🏭)" or (doc:Path():find(moho:UserAppDir() .. "\\Swatches\\") and " (👤)") or ""
				self.swatches[i] = {}
				for j = doc:CountLayers() - 1, 0, -1 do
					local layer, mesh = doc:Layer(j), nil
					local slider, slider_2 = layer:HasAction("SLIDER") and layer:ActionDuration("SLIDER") == 1 or nil, layer:HasAction("SLIDER 2") and layer:ActionDuration("SLIDER 2") == 1 or nil
					local tags = string.lower(layer:UserTags())
					local icon = (slider or slider_2) and "    🎛 " or "    🎨 " --local icon = (tags:match("picker") or tags:match("chooser") or tags:match("selector")) and "🎨 " or " ⊞  "
					local kind = (layer:LayerType() == MOHO.LT_VECTOR and not layer:IsRenderOnly()) and "swatch" or "other"
					local samples = 0
	
					if j == doc:CountLayers() - 1 then
						table.insert(self.swatches[i], {label = string.upper(doc:Name()), shortcut = 0, msg = 0, id = i, kind = "chunk", suffix = owner, enable = false}) --"🗃 "
					end
					if (layer:LayerType() == MOHO.LT_VECTOR) and not layer:IsRenderOnly() then
						count = count + 1
						swatchCount = swatchCount + 1
						mesh = moho:LayerAsVector(layer):Mesh()
						if mesh and mesh:CountShapes() > 0 then
							self.countFactory = doc:Path():find(moho:UserAppDir() .. "\\Scripts\\ScriptResources\\ls_shapes_window\\Swatches\\") and self.countFactory + 1 or self.countFactory
							table.insert(self.swatches[i], {label = icon .. doc:Layer(j):Name(), shortcut = 0, msg = count, id = j, kind = kind, suffix = "", enable = true}) --self.menu2:AddItem(icon .. doc:Layer(j):Name(), 0, count)
							if mesh:ShapeByName("SLIDER") ~= nil then
								--print(layer:Name())
							end
						end
					end
	
				end
				self.swatches[i].count = swatchCount
				--suffix = countValid > 0 and (doc:Path():find(moho:UserAppDir() .. "\\Scripts\\ScriptResources\\ls_shapes_window\\") and " (Factory)") or (doc:Path():find(moho:UserAppDir() .. "\\Swatches\\") and " (User)") or " (0)"
				--self.menu2:AddItem(string.upper(doc:Name() .. suffix), 0, 0) self.menu2:SetEnabled(0, false)
			end
			if #self.swatches > 0 then
				for i, chunk in ipairs(self.swatches) do
					if chunk.count and chunk.count > 0 then
						for j, item in ipairs(chunk) do
							if (item.kind == "chunk" and chunk.count and chunk.count > 0) or item.kind == "swatch" then
								self.menu2:AddItem(item.label .. (item.msg == 0 and item.suffix or ""), item.shortcut, item.msg) self.menu2:SetEnabled(0, false)
							end
						end
					end
					for j, item in ipairs(chunk) do -- Delete everything else than actual swatches afterwards to avoid table mess...
						if item.kind ~= "swatch" then
							--table.remove(self.swatches[i], j)
						end
					end
				end
			end
			self.menu2:AddItem("", 0, 0)
			self.menu2:AddItem(MOHO.Localize("/LS/ShapesWindow/CutomSwatches=Custom Swatches..."), 0, count + 1) --"/Menus/Interval/Custom=Custom...
			self.menu2:AddItem(MOHO.Localize("/LS/ShapesWindow/UseSelection=Use Selection"), 0,  count + 2) --USE SELECTION (TEMP)
			self.menu2:AddItem(MOHO.Localize("/LS/ShapesWindow/EditCurrentSwatch=Edit Current Swatch"), 0,  count + 3)
			self.menu2:AddItem(MOHO.Localize("/LS/ShapesWindow/ReloadSwatches=Reload Swatches"), 0, count + 4)
		end
	
		self.menu2:UncheckAll()
		--self.menu2:SetChecked(self.MENU2, LS_ShapesWindow.swatch == -1) -- None
		--self.menu2:SetChecked(self.MENU2 + self:CountRealItems(self.menu2) - 1 + 1, LS_ShapesWindow.swatch == -2) -- Use 
		self.menu2:SetChecked((self.MENU2 + LS_ShapesWindow.swatch) + 1, true)
		self.menu2:SetEnabled(self.MENU2 + self:CountRealItems(self.menu2, self.MENU2) - 2, LS_ShapesWindow.swatch > self.countFactory - 1)
	
		for i = self.MENU2 + 3, self.MENU2 + self:CountRealItems(self.menu2, self.MENU2) - 2 do --print(math.abs(self.MENU2 - i))
			--self.menu2:SetChecked(i, LS_ShapesWindow.swatch == math.abs((self.MENU2 + 3) - i)) -- List Entry
		end

		--self.menuStyle1:RemoveAllItems()
		--self.menuStyle1:AddItem(MOHO.Localize("/Windows/Style/New=New"), 0, baseMsg)
		--self.menuStyle1:AddItem("", 0, 0)
		--self.menuStyle1:AddItem(MOHO.Localize("/Scripts/Utility/None=<None>"), 0, baseMsg)
		LS_ShapesWindow:BuildStyleChoiceMenu(self.menuStyle1, doc, self.SELECTSTYLE1, self.DUMMY)
		LS_ShapesWindow:BuildStyleChoiceMenu(self.menuStyle2, doc, self.SELECTSTYLE2, self.DUMMY)
	
		--self.shapeCreationLabel:Enable(not toolsDisabled)
		for i, but in ipairs(self.shapeButtons) do
			but:Enable(edges > 0 and not toolsDisabled)
		end
	end

	--self.menu1Popup:Enable(self.menu1Popup and self.menu1:CountItems() > 0 or false)
	--self.menu2Popup:Enable(self.menu2Popup and self.menu2:CountItems() > 0 or false)
	--self.menu3Popup:Enable(self.menu3Popup and self.menu3:CountItems() > 0 or false)

	if (mesh == nil) or ((lDrawing and lDrawing:IsCurver()) or (lDrawing:IsWarpLayer() and (lDrawing:ContinuousTriangulation() or LS_ShapesWindow.ignoreNonRegular))) then -- Disable everything irrelevant if no valid/drawing layer is active ("Ignore Non-Regular" makes e.g. non-continuously-triangulated layers be also ignored).
		--l:Enable(false) -- Used classic enable/disable method due to this causes unwanted blinking at frame change and so...
		self.modeBut:Enable(false)
		self.itemName:Enable(false)
		self.itemName:SetValue("") --LS_ShapesWindow.mode < 2 and MOHO.Localize("/LS/ShapesWindow/NoVectors=No Vectors...") or ""
		self.itemVisCheck:Enable(false)
		self.itemVisCheck:SetValue(false)
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
		self.combineBlend:SetValue(0)
		self.mergeBut:Enable(false)
		self.baseBut:Enable(false)
		self.baseBut:SetValue(false)
		self.topBut:Enable(false)
		self.topBut:SetValue(false)
		self.raise:Enable(false)
		self.lower:Enable(false)
		self.selectAllBut:Enable(false)
		self.selectSimilarBut:Enable(false)
		self.deleteBut:Enable(false)
		self.copyBut:Enable(true)
		self.pasteBut:Enable(true)
		self.resetBut:Enable(true)
		
		self.skipBlock = true
		for i = self.itemList:CountItems(), 1, -1 do
			self.itemList:RemoveItem(i, false)
		end
		self.skipBlock = false
		self.itemList:Enable(false)
		self.itemList:Redraw()

		self.menu1Popup:Enable(true)
		if LS_ShapesWindow.advanced then
			--self.shapeCreationLabel:Enable(false)
			self.fillCheck:Enable(false)
			self.fillCheck:SetValue(true)
			self.fillCol:Enable(true)
			self.fillColOverride:Enable(false)
			self.fillColOverride:SetValue(false)
			self.lineCheck:Enable(false)
			self.lineCheck:SetValue(true)
			self.lineCol:Enable(true)
			self.lineColOverride:Enable(false)
			self.lineColOverride:SetValue(false)
			self.widthLabel:Enable(true)
			self.lineWidth:Enable(true)
			self.lineWidthOverride:Enable(false)
			self.lineWidthOverride:SetValue(false)
			self.capsBut:Enable(true)
			self.menuStyle1:SetChecked(style1 and self.SELECTSTYLE1 + 1 + style1ID or self.SELECTSTYLE1, true) self.menuStyle1Popup:Redraw()
			self.menuStyle2:SetChecked(style2 and self.SELECTSTYLE2 + 1 + style2ID or self.SELECTSTYLE2, true) self.menuStyle2Popup:Redraw()
		end
		if (LS_ShapesWindow.showInfobar and self.infobar ~= nil) then
			self.infobar:SetValue(table.concat(info, info.sep or " • "):gsub("^" .. info.sep .. " *", ""))
		end

		if (doc == nil) then -- Disable everything else irrelevant if there is no document open
			self.menu1:SetEnabled(self.MENU1 + 5, false) -- Advanced (Create)
			self.menu1:SetEnabled(self.MENU1 + 6, false) -- Use Large Buttons
			self.menu1:SetEnabled(self.MENU1 + 7, false) -- Use Large Palette
			self.menu1:SetEnabled(self.MENU1 + 8, false) -- Show Infobar
			self.copyBut:Enable(false)
			self.pasteBut:Enable(false)
			--[[20231214-0521: Commented in order to see if it's really necessary...
			if (LS_ShapesWindow.mode > 1) then
				self.skipBlock = true
				for i = self.itemList:CountItems(), 1, -1 do
					self.itemList:RemoveItem(i, false)
				end
				self.skipBlock = false
			end
			--]]
			if LS_ShapesWindow.advanced then
				--self.shapeCreationLabel:Enable(false)
				self.menuStyle1:SetChecked(self.SELECTSTYLE1, true) self.menuStyle1Popup:Redraw()
				self.menuStyle2:SetChecked(self.SELECTSTYLE2, true) self.menuStyle2Popup:Redraw()
				if (LS_ShapesWindow.showInfobar and self.infobar ~= nil) then
					info[1] = doc and "🔘" or  "ℹ " .. MOHO.Localize("/LS/ShapesWindow/NoDocumentOpen=No document open...")
					self.infobar:SetValue(table.concat(info, info.sep or " • "):gsub("^" .. info.sep .. " *", ""))
				end
			end
		end

		helper:delete()
		return
	else -- Enable everything relevant if a valid/drawing layer is active
		--l:Enable(true) -- Used classic enable/disable method due to this causes unwanted blinking at frame change and so...
		self.menu1:SetEnabled(self.MENU1 + 5, true) -- Advanced (Create)
		self.menu1:SetEnabled(self.MENU1 + 6, true) -- Use Large Buttons
		self.menu1:SetEnabled(self.MENU1 + 7, true) -- Use Large Palette
		self.menu1:SetEnabled(self.MENU1 + 8, true) -- Show Infobar
		self.modeBut:Enable(true)
		--[[20231208-0555: Here seems to be the problem with the unnecesary shape list refreshing upon frame change... STUDY!
		if (LS_ShapesWindow.mode ~= self.mode) then
			self.skipBlock = true
			for i = self.itemList:CountItems(), 1, -1 do
				self.itemList:RemoveItem(i, false)
			end
			self.skipBlock = false
		end
		--]]
		self.itemList:Enable(true)
		self.itemList:Redraw()

		if LS_ShapesWindow.advanced then
			--self.shapeCreationLabel:Enable(true) --self.shapeCreationLabel:Enable(not toolsDisabled)
			for i, but in ipairs(self.shapeButtons) do
				but:Enable(edges > 0 and not toolsDisabled)
			end
		end
	end

	---[[20231006-1745: Before selecting items in list much bellow, do here the "Points-Based Selection" thing if active (so then you can rely on shape/shapeID/etc. kind of values)
	if mesh ~= nil and not (lDrawing:IsCurver() or lDrawing:IsWarpLayer()) then
		if (LS_ShapesWindow.pointsBasedSel and not tool:find("SelectShape")) then
			if styleName == "" and moho:CountSelectedPoints() > 1 then -- Avoid Points-Based Selection select any shape if a style is being edited to allow normal Style workflow. 
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
	--local shapeStyle1, shapeStyle2
	--local shapeStyle1UUID, shapeStyle2UUID
	--local shapeStyle1ID, shapeStyle2ID

	if (shape ~= nil) then
		LS_ShapesWindow.mode = 1
		style1, style2 = shape.fInheritedStyle, shape.fInheritedStyle2
		style1UUID, style2UUID = style1 and style1.fUUID:Buffer() or nil, style2 and style2.fUUID:Buffer() or nil
		style1ID, style2ID = LS_ShapesWindow:StyleID(doc, style1), LS_ShapesWindow:StyleID(doc, style2)

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
					self.baseBut:Enable(position > 1)
					self.topBut:Enable(position < total)
					self.mergeBut:Enable(true)
					info[4] = "♒ ".. position .. "/" .. total --≈≋💧
				else
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
				self.baseBut:Enable(false)
				self.topBut:Enable(false)
				self.mergeBut:Enable(false)
				info[4] = nil
			end
		end

		--self.modeBut:Enable(true)
		self.itemName:Enable(true)
		self.itemPreview:Enable(true)
		self.itemVisCheck:Enable(true)
		self.itemVisCheck:SetValue(not shape.fHidden)
		if LS_ShapesWindow.advanced then
			self.fillCheck:SetValue(shape.fHasFill)
			self.fillCheck:Enable(shape.fFillAllowed)
			self.fillCol:Enable(shape.fHasFill)
			self.fillColOverride:Enable(style1 and style1.fDefineFillCol or style2 and style2.fDefineFillCol)
			self.fillColOverride:SetValue(shape.fMyStyle.fDefineFillCol)
			self.lineCheck:SetValue(shape.fHasOutline)
			self.lineCheck:Enable(true)
			self.lineCol:Enable(shape.fHasOutline)
			self.lineColOverride:Enable(style1 and style1.fDefineLineCol or style2 and style2.fDefineLineCol)
			self.lineColOverride:SetValue(shape.fMyStyle.fDefineLineCol)
			self.lineWidthOverride:Enable(style1 and style1.fDefineLineWidth or style2 and style2.fDefineLineWidth)
			self.lineWidthOverride:SetValue(shape.fMyStyle.fDefineLineWidth)
			self.menuStyle1:SetChecked(style1 and self.SELECTSTYLE1 + 1 + style1ID or self.SELECTSTYLE1, true) self.menuStyle1Popup:Redraw()
			self.menuStyle2:SetChecked(style2 and self.SELECTSTYLE2 + 1 + style2ID or self.SELECTSTYLE2, true) self.menuStyle2Popup:Redraw()
		end
		self.deleteBut:Enable(true)
		self.modeBut:SetLabel(MOHO.Localize(modes[LS_ShapesWindow.mode]):gsub("%s+%b()", "")) self.modeBut:Redraw() --Mode: 1 (SHAPE)
		info[1] = "🦠" --"" .. MOHO.Localize("/Windows/Style/SHAPE=SHAPE")
		info[2] = shapeLUID > -1 and "🆔 " .. shapeLUID or "🆔 " .. "?" --string.format("%d", shape:ShapeID())
		info[3] = shapes > 0 and "#️⃣ " .. shapesSel .. "/" .. shapes or shapes
	else
		LS_ShapesWindow.mode = LS_ShapesWindow.mode == 2 and LS_ShapesWindow.mode or 0
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
			self.baseBut:Enable(false)
			self.topBut:Enable(false)
			self.mergeBut:Enable(false)
		end

		self.deleteBut:Enable(false)
		self.itemName:Enable(false)
		self.itemVisCheck:Enable(false)
		self.itemVisCheck:SetValue(true)
		self.itemPreview:Enable(false)
		if LS_ShapesWindow.advanced then
			self.fillCheck:SetValue(true)
			self.fillCheck:Enable(false)
			self.fillCol:Enable(true)
			self.fillColOverride:Enable(false)
			self.fillColOverride:SetValue(false)
			self.lineCheck:SetValue(true)
			self.lineCheck:Enable(false)
			self.lineCol:Enable(true)
			self.lineColOverride:Enable(false)
			self.lineColOverride:SetValue(false)
			self.lineWidthOverride:Enable(false)
			self.lineWidthOverride:SetValue(false)
			self.menuStyle1:SetChecked(style1 and self.SELECTSTYLE1 + 1 + style1ID or self.SELECTSTYLE1, true) self.menuStyle1Popup:Redraw()
			self.menuStyle2:SetChecked(style2 and self.SELECTSTYLE2 + 1 + style2ID or self.SELECTSTYLE2, true) self.menuStyle2Popup:Redraw()
		end
		if LS_ShapesWindow.mode == 2 then
			info[1] = doc and "🔘" or  "ℹ " .. MOHO.Localize("/LS/ShapesWindow/NoDocumentOpen=No document open...") --"" .. MOHO.Localize("/Windows/Style/STYLE=STYLE")
			info[2] = "🆔 " .. styleID
			info[3] = styles > 0 and "#️⃣ " .. itemsSel .. "/" .. styles or  "#️⃣ " .. styles
			info[4] = "🔣 " .. styleUUID ~= "" and styleUUID or "?"
		end
	end

	self:UpdateItem(moho, shape, false) --20240103-0448: Had to avoid draw fills due to a last minute weird behavior upon undoing after modifyig shapes! (TODO & TBO!)
	local infoContent = table.concat(info, info.sep or " • "):gsub("^" .. info.sep .. " *", "")
	if (LS_ShapesWindow.showInfobar) and self.infobar then
		self.infobar:SetValue(infoContent) --self.infobar:SetValue(#infoContent > 30 and (infoContent):sub(1, 30) .. "…" or infoContent) -- 2023101011-1530: Discarted for now, since string.sub can "destroy" emojis and cause problems! 
		self.infobar:SetToolTip(#infoContent > 36 and infoContent or "")
		self.infobar:Enable(false)
	else
		if self.infobar then
			self.infobar:SetValue("")
		end
		--self.itemNameLabel:SetToolTip(MOHO.Localize("/Windows/Style/Name=Name") .. " (" .. infoContent .. ")")
		self.itemPreview:SetToolTip(infoContent)
	end

	if self.skipBlock == true then --if self.skipBlock == true and tool:find("SelectPoints") then -- 20231007-1730: Perform ONLY widget updates above when called from HandlMessage/UpdateUI in order to avoid entering into endless loop!
		return
	end

	if LS_ShapesWindow.mode < 2 then --if Shapes Mode
		local shapeTable = {}
		for i = 1, shapes do -- Current shapes state
			local shape = mesh:Shape(i - 1)
			shapeTable[0] = lDrawingUUID
			shapeTable[i] = shape:Name() .. shape.fComboMode .. (shape.fHidden == true and " *" or "")
		end	--print(#self.shapeTable, ":", table.concat(self.shapeTable, ", "))

		if self.itemList:CountItems() == 1 or self.shapeTable and (#self.shapeTable ~= #shapeTable or table.concat(self.shapeTable) ~= table.concat(shapeTable) or (LS_ShapesWindow.mode ~= self.mode)) then
			self.skipBlock = true
			for i = self.itemList:CountItems(), 1, -1 do
				self.itemList:RemoveItem(i, false)
			end

			for i = shapes - 1, 0, -1 do
				local shape = mesh:Shape(i)
				local cMode = (shape.fComboMode == MOHO.COMBO_ADD and "+") or (shape.fComboMode == MOHO.COMBO_SUBTRACT and "- ") or (shape.fComboMode == MOHO.COMBO_INTERSECT and "×") or "  " --⊕⊝⊖⊗⊘
				local vMode = (shape.fHidden == true and " *" or "")

				if shape == shape:BottomOfCluster() then
					self.itemList:AddItem("↳  " .. cMode .. " " .. shape:Name() .. vMode, false)
				elseif shape == shape:TopOfCluster() then
					self.itemList:AddItem("↱  " .. cMode .. " " .. shape:Name() .. vMode, false)
				else
					if shape:IsInCluster() then
						self.itemList:AddItem("    " .. cMode .. " " .. shape:Name() .. vMode, false)
					else
						self.itemList:AddItem(shape:Name() .. vMode, false)
					end
				end
			end
			self.skipBlock = false
		end

		self.skipBlock = true
		local first = false
		for i = 1, self.itemList:CountItems() - 1 do
			local shape = mesh:Shape(i - 1) --print(i, ": ", shape and "Name: " .. shape:Name() or "NO SHAPE")
			if shape.fSelected == true then
				if not self.itemList:IsItemSelected(shapes - i + 1) or shapesSel ~= itemsSel then
					self.itemList:SetSelItem(self.itemList:GetItem(shapes - i + 1), false, first) -- 20231008-0037: Changing redraw (2nd ar.) to false in a try to improve performace... (TBD) 
					first = true
				end
			end
		end
		if shapeID and shapeID >= 0 then
			self.itemName:Enable(true)
			self.itemName:SetValue(mesh:Shape(shapeID):Name())
			--self.itemVisCheck:Enable(true) -- 20231129-2233 (TODO): Study if necessary...
			--self.itemVisCheck:SetValue(not mesh:Shape(shapeID).fHidden) -- 20231129-2233 (TODO): Study if necessary...
			self.itemList:ScrollItemIntoView(shapes - shapeID, true)
		elseif shapeID < 0 then
			self.itemName:Enable(false)
			self.itemName:SetValue(" " .. MOHO.Localize("/LS/ShapesWindow/ShapeManagement=Shape Management") .. " ")

			if not self.itemList:IsItemSelected(0) then
				self.itemList:SetSelItem(self.itemList:GetItem(0), true, false) -- 20230920-1605: Had to pass false for redraw (2nd arg.) to avoid items deselection! 20231008-0036: Passing true again, otherwise <None> item isn't selected upon e.g. deselecting all
				self.itemList:ScrollItemIntoView(0, true) -- It doesn't seem to scroll to item 0
			end
		end
		self.skipBlock = false
	else -- if Styles Mode
		local styleTable = {}
		for i = 1, styles do -- Current styles state
			local iStyle = doc:StyleByID(i - 1)
			styleTable[0] = lDrawingUUID
			styleTable[i] = iStyle.fName:Buffer()
		end	--print(#self.styleTable, ":", table.concat(self.styleTable, ", "))

		if self.itemList:CountItems() == 1 or self.styleTable and (#self.styleTable ~= #styleTable or table.concat(self.styleTable) ~= table.concat(styleTable) or (LS_ShapesWindow.mode ~= self.mode)) then
			self.skipBlock = true
			for i = self.itemList:CountItems(), 1, -1 do
				self.itemList:RemoveItem(i, false)
			end

			for i = 0, styles - 1 do
				local iStyle = doc:StyleByID(i)
				self.itemList:AddItem(iStyle.fName:Buffer(), false)
			end
			self.skipBlock = false
		end

		self.skipBlock = true
		local first = false
		if (style and styleName ~= "") then
			for i = 0, styles - 1 do --for i = 1, self.itemList:CountItems() - 1 do
				local iStyle = doc:StyleByID(i)
				if (iStyle and iStyle.fUUID:Buffer() == styleUUID) then
					iStyle.fSelected = true
					self.selItem = i + 1
				else
					iStyle.fSelected = false
				end
			end
			--if self.itemList:NumSelectedItems() > 1 then
				--self.itemList:SetSelItem(self.itemList:GetItem(0), false, false) -- Select None before if current selItem is part of a multi-selection
			--end
			--if not self.itemList:IsItemSelected(self.selItem) then
				self.itemList:SetSelItem(self.itemList:GetItem(self.selItem), false, false)
				self.itemList:ScrollItemIntoView(self.selItem, true)
			--end
		else -- 202401040525: Ensure <None> is selected when entering manually to STYLE Mode? (TBC/TODO)
			for i = 0, styles - 1 do
				local iStyle = doc:StyleByID(i) --print(iStyle.fName:Buffer(), ", ", tostring(iStyle.fSelected))
				if iStyle.fSelected == true then --and not self.itemList:IsItemSelected(i + 1)
					if not self.itemList:IsItemSelected(i + 1) or stylesSel ~= itemsSel then
						self.itemList:SetSelItem(self.itemList:GetItem(i + 1), false, first) -- 20231008-0037: Changing redraw (2nd ar.) to false in a try to improve performace... (TBD) 
						first = true
						--self.selItem = 0
					end
				end
			end
			self.itemName:SetValue(self.itemList:SelItem() > 0 and self.itemList:SelItemLabel() or "  " .. MOHO.Localize("/LS/ShapesWindow/StyleManagement=Style Management") .. "  ")
			if styleID and styleID >= 0 then
				--?
			elseif styleID < 0 then
				if not self.itemList:IsItemSelected(0) then
					self.itemList:SetSelItem(self.itemList:GetItem(0), true, false)
					self.itemList:ScrollItemIntoView(0, true)
				end
			end
		end
		self.skipBlock = false
		self.itemName:Enable(self.itemList:SelItem() > 0)
		self.deleteBut:Enable(stylesSel > 0)
	end

	self.raise:Enable(((LS_ShapesWindow.mode < 2) and shapeID and shapeID >= 0) and self.itemList:SelItem() > 1 or false) --print(self.itemList:SelItem(), ", ", self.itemList:SelItemLabel())
	self.raise:SetToolTip(LS_ShapesWindow.mode < 2 and MOHO.Localize("/Menus/Draw/RaiseShape=Raise Shape") .. " (<alt> " .. MOHO.Localize("/Menus/Draw/RaiseToFront=Raise To Front") .. ")" or "")
	self.lower:Enable(((LS_ShapesWindow.mode < 2) and shapeID and shapeID >= 0) and (self.itemList:SelItem() > 0 and self.itemList:SelItem() < self.itemList:CountItems() - 1) or false)
	self.lower:SetToolTip(LS_ShapesWindow.mode < 2 and MOHO.Localize("/Menus/Draw/LowerShape=Lower Shape") .. " (<alt> " .. MOHO.Localize("/Menus/Draw/LowerToBack=Lower To Back") .. ")" or "")

	self.selectAllBut:Enable((LS_ShapesWindow.mode < 2 and shapes > 0) or (LS_ShapesWindow.mode == 2 and style ~= nil and styles > 0))
	--self.selectAllBut:SetLabel(LM_SelectShape:CountSelectedShapes(moho) == mesh:CountShapes() and "✅" or "☑", false) -- 20230922: It seems to tail some text??
	--self.selectAllBut:Redraw()
	self.deleteBut:SetToolTip((LS_ShapesWindow.mode < 2) and MOHO.Localize("/Scripts/Tool/DeleteShape/DeleteShapes=Delete Shape") .. "/s" or MOHO.Localize("/LS/ShapesWindow/DeleteStyles=Delete Style/s"))
	self.selectSimilarBut:Enable((LS_ShapesWindow.mode < 2 and shape ~= nil and shapesSel == 1 and shapes > 1) or (LS_ShapesWindow.mode == 2 and style ~= nil and stylesSel == 1 and styles > 1)) 
	self.selectSimilarBut:SetToolTip(MOHO.Localize("/LS/ShapesWindow/SelectSimilar=Select Similar") .. (LS_ShapesWindow.mode < 2 and " (<alt> " .. MOHO.Localize("/LS/ShapesWindow/IncludingStyles=Including styles") .. ")" or ""))
	self.checkerSelBut:SetValue(MOHO.MohoGlobals.SelectedShapeCheckerboard)

	if LS_ShapesWindow.advanced then 
		local createCursor = LS_ShapesWindow.mode < 2 and "ScriptResources/../../Support/Scripts/Tool/lm_select_shape_cursor" or "ScriptResources/../../Support/Scripts/Tool/lm_colorpoints_cursor"
		for i, but in ipairs(self.shapeButtons) do
			but:SetCursor(LM.GUI.Cursor(createCursor, 0, 0)) --ScriptResources/../../Support/Scripts/Tool/lm_colorpoints_cursor
		end
		self.menuStyle1Popup:Enable(styleName == "") self.menuStyle1Popup:Redraw()
		self.menuStyle1Popup:SetToolTip(MOHO.Localize("/Windows/Style/Style1=Style 1") .. (style1Name ~= ""  and ": " .. style1Name or "") .. " (" ..  MOHO.Localize("/LS/ShapesWindow/AppliesAbove=Applies Above") .. ")")
		self.menuStyle1Popup:SetCursor(LM.GUI.Cursor("ScriptResources/ls_shapes_window/ls_shape_style_1_cursor", 0, 0))
		self.menuStyle2Popup:Enable(styleName == "") self.menuStyle2Popup:Redraw()
		self.menuStyle2Popup:SetToolTip(MOHO.Localize("/Windows/Style/Style2=Style 2") .. (style2Name ~= ""  and ": " .. style2Name or "") .. " (" ..  MOHO.Localize("/LS/ShapesWindow/AppliesBellow=Applies Bellow") .. ")")
		self.menuStyle2Popup:SetCursor(LM.GUI.Cursor("ScriptResources/ls_shapes_window/ls_shape_style_2_cursor", 0, 0))
		self.menu2Popup:SetToolTip(LS_ShapesWindow.showAllTooltips and MOHO.Localize("/Windows/Style/Swatches=Swatches") .. " (" .. self.menu2:FirstCheckedLabel():gsub("^%s+", "") .. ")" or "")
		self.menu2Popup:SetCursor(LM.GUI.Cursor("ScriptResources/ls_shapes_window/ls_swatches_cursor", 0, 0)) --"ScriptResources/../../Support/Scripts/Tool/lm_video_tracking_cursor"
		if LS_ShapesWindow.swatch ~= -1 and LS_ShapesWindow.swatch ~= self.swatch and self.colorSlider then
			if self.menu2:FirstCheckedLabel():match("🎛") then --20231030-1140: Kind of dirty solution based on current swatch label... Improve! (TODO) 
				self.colorSlider:Enable(true)
				self.colorSlider:Redraw()
				self.colorSlider:SetCursor(LM.GUI.Cursor("ScriptResources/../../Support/Scripts/Tool/lm_zoom_camera_cursor", 0, 0))
			else
				self.colorSlider:Enable(false)
				self.colorSlider:SetCursor() -- Reset default cursor
			end
			self.colorPreview:Refresh() --self:UpdateColor(moho)
		end
	end

	self.modeBut:SetToolTip(MOHO.Localize("/LS/ShapesWindow/Mode=Mode: ") .. MOHO.Localize(modes[LS_ShapesWindow.mode]))
	if (LS_ShapesWindow.showAllTooltips ~= self.showAllTooltips) or self.isNewRun then -- Avoid unnecesary tooltip updates
		self.menu1Popup:SetToolTip(LS_ShapesWindow.showAllTooltips and MOHO.Localize("/Dialogs/LayerSettings/General=General") or "")
		--self.menu3Popup:SetToolTip(LS_ShapesWindow.showAllTooltips and MOHO.Localize("/Windows/Library/More=More:"):gsub("[^%w]$", "") or "")
		--self.itemNameLabel:SetToolTip(MOHO.Localize("/Windows/Style/Name=Name"))
		self.combineBlend:SetToolTip(LS_ShapesWindow.showAllTooltips and MOHO.Localize("/Scripts/Tool/SelectShape/Blend=Blend:"):gsub("[^%w]$", "") .. " (" .. MOHO.Localize("/Dialogs/NudgeDlog/Amount=Amount") ..")" or "") -- Remove any non-alphanumeric ending character
		self.baseBut:SetToolTip(LS_ShapesWindow.showAllTooltips and MOHO.Localize("/Scripts/Tool/SelectShape/SelectBottomOfCluster=Select bottom of Liquid Shape") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All") .. ")" or "")
		self.topBut:SetToolTip(LS_ShapesWindow.showAllTooltips and MOHO.Localize("/Scripts/Tool/SelectShape/SelectTopOfCluster=Select top of Liquid Shape") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All") .. ")" or "")
		--self.shapePaletteLabel:SetToolTip(LS_ShapesWindow.showAllTooltips and MOHO.Localize("/LS/ShapesWindow/ShapePalette=Shape Palette") or "")
		self.showAllTooltips = LS_ShapesWindow.showAllTooltips
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
		self.shapeTable[i] = shape:Name() .. shape.fComboMode .. (shape.fHidden == true and " *" or "")
	end

	styles = doc and doc:CountStyles() or 0
	for i = 0, #self.styleTable do -- Ensure the table is empty before updating! Otherwise if it had more elements, they will remain and the system will think there are more shapes than actually are (force an unnecessary list update).
		self.styleTable[i] = nil
	end
	for i = 1, styles do -- Previous styles state
		local style = doc:StyleByID(i - 1)
		self.styleTable[0] = moho.drawingLayer:UUID()
		self.styleTable[i] = style.fName:Buffer()
	end

	self.mode = LS_ShapesWindow.mode
	self.style = moho:CurrentEditStyle()
	self.swatch = LS_ShapesWindow.swatch
	self.colorSliderVal = self.colorSlider and self.colorSlider:Value() or 1
	self.isNewRun = false
	helper:delete()
end

function LS_ShapesWindowDialog:OnOK() --print("LS_ShapesWindowDialog:OnOK(): ", " 🕗: " .. os.clock()) LM.Snooze(1500)
	local helper = MOHO.ScriptInterfaceHelper:new_local()
	local moho = helper:MohoObject()
	local doc = moho.document

	if LS_ShapesWindow.dlog == nil then -- Reopen the just auto-closed window
		LS_ShapesWindow:Run(moho)
	else
		LS_ShapesWindow.dlog = nil -- Mark the window closed
		LS_ShapesWindow.shouldOpen = false
	end

	if doc and doc:Name() then --20231229-1415: This check seems now necessary to avoid crashes upon closing Moho while dialog is open? But I'd swear not before...
		moho:UpdateUI()
	end
	helper:delete()
end

function LS_ShapesWindowDialog:UpdateItem(moho, shape, fills) --print("LS_ShapesWindowDialog:UpdateItem" .. os.clock())
	local lMesh = moho:DrawingMesh()
	local pMesh = self.itemPreview:Mesh()
	shape = shape or moho:SelectedShape() --print(tostring(shape), ", ", shape and shape:Name() or "NIL")
	pMesh:Clear()
	pMesh:SelectNone()

	if (lMesh ~= nil and shape ~= nil) then
		local single = LS_ShapesWindow:IsSingleCurve(shape) --20240101-1730: Had to exclude multi-curve shapes due to "shape out of range" warnings/crashes. Multi-curve shapes didn't preview accurately anyway... 
		local offset = shape:ShapeCenter()
		if shape.fHasFill and single and not shape.fHidden and fills then --20231219-0342: Had to exclude hidden shapes due to a "shape out of range" crash upon reaching CombineShapes bellow if shape is in intersection liquid mode! TBO...
			local v = LM.Vector2:new_local() -- Create a dummy shape in the middle of what will be the final shape so that CombineShapes can do its job (without throwing errors)
			v:Set(-0.0001, 0.0001) pMesh:AddLonePoint(offset - v, 0)
			v:Set(0.0001, 0.0001) pMesh:AppendPoint(offset - v, 0)
			v:Set(0.0001, -0.0001) pMesh:AppendPoint(offset - v, 0)
			v:Set(-0.0001, -0.0001) pMesh:AppendPoint(offset - v, 0)
			v:Set(-0.0001, 0.0001) pMesh:AppendPoint(offset - v, 0)
			pMesh:WeldPoints(4, 0, 0)
			pMesh:SelectConnected()

			if self.itemPreview:CreateShape(true) then
				if pMesh:CountShapes() > 0 then
					pMesh:Shape(0):SetName("_dummy_shape_")
					pMesh:Shape(0).fHasOutline = shape.fHasOutline
					--if shape.fHidden == true then shape.fHidden = false end
					pMesh:CombineShapes(pMesh:Shape(0), shape, MOHO.COMBO_ADD, 0.0, true)
					pMesh:Shape(1):SetName(shape:Name())
					pMesh:Shape(0):SelectAllPoints()
					pMesh:DeleteShape(0)
					pMesh:DeleteSelectedPoints()

					--[[20231113-0520: Try to delete any segment not present in the original shape? (TODO)
					for copEdg = 0, pMesh:Shape(0):CountEdges() - 1 do
						local copCurID, copSegID = shape:GetEdge(e)
						for origEdg = 0, shape:CountEdges() - 1 do
							local origCurID, origSegID = shape:GetEdge(e)

						end
					end
					--]]
				end
			end
		else
			for e = 0, shape:CountEdges() - 1 do
				local cID, sID = shape:GetEdge(e) --print(tostring(lMesh:Curve(cID).fClosed))
				local startPercent, endPercent = lMesh:Curve(cID):GetSegmentRange(sID)
				local step = (endPercent - startPercent) / 5
				local p1 = lMesh:Curve(cID):GetPercentLocation(startPercent)
				pMesh:AddLonePoint(p1, 0)
	
				for i = 1, 10 do
					local nextPercent = startPercent + step * i
					nextPercent = nextPercent > endPercent and endPercent or nextPercent
					local p2 = lMesh:Curve(cID):GetPercentLocation(nextPercent)
					pMesh:AppendPoint(p2, 0)
				end
			end
			pMesh:SelectConnected()
			if self.itemPreview:CreateShape(false) then
				pMesh:Shape(0):SetName(shape:Name())
			end
		end

		if pMesh:CountShapes() > 0 then
			if shape:HasPositionDependentStyles() and pMesh:Shape(0):HasPositionDependentStyles() then
				--local center, handle = shape:EffectHandle1(), shape:EffectHandle2()
				pMesh:Shape(0).fEffectOffset.value = shape.fEffectOffset.value
				pMesh:Shape(0).fEffectScale.value = shape.fEffectScale.value
				pMesh:Shape(0).fEffectRotation.value = shape.fEffectRotation.value
			end
			--pMesh:Shape(0).fMyStyle.fFillCol = shape.fMyStyle.fFillCol
			--pMesh:Shape(0).fMyStyle.fLineCol = shape.fMyStyle.fLineCol
			--pMesh:Shape(0).fMyStyle.fLineWidth = shape.fMyStyle.fLineWidth
		end

		pMesh:SelectAll()
		pMesh:PrepMovePoints()
		self.itemPreview:AutoZoom()
		pMesh:ScalePoints(0.8, 0.8, pMesh:SelectedCenter(), false)
	end

	self.itemPreview:Refresh()
end

function LS_ShapesWindowDialog:UpdateColor(moho) --print("LS_ShapesWindowDialog:UpdateColor" .. os.clock())
	--local lMesh = moho:DrawingMesh()
	--local pMesh = self.colorPreview and self.colorPreview:Mesh() or nil
	if self.colorPreview and self.colorPreview:Mesh() ~= nil then
		self:UpdatePreview(moho, self.colorPreview)
	end
end

function LS_ShapesWindowDialog:UpdatePreview(moho, preview) --print("LS_ShapesWindowDialog:UpdatePreview" .. os.clock())
	if LS_ShapesWindow.doc ~= nil then -- 20231223-2345: Check to avoid crash upon auto-opening, better try to include the document as argument?
		LS_ShapesWindow.swatchLayer = LS_ShapesWindow.swatchLayer > LS_ShapesWindow.doc:CountLayers() - 1 and LS_ShapesWindow.doc:CountLayers() - 1 or LS_ShapesWindow.swatchLayer --LM.Clamp(LS_ShapesWindow.swatchLayer, 0, LS_ShapesWindow.doc:CountLayers() - 1) --print(LS_ShapesWindow.doc:Name(), ", ", moho.document:Name())
		local layer = LS_ShapesWindow.doc:Layer(LS_ShapesWindow.swatchLayer)
		local lMesh = layer and moho:LayerAsVector(layer):Mesh() or moho:DrawingMesh()
		local pMesh = preview:Mesh()
		local v = LM.Vector2:new_local()
		pMesh:Clear()
		pMesh:SelectNone()

		if (lMesh ~= nil and lMesh:CountShapes() > 0) then
			for i = 0, lMesh:CountShapes() - 1 do
				local shape = lMesh:Shape(i) --print(shape:Name())
				local offset = shape:ShapeCenter()
				pMesh:SelectNone()
				if shape.fHasFill then
					v:Set(-0.0001, 0.0001) pMesh:AddLonePoint(offset - v, 0) -- Create a dummy shape in the middle of what will be the final shape so that CombineShapes work without throwing errors
					v:Set(0.0001, 0.0001) pMesh:AppendPoint(offset - v, 0)
					v:Set(0.0001, -0.0001) pMesh:AppendPoint(offset - v, 0)
					v:Set(-0.0001, -0.0001) pMesh:AppendPoint(offset - v, 0)
					v:Set(-0.0001, 0.0001) pMesh:AppendPoint(offset - v, 0)
					pMesh:WeldPoints(pMesh:CountPoints() - 1, pMesh:CountPoints() - 4, 0)
					pMesh:SelectConnected()
					if preview:CreateShape(true) then
						--if pMesh:CountShapes() > 0 then
							pMesh:Shape(pMesh:CountShapes() - 1):SetName("_dummy_shape_")
							pMesh:ShapeByName("_dummy_shape_").fHasOutline = shape.fHasOutline
							pMesh:ShapeByName("_dummy_shape_"):CopyStyleProperties(shape, false, not shape.fHasOutline)
							pMesh:CombineShapes(pMesh:ShapeByName("_dummy_shape_"), shape, MOHO.COMBO_ADD, 0.0, true)
							--pMesh:Shape(pMesh:CountShapes()-1):CopyStyleProperties(shape, false, not shape.fHasOutline)
							pMesh:Shape(pMesh:CountShapes() - 1):SetName(shape:Name())
							pMesh:ShapeByName("_dummy_shape_"):SelectAllPoints()
							pMesh:DeleteShape(pMesh:CountShapes() - 2)
							pMesh:DeleteSelectedPoints()
		
							--[[20231113-0520: Try to delete any segment not present in the original shape? (TODO)
							for copEdg = 0, pMesh:Shape(0):CountEdges() - 1 do
								local copCurID, copSegID = shape:GetEdge(e)
								for origEdg = 0, shape:CountEdges() - 1 do
									local origCurID, origSegID = shape:GetEdge(e)
		
								end
							end
							--]]
						--end
					end
				else
					for e = 0, shape:CountEdges() - 1 do
						local cID, sID = shape:GetEdge(e) --print(tostring(lMesh:Curve(cID).fClosed))
						local startPercent, endPercent = lMesh:Curve(cID):GetSegmentRange(sID)
						local step = (endPercent - startPercent) / 5
						local p1 = lMesh:Curve(cID):GetPercentLocation(startPercent)
						pMesh:AddLonePoint(p1, 0)
			
						for i = 1, 10 do
							local nextPercent = startPercent + step * i
							nextPercent = nextPercent > endPercent and endPercent or nextPercent
							local p2 = lMesh:Curve(cID):GetPercentLocation(nextPercent)
							pMesh:AppendPoint(p2, 0)
						end
					end
					pMesh:SelectConnected()
					if preview:CreateShape(false) then
						pMesh:Shape(pMesh:CountShapes() - 1):SetName(shape:Name())
						--pMesh:Shape(pMesh:CountShapes() - 1).fMyStyle.fLineCol = shape.fMyStyle.fLineCol
						--pMesh:Shape(pMesh:CountShapes() - 1).fMyStyle.fLineWidth = shape.fMyStyle.fLineWidth
						--pMesh:Shape(pMesh:CountShapes() - 1).fMyStyle.fLineCaps = shape.fMyStyle.fLineCaps
						pMesh:Shape(pMesh:CountShapes() - 1):CopyStyleProperties(shape, true, false)
					end
				end
				if pMesh:CountShapes() > 0 then
					if shape:HasPositionDependentStyles() and pMesh:Shape(pMesh:CountShapes() - 1):HasPositionDependentStyles() then
						--local center, handle = shape:EffectHandle1(), shape:EffectHandle2()
						pMesh:Shape(pMesh:CountShapes() - 1).fEffectOffset.value = shape.fEffectOffset.value
						pMesh:Shape(pMesh:CountShapes() - 1).fEffectScale.value = shape.fEffectScale.value
						pMesh:Shape(pMesh:CountShapes() - 1).fEffectRotation.value = shape.fEffectRotation.value
					end
				end
			end
			--v:Set(0, 0)
			--pMesh:SelectAll()
			--pMesh:PrepMovePoints()
			--preview:AutoZoom()
			--pMesh:ScalePoints(1.1, 1.1, pMesh:SelectedCenter(), false)
		end
		preview:Refresh()
	end
end

--[[
function LS_ShapesWindowDialog:UpdateColor(moho) --print("LS_ShapesWindowDialog:UpdateColor" .. os.clock())
	local mesh = self.colorPreview:Mesh()
	mesh:Clear()
	mesh:SelectNone()

	local v = LM.Vector2:new_local()
	local lineCol = LM.ColorVector:new_local() lineCol:Set(0, 0, 0, 1)
	local fillCol = LM.ColorVector:new_local() fillCol:Set(1, 1, 0, 1)
	local gradCol = LM.rgb_color:new_local() gradCol.a = 255

	v:Set(-1.6, 1.1) mesh:AddLonePoint(v, 0)
	v:Set(-1.25, 1.1) mesh:AppendPoint(v, 0)
	v:Set(-1.25, -1.1) mesh:AppendPoint(v, 0)
	v:Set(-1.6, -1.1) mesh:AppendPoint(v, 0)
	v:Set(-1.6, 1.1) mesh:AppendPoint(v, 0)
	mesh:WeldPoints(4, 0, 0)
	mesh:SelectConnected()

	self.colorPreview:CreateShape(true)
	v:Set(0, -0.666)
	mesh:Shape(0):MakePlain()
	mesh:Shape(0).fMyStyle.fLineWidth = 0.033
	mesh:Shape(0).fEffectOffset:SetValue(0, v)
	mesh:Shape(0).fMyStyle:SetGradient(MOHO.GRADIENT_LINEAR)
	gradCol.r = 0 gradCol.g = 0 gradCol.b = 0
	mesh:Shape(0).fMyStyle:SetGradientColor(0, gradCol)
	gradCol.r = 255 gradCol.g = 255 gradCol.b = 255
	mesh:Shape(0).fMyStyle:SetGradientColor(1.111, gradCol)
	--mesh:Shape(0).fMyStyle.fFillCol:SetValue(0, fillCol)
	--mesh:Shape(0).fMyStyle.fLineCol:SetValue(0, lineCol)
	--mesh:Shape(0).fHasOutline = false

	for i = 0, mesh:CountPoints() - 1 do
		mesh:Point(i):SetCurvature(MOHO.PEAKED, 0) --MOHO.PEAKED
	end

	mesh:SelectNone()
	v:Set(0.166, 0) mesh:AddLonePoint(v, 0)
	--mesh:Point(0).fWidth:SetValue(0, 2)
	v:Set(0.166, 0.0111) mesh:AppendPoint(v, 0)
	--mesh:Point(1).fWidth:SetValue(0, 3)
	mesh:SelectConnected()

	self.colorPreview:CreateShape(false)
	mesh:Shape(1):MakePlain()
	mesh:Shape(1).fMyStyle.fLineWidth = 0.965

	v:Set(0, 0)
	self.colorPreview:CreateShape(false)
	--mesh:Shape(2):MakePlain()
	mesh:Shape(2).fMyStyle.fLineWidth = 0.875
	--mesh:Shape(2).fEffectOffset:SetValue(0, v)
	mesh:Shape(2).fMyStyle:SetGradient(MOHO.GRADIENT_ANGLE)
	gradCol.r = 255 gradCol.g = 0 gradCol.b = 0
	mesh:Shape(2).fMyStyle:SetGradientColor(0, gradCol)
	gradCol.r = 255 gradCol.g = 255 gradCol.b = 0
	mesh:Shape(2).fMyStyle:SetGradientColor(0.25, gradCol)
	gradCol.r = 0 gradCol.g = 255 gradCol.b = 255
	mesh:Shape(2).fMyStyle:SetGradientColor(0.5, gradCol)

	--mesh:Point(0).fWidth:SetValue(0, 0.95)
	--mesh:Point(1).fWidth:SetValue(0, 0.95)
	self.colorPreview:Refresh()

	--[=[
	local c = LM.ColorVector:new_local() c:Set(1, 1, 1, 0.5)
	local v = LM.Vector2:new_local()
	local numPoints = 4
	local angle = math.pi / 2
	local dAngle = (math.pi * 2) / numPoints
	local bigR = 0.95
	for i = 0, numPoints - 1 do
		v.x = bigR * math.cos(angle)
		v.y = bigR * math.sin(angle)
		if (i == 0) then
			mesh:AddLonePoint(v, 0)
		else
			mesh:AppendPoint(v, 0)
			mesh:Point(i):SetCurvature(0.391379, 0) --MOHO.PEAKED
		end
		angle = angle + dAngle
	end
	v.x, v.y = bigR * math.cos(angle), bigR * math.sin(angle)
	mesh:AppendPoint(v, 0)
	mesh:Point(numPoints - 1):ResetControlHandles(0)
	mesh:WeldPoints(0, 0 + numPoints, 0)
	mesh:Point(numPoints - 1):ResetControlHandles(0)
	mesh:Point(numPoints - 1):SetCurvature(0.391379, 0) --MOHO.PEAKED
	mesh:SelectConnected()
	self.colorPreview:CreateShape(true)
	self.colorPreview:CreateShape(true)
	--mesh:Shape(1):MakePlain()
	mesh:Shape(1).fMyStyle.fFillCol:SetValue(0, c)
	self.colorPreview:Refresh()
	--]=]

	--[=[
	local v = LM.Vector2:new_local()
	v:Set(-1.333, 1.1) mesh:AddLonePoint(v, 0)
	v:Set(1.1, 1.1) mesh:AppendPoint(v, 0)
	v:Set(1.1, -1.1) mesh:AppendPoint(v, 0)
	v:Set(-1.333, -1.1) mesh:AppendPoint(v, 0)
	v:Set(-1.1, 1.1) mesh:AppendPoint(v, 0)
	mesh:WeldPoints(4, 0, 0)

	for i = 0, mesh:CountPoints() - 1 do
		mesh:Point(i):SetCurvature(0.391379, 0) --MOHO.PEAKED
	end
	mesh:SelectConnected()
	self.colorPreview:CreateShape(true)
	--mesh:Shape(mesh:CountShapes()-1).fMyStyle.fFillCol.value = ipIconCol
	self.colorPreview:Refresh()
	--]=]
end
--]]

function LS_ShapesWindowDialog_Update(moho) --print("LS_ShapesWindowDialog_Update(" .. tostring(moho) .."): ", " 🕗: " .. os.clock())
	if LS_ShapesWindow.dlog then
		LS_ShapesWindow.dlog:Update(moho)
	end
end

-- Register the dialog to be updated when changes are made
table.insert(MOHO.UpdateTable, LS_ShapesWindowDialog_Update)

function LS_ShapesWindowDialog:HandleMessage(msg) --print("LS_ShapesWindowDialog:HandleMessage(" .. math.floor(msg) .. "): " .. LS_ShapesWindowDialog:WhatMsg(msg), " 🕗: " .. os.clock())
	--local caller = debug.getinfo(3) and debug.getinfo(3).name or "NULL" print(caller) --0: getinfo, 1: NULL/NULL, 2: SetSelItem/NULL, 3: NULL/Update, 4: NULL/func, 5: NULL/NULL
	local helper = MOHO.ScriptInterfaceHelper:new_local()
	local moho = helper:MohoObject()
	local frame = moho.frame
	local doc = moho.document --print("HM: " .. (doc and doc:Name()) or "No Doc") --20240103-1809: Back to normality after fixing the casue of opening document mess? (TBO!)
	--local doc = (LS_ShapesWindow.defDoc and LS_ShapesWindow.defDoc ~= moho.document) and LS_ShapesWindow.defDoc or moho.document --print("HM: " .. (doc and doc:Name()) or "No Doc") --20240102-1638: A try to fix/patch the new opening document mess for now... (TBO!)
	local docH = doc and doc:Height() or 240
	local tool = moho:CurrentTool()
	local l = self:GetLayout()
	--local vHeight, vWidth = moho.view:Height(), moho.view:Width()
	local styleName = moho:CurrentEditStyle() and tostring(moho:CurrentEditStyle().fName:Buffer()) or ""
	local style = moho:CurrentEditStyle() -- 20231010-0554: For some reason, "styleName" must be gathered before this assignment, otherwise then it won't be possible to access "style" properties!
	local styleID = -1
	local styles = doc and math.floor(doc:CountStyles()) or 0
	local styleSelID = LS_ShapesWindow.mode == 2 and math.floor(self.itemList:SelItem()) - 1 or -1
	local styleSel = doc and doc:StyleByID(styleSelID) or style
	local stylesSel = math.floor(self.itemList:NumSelectedItems() + (self.itemList:IsItemSelected(0) == true and -1 or 0))
	self.msg = msg or MOHO.MSG_BASE

	if (msg >= self.MENU1 and msg <= self.MENU1 + self:CountRealItems(self.menu1)) then -- -1? -- Process first of all stuff that can be accesed even without an open document.
		if (doc == nil) then -- Since there doesn't seem to be possible to trigger anything upon closing last document... well try to disable irrelevant widgets as soon as user click any menu entry.  
			self:Update()
		end
		if (msg == self.MENU1) then -- Points-Based Selection
			LS_ShapesWindow.pointsBasedSel = not LS_ShapesWindow.pointsBasedSel
		elseif (msg == self.MENU1 + 1) then -- Ignore Non-Regular Vector Layers
			LS_ShapesWindow.ignoreNonRegular = not LS_ShapesWindow.ignoreNonRegular
		elseif (msg == self.MENU1 + 2) then -- Link To Style Window
			LS_ShapesWindow.linkToStyle = not LS_ShapesWindow.linkToStyle
		elseif (msg == self.MENU1 + 3) then -- Open On Startup
			LS_ShapesWindow.openOnStartup = not LS_ShapesWindow.openOnStartup
		elseif (msg == self.MENU1 + 4) then -- Show In Tools Palette
			LS_ShapesWindow.showInTools = not LS_ShapesWindow.showInTools
			moho:SetCurFrame(frame ~= 0 and 0 or 1)
			moho:SetCurFrame(frame)
		elseif (msg == self.MENU1 + 5) then -- Show All Tooltips
			LS_ShapesWindow.showAllTooltips = not LS_ShapesWindow.showAllTooltips
		elseif (msg >= self.MENU1 + 6 and msg <= self.MENU1 + 9) then -- Try to encompass here options which require auto-reopening.
			if (msg == self.MENU1 + 6) and doc ~= nil then -- Advanced (Create)
				LS_ShapesWindow.advanced = not LS_ShapesWindow.advanced
				--self.menu1:SetChecked(msg, LS_ShapesWindow.advanced) -- Not necessary in this case, but another possibility of update entries' checkmarks...
			elseif (msg == self.MENU1 + 7) and doc ~= nil then -- Use Large Buttons
				LS_ShapesWindow.largeButtons = not LS_ShapesWindow.largeButtons
			elseif (msg == self.MENU1 + 8) and doc ~= nil then -- Use Large Palette
				LS_ShapesWindow.largePalette = not LS_ShapesWindow.largePalette
			elseif (msg == self.MENU1 + 9) and doc ~= nil then -- Show Infobar
				LS_ShapesWindow.showInfobar = not LS_ShapesWindow.showInfobar
			end
			if (doc ~= nil) then
				--print("1: (msg >= self.MENU1 + 3 and msg <= self.MENU1 + 6)")
				self.dummyList:SetSelItem(self.dummyList:GetItem(0), false)
				--print("2: (msg >= self.MENU1 + 3 and msg <= self.MENU1 + 6)")
				if (LS_ShapesWindow.dlog) then
					LS_ShapesWindow.dlog = nil
				end
			end
			helper:delete()
			return
		elseif (msg == self.MENU1 + 10) then -- Restore Defaults [?]
			local alert = LM.GUI.Alert(LM.GUI.ALERT_QUESTION,
			LS_ShapesWindow:UILabel() .. ": " .. MOHO.Localize("/Dialogs/Preferences/ToolPrefs/RestoreDefaults=Restore Factory Defaults") .. "?",
			MOHO.Localize(doc ~= nil and "/LS/ShapesWindow/TheWindowWillReopen=The window will reopen itself if necessary." or "/LS/ShapesWindow/TheWindowWillClose=The window will close if necessary."), nil,
			MOHO.Localize("/Dialogs/ProjectSettings/RestoreDefaults=Restore Defaults"):gmatch("%w+")(), MOHO.Localize("/Strings/Cancel=Cancel")) --Restore: 0, Cancel: 1
			if alert == 0 then
				LS_ShapesWindow:ResetPrefs()
				if LS_ShapesWindow.advanced ~= self.menu1:IsChecked(self.MENU1 + 5) or LS_ShapesWindow.largeButtons ~= self.menu1:IsChecked(self.MENU1 + 6) or LS_ShapesWindow.largePalette ~= self.menu1:IsChecked(self.MENU1 + 7) or LS_ShapesWindow.showInfobar ~= self.menu1:IsChecked(self.MENU1 + 8) then -- Only Reopen window if necessary.
					--print("1: (msg == self.MENU1 + 7)")
					self.dummyList:SetSelItem(self.dummyList:GetItem(0), false)
					--print("2: (msg == self.MENU1 + 7)")
					if (LS_ShapesWindow.dlog) and doc ~= nil then -- It may be better not try to reopen without an open document, otherwise the lack of view (among other things) will make it open weirdly.
						LS_ShapesWindow.dlog = nil
					end
					helper:delete()
					return
				end
			else
				helper:delete()
				return
			end
		elseif (msg == self.MENU1 + 11) then -- Check For Updates...
			os.execute('start "" ' .. LS_ShapesWindow.url) --os.execute('start "" "https://mohoscripts.com/script/"' .. (info.source):match("^.*[/\\](.*).lua$"))
		elseif (msg == self.MENU1 + 12) then -- About...
			local years = ScriptBirth:sub(1,4) .. (tonumber(ScriptBuild:sub(1, 4)) > tonumber(ScriptBirth:sub(1, 4)) and "-" .. ScriptBuild:sub(1,4) or "")
			local block1a = LS_ShapesWindow:UILabel() .. " " .. LS_ShapesWindow:Version()
			local block1b = "\n" ..  LS_ShapesWindow:Creator()
			--local blockSep = "\n" ..  ("_"):rep(math.max(block1a and #block1a or 0, block1b and #block1b or 0))
			local block2 = LS_ShapesWindow:Description() .. "\n\n"
			local block3 = "Licensed under the Apache License, Version 2.0"
			local alert = LM.GUI.Alert(LM.GUI.ALERT_INFO, block1a .. block1b, block2, block3, MOHO.Localize("/LS/ShapesWindow/Acknowledgements=Acknowledgements"), MOHO.Localize("/Dialogs/SLAPanel/ReadLicense=Read License"), MOHO.Localize("/Menus/File/CloseRender=Close")) --This script is freeware and released under the GNU General Public License. --Licensed under the MIT License.
			if alert == 0 then
				local alert = LM.GUI.Alert(LM.GUI.ALERT_INFO, LS_ShapesWindow.ack[1], table.concat(LS_ShapesWindow.ack, "    \n\n", 2, #LS_ShapesWindow.ack - 1) , LS_ShapesWindow.ack[#LS_ShapesWindow.ack], MOHO.Localize("/Menus/File/CloseRender=Close"))
			elseif alert == 1 then
				local alert = LM.GUI.Alert(LM.GUI.ALERT_INFO, "Licence & Warranty", LS_ShapesWindow:License(years), nil, MOHO.Localize("/Menus/File/CloseRender=Close"))
			end
		elseif (msg == self.MENU1 + self:CountRealItems(self.menu1) - 1) then -- Last (Testground!)
			--print("...")
		end

		--if (doc ~= nil) then
			self:Update()
			MOHO.Redraw()
		--end
		helper:delete()
		return
	elseif (msg >= self.MENU2 and msg <= self.MENU2 + self:CountRealItems(self.menu2, self.MENU2) - 1) then
		local reopen = false
		if (msg == self.MENU2) then --print("None") -- None
			reopen = LS_ShapesWindow.swatch ~= -1
			LS_ShapesWindow.swatch = (msg - self.MENU2) - 1

			if reopen then
				self.dummyList:SetSelItem(self.dummyList:GetItem(0), false)
				if (LS_ShapesWindow.dlog) then
					LS_ShapesWindow.dlog = nil
				end
			end
			helper:delete()
			return
		elseif (msg >= self.MENU2 + 1) and (msg <= self.MENU2 + self:CountRealItems(self.menu2, self.MENU2) - 4) then --print(">>> " .. (msg - self.MENU2) - 1)
			reopen = LS_ShapesWindow.swatch == -1 and (msg - self.MENU2) - 1 > -1
			LS_ShapesWindow.swatch = (msg - self.MENU2) - 1

			--[[20231122: Pre-nested table system working code.
			local count, layer = 0, nil
			for i, doc in ipairs(LS_ShapesWindow.docList) do
				for j = doc:CountLayers() - 1, 0, -1 do
					layer = doc:Layer(j)
					count = count + 1
					if count == (msg - self.MENU2) then
					--if (layer:LayerType() == MOHO.LT_VECTOR) and not layer:IsRenderOnly() then --20231121-0716: Would need to check if it's a valid swatch in order to match Update state! But needs rethinking...
						LS_ShapesWindow.swatchDoc = i
						LS_ShapesWindow.swatchLayer = j
						break
					--end
					end
				end
			end
			--]]
			--[[20231127-0716: Nested table system working code.
			local count, layer = 0, nil
			for i, chunk in ipairs(self.swatches) do
				for j = #chunk - 1, 0, -1 do print(msg - self.MENU2, ", ", i, ", ", j)
					--layer = doc:Layer(j)
					count = count + 1
					if count == (msg - self.MENU2) then
						LS_ShapesWindow.swatchDoc = i
						LS_ShapesWindow.swatchLayer = j --print(msg - self.MENU2, ", ", LS_ShapesWindow.swatchDoc, ", ", LS_ShapesWindow.swatchLayer)
						break
					end
				end
			end
			--]]
			local count, layer = 0, nil
			for i, chunk in ipairs(self.swatches) do
				for j = 1, #chunk do
					--layer = doc:Layer(j)
					count = count + 1
					if chunk[j] and chunk[j].msg == msg then --print(msg - self.MENU2, ", ", chunk[j] and chunk[j].msg or "", ", ", i, ", ", j)
						LS_ShapesWindow.doc = LS_ShapesWindow.docList[i]
						LS_ShapesWindow.swatchDoc = i
						LS_ShapesWindow.swatchLayer = chunk[j].id and chunk[j].id or -1 --print(msg - self.MENU2, ", ", LS_ShapesWindow.swatchDoc, ", ", LS_ShapesWindow.swatchLayer)
						break
					end
				end
			end

			if reopen then
				self.dummyList:SetSelItem(self.dummyList:GetItem(0), false)
				if (LS_ShapesWindow.dlog) then
					LS_ShapesWindow.dlog = nil
				end
			end
			self:Update()
			self:UpdateColor(moho)
			self.menu2:UncheckAll()
			self.menu2:SetChecked(msg, true) --self.menu2Popup:Redraw()
			helper:delete() --20240102-0425: This was missing for some reason and that seemed the cause for all the open documents mess?? (TBO!)
			return
		elseif (msg == self.MENU2 + self:CountRealItems(self.menu2, self.MENU2) - 4) then --print("Custom Swatches...") -- Custom Swatches...

		elseif (msg == self.MENU2 + self:CountRealItems(self.menu2, self.MENU2) - 3) then --print("Use Selection") -- Use Selection
			LS_ShapesWindow.swatch = -2
		elseif (msg == self.MENU2 + self:CountRealItems(self.menu2, self.MENU2) - 2) then --print("Edit Current Swatch") -- Edit Current Swatch
			if LS_ShapesWindow.doc ~= nil then
				local doc, layer = LS_ShapesWindow.docList[LS_ShapesWindow.swatchDoc] --local layer = LS_ShapesWindow.doc:Layer(LS_ShapesWindow.swatchLayer)
				if doc ~= nil then
					--[[20240102-1744: Alternative mode for/if bellow one start failing again...
					local path = doc:Path():reverse()
					local sepPos = string.find(path, "[/\\]")
					if sepPos then
						local sep = path:sub(sepPos, sepPos)
						path = string.sub(path, sepPos + 1):reverse() --print(path)
						os.execute(sep == "/" and 'open "" "' or  'start "" "'  .. path .. '"') -- Just open de directory for the momment...
					else
						helper:delete()
						return
					end
					--]]
					
					---[[20240102-0425: Commented and uncommented again, since it ended up messing current document detection, but after adding the missing helper:delete() above it appears solved?
					--print("Print 1: " .. moho.document:Name())
					helper:delete()
					moho:FileOpen(doc:Path()) --os.execute('start "" "' .. doc:Path() .. '"')
					local helper = MOHO.ScriptInterfaceHelper:new_local() -- 20231120-0545: FileOpen immediately calls isRelevant/isEnabled & Dialog_Update, messing up (I think) current MohoObject, so a new one ensures openning document is targeted instead a previously opened one.
					local moho = helper:MohoObject()
					--print("Print 2: " .. moho.document:Name())
					LS_ShapesWindow.swatchLayer = LS_ShapesWindow.swatchLayer > moho.document:CountLayers() - 1 and moho.document:CountLayers() - 1 or LS_ShapesWindow.swatchLayer --LM.Clamp(LS_ShapesWindow.swatchLayer, 0, moho.document:CountLayers() - 1) --print(doc:Name(), ", ", moho.document:Name())
					layer = moho.document:Layer(LS_ShapesWindow.swatchLayer)
					moho:SetSelLayer(layer, false, true)
					if not (moho.layer:HasAction("SLIDER") and moho.layer:HasAction("SLIDER 2")) then --20231231-0545: MohoDoc:Layer - out of range | attempt to index a nil value (field 'layer') - Upon clicking 'Edit Current Swatch' (TODO)
						--MOHO.MohoGlobals.GridOn = moho.gridOn == false and true or moho.gridOn
						--MOHO.MohoGlobals.GridSize = moho.gridSize ~= 11 and 11 or moho.gridSize
					end
					for i = 0, moho.document:CountLayers() - 1 do
						moho.document:Layer(i):SetVisible(i == LS_ShapesWindow.swatchLayer) --print(doc:Layer(i):Name())
					end
					moho:UpdateUI()
					helper:delete()
					return
					--]]
				end
			end
		elseif (msg == self.MENU2 + self:CountRealItems(self.menu2, self.MENU2) - 1) then --print("Reload Swatches")
			LS_ShapesWindow.docList = {}
			LS_ShapesWindow.docsLoaded = false
			self.menu2:RemoveAllItems()
			LS_ShapesWindow:IsEnabled(moho)
			--self:UpdateColor(moho)
		else
			--LS_ShapesWindow.swatch = math.abs((self.MENU2 + 3) - msg) print(LS_ShapesWindow.swatch)
		end
		self:Update()
	end

	if (style == nil and doc == nil) then -- Ensure nothing is run from here on after closing last doc (or things like LayerAsVector will make Moho crash).
		self:Update()
		helper:delete()
		return
	else
		for i = 0, styles - 1 do
			local iStyle = doc:StyleByID(i)
			if iStyle == style then
				styleID = math.floor(i)
				break
			elseif iStyle.fSelected then
				styleID = math.floor(i)
			end
		end
	end

	local mesh = moho:DrawingMesh()
	local layer = moho.layer --print("HM: " .. tostring(moho.document:Name()), ", ", layer:Name())
	local lFrame = layer and moho.layerFrame or 0
	local lDrawing = moho.drawingLayer and moho:LayerAsVector(moho.drawingLayer) or nil
	local lDrawingFrame = lDrawing and moho.drawingLayerFrame or 0
	local shape = moho:SelectedShape()
	local shapeID = shape and mesh:ShapeID(shape) or -1
	local shapeName = shape and shape:Name() or ""
	local shapes = mesh and mesh:CountShapes() or 0
	local shapesSel = moho:CountSelectedShapes(true) -- Use this instead LM_SelectShape:CountSelectedShapes??
	local shapeStyle1 = shape ~= nil and shape.fInheritedStyle or nil
	local shapeStyle2 = shape ~= nil and shape.fInheritedStyle2 or nil

	if (style == nil and mesh == nil) then --print(LS_ShapesWindowDialog:WhatMsg(msg))
		if msg < self.FILL and msg > self.RESET_ALT and msg ~= self.CHANGE then --print(msg, ", ", self.MENU1 + self:CountRealItems(self.menu1) - 1) -- If doc but not object, exit should msg was other than options menu's
			helper:delete()
			return
		end
	end

	local undoable = true
	if ((msg >= self.MENU1 and msg < self.FILLED) or msg == self.MODE or msg == self.CHANGE or msg == self.BASE_SHAPE or msg == self.BASE_SHAPE_ALT or msg == self.TOP_SHAPE or msg == self.TOP_SHAPE_ALT or msg == self.SELECTALL or msg == self.SELECTALL_ALT or msg == self.SELECTSIMILAR or msg == self.SELECTSIMILAR_ALT or msg == self.CHECKERSEL or msg == self.COPY or msg == self.COLORSLIDER or (msg >= self.FILLCOLOR and msg <= self.FILLCOLOR_END) or (msg >= self.LINECOLOR and msg <= self.LINECOLOR_END)) then
		undoable = false
	end
	if (doc ~= nil and undoable) then
		doc:PrepUndo(lDrawing)
		doc:SetDirty()
	end

	if (msg == self.CHANGE) then
		if doc == nil and mesh == nil then
			self:Update()
			helper:delete()
			return 
		end
		if LS_ShapesWindow.mode < 2 then
			if self.skipBlock == true then -- Try to avoid unwanted call to Update/UpdateWidgets bellow upon selecting, no matter how, a list item!
				if (LS_ShapesWindow.pointsBasedSel and not tool:find("SelectShape")) then --if (LS_ShapesWindow.pointsBasedSel and tool:find("SelectPoints")) then
					if shapesSel == 0 then
						self.count = 0
					end
					if self.count and self.count == shapesSel then
						--self:Update()
						--if tool:find("SelectShape") then -- Use this solution instead of UpdateUI() bellow? It's quicker cause doesn't update the entire UI, but e.g. Style window could get outdated!
							--LM_SelectShape:UpdateWidgets(moho)
						--end
						moho:UpdateUI()
						self.count = 0
					end
					self.count = self.count + 1
				end
				helper:delete()
				return -- 20230920-2103: Commented, since it seems to make dialog widgets not update propertly... 20231006-2004: But now it's uncommented and works? 🤔
			end

			if (mesh ~= nil) then --print("Print 1" .. ", " .. mesh:CountShapes() .. ", " .. self.itemList:CountItems())
				shapeID = self.itemList:SelItem() > 0 and mesh:CountShapes() - self.itemList:SelItem() or -1
				for i = 1, self.itemList:CountItems() - 1 do
					local shape = mesh:Shape(mesh:CountShapes() - i)
					if shape ~= nil then
						shape.fSelected = self.itemList:IsItemSelected(i)
					end
				end --print("Print 2" .. ", " .. mesh:CountShapes() .. ", " .. self.itemList:CountItems())
				---[=[Experimental Points-Based Selection Mode...
				if (LS_ShapesWindow.pointsBasedSel and not tool:find("SelectShape")) then
					for i = 0, mesh:CountShapes() - 1 do
						local shape = mesh:Shape(i)
						if shape.fSelected == true then -- Select selected shape's points
							shape:SelectAllPoints()
						else -- 20231018-1645 TODO: There's an issue arround all this and different shapes sharing points (e.g. if you select all shapes of a Grid WITH stroke).
							for pID = shape:CountPoints() - 1, 0, -1 do -- De-select unselected shape's points
								local point = mesh:Point(shape:GetPoint(pID))
								point.fSelected = false
							end
						end
					end
				end
				--]=]
				--[=[20231010-0414: It doesn't seem really necessary to set/update these widgets also from here, but keep an eye on it...
				self.itemName:Enable(self.itemList:SelItem() > 0)
				self.itemName:SetValue(self.itemList:SelItem() > 0 and mesh:Shape(mesh:CountShapes() - self.itemList:SelItem()):Name() or "")
				self.raise:Enable(self.itemList:SelItem() > 1)
				self.lower:Enable(self.itemList:SelItem() > 0 and self.itemList:SelItem() < self.itemList:CountItems() - 1)
				--]=]
				MOHO.Redraw()
				if LS_ShapesWindow.linkToStyle then
					moho:UpdateUI()
				else
					--style.fFillCol:SetValue(lDrawingFrame, self.fillCol:Value())
					--self.fillCol:SetValue(style.fFillCol.value)
					if tool:find("SelectShape") then -- This will be quicker than UpdateUI(), but then Style window wouldn't update accordingly to selected item by list.
						---[[Other tries of updating the toolbar without any success...
						--self:UpdateWidgets()
						--doc:Refresh()
						--doc:PrepUndo(layer, true)
						--doc:Undo()
						--moho:SetCurFrame(1)
						--moho:SetCurFrame(0)
						--moho:UpdateUI()
						--]]
						--LM_SelectShape:UpdateWidgets(moho)
					end
					self:Update()
				end
			end
		else
			if self.skipBlock == true then -- Try to avoid unwanted call to Update/UpdateWidgets bellow upon selecting, no matter how, a list item!
				helper:delete()
				return -- 20230920-2103: Commented, since it seems to make dialog widgets not update propertly... 20231006-2004: But now it's uncommented and works? 🤔
			end
			if (doc ~= nil) then
				--styleID = self.itemList:SelItem() > 0 and doc	:CountStyles() - self.itemList:SelItem() or -1
				for i = 0, styles - 1 do
					local iStyle = doc:StyleByID(i) --doc:CountStyles() - i
					if iStyle ~= nil then
						iStyle.fSelected = self.itemList:IsItemSelected(i + 1)
					end
					--print(iStyle.fName:Buffer(), ", ", tostring(iStyle.fSelected))
				end
				if math.floor(self.itemList:SelItem()) - 1 ~= styleID then
					LS_ShapesWindow.mode = LS_ShapesWindow:StyleLeaver(moho, mesh, 2)
					
				end
				self:Update()
			end
		end
	elseif (msg == self.MODE) then
		if LS_ShapesWindow.mode < 2 then -- if Shape Modes
			if (mesh ~= nil) and LS_ShapesWindow.mode == 1 then
				moho:DeselectShapes()
				MOHO.Redraw()
			end
			LS_ShapesWindow.mode = 2
			self.selItem = 0
		elseif LS_ShapesWindow.mode == 2 then -- if STYLE Mode
			if mesh ~= nil then
				local test = LS_ShapesWindow:StyleLeaver(moho, mesh)
				--[[
				if styleName ~= "" then
					--local v = LM.Vector2:new_local() v:Set(0, -100) v:Set(0, -100.0001)
					mesh:SelectNone()
					mesh:AddLonePoint(LM.Vector2:new_local(0, -100) , 0)
					mesh:AppendPoint(LM.Vector2:new_local(0, -100.0001), 0)
					mesh:SelectConnected()

					if moho:CreateShape(false, false, 0) then
						if mesh:CountShapes() > 0 then
							local tempShape = mesh:Shape(mesh:CountShapes() - 1)
							tempShape:SetName("")
							tempShape:MakePlain()
							tempShape.fSelected = true
							--tempShape:SelectAllPoints()
							--mesh:DeleteShape(mesh:CountShapes() - 1)
							--curStyle = moho:CurrentEditStyle() print(curStyle.fName:Buffer())
							--print("Before 'UpdateUI'")
							moho:UpdateUI()
							--print("After 'UpdateUI'")
							moho:DeselectShapes() --tempShape.fSelected = false
							mesh:DeleteShape(mesh:CountShapes() - 1)
							mesh:DeleteSelectedPoints()
							MOHO.Redraw()
						end
					end
					--[=[
					if style ~= nil and styleName == "" then
						LS_ShapesWindow.mode = 0 -- DEFAULTS (Shape Management)
					end
					if shape ~= nil then
						LS_ShapesWindow.mode = 1
					else
						LS_ShapesWindow.mode = 0
					end
					--]=]
					--LS_ShapesWindow.mode = (style ~= nil and styleName == "") or 2
					--LS_ShapesWindow.mode = shape ~= nil and 1 or 0
				end
				--]]
			else
				--20231205-1925: Do nothing for now, among other things, cause it would require the creation of a temp vector layer, which would be visible for a sec upon UpdatingUI...
			end
			LS_ShapesWindow.mode = 0
			self.selItem = 0
		end
		self:Update()
	elseif (msg == self.NAME) then
		if shapeID and shapeID >= 0 then
			for i = 0, mesh:CountShapes() - 1 do
				local iShape = mesh:Shape(i)
				if (iShape.fSelected) then
					iShape:SetName(self.itemName:Value())
					LS_ShapesWindow:MakeShapeNameUnique(mesh, i)
				end
			end
		elseif (style ~= nil and styleName ~= "") then -- Current Style (TAKE CARE NOT TO NAME DEFAULT NAMELESS STYLE!)
			style.fName:Set(self.itemName:Value()) --doc:RenameStyle(styleName, self.itemName:Value(), nil) -- Doesn't seem to dio anything...
			--[[
			style.fName:Set(self.itemName:Value())
			for i = 0, doc:CountStyles() - 1 do
				local iStyle = doc:StyleByID(i) --print(iStyle.fUUID:Buffer())
				if tostring(iStyle) == tostring(style) then -- 20231010-0520: For some reason, this is the only way Moho allows me to rename current style. Well...
					--iStyle.fName:Set(self.itemName:Value())
				end
			end
			--]]
		elseif (style ~= nil and styleName == "") then -- Selected Style/s
			for i = 0, doc:CountStyles() - 1 do
				local iStyle = doc:StyleByID(i)
				if (iStyle.fSelected) then
					iStyle.fName:Set(self.itemName:Value())
					LS_ShapesWindow:MakeStyleNameUnique(doc, i)
				end
			end
		end
		moho:UpdateUI()
	elseif (msg == self.VIS) then
		if (mesh ~= nil and shape ~= nil) then
			for i = 0, shapes - 1 do
				local shape = mesh:Shape(i)
				if (shape.fSelected) then
					shape.fHidden = not self.itemVisCheck:Value()
				end
			end
			MOHO.Redraw()
		end
		self:Update()
	elseif (msg == self.COMBINE_NORMAL) then
		for i = 0, shapes - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fComboMode = MOHO.COMBO_NORMAL
			end
		end
		--lDrawing:UpdateCurFrame(false)
		--moho.view:DrawMe()
		MOHO.Redraw()
		self:Update()
		moho:UpdateUI()
	elseif (msg == self.COMBINE_ADD) then
		for i = 0, shapes - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fComboMode = MOHO.COMBO_ADD
			end
		end
		--lDrawing:UpdateCurFrame(false)
		--moho.view:DrawMe()
		MOHO.Redraw()
		self:Update()
		moho:UpdateUI()
	elseif (msg == self.COMBINE_SUBTRACT) then
		for i = 0, shapes - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fComboMode = MOHO.COMBO_SUBTRACT
			end
		end
		--lDrawing:UpdateCurFrame(false)
		--moho.view:DrawMe()
		MOHO.Redraw()
		self:Update()
		moho:UpdateUI()
	elseif (msg == self.COMBINE_INTERSECT) then
		for i = 0, shapes - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fComboMode = MOHO.COMBO_INTERSECT
			end
		end
		--lDrawing:UpdateCurFrame(false)
		--moho.view:DrawMe()
		MOHO.Redraw()
		self:Update()
		moho:UpdateUI()
	elseif (msg == self.COMBINE_BLEND_BUT or msg == self.COMBINE_BLEND_BUT_ALT) then
		for i = 0, shapes - 1 do
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
		for i = 0, shapes - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				shape.fComboBlend:SetValue(lDrawingFrame, blend)
			end
		end
		--moho.view:DrawMe()
		MOHO.Redraw()
		self:Update()
		--LM_SelectShape:UpdateWidgets(moho) -- 20231011-1933: This indeed updates Select Shapes tool toolbar's "Blend" widget, but little less!
		moho:UpdateUI() -- 20231011-1933: It only seems necessary to update Timeline and Select Shapes tool toolbar's "Blend" widget? So let's try the above...
	elseif (msg == self.BASE_SHAPE) then
		--LM_SelectShape:HandleMessage(moho, moho.view, LM_SelectShape.BASE_SHAPE)
		if (shape ~= nil and shape:IsInCluster()) then
			local clusterBaseShape = shape:BottomOfCluster()
			mesh:SelectNone()
			clusterBaseShape.fSelected = true
			if (LS_ShapesWindow.pointsBasedSel and not tool:find("SelectShape")) then
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
			if (LS_ShapesWindow.pointsBasedSel and not tool:find("SelectShape")) then
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
				if (LS_ShapesWindow.pointsBasedSel and not tool:find("SelectShape")) then
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
		self:Update()
	elseif (msg == self.RAISE or msg == self.RAISE_ALT) then
		for i = shapes - 1, 0, -1 do
			if (mesh:Shape(i).fSelected) then
				mesh:RaiseShape(i, msg == self.RAISE_ALT)
			end
		end
		MOHO.Redraw()
		self:Update()
	elseif (msg == self.LOWER or msg == self.LOWER_ALT) then
		for i = 0, shapes - 1 do
			if (mesh:Shape(i).fSelected) then
				mesh:LowerShape(i, msg == self.LOWER_ALT)
			end
		end
		MOHO.Redraw()
		self:Update()
	elseif (msg == self.SELECTALL or msg == self.SELECTALL_ALT) then -- 🤔 What if click once selected all, another click deselected all and holding <alt> selected similar?
		if LS_ShapesWindow.mode < 2 then
			if (msg == self.SELECTALL and shapes == shapesSel) then 
				LM.Beep()
				helper:delete()
				return
			end
			for i = 0, shapes - 1 do
				local iShape = mesh:Shape(i)
				iShape.fSelected = (msg == self.SELECTALL) and true or not iShape.fSelected
				if (LS_ShapesWindow.pointsBasedSel and not tool:find("SelectShape")) then
					if iShape.fSelected then
						iShape:SelectAllPoints()
					else
						for pID = iShape:CountPoints() - 1, 0, -1 do -- De-select the just de-selected shape's points
							local point = mesh:Point(iShape:GetPoint(pID))
							point.fSelected = false
						end
					end
				end
			end
			MOHO.Redraw()
		else
			if style and styleName ~= "" then
				LS_ShapesWindow.mode = LS_ShapesWindow:StyleLeaver(moho, mesh, 2)
			end
			if (msg == self.SELECTALL and styles == stylesSel) then 
				LM.Beep()
				helper:delete()
				return
			end
			for i = 0, styles - 1 do
				local iStyle = doc:StyleByID(i)
				iStyle.fSelected = (msg == self.SELECTALL) and true or not iStyle.fSelected --20240102-2224: It seems to fail if only first item in list is selected... But why? (TODO)
			end
		end
		moho:UpdateUI() -- It seems necessary in order to activate buttons accordingly list selection, plus it seems to solve the above note!
		self:Update()
		self.itemList:Redraw()
	elseif (msg == self.SELECTSIMILAR or msg == self.SELECTSIMILAR_ALT) then
		local count = 0
		if LS_ShapesWindow.mode < 2 then
			for i = 0, shapes - 1 do
				local iShape = mesh:Shape(i)
				if iShape ~= nil and (mesh:ShapeID(iShape) ~= shapeID) and iShape:ArePropertiesEqual(shape) then
					iShape.fSelected = true
					if (LS_ShapesWindow.pointsBasedSel and not tool:find("SelectShape")) then
						iShape:SelectAllPoints()
					end
					count = count + 1
				end
			end
		else
			local style = (style and styleName ~= "") and style or styleSel --print(style.fName:Buffer())
			local styleUUID = style.fUUID:Buffer()
			for i = 0, styles - 1 do
				local iStyle = doc:StyleByID(i)
				if iStyle ~= nil and (iStyle.fUUID:Buffer() ~= styleUUID) and iStyle:ArePropertiesEqual(style) then
					iStyle.fSelected = true
					count = count + 1
				end
			end
			if count > 0 then
				LS_ShapesWindow.mode = LS_ShapesWindow:StyleLeaver(moho, mesh, 2)
				moho:UpdateUI()
			end
			--[[20231218-1800: First attempt (TODO)
			for i = 0, styles - 1 do
				local iStyle = doc:StyleByID(i)
				if (i ~= styleID) and iStyle:ArePropertiesEqual(style) then
					iStyle.fSelected = true
					count = count + 1
				end
			end
			--]]
		end
		if count < 1 then
			LM.Beep()
		else
			MOHO.Redraw()
			self:Update()
			self.itemList:Redraw()
		end
	elseif (msg == self.CHECKERSEL) then
		MOHO.MohoGlobals.SelectedShapeCheckerboard = not (MOHO.MohoGlobals.SelectedShapeCheckerboard)
		if (moho ~= nil) and (doc ~= nil) then
			MOHO.Redraw()
		end
		self:Update()
		moho:UpdateUI()
	elseif (msg == self.COLORSLIDER) then --print(self.colorSlider:Value())
		local layer, mesh
		if LS_ShapesWindow.swatch ~= -1 and LS_ShapesWindow.swatchDoc ~= nil then
			if LS_ShapesWindow.doc:Layer(LS_ShapesWindow.swatchLayer) ~= nil then
				layer = moho:LayerAsVector(LS_ShapesWindow.doc:Layer(LS_ShapesWindow.swatchLayer)) --moho:LayerAsVector(moho.layer) print(moho.document:Name(), ", ", moho.layer:Name())
				mesh = layer and layer:Mesh() or nil
				if layer:HasAction("SLIDER") and layer:ActionDuration("SLIDER") == 1 then
					if not layer:HasAction("SLIDER (DEFAULT)") then
						layer:ActivateAction("SLIDER" .. " (DEFAULT)")
						layer:InsertAction("SLIDER", 1)
						--AnimChannel:Reset(0)
						layer:ActivateAction("")

						local chInfo  =  MOHO.MohoLayerChannel:new_local()
						for i = 0, layer:CountChannels() - 1 do
							layer:GetChannelInfo(i, chInfo)
							if (chInfo.subChannelCount == 1) then
								local ch = layer:Channel(i, 0, LS_ShapesWindow.doc):ActionByName("SLIDER (DEFAULT)") --20231228-2015: Using LS_ShapesWindow.doc instead moho.document to make it work without open doc/s (same applies bellow)
								if ch and ch:CountKeys() > 1 then
									ch:Reset(1)
									--print(MOHO.Localize("/Scripts/Menu/ListChannels/Channel=Channel ") .. i .. ": " .. chInfo.name:Buffer() .. MOHO.Localize("/Scripts/Menu/ListChannels/Keyframes= Keyframes: ") .. ch:CountKeys())
								end
							else
								--print(MOHO.Localize("/Scripts/Menu/ListChannels/Channel=Channel ") .. i .. ": " .. chInfo.name:Buffer())
								for subID = 0, chInfo.subChannelCount - 1 do
									local ch = layer:Channel(i, subID, LS_ShapesWindow.doc):ActionByName("SLIDER (DEFAULT)")
									if ch and ch:CountKeys() > 1 then
										ch:Reset(1)
										--print(MOHO.Localize("/Scripts/Menu/ListChannels/SubChannel=    Sub-channel ") .. subID .. MOHO.Localize("/Scripts/Menu/ListChannels/Keyframes= Keyframes: ") .. ch:CountKeys())
									end
								end
							end
						end
						--layer:ActivateAction("")
					end

					local default = LM.String:new_local() default:Set("SLIDER (DEFAULT)")
					local slider = LM.String:new_local() slider:Set("SLIDER")
					local slider2 = LM.String:new_local() slider2:Set("SLIDER 2")
					local percent = {math.abs((self.colorSlider:Value() / 255)), 1}
					local name = {[1] = default, [2] = slider} --print(percent[1])
					layer:BlendActions(0, true, 1, {default}, {percent[1]})
					layer:BlendActions(0, true, 1, {slider}, {math.abs(percent[1] - 1)})
					--[[
					--layer:BlendActions(0, true, 2, name, percent)
					--layer:InsertAction("SLIDER", 0, false)
					--layer:UpdateCurFrame(true)
					--]]
					layer:UpdateCurFrame(true)
					self:UpdateColor(moho)
				end
			end
		end
		--[[20231123-0638: Working code (more ot less) backup...
		local layer, mesh
		if LS_ShapesWindow.swatch ~= -1 and LS_ShapesWindow.swatchDoc ~= nil then
			if LS_ShapesWindow.doc:Layer(LS_ShapesWindow.swatchLayer) ~= nil then
				layer = moho:LayerAsVector(LS_ShapesWindow.doc:Layer(LS_ShapesWindow.swatchLayer))
				mesh = layer and layer:Mesh() or nil
				if layer:HasAction("SLIDER") and layer:ActionDuration("SLIDER") == 1 then
					local default = LM.String:new_local() default:Set("DEFAULT")
					local slider = LM.String:new_local() slider:Set("SLIDER")
					local slider2 = LM.String:new_local() slider2:Set("SLIDER")
					local percent = {math.abs((self.colorSlider:Value() / 255)), 1}
					local name = {[1] = default, [2] = slider} --print(percent[1])
					layer:BlendActions(0, true, 1, {default}, {percent[1]})
					layer:BlendActions(0, true, 1, {slider}, {math.abs(percent[1] - 1)})
					--layer:BlendActions(0, true, 2, name, percent)
					--layer:InsertAction("SLIDER", 0, false)
					--layer:UpdateCurFrame(true)
					layer:UpdateCurFrame(true)
					self:UpdateColor(moho)
				end
			end
		end
		--]]
	elseif (msg == self.DELETE) then
		if (doc ~= nil) then
			local redraw
			local i = 0
			if LS_ShapesWindow.mode < 2 then
				if (mesh ~= nil) then
					while i < mesh:CountShapes() do
						if (mesh:Shape(i).fSelected) then
							mesh:DeleteShape(i)
							redraw = redraw == nil and true or redraw
						else
							i = i + 1
						end
					end
				end
			else
				local host = layer
				while i < doc:CountStyles() do
					local style = doc:StyleByID(i)
					if (style.fSelected) then
						redraw = redraw == nil and doc:IsStyleUsed(style, host) or redraw
						doc:RemoveStyle(style, nil)
					else
						i = i + 1
					end
				end
			end

			if redraw == true then
				--moho.view:DrawMe()
				MOHO.Redraw()
			end
			moho:UpdateUI() -- Contrary to self:Update(), it correctly updates infobar e.g. upon deleting shapes while Select Shape tool is active, but does it worth? 🤔
			self:Update() -- 20231222-1430: Moved bellow UpdateUI(), otherwise it made window switch to STYLE mode after shape deletion for no (known) reason... It may not be necessary anyway?
		end
	elseif (msg == self.FILL) then
		---[=[LM_SelectShape:HandleMessage(moho, moho.view, LM_SelectShape.FILL)
		if (mesh ~= nil and shape ~= nil) then
			if (shape.fFillAllowed) then
				shape.fHasFill = self.fillCheck:Value()
			end
			if (shape:IsInCluster() and shape.fComboMode ~= MOHO.COMBO_INTERSECT) then
				shape:BottomOfCluster().fHasFill = self.fillCheck:Value()
			end

			for i = 0, shapes - 1 do
				local shape = mesh:Shape(i)
				if (shape.fSelected) then
					if (shape.fFillAllowed) then
						shape.fHasFill = self.fillCheck:Value()
					end
				end
			end
			MOHO.Redraw()
			moho:UpdateUI()
		end
		--]=]
	elseif (msg == self.FILL_ALT) then
		if (mesh ~= nil) then
			local shapeFillCol = LM.ColorVector:new_local()
			for i = 0, shapes - 1 do
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
		end
	elseif (msg == self.FILLCOLOR) then
		if (doc ~= nil and not self.editingColor) then
			doc:PrepUndo(lDrawing)
			doc:SetDirty()
		end
		if (style ~= nil) then
			style.fFillCol:SetValue(lDrawingFrame, self.fillCol:Value())
			if (not self.editingColor) then
				--moho:UpdateUI()
			end
		end
		if (mesh ~= nil) then
			for i = 0, shapes - 1 do
				local shape = mesh:Shape(i)
				if (shape.fSelected) then
					shape.fMyStyle.fFillCol:SetValue(lDrawingFrame, self.fillCol:Value())
				end
			end
			MOHO.Redraw()
			if (not self.editingColor) then
				moho:NewKeyframe(CHANNEL_FILL)
				moho:UpdateUI()
			end
		end
	elseif (msg == self.FILLCOLOR_BEGIN) then
		self.editingColor = true
		self:HandleMessage(self.FILLCOLOR)
	elseif (msg == self.FILLCOLOR_END) then
		self.editingColor = false
	elseif (msg == self.FILLCOLOROVER) then
		if (mesh ~= nil and shape ~= nil) then
			--self.fillColOverride:Enable(shapeStyle1 and shapeStyle1.fDefineFillCol or shapeStyle2 and shapeStyle2.fDefineFillCol)
			--self.fillColOverride:SetValue(shape.fMyStyle.fDefineFillCol)
			shape.fMyStyle.fDefineFillCol = self.fillColOverride:Value()
			MOHO.Redraw()
			moho:UpdateUI()
		end
	elseif (msg == self.LINE) then
		---[=[LM_SelectShape:HandleMessage(moho, moho.view, LM_SelectShape.LINE)
		if (mesh ~= nil and shape ~= nil) then
			shape.fHasOutline = self.lineCheck:Value()
			if (shape:IsInCluster() and shape.fComboMode ~= MOHO.COMBO_INTERSECT) then
				shape:BottomOfCluster().fHasOutline = self.lineCheck:Value()
			end
			for i = 0, shapes - 1 do
				local shape = mesh:Shape(i)
				if (shape.fSelected) then
					shape.fHasOutline = self.lineCheck:Value()
				end
			end
			MOHO.Redraw()
			moho:UpdateUI()
		end
		--]=]
	elseif (msg == self.LINE_ALT) then
		local shapeLineCol = LM.ColorVector:new_local()
		for i = 0, shapes - 1 do
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
		if (doc ~= nil and not self.editingColor) then
			doc:PrepUndo(lDrawing)
			doc:SetDirty()
		end
		if (style ~= nil) then
			style.fLineCol:SetValue(lDrawingFrame, self.lineCol:Value())
			if (not self.editingColor) then
				--moho:UpdateUI()
			end
		end
		if (mesh ~= nil) then
			for i = 0, shapes - 1 do
				local shape = mesh:Shape(i)
				if (shape.fSelected) then
					shape.fMyStyle.fLineCol:SetValue(lDrawingFrame, self.lineCol:Value())
				end
			end
			MOHO.Redraw()
			if (not self.editingColor) then
				moho:NewKeyframe(CHANNEL_LINE)
				moho:UpdateUI()
			end
		end
	elseif (msg == self.LINECOLOR_BEGIN) then
		self.editingColor = true
		self:HandleMessage(self.LINECOLOR)
	elseif (msg == self.LINECOLOR_END) then
		self.editingColor = false
	elseif (msg == self.LINECOLOROVER) then
		if (mesh ~= nil and shape ~= nil) then
			--self.lineColOverride:Enable(shapeStyle1 and shapeStyle1.fDefineLineCol or shapeStyle2 and shapeStyle2.fDefineLineCol)
			--self.lineColOverride:SetValue(shape.fMyStyle.fDefineLineCol)
			shape.fMyStyle.fDefineLineCol = self.lineColOverride:Value()
			MOHO.Redraw()
			moho:UpdateUI()
		end
	elseif (msg == self.LINEWIDTH) then
		if (style ~= nil) then
			local lineWidth = self.lineWidth:FloatValue()
			lineWidth = LM.Clamp(lineWidth, 0.25, 256)
			style.fLineWidth = lineWidth / docH
		end
		if (mesh ~= nil) then
			for i = 0, shapes - 1 do
				local shape = mesh:Shape(i)
				if (shape.fSelected) then
					local lineWidth = self.lineWidth:FloatValue()
					lineWidth = LM.Clamp(lineWidth, 0.25, 256)
					shape.fMyStyle.fLineWidth = lineWidth / docH
				end
			end
			MOHO.Redraw()
		else
			if (doc == nil and (self.itemList and self.itemList:IsEnabled() == true)) then
				self:Update()
			end
		end
		moho:UpdateUI()
	elseif (msg == self.LINEWIDTHOVER) then
		if (mesh ~= nil and shape ~= nil) then
			--self.lineWidthOverride:Enable(shapeStyle1 and shapeStyle1.fDefineLineWidth or shapeStyle2 and shapeStyle2.fDefineLineWidth)
			--self.lineWidthOverride:SetValue(shape.fMyStyle.fDefineLineWidth)
			shape.fMyStyle.fDefineLineWidth = self.lineWidthOverride:Value()
			MOHO.Redraw()
			moho:UpdateUI()
		end
	elseif (msg == self.ROUNDCAPS) then
		if (style ~= nil) then
			style.fLineCaps = self.capsBut:Value() and 1 or 0
		end
		if (mesh ~= nil) then
			for i = 0, shapes - 1 do
				local shape = mesh:Shape(i)
				if (shape.fSelected) then
					shape.fMyStyle.fLineCaps = self.capsBut:Value() and 1 or 0
				end
			end
			MOHO.Redraw()
		else
			if (doc == nil) then
				self:Update()
			end
		end
		moho:UpdateUI()
	elseif (msg >= self.FILLED and msg <= self.FILLEDOUTLINED_ALT) then
		local m = msg - self.FILLED
		local creationMode = LM_CreateShape.creationMode
		if (mesh ~= nil) then
			LM_CreateShape.creationMode = math.floor(m / 2) --- #self.shapeButtons
			LM_CreateShape:HandleMessage(moho, moho.view, msg % 2 == 0 and LM_CreateShape.CREATE or LM_CreateShape.CREATE_CONNECTED)
			LM_CreateShape.creationMode = creationMode
		end
		moho:UpdateUI()
	elseif (msg == self.COPY or msg == self.PASTE) then --20240102-2030: This doesn't work as expected, will have to figure out how to store the copied properties in a way they are not overwriten upon selecting another shape...
		if shape ~= nil then
			if msg == self.COPY then
				self.tempShape = moho:NewShapeProperties()
			else -- PASTE
				if mesh ~= nil and self.tempShape then
					for i = 0, shapes - 1 do
						local shape = mesh:Shape(i)
						if (shape.fSelected) then
							shape:CopyStyleProperties(self.tempShape, false, false)
						end
					end
				end
			end
			MOHO.Redraw()
		else
			if style ~= nil then
				if msg == self.COPY then
					self.tempShape = moho:NewShapeProperties()
				else -- PASTE
					if mesh ~= nil and self.tempShape then
						moho:PickStyleProperties(self.tempShape)
					end
				end
				MOHO.Redraw()
			end
		end
		self:Update()
		moho:UpdateUI()
	elseif (msg == self.RESET) or (msg == self.RESET_ALT) then
		local mohoLineWidth = 0.005556 * 2 -- Factory default value * 2 = 8px (No MohoGlobal??)
		if (style ~= nil) then
			style.fFillCol:SetValue(lDrawingFrame, MOHO.MohoGlobals.FillCol)
			style.fLineCol:SetValue(lDrawingFrame, MOHO.MohoGlobals.LineCol)
			style.fLineWidth = mohoLineWidth
			style.fLineCaps = 1
			MOHO.Redraw()
		else
			self.fillCol:SetValue(MOHO.MohoGlobals.FillCol)
			self.lineCol:SetValue(MOHO.MohoGlobals.LineCol)
			self.lineWidth:SetValue(mohoLineWidth * docH)
			self.capsBut:SetValue(true)
			--helper:delete()
			--return
		end
		if (mesh ~= nil) then
			for i = 0, shapes - 1 do
				local shape = mesh:Shape(i)
				if (shape.fSelected) then
					if lDrawingFrame == 0 then
						shape.fMyStyle.fFillCol:SetValue(lDrawingFrame, MOHO.MohoGlobals.FillCol)
						shape.fMyStyle.fLineCol:SetValue(lDrawingFrame, MOHO.MohoGlobals.LineCol)
						shape.fMyStyle.fLineWidth = mohoLineWidth
						shape.fMyStyle.fLineCaps = 1
						shape.f3DThickness:SetValue(lDrawingFrame, 0.1250)
						if msg == self.RESET_ALT then
							shape:MakePlain() --shape:RemoveStyles()
						end
					else
						if shape.fHasFill == true then
							shape.fMyStyle.fFillCol:SetValue(lDrawingFrame, shape.fMyStyle.fFillCol:GetValue(0))
							if msg == self.RESET_ALT then
								shape.fMyStyle.fFillCol:SetValue(lDrawingFrame, MOHO.MohoGlobals.FillCol)
							end
						end
						if shape.fHasOutline == true then
							shape.fMyStyle.fLineCol:SetValue(lDrawingFrame, shape.fMyStyle.fLineCol:GetValue(0))
							if msg == self.RESET_ALT then
								shape.fMyStyle.fLineCol:SetValue(lDrawingFrame, MOHO.MohoGlobals.LineCol)
							end
						end
						if (lDrawing.f3DMode ~= MOHO.VECTOR3D_NONE and lDrawing.f3DMode ~= MOHO.VECTOR3D_LATHE) then
							if msg == self.RESET_ALT then
								shape.f3DThickness:SetValue(lDrawingFrame, 0.1250) -- */ docH)
							else
								if shape.f3DThickness:Duration() > 0 and (shape.f3DThickness:GetValue(lDrawingFrame) ~= shape.f3DThickness:GetValue(0)) then
									shape.f3DThickness:SetValue(lDrawingFrame, shape.f3DThickness:GetValue(0))
								end
							end
						end
						if shape.fEffectOffset:Duration() > 0 then
							shape.fEffectOffset:SetValue(lDrawingFrame, shape.fEffectOffset:GetValue(0))
						end
						if shape.fEffectRotation:Duration() > 0 then
							shape.fEffectRotation:SetValue(lDrawingFrame, shape.fEffectRotation:GetValue(0))
						end
						if shape.fEffectScale:Duration() > 0 then
							shape.fEffectScale:SetValue(lDrawingFrame, shape.fEffectScale:GetValue(0))
						end
					end
				end
			end
			MOHO.Redraw()
		end
		self:Update()
		moho:UpdateUI()
	elseif (msg >= self.SELECTSTYLE1 and msg < self.SELECTSTYLE2) then
		local style1Sel = (doc and doc:StyleByID(msg - self.SELECTSTYLE1 - 1)) and (doc and doc:StyleByID(msg - self.SELECTSTYLE1 - 1).fUUID) or LM.String:new_local("")
		if (shape ~= nil) then
			for i = 0, shapes - 1 do
				local iShape = mesh:Shape(i)
				if (iShape.fSelected) then
					for i = 0, doc:CountStyles() - 1 do
						iShape.fInheritedStyle = doc:StyleByID(msg - self.SELECTSTYLE1 - 1)
					end
				end
			end
			MOHO.Redraw()
		else
			if (self.tempShape ~= nil) then
				if (doc ~= nil) then
					self.tempShape.fInheritedStyleName = (doc and doc:StyleByID(msg - self.SELECTSTYLE1 - 1)) and (doc and doc:StyleByID(msg - self.SELECTSTYLE1 - 1).fUUID) or LM.String:new_local("")
				else
					self.tempShape.fInheritedStyleName = LM.String:new_local("")
					self:Update()
				end
			end
		end
		moho:UpdateUI()
		--self.menuStyle1:UncheckAll()
		--self.menuStyle1:SetChecked(self.SELECTSTYLE1, true)
		--self:Update()
	elseif (msg >= self.SELECTSTYLE2 and msg < self.MSG_LIMIT) then
		local style2Sel = (doc and doc:StyleByID(msg - self.SELECTSTYLE2 - 1)) and (doc and doc:StyleByID(msg - self.SELECTSTYLE2 - 1).fUUID) or LM.String:new_local("")
		if (shape ~= nil) then
			for i = 0, shapes - 1 do
				local iShape = mesh:Shape(i)
				if (iShape.fSelected) then
					for i = 0, doc:CountStyles() - 1 do
						iShape.fInheritedStyle2 = doc:StyleByID(msg - self.SELECTSTYLE2 - 1)
					end
				end
			end
			MOHO.Redraw()
		else
			if (self.tempShape ~= nil) then
				if (doc ~= nil) then
					self.tempShape.fInheritedStyleName2 = (doc and doc:StyleByID(msg - self.SELECTSTYLE2 - 1)) and (doc and doc:StyleByID(msg - self.SELECTSTYLE2 - 1).fUUID) or LM.String:new_local("")
				else
					self.tempShape.fInheritedStyleName2 = LM.String:new_local("")
					self:Update()
				end
			end
		end
		moho:UpdateUI()
	elseif LM.GUI.MSG_CANCEL then -- Triggered upon auto-closing.
		--return
		--helper:delete()
	end
	--moho:UpdateUI()
	helper:delete()
end

function LS_ShapesWindowDialog:WhatMsg(msg, t) --(int, table) char
	t = t or self
	local what = "<NONE>"
	for k, v in pairs(t) do
		if v == msg then
			what = k
		end
	end
	return what
end

function LS_ShapesWindowDialog:CountRealItems(w, msg) --(LM.GUI.Widget, int) int
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

function LS_ShapesWindow:IsEnabled(moho) --print("LS_ShapesWindow:IsEnabled(" .. tostring(moho.document:Name()) .. ")", " 🕗: " .. os.clock())
	if (not self.docsLoaded) then
		local swatchDir = moho:UserAppDir()
		if (swatchDir ~= "") then
			swatchDir = swatchDir .. "\\Scripts\\ScriptResources\\ls_shapes_window\\Swatches\\"
			moho:BeginFileListing(swatchDir)
			local fileName = moho:GetNextFile()
			while fileName ~= nil do
				local docPath = swatchDir .. fileName
				self:LoadDocument(moho, docPath)
				fileName = moho:GetNextFile()
			end
		end
		local swatchDir = moho:UserAppDir()
		if (swatchDir ~= "") then
			swatchDir = swatchDir .. "\\Swatches\\"
			moho:BeginFileListing(swatchDir)
			local fileName = moho:GetNextFile()
			while fileName ~= nil do
				local docPath = swatchDir .. fileName
				self:LoadDocument(moho, docPath)
				fileName = moho:GetNextFile()
			end
		end
		self.docsLoaded = true
	end

	if (LS_ShapesWindow.dlog == nil) then
		return true
	end
	return false
end

function LS_ShapesWindow:IsRelevant(moho) --print("LS_ShapesWindow:IsRelevant(" .. tostring(moho.document:Name()) .. ")", " 🕗: " .. os.clock())
	self.defMoho = moho
	self.defDoc = self.defMoho.document
	self.defLayer = (self.defDoc and self.defDoc:CountLayers() > 0) and self.defDoc:Layer(0) or nil
	self.defVecLayer = self.defLayer and moho:LayerAsVector(self.defLayer) or nil
	self.defMesh = self.defVecLayer and self.defVecLayer:Mesh() or nil

	if self.defDoc ~= nil and self.defDoc:Name() ~= "-" then
		if self.openOnStartup and self.shouldOpen and self.lastMOHO ~= tostring(MOHO) then
			self:Run(moho) --LS_ShapesWindowDialog:Update(moho)
		end
	end

	if self:CompareVersion(moho:AppVersion(), 14.0) < 0 or not self.showInTools then
		return false
	end
	return true
end

function LS_ShapesWindow:Run(moho)
	if self.dlog == nil then
		self.mode = 0
		--[[20230929-2230: Throw a warning, for now, if current tool has a dialog to avoid both get messed up... 20231004-1430: See dlogBypass patch bellow! :D
		local reminder = ""
		if self.prevClock and (os.clock() - self.prevClock) * 1000 < 300 * (speedFactor or 1) then
			reminder = "Reminder: "
		end
		local tool = moho:CurrentTool()
		for _, v in pairs(_G[tool]) do --if _G[moho:CurrentTool()].dlog then
			if type(v) == "userdata" and tostring(v):find("SimpleDialog") then -- Throw a warning...
				if self.alertCantOpen ~= 1 or reminder ~= "" then 
					self.alertCantOpen = LM.GUI.Alert(LM.GUI.ALERT_INFO, reminder .. "The \"" .. LS_ShapesWindow:UILabel() .. "\" couldn't be opened due to currently active tool (\"" .. _G[tool]:UILabel() .. "\" in this case) has a dialog and that may cause problems.", "Please, select a different one in \"Tools\" palette with that in mind and try again... Once \"" .. LS_ShapesWindow:UILabel() .. "\" is open, you are free to activate and work breezily with any tool.", nil, "OK", (reminder == "" and "Got it!" or nil), nil) --OK: 0, Got it: 1
					self.alertCantOpen = reminder ~= "" and 1 or self.alertCantOpen
				else
					LM.Beep()
				end
				self.prevClock = os.clock()
				return
			end
		end
		--]]

		self.dlog = LS_ShapesWindowDialog:new(moho)
		--self.dlogBypass = LS_ShapesWindowDialog:new(moho) self.dlogBypass = nil -- dlogGuard, dlogShield, dlogBait, dlogTrap, dlogPatch...
		self.dlog:DoModeless()
	else
		--print(self.dlog.itemNameLabel:Height())
		LM.Beep()
	end

end

function LS_ShapesWindow:CompareVersion(a, b) -- Sorting an array of semantic versions or SemVer (https://medium.com/geekculture/sorting-an-array-of-semantic-versions-in-typescript-55d65d411df2)
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
end --print(tostring(LS_ShapesWindow:CompareVersion("13.5.6", "14.0")))

function LS_ShapesWindow:LoadDocument(moho, docPath)
	local doc = moho:LoadDocument(docPath)
	if (doc ~= nil) then
		table.insert(self.docList, doc)
		if (self.doc == nil) then
			self.doc = doc
		end
	end
end

--[[20231218-2014: Using "StyleID" instead... Delete?
function LS_ShapesWindow:StyleIDByUUID(doc, UUID)
	if doc ~= nil and UUID ~= nil then
		for i = 0, doc:CountStyles() - 1 do
			if (doc:StyleByID(i).fUUID:Buffer() == UUID) then
				return i
			end
		end
	end
end
--]]

function LS_ShapesWindow:StyleID(doc, style)
	local ID = -1
	if doc ~= nil and style ~= nil then
		for i = 0, doc:CountStyles() - 1 do
			if (doc:StyleByID(i) == style) then --(doc:StyleByID(i).fUUID:Buffer() == style.fUUID)
				ID = i
				break
			end
		end
	end
	return ID
end

function LS_ShapesWindow:MakeStyleNameUnique(doc, id, jump) --(MohoDoc, int, int) void
	if (doc ~= nil and id ~= nil) then
		local count = 0 + (jump or 1)
		local baseName = doc:StyleByID(id).fName:Buffer() -- Style's original name
		local newName = baseName -- Current name of the shape, which goes updating
		local namesake = id
		for i = 0, doc:CountStyles() - 1 do -- Check if the name is already taken by another style and, if so, pick that style's reference ID
			local style = doc:StyleByID(i)
			if style.fName:Buffer() == baseName and i ~= id then
				namesake = i
			end
		end
		if doc:Style(newName) ~= nil and doc:StyleByID(namesake) ~= doc:StyleByID(id) then -- We check if there is another shape with the current name, not with the original one
			while doc:Style(newName) do -- As long as there is another shape with the current name and it's not the same as the one we are renaming...
				count = count + 1
				newName = baseName .. " " .. count -- We generate the new name using the original name and the counter
			end
		end
		doc:StyleByID(id).fName:Set(newName) -- We assign the new name to the shape using the current name
	end
end


function LS_ShapesWindow:StyleLeaver(moho, mesh, mode) -- StyleDeactivator?
	mesh = mesh or moho:DrawingMesh()
	if moho ~= nil and mesh ~= nil then
		local styleName = moho:CurrentEditStyle() and tostring(moho:CurrentEditStyle().fName:Buffer()) or ""
		if styleName ~= "" then
			--local v = LM.Vector2:new_local() v:Set(0, -100) v:Set(0, -100.0001)
			mesh:SelectNone()
			mesh:AddLonePoint(LM.Vector2:new_local(0, -100) , 0)
			mesh:AppendPoint(LM.Vector2:new_local(0, -100.0001), 0)
			mesh:SelectConnected()

			if moho:CreateShape(false, false, 0) then
				if mesh:CountShapes() > 0 then
					local tempShape = mesh:Shape(mesh:CountShapes() - 1)
					tempShape:SetName("")
					tempShape:MakePlain()
					tempShape.fSelected = true
					--tempShape:SelectAllPoints()
					--mesh:DeleteShape(mesh:CountShapes() - 1)
					--curStyle = moho:CurrentEditStyle() print(curStyle.fName:Buffer())
					--print("Before 'UpdateUI'")
					moho:UpdateUI() --print("After 'UpdateUI'")
					moho:DeselectShapes() --tempShape.fSelected = false
					mesh:DeleteShape(mesh:CountShapes() - 1)
					mesh:DeleteSelectedPoints()
					MOHO.Redraw()
				end
				return mode or self.mode or 0
			end
		end
	end
	return self.mode or 0
end

function LS_ShapesWindow:CountCurves(moho, shape) --(moho, M_Shape) int
	local mesh = moho:DrawingMesh()
	local shape = shape or moho:SelectedShape()
	local count = 0
	if shape ~= nil then
		for curveID = 0, mesh:CountCurves() - 1 do
			if shape:ContainsCurve(curveID) then
				count = count + 1
			end
		end
	end
	return count
end

function LS_ShapesWindow:IsSingleCurve(shape) --(M_Shape) bool
	if shape ~= nil then
		local curveID, segID = -1, -1
		local curveID = shape:GetEdge(0, curveID, segID)
		for i = 0, shape:CountEdges() - 1 do
			local nextCurveID, nextSegID = -1, -1
			nextCurveID, nextSegID = shape:GetEdge(i, curveID, segID)
			if nextCurveID ~= curveID then
				return false
			end
		end
	end
	return true
end

function LS_ShapesWindow:MakeShapeNameUnique(mesh, id, jump) --(mesh, int, int) void
	if (mesh ~= nil and id ~= nil) then
		local count = 0 + (jump or 1)
		local baseName = mesh:Shape(id):Name() -- Shape's original name
		local newName = baseName -- Current name of the shape, which goes updating
		local namesake = id
		for i = 0, mesh:CountShapes() - 1 do -- Check if the name is already taken by another shape and, if so, pick that shape's reference ID
			local shape = mesh:Shape(i)
			if shape:Name() == baseName and i ~= id then
				namesake = i
			end
		end
		if mesh:ShapeByName(newName) ~= nil and mesh:Shape(namesake) ~= mesh:Shape(id) then -- We check if there is another shape with the current name, not with the original one
			while mesh:ShapeByName(newName) do -- As long as there is another shape with the current name and it's not the same as the one we are renaming...
				count = count + 1
				newName = baseName .. " " .. count -- We generate the new name using the original name and the counter
			end
		end
		mesh:Shape(id):SetName(newName) -- We assign the new name to the shape using the current name
	end
end

function LS_ShapesWindow:BuildStyleChoiceMenu(menu, doc, baseMsg, dummyMsg, exclude) --(LM_Menu, MohoDoc, MSG_BASE, int) void
	menu:RemoveAllItems()
	menu:AddItem(MOHO.Localize("/Windows/Style/None2=None"), 0, baseMsg) --øØ‹›
	if doc ~= nil then
		for i = 0, doc:CountStyles() - 1 do
			local style = doc:StyleByID(i)
			local styleName = style.fName:Buffer()
			if (i ~= exclude and styleName ~= "") then
				if i == 0 then menu:AddItem("", 0, 0) end
				menu:AddItem(styleName, 0, baseMsg + 1 + i)
			end
		end
	end
end

function LS_ShapesWindow:IsSwatchLayer(moho, layer)
	return (layer and layer:LayerType() == MOHO.LT_VECTOR and moho:LayerAsVector(layer):Mesh():CountShapes() > 1) and not layer:IsRenderOnly()
end

function LS_ShapesWindow.LineBreaker(s, numSpaces, sep)
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

function LS_ShapesWindow.Abbreviator(s)
	local num = 0
	local abrev = string.gsub(s, "%a+", function(w) if #w > 4 then num = num + 1 return string.sub(w, 1, 3) .. "." else return w end end)
	return abrev, num
end

function LS_ShapesWindow.BiasedRandom (p, r, n)
	return math.random () < p and n or math.random (n + 1, r)
end

function LS_ShapesWindow:License(years, name, company)
	years = years or self.ScriptBirth or os.date("%Y")
	name = name or "Rai López"
	company = company or "Lost Scripts™"

	local license =	[[
	Copyright © %s - %s (%s)

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
	        Use         - use/reuse freely, even commercially
	        Adapt  - remix, transform, and build upon for any purpose
	        Share    - redistribute the material in any medium or format

	Adapt / Share under the following terms:
	        Attribution - You must give appropriate credit, provide a link to
	        the Apache 2.0 license, and indicate if changes were made. You may
	        do so in any reasonable manner, but not in any way that suggests
	        the licensor endorses you or your use.

	Licensed works, modifications and larger works may be distributed
	under different License terms and without source code.

	Unless required by applicable law or agreed to in writing, software
	distributed under the License is distributed on an "AS IS" BASIS,
	WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
	See the License for the specific language governing permissions and
	limitations under the License.

	The Developer %s will not be liable for any direct,
	indirect or consequential loss of actual or anticipated - data, revenue,
	profits, business, trade or goodwill that is suffered as a result of the
	use of the software provided.
	]]
	--                                                                                                                                                      
	return string.format(license, tostring(years), name, company, name)
end --print(LS_ShapesWindow:License())
