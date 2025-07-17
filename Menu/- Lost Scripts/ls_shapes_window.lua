-- **************************************************
-- Provide Moho with the name+ of this script object
-- **************************************************

ScriptName = "LS_ShapesWindow"
ScriptBirth = "20220918-0248"
ScriptBuild = "20240224-0117"
ScriptVersion = "0.3.1 BETA"
ScriptTarget = "Moho® 14.1+ Pro"

-- **************************************************
-- General information about this script
-- **************************************************

LS_ShapesWindow = {}

LS_ShapesWindow.BASE_STR = 2320

function LS_ShapesWindow:Name()
	return "Shapes Window"
end

function LS_ShapesWindow:Version()
	return self.version -- "0.0.1.20231005.1731"
end

function LS_ShapesWindow:Description()
	return MOHO.Localize("/LS/ShapesWindow/Description=A persistent shape palette plus helpers for better management of Moho® vectors in general and the AMAZING new \"Liquid Shapes\" in particular.")
end

function LS_ShapesWindow:Creator()
	return "Rai López"
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
	self.beginnerMode = prefs:GetBool("LS_ShapesWindow.beginnerMode", true)
	self.advanced = prefs:GetBool("LS_ShapesWindow.advanced", true)
	self.largeButtons = prefs:GetBool("LS_ShapesWindow.largeButtons", false)
	self.largePalette = prefs:GetBool("LS_ShapesWindow.largePalette", false)
	self.showInfobar = prefs:GetBool("LS_ShapesWindow.showInfobar", true)
	self.swatch = prefs:GetInt("LS_ShapesWindow.swatch", -1)
	self.swatchDoc = prefs:GetInt("LS_ShapesWindow.swatchDoc", 1)
	self.swatchLayer = prefs:GetInt("LS_ShapesWindow.swatchLayer", 1)
	self.swatchPath = prefs:GetString("LS_ShapesWindow.swatchPath", "")
	self.brushDirectory = prefs:GetInt("LS_ShapesWindow.brushDirectory", 2)
	self.multiMenuMode = prefs:GetInt("LS_ShapesWindow.multiMenuMode", 0)
	self.multiMenuFlags = prefs:GetInt("LS_ShapesWindow.multiMenuFlags", 0)
	self.alertCantOpen = prefs:GetInt("LS_ShapesWindow.alertCantOpen", 0)
	self.alertShowInTools = prefs:GetInt("LS_ShapesWindow.alertShowInTools", 0)
	self.lastMOHO = prefs:GetString("LS_ShapesWindow.lastMOHO", tostring(0))
	--self.endedByMoho = prefs:GetBool("LS_ShapesWindow.endedByApp", false)
	--self.endedByUser = prefs:GetBool("LS_ShapesWindow.endedByUser", false)

	self.DarkHighlight = prefs:GetString("DarkHighlight", "105 169 161 255") --224 160 0 255
	self.FirstRun2 = prefs:GetInt("FirstRun2", 0)
	self.HighlightColor = prefs:GetString("HighlightColor", "34 124 175 255") --224 160 0 255?
	self.LightHighlight = prefs:GetString("LightHighlight", "34 124 175 255") --34 124 175 255
	self.MohoLineWidth = prefs:GetFloat("MohoLineWidth", 0.005556 * 2) --0.011111
	self.UILightness_v12beta = prefs:GetFloat("UILightness_v12beta", 0.088000) --0.207000
	self.UseLargeFonts = prefs:GetBool("UseLargeFonts", false)
end

function LS_ShapesWindow:SavePrefs(prefs) --print("LS_ShapesWindow:SavePrefs(" .. tostring(prefs) .. ")", " 🕗: " .. os.clock()) LM.Snooze(1500)
	prefs:SetInt("LM_CreateShape.creationMode", self.creationMode)
	prefs:SetBool("LS_ShapesWindow.pointsBasedSel", self.pointsBasedSel)
	prefs:SetBool("LS_ShapesWindow.ignoreNonRegular", self.ignoreNonRegular)
	prefs:SetBool("LS_ShapesWindow.linkToStyle", self.linkToStyle)
	prefs:SetBool("LS_ShapesWindow.openOnStartup", self.openOnStartup)
	prefs:SetBool("LS_ShapesWindow.shouldOpen", true)
	prefs:SetBool("LS_ShapesWindow.showInTools", self.showInTools)
	prefs:SetBool("LS_ShapesWindow.beginnerMode", self.beginnerMode)
	prefs:SetBool("LS_ShapesWindow.advanced", self.advanced)
	prefs:SetBool("LS_ShapesWindow.largeButtons", self.largeButtons)
	prefs:SetBool("LS_ShapesWindow.largePalette", self.largePalette)
	prefs:SetBool("LS_ShapesWindow.showInfobar", self.showInfobar)
	prefs:SetInt("LS_ShapesWindow.swatch", self.swatch)
	prefs:SetInt("LS_ShapesWindow.swatchDoc", self.swatchDoc)
	prefs:SetInt("LS_ShapesWindow.swatchLayer", self.swatchLayer)
	prefs:SetString("LS_ShapesWindow.swatchPath", self.swatchPath)
	prefs:SetInt("LS_ShapesWindow.brushDirectory", self.brushDirectory)
	prefs:SetInt("LS_ShapesWindow.multiMenuMode", self.multiMenuMode)
	prefs:SetInt("LS_ShapesWindow.multiMenuFlags", self.multiMenuFlags)
	prefs:SetInt("LS_ShapesWindow.alertCantOpen", self.alertCantOpen)
	prefs:SetInt("LS_ShapesWindow.alertShowInTools", self.alertShowInTools)
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
	LS_ShapesWindow.beginnerMode = true
	LS_ShapesWindow.advanced = true
	LS_ShapesWindow.largeButtons = false
	LS_ShapesWindow.largePalette = false -- 0: Max, 1: Full, 2: Half, 3: Third?
	LS_ShapesWindow.showInfobar = true
	LS_ShapesWindow.swatch = -1
	LS_ShapesWindow.swatchDoc = 1
	LS_ShapesWindow.swatchLayer = 1
	LS_ShapesWindow.swatchPath = ""
	LS_ShapesWindow.brushDirectory = 2
	LS_ShapesWindow.multiMenuMode = 0 -- 0: Fill, 1: Stroke, 2: FX, 3: Recolor (RGB), Recolor (HSB)
	LS_ShapesWindow.multiMenuFlags = 1 -- 1: Affects Fills, 2: Affects Strokes, 4: ...
	LS_ShapesWindow.alertCantOpen = 0
	LS_ShapesWindow.alertShowInTools = 0
end

-- **************************************************
-- Recurring values
-- **************************************************

LS_ShapesWindow.name = ScriptName
LS_ShapesWindow.birth = ScriptBirth
LS_ShapesWindow.build = ScriptBuild
LS_ShapesWindow.version = ScriptVersion
LS_ShapesWindow.target = ScriptTarget
LS_ShapesWindow.UUID = "f5350aae-a7ad-4080-9685-a5ef32bd6faa" --ac74b0a7-3e7c-2f59-2f78-f69ac973cf6c
LS_ShapesWindow.path = debug.getinfo(1,'S')
LS_ShapesWindow.filename = (LS_ShapesWindow.path.source):match("^.*[/\\](.*).lua$")
LS_ShapesWindow.web = "https://lost-scripts.github.io/"
LS_ShapesWindow.webpage = LS_ShapesWindow.web .. "scripts/" .. LS_ShapesWindow.filename
LS_ShapesWindow.forge = "https://github.com/"
LS_ShapesWindow.forgeArk = LS_ShapesWindow.forge .. "lost-scripts/"
LS_ShapesWindow.repo = LS_ShapesWindow.forgeArk .. LS_ShapesWindow.filename
LS_ShapesWindow.repoLatest = LS_ShapesWindow.repo .. "/releases/latest/" --https://github.com/lost-scripts/ls_shapes_window/releases/latest/#YOURS-IS-v0.3.0-BETA
LS_ShapesWindow.repoDown = LS_ShapesWindow.repoLatest .. "download/" .. LS_ShapesWindow.filename .. ".zip" --https://stackoverflow.com/questions/24987542/is-there-a-link-to-github-for-downloading-a-file-in-the-latest-release-of-a-repo
LS_ShapesWindow.doc = nil
LS_ShapesWindow.docList = {}
LS_ShapesWindow.docPath = ""
LS_ShapesWindow.docsLoaded = false
LS_ShapesWindow.dlog = nil
LS_ShapesWindow.shouldOpen = false
LS_ShapesWindow.shouldReopen = false
LS_ShapesWindow.mode = 0 -- 0: DEFAULT, 1: SHAPE, 2: STYLE / Style Management, 3: ?
LS_ShapesWindow.multiMenuLast = (LS_ShapesWindow.multiMenuMode and LS_ShapesWindow.multiMenuMode < 2) and LS_ShapesWindow.multiMenuMode or 0
LS_ShapesWindow.multiMenuRules = false
LS_ShapesWindow.multiValues = {[3] = {0, 0, 0, 1}, [4] = {0, 0, 0, 0}}
LS_ShapesWindow.isHelpVisible = false
LS_ShapesWindow.showHelp = false
--LS_ShapesWindow.DarkHighlight = "224 160 0 255" --224 160 0 255
--LS_ShapesWindow.FirstRun2 = 0
--LS_ShapesWindow.HighlightColor = "224 160 0 255" --224 160 0 255
--LS_ShapesWindow.LightHighlight = "34 124 175 255" --34 124 175 255
--LS_ShapesWindow.MohoLineWidth = 0.005556
--LS_ShapesWindow.UILightness_v12beta = 0.088000 --0.207000
--LS_ShapesWindow.UseLargeFonts = false

-- **************************************************
-- Shapes Window dialog
-- **************************************************

local LS_ShapesWindowDialog = {}

LS_ShapesWindowDialog.MENU1					= MOHO.MSG_BASE
--LS_ShapesWindowDialog.MENU2				= MOHO.MSG_BASE + 20 -- NOTE: Used to be what is now SELECTSWATCH

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
LS_ShapesWindowDialog.COLORSWAP				= MOHO.MSG_BASE + 118
LS_ShapesWindowDialog.LINEWIDTH				= MOHO.MSG_BASE + 119
LS_ShapesWindowDialog.LINEWIDTHOVER			= MOHO.MSG_BASE + 120
LS_ShapesWindowDialog.ROUNDCAPS				= MOHO.MSG_BASE + 121
LS_ShapesWindowDialog.BRUSH					= MOHO.MSG_BASE + 122
LS_ShapesWindowDialog.COPY					= MOHO.MSG_BASE + 123
LS_ShapesWindowDialog.PASTE					= MOHO.MSG_BASE + 124
LS_ShapesWindowDialog.RESET					= MOHO.MSG_BASE + 125
LS_ShapesWindowDialog.RESET_ALT				= MOHO.MSG_BASE + 126

LS_ShapesWindowDialog.MODE					= MOHO.MSG_BASE + 127
LS_ShapesWindowDialog.NAME					= MOHO.MSG_BASE + 128
LS_ShapesWindowDialog.VIS					= MOHO.MSG_BASE + 129
LS_ShapesWindowDialog.COMBINE_NORMAL		= MOHO.MSG_BASE + 130
LS_ShapesWindowDialog.COMBINE_ADD			= MOHO.MSG_BASE + 131
LS_ShapesWindowDialog.COMBINE_SUBTRACT		= MOHO.MSG_BASE + 132
LS_ShapesWindowDialog.COMBINE_INTERSECT		= MOHO.MSG_BASE + 133
LS_ShapesWindowDialog.COMBINE_BLEND_BUT		= MOHO.MSG_BASE + 134
LS_ShapesWindowDialog.COMBINE_BLEND_BUT_ALT	= MOHO.MSG_BASE + 135
LS_ShapesWindowDialog.COMBINE_BLEND			= MOHO.MSG_BASE + 136
LS_ShapesWindowDialog.BASE_SHAPE			= MOHO.MSG_BASE + 137
LS_ShapesWindowDialog.BASE_SHAPE_ALT		= MOHO.MSG_BASE + 138
LS_ShapesWindowDialog.TOP_SHAPE				= MOHO.MSG_BASE + 139
LS_ShapesWindowDialog.TOP_SHAPE_ALT			= MOHO.MSG_BASE + 140
LS_ShapesWindowDialog.MERGE					= MOHO.MSG_BASE + 141
LS_ShapesWindowDialog.RAISE					= MOHO.MSG_BASE + 142
LS_ShapesWindowDialog.RAISE_ALT				= MOHO.MSG_BASE + 143
LS_ShapesWindowDialog.LOWER					= MOHO.MSG_BASE + 144
LS_ShapesWindowDialog.LOWER_ALT				= MOHO.MSG_BASE + 145
LS_ShapesWindowDialog.DELETE				= MOHO.MSG_BASE + 146
LS_ShapesWindowDialog.DELETE_ALT			= MOHO.MSG_BASE + 147
LS_ShapesWindowDialog.SELECTALL				= MOHO.MSG_BASE + 148
LS_ShapesWindowDialog.SELECTALL_ALT			= MOHO.MSG_BASE + 149
LS_ShapesWindowDialog.SELECTMATCHING		= MOHO.MSG_BASE + 150
LS_ShapesWindowDialog.SELECTMATCHING_ALT	= MOHO.MSG_BASE + 151
LS_ShapesWindowDialog.CHECKERSEL			= MOHO.MSG_BASE + 152
LS_ShapesWindowDialog.STYLESWAP				= MOHO.MSG_BASE + 153
LS_ShapesWindowDialog.COLORSLIDER			= MOHO.MSG_BASE + 154
LS_ShapesWindowDialog.CHANGE				= MOHO.MSG_BASE + 155
LS_ShapesWindowDialog.DUMMY					= MOHO.MSG_BASE + 156
LS_ShapesWindowDialog.MULTI1				= MOHO.MSG_BASE + 157
LS_ShapesWindowDialog.MULTI2				= MOHO.MSG_BASE + 158
LS_ShapesWindowDialog.MULTI3				= MOHO.MSG_BASE + 159
LS_ShapesWindowDialog.MULTI4				= MOHO.MSG_BASE + 160
LS_ShapesWindowDialog.APPLY					= MOHO.MSG_BASE + 161
LS_ShapesWindowDialog.APPLY_ALT				= MOHO.MSG_BASE + 162
LS_ShapesWindowDialog.MULTI					= MOHO.MSG_BASE + 200
LS_ShapesWindowDialog.SELECTSTYLE1			= MOHO.MSG_BASE + 250	-- extremely unlikely to have anything close to 50 modes...
LS_ShapesWindowDialog.SELECTSTYLE2			= MOHO.MSG_BASE + 1250	-- extremely unlikely to have anything close to 1000 styles
LS_ShapesWindowDialog.SELECTSWATCH			= MOHO.MSG_BASE + 1350	-- extremely unlikely to have anything close to 1000 styles
LS_ShapesWindowDialog.SELECTBRUSH			= MOHO.MSG_BASE + 1850	-- extremely unlikely to have anything close to 500 swatches
LS_ShapesWindowDialog.MSG_LIMIT				= MOHO.MSG_BASE + 3000	-- extremely unlikely to have anything close to 1150 brushes?

function LS_ShapesWindowDialog:new(moho) --print("LS_ShapesWindowDialog:new(" .. tostring(moho) .. "): ", " 🕗: " .. os.clock()) -- This print makes the window get closed upon closing the LCW!
	local d = LM.GUI.SimpleDialog(MOHO.Localize("/Windows/Style/Shapes=Shapes"), LS_ShapesWindowDialog) --LS_ShapesWindow:UILabel()
	local l = d:GetLayout()
	local doc = moho.document
	local docH = doc and doc:Height() or 240
	local style = moho:CurrentEditStyle()

	local mainW = 150 --144 --140 --132
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
	d.vHeight = d.v and math.floor((d.v:Height() / (LS_ShapesWindow.largePalette and 1 or 2))) - 214 or (LS_ShapesWindow.largePalette and 648 or 324) --d.vHeight = d.vHeight and d.vHeight - 132 or 726
	d.beginnerMode = LS_ShapesWindow.beginnerMode
	d.editingColor = false
	d.tempShape = moho:NewShapeProperties() or MOHO.MohoGlobals.NewShapeProperties
	d.resPath = moho:UserContentDir() .. '\\Scripts\\ScriptResources\\' .. LS_ShapesWindow.filename

	l:AddPadding(-12)
	l:Unindent(8)

	l:AddPadding(-12) ---14 (if modeBut)
	l:PushV(LM.GUI.ALIGN_LEFT, 0)
		--l:AddPadding(-4) -- Comment if modeBut
		l:PushH(LM.GUI.ALIGN_LEFT, 0)
			l:AddPadding(LS_ShapesWindow.largeButtons and padH or 0) --l:AddPadding(-7)
			d.menu1 = LM.GUI.Menu("") --☰⁝⚙…
			d.menu1.conditionalItems = {}
			d.menu1Popup = LM.GUI.PopupMenu(menuW, false)
			--d.menu1Popup:SetToolTip(MOHO.Localize("/Dialogs/LayerSettings/General=General")) --"/Dialogs/LayerSettings/GeneralTab/Options=Options"
			d.menu1Popup:SetMenu(d.menu1)
			l:AddChild(d.menu1Popup, LM.GUI.ALIGN_LEFT, 6) --largeFonts = d.menu1Popup:Height() > 24 
			d.menu1:AddItem(MOHO.Localize("/LS/ShapesWindow/PointsBasedSelection=Points-Based Selection") .. " [🧪]", 0, self.MENU1)
			d.menu1:AddItem(MOHO.Localize("/LS/ShapesWindow/IgnoreNonRegularVectorLayers=Ignore Non-Regular Vector Layers"), 0, self.MENU1 + 1)
			d.menu1:AddItem(MOHO.Localize("/LS/ShapesWindow/LinkToStyleWindow=Link To Style Window"), 0, self.MENU1 + 2)
			--d.menu1:AddItem(MOHO.Localize("/LS/ShapesWindow/AsleepWhileUsingDrawingTools=Asleep While Using Drawing Tools"), 0, self.MENU1 + 2) -- & Click To Awake? -- TBC
			d.menu1:AddItem("", 0, 0)
			d.menu1:AddItem(MOHO.Localize("/LS/ShapesWindow/OpenOnStartup=Open On Startup"), 0, self.MENU1 + 3)
			d.menu1:AddItem(MOHO.Localize("/LS/ShapesWindow/ShowInTools=Show In \"Tools\" Palette"), 0, self.MENU1 + 4)
			d.menu1:AddItem(MOHO.Localize("/LS/ShapesWindow/BeginnersMode=Beginner's Mode (Tooltippy)"), 0, self.MENU1 + 5)
			d.menu1:AddItem("", 0, 0)
			d.menu1:AddItem(MOHO.Localize("/LS/ShapesWindow/AdvancedMode=Advanced (Creation Controls)"), 0, self.MENU1 + 6) d.menu1:SetEnabled(self.MENU1 + 6, true) --Show Creation Controls?
			d.menu1:AddItem(MOHO.Localize("/LS/ShapesWindow/UseLargeButtons=Use Large Buttons"), 0, self.MENU1 + 7)
			d.menu1:AddItem(MOHO.Localize("/LS/ShapesWindow/UseLargePalette=Use Large Palette (%d Items)"):match("[^%(]+"), 0, self.MENU1 + 8) --MOHO.Localize("/Dialogs/ExportSettings/HalfDimensions=Use Large Palette (%dx%d)"):match("[^%(]+")
			d.menu1:AddItem(MOHO.Localize("/Windows/LayerComps/ShowComp=Show") .. " " .. "Infobar", 0, self.MENU1 + 9)
			--d.menu1:AddItem(MOHO.Localize("/LS/ShapesWindow/ResizeAndReopen=Resize & Reopen"), 0, self.MENU1 + 9)
			d.menu1:AddItem("", 0, 0)
			d.menu1:AddItem(MOHO.Localize("/Dialogs/ProjectSettings/RestoreDefaults=Restore Defaults") .. " [?]", 0, self.MENU1 + 10)
			d.menu1:AddItem("", 0, 0)
			if (LS_ShapesWindow:FileExists(d.resPath .. '\\HELP.png') == true) or (LS_ShapesWindow:FileExists(d.resPath .. '\\@HELPME.url') == true) or LS_ShapesWindow.repo then
				table.insert (d.menu1.conditionalItems, self.MENU1 + 11)
				d.menu1:AddItem(MOHO.Localize("/Menus/Help/Help=Help") .. "...", 0, d.menu1.conditionalItems[#d.menu1.conditionalItems])
			end
			if (LS_ShapesWindow:FileExists(d.resPath .. '\\@VISITME.url') == true) or (LS_ShapesWindow.webpage and LS_ShapesWindow.webpage ~= "") then
				table.insert (d.menu1.conditionalItems, self.MENU1 + 12)
				d.menu1:AddItem(MOHO.Localize("/LS/ShapesWindow/VisitWebpage=Visit Webpage") ..  "...", 0, d.menu1.conditionalItems[#d.menu1.conditionalItems])
			end
			if (LS_ShapesWindow:FileExists(d.resPath .. '\\@UPDATEME.url') == true) or (LS_ShapesWindow.repoLatest and LS_ShapesWindow.repoLatest ~= "") then
				table.insert (d.menu1.conditionalItems, self.MENU1 + 13)
				d.menu1:AddItem(MOHO.Localize("/Menus/Help/CheckForUpdates=Check For Updates..."), 0, d.menu1.conditionalItems[#d.menu1.conditionalItems])
			end
			if (#d.menu1.conditionalItems > 1) then
				d.menu1:AddItem("", 0, 0)
			end
			d.menu1:AddItem(MOHO.Localize("/Menus/Application/About=About") .. " " .. LS_ShapesWindow:UILabel() .. "...", 0, self.MENU1 + 14)
			--d.menu1:AddItem("...", 0, self.MENU1 + 15) -- Last (Testground!)
			--[[
			l:AddPadding(0) --l:AddPadding(-2)
			d.menu2 = LM.GUI.Menu("")
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
			--d.menu3:AddItem(MOHO.Localize("/Windows/Style/Swatches=Swatches"), 0, self.SELECTSWATCH)
			--d.menu3:AddItem(MOHO.Localize("/Windows/Style/Swatches=Swatches"), 0, self.SELECTSWATCH + 1)
			--]=]
			l:AddPadding(1)
			--]]
		l:Pop() --H

		l:Indent(8)
		---[[20231010-1630: Don't try to support Style management, yet...
		l:AddPadding(LS_ShapesWindow.UseLargeFonts and -27 or -22)
		l:PushH(LM.GUI.ALIGN_CENTER, 0)
			l:AddPadding(9)
			d.modeBut = LM.GUI.ShortButton("    MODE    ", self.MODE) --"Room 4 Label"
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
			d.itemName = LM.GUI.TextControl(mainW - d.itemVisCheck:Width() - 3, "Sel. Item Name", self.NAME, -1) --20240207-2030: wat? -1 instead of LM.GUI.FIELD_TEXT seems to make the enter key work??
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

				d.selectMatchingBut = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_sel_similar", "", false, self.SELECTMATCHING, true)
				d.selectMatchingBut:SetAlternateMessage(self.SELECTMATCHING_ALT)
				l:AddChild(d.selectMatchingBut, LM.GUI.ALIGN_FILL)
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

				d.deleteBut = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_delete", MOHO.Localize("/Windows/Style/Delete=Delete"), false, self.DELETE, true) --"<alt> Delete entire Liquid Shape"? --"ScriptResources/../channel_off" --"ScriptResources/../action_del" 
				d.deleteBut:SetAlternateMessage(self.DELETE_ALT)
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
				local listHeight = LM.Clamp(d.vHeight % itemHeight == 0 and d.vHeight or d.vHeight + (itemHeight - d.vHeight % itemHeight) + 2, itemHeight * 15 + 2, itemHeight * 25 + 2) -- Try to ensure last item always fits (Min: 296?)
				--local listHeight = (d.itemName:Height() * d.shapes < d.vHeight) and d.itemName:Height() * d.shapes or d.vHeight -- Try to addapt to viewport height
				--l:AddPadding(-1)
				d.itemList = LM.GUI.ImageTextList(mainW, listHeight, self.CHANGE) --175
				d.itemList:SetAllowsMultipleSelection(true)
				d.itemList:SetDrawsPrimarySelection(true)
				d.itemList:AddItem((" "):rep(13) .. MOHO.Localize("/Windows/Style/None=<None>"), false)
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

			--if LS_ShapesWindow.largeButtons then l:AddPadding(0) end
			d.combineBlendBut = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_combine_blend", MOHO.Localize("/Scripts/Tool/SelectShape/Blend=Blend:"):gsub("[^%w]$", "") .. " (<alt> " .. MOHO.Localize("/Windows/Style/Reset=Reset") .. ")", true, self.COMBINE_BLEND_BUT, true) --Remove any non-alphanumeric ending character
			d.combineBlendBut:SetAlternateMessage(self.COMBINE_BLEND_BUT_ALT)
			d.combineBlendBut.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.combineBlendBut)
			l:AddChild(d.combineBlendBut, LM.GUI.ALIGN_FILL, 0)
			l:AddPadding(-4)
			d.combineBlend = LM.GUI.TextControl(0, LS_ShapesWindow.largeButtons and (LS_ShapesWindow.UseLargeFonts and "00" or "000") or "0.00", self.COMBINE_BLEND, LM.GUI.FIELD_UFLOAT) --≈≋
			d.combineBlend:SetPercentageMode(true)
			d.combineBlend:SetWheelInc(1.0)
			d.combineBlend.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.combineBlend)
			l:AddChild(d.combineBlend, LM.GUI.ALIGN_FILL, 0)
			if true then l:AddPadding(0) end --not LS_ShapesWindow.largeButtons

			l:PushV(LM.GUI.ALIGN_CENTER, 0)
				d.topBut = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_select_cluster_top", MOHO.Localize("/Scripts/Tool/SelectShape/SelectTopOfCluster=Select top of Liquid Shape") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All") .. ")", false, self.TOP_SHAPE, true)
				d.topBut:SetAlternateMessage(self.TOP_SHAPE_ALT)
				--d.topBut:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/SelectTopOfCluster=Select top of Liquid Shape"))
				d.topBut.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.topBut)
				if true then l:AddChild(d.topBut, LM.GUI.ALIGN_FILL, 0) end --not LS_ShapesWindow.largeButtons

				d.baseBut = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_select_cluster_bottom", MOHO.Localize("/Scripts/Tool/SelectShape/SelectBottomOfCluster=Select bottom of Liquid Shape") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All") .. ")", false, self.BASE_SHAPE, true)
				d.baseBut:SetAlternateMessage(self.BASE_SHAPE_ALT)
				--d.baseBut:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/SelectBottomOfCluster=Select bottom of Liquid Shape"))
				d.baseBut.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.baseBut)
				if true then l:AddChild(d.baseBut, LM.GUI.ALIGN_FILL, 0) end --not LS_ShapesWindow.largeButtons
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
			l:PushH(LM.GUI.ALIGN_FILL, 1)
				l:AddPadding(2)
				d.fillCheck = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_fill", MOHO.Localize("/Scripts/Tool/SelectShape/Fill=Fill:"):gsub("[^%w]$", "") .. " (<alt>" .. MOHO.Localize("/LS/ShapesWindow/AnimateVisibility=Animate its visibility instead"), true, self.FILL, true)
				d.fillCheck:SetAlternateMessage(self.FILL_ALT)
				l:AddChild(d.fillCheck, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(-1)
				l:PushH(LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(-15)
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

				d.createButtons = {}
				table.insert(d.createButtons, LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_create_fill", "", false, self.FILLED, true))
				table.insert(d.createButtons, LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_create_line", "", false, self.OUTLINED, true))
				table.insert(d.createButtons, LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_create_both", "", false, self.FILLEDOUTLINED, true))
				l:AddPadding(0)

				for i, but in ipairs(d.createButtons) do
					l:PushV(LM.GUI.ALIGN_CENTER, 0)
						l:AddChild(but, LM.GUI.ALIGN_FILL, 0)
						if LS_ShapesWindow.largeButtons then l:AddChild(LM.GUI.TextList(butW + butW1, 0, 0), LM.GUI.ALIGN_CENTER, 0) end
					l:Pop() --V
					but:SetAlternateMessage(self.FILLED + (i * 2 - 1))
					l:AddPadding(i < #d.createButtons and 1 or 0)
				end
				l:AddPadding(1)
			l:Pop() --H

			l:PushH(LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(20)
				d.swapColBut = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_color_swap", MOHO.Localize("/LS/ShapesWindow/Swap=Swap!"), false, self.COLORSWAP, true)
				l:AddChild(d.swapColBut, LM.GUI.ALIGN_LEFT, 0)
			l:Pop() --H

			l:PushH(LM.GUI.ALIGN_FILL, 1)
				l:AddPadding(2)
				d.lineCheck = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_line", MOHO.Localize("/Scripts/Tool/SelectShape/Stroke=Stroke:"):gsub("[^%w]$", "") .. " (<alt>" .. MOHO.Localize("/LS/ShapesWindow/AnimateVisibility=Animate its visibility instead"), true, self.LINE, true)
				d.lineCheck:SetAlternateMessage(self.LINE_ALT)
				l:AddChild(d.lineCheck, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(-1)
				l:PushH(LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(-15)
					d.lineCol = LM.GUI.ShortColorSwatch(true, self.LINECOLOR)
					d.lineCol:SetConstantMessages(true)
					d.lineCol:SetModalMessages(self.LINECOLOR_BEGIN, self.LINECOLOR_END)
					d.lineCol:SetValue(style ~= nil and style.fLineCol or MOHO.MohoGlobals.LineCol)
					l:AddChild(d.lineCol, LM.GUI.ALIGN_FILL, 0)
				l:Pop() --H
				l:AddPadding(-2)
				d.lineColOverride = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_override", MOHO.Localize("/LS/ShapesWindow/FillOverride=Line Color Override"), true, self.LINECOLOROVER, true)
				l:AddChild(d.lineColOverride, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(4)
				--l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL, 0)
				--l:AddPadding(2)
				--d.widthLabel = LM.GUI.DynamicText("ø", 0)
				--d.widthLabel:SetToolTip(MOHO.Localize("/Dialogs/InsertText/BalloonWidth=Stroke Width"))
				--l:AddChild(d.widthLabel, LM.GUI.ALIGN_CENTER, 0)
				--l:AddPadding(-3)
				d.lineWidth = LM.GUI.TextControl(0, LS_ShapesWindow.UseLargeFonts and "00" or "000", self.LINEWIDTH, LM.GUI.FIELD_UFLOAT) --ø
				d.lineWidth:SetUnits(LM.GUI.UNIT_PIXELS) --LM.GUI.UNIT_NONE
				d.lineWidth:SetWheelInc(1.0)
				d.lineWidth:SetWheelInteger(true) --false?
				d.lineWidth:SetValue(style ~= nil and style.fLineWidth or LS_ShapesWindow.MohoLineWidth * docH)
				l:AddChild(d.lineWidth, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(-2)
				d.lineWidthOverride = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_override", MOHO.Localize("/LS/ShapesWindow/FillOverride=Line Width Override"), true, self.LINEWIDTHOVER, true)
				l:AddChild(d.lineWidthOverride, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(4)
				l:PushV(LM.GUI.ALIGN_CENTER, 0)
					d.capsBut = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_round_caps", MOHO.Localize("/Windows/Style/RoundCaps=Round caps"), true, self.ROUNDCAPS, true)
					d.capsBut:SetValue(style == nil or style.fLineCaps == 1)
					l:AddChild(d.capsBut, LM.GUI.ALIGN_FILL, 0)
					if LS_ShapesWindow.largeButtons then l:AddChild(LM.GUI.TextList((butW + butW1) / 1.333, 0, 0), LM.GUI.ALIGN_FILL, 0) end
				l:Pop() --V 
				l:AddPadding(-2)
				--d.brushPreview = MOHO.MeshPreview(LS_ShapesWindow.largeButtons and 22 or 16, 22) -- It seems LM_MeshPreview widget doesn't display brushes. Oh, well...
				--d.brushPreview:SetToolTip(MOHO.Localize("/Dialogs/BrushPicker/NoBrush=No Brush"))
				--l:AddChild(d.brushPreview)
				l:AddPadding(2)
				l:AddPadding(0)

				l:PushV(LM.GUI.ALIGN_CENTER, 0)
					d.brushBut = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_brush", MOHO.Localize("/Dialogs/BrushPicker/Brush=Brush"), true, self.BRUSH, true) --/Dialogs/BrushPicker/NoBrush=No Brush
					d.brushBut:SetAlternateMessage(self.BRUSH_ALT)
					l:AddChild(d.brushBut, LM.GUI.ALIGN_FILL, 0)
					l:PushV(LM.GUI.ALIGN_FILL, 0)
						l:AddPadding(-11) --15
						d.brushMenu = LM.GUI.Menu("🖌")
						d.brushMenuPopup = LM.GUI.PopupMenu(LS_ShapesWindow.largeButtons and butW + butW1 or 22, false)
						d.brushMenuPopup:SetMenu(d.brushMenu)
						l:AddChild(d.brushMenuPopup, LM.GUI.ALIGN_FILL, 0)
					l:Pop() --V
				l:Pop() --V
				--l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL, 0)
				--l:AddPadding(4)

				--d.capsBut = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_round_caps", MOHO.Localize("/Windows/Style/RoundCaps=Round caps"), true, self.ROUNDCAPS, true)
				--d.capsBut:SetValue(style == nil or style.fLineCaps == 1)
				--l:AddChild(d.capsBut, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(1)
			l:Pop() --H
		end

		if LS_ShapesWindow.advanced then
			l:AddPadding(4)
			l:AddChild(LM.GUI.TextList(0, 1), LM.GUI.ALIGN_FILL, 0)
			l:PushH(LM.GUI.ALIGN_FILL, 0)
				l:Unindent(3)
				l:PushH(LM.GUI.ALIGN_LEFT, 0)
					l:AddPadding(-4)
					d.style1Menu = LM.GUI.Menu("Style 1") --¹²₁₂⒈⒉
					d.style1MenuPopup = LM.GUI.PopupMenu(math.floor((mainW + butW + butW1 + padH - menuW - 8) / 2), true) ---6
					--d.style1MenuPopup:SetToolTip(MOHO.Localize("/Windows/Style/Style1=Style 1") .. " (" ..  MOHO.Localize("/LS/ShapesWindow/AppliesAbove=Applies Above") .. ")")
					d.style1MenuPopup:SetMenu(d.style1Menu)
					l:AddChild(d.style1MenuPopup, LM.GUI.ALIGN_LEFT, 0)
				l:Pop() --H
				l:AddPadding(1)
				d.swapBut = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_shape_style_swap", MOHO.Localize("/LS/ShapesWindow/Swap=Swap!"), false, self.STYLESWAP, true)
				l:AddChild(d.swapBut, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(1)
				l:PushH(LM.GUI.ALIGN_LEFT, 0)
					l:AddPadding(-4)
					d.style2Menu = LM.GUI.Menu("Style 2")
					d.style2MenuPopup = LM.GUI.PopupMenu(math.floor((mainW + butW + butW1 + padH - menuW - 8) / 2), true) --6
					--d.style2MenuPopup:SetToolTip(MOHO.Localize("/Windows/Style/Style2=Style 2") .. " (" ..  MOHO.Localize("/LS/ShapesWindow/AppliesBelow=Applies Below") .. ")")
					d.style2MenuPopup:SetMenu(d.style2Menu)
					l:AddChild(d.style2MenuPopup)
				l:Pop() --H
				l:AddPadding(2)
				l:AddPadding(0)
				d.swatchMenu = LM.GUI.Menu("🎨") --⊞▦▩⩩⩨
				d.swatchMenuPopup = LM.GUI.PopupMenu(menuW, false) --8 + 2?
				d.swatchMenuPopup:SetMenu(d.swatchMenu)
				l:AddChild(d.swatchMenuPopup)
				l:AddPadding(2)
				l:Indent(3)
			l:Pop() --H

			if LS_ShapesWindow.swatch ~= -1 then
				l:AddPadding(3)
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
						d.colorSlider:SetRange(-255, 0)
						d.colorSlider:SetValue(-255)
						--d.colorSlider:SetNumTicks(8)
						--d.colorSlider:SetShowTicks(true)
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

				l:AddPadding(2)
				l:AddChild(LM.GUI.TextList(0, 1), LM.GUI.ALIGN_FILL, 0)
				l:PushV(LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(-2)
					--l:Unindent(2)
					l:PushH(LM.GUI.ALIGN_LEFT, 0)
						l:AddPadding(-20)
						l:AddPadding(0)
						d.multiMenu = LM.GUI.Menu("Multi Menu") --¹²①②₁₂
						d.multiMenuPopup = LM.GUI.PopupMenu(LS_ShapesWindow.UseLargeFonts and 54 or 42, true)
						d.multiMenuPopup:SetToolTip(MOHO.Localize("/LS/ShapesWindow/MultiFunctionMenu=Multi-Function Menu"))
						d.multiMenuPopup:SetMenu(d.multiMenu)
						d.multiMenu:AddItem("⚫" .. " " .. MOHO.Localize("/LS/ShapesWindow/Fill=Fill"), 0, self.MULTI) 
						d.multiMenu:AddItem("⚪" .. " " .. MOHO.Localize("/LS/ShapesWindow/Stroke=Stroke"), 0, self.MULTI + 1)
						d.multiMenu:AddItem("📌" .. " " .. MOHO.Localize("/LS/ShapesWindow/FXTransform=FX Transform"), 0, self.MULTI + 2)
						d.multiMenu:AddItem("🚥" .. " " .. MOHO.Localize("/LS/ShapesWindow/RecolorRGB=Recolor (RGBα)"), 0, self.MULTI + 3)
						d.multiMenu:AddItem("🌈" .. " " .. MOHO.Localize("/LS/ShapesWindow/RecolorRGB=Recolor (HSB)"), 0, self.MULTI + 4)
						d.multiMenu:AddItem("", 0, 0)
						d.multiMenu:AddItem(MOHO.Localize("/LS/ShapesWindow/CopyHex=Copy HEX"), 0, self.MULTI + 5) --#️⃣
						d.multiMenu:AddItem(MOHO.Localize("/LS/ShapesWindow/CopyValues=Copy Values"), 0, self.MULTI + 6) --✂
						d.multiMenu:AddItem(MOHO.Localize("/LS/ShapesWindow/PasteValues=Paste Values"), 0, self.MULTI + 7) --📋
						d.multiMenu:AddItem(MOHO.Localize("/LS/ShapesWindow/MultiMenuModeReset=Reset Values"), 0, self.MULTI + 8) --↺
						d.multiMenu:AddItem("", 0, 0)
						d.multiMenu:AddItem(MOHO.Localize("/LS/ShapesWindow/InvertColor=Invert Color"), 0, self.MULTI + 9) --◑
						--d.multiMenu:AddItem(MOHO.Localize("/LS/ShapesWindow/BlendColors=Blend (50%)"), 0, self.MULTI + 12) --💫 This, in  any case, should be a mode...
						--d.multiMenu:AddItem(MOHO.Localize("/LS/ShapesWindow/MultiplyColors=Multiply"), 0, self.MULTI + 13) --✳ Add Colors, Subtract Colors?
						d.multiMenu:AddItem("", 0, 0)
						d.multiMenu:AddItem("OPTIONS: ", 0, 0) d.multiMenu:SetEnabled(0, false)
						d.multiMenu:AddItem(MOHO.Localize("/LS/ShapesWindow/ApplyToFills=Affects Fills"), 0, self.MULTI + 10)
						d.multiMenu:AddItem(MOHO.Localize("/LS/ShapesWindow/ApplyToStrokes=Affects Strokes"), 0, self.MULTI + 11)
						l:AddChild(d.multiMenuPopup, LM.GUI.ALIGN_FILL, 0)
						l:AddPadding(-16)
					l:Pop() --H
					l:AddPadding(-d.multiMenuPopup:Height()) -- + 2 (if Unindent/Indent)
					l:PushH(LM.GUI.ALIGN_RIGHT, 0)
						l:AddPadding(24)
						d.multi1 = LM.GUI.TextControl(0, LS_ShapesWindow.UseLargeFonts and "-0" or "0  0", self.MULTI1, LM.GUI.FIELD_FLOAT) --32
						d.multi1:SetUnits(LM.GUI.UNIT_NONE)
						d.multi1:SetWheelInc(2)
						d.multi1:SetWheelInteger(true)
						l:AddChild(d.multi1, LM.GUI.ALIGN_FILL, 0)
						l:AddPadding(1)
						d.multi2 = LM.GUI.TextControl(0, LS_ShapesWindow.UseLargeFonts and "-0" or "0  0", self.MULTI2, LM.GUI.FIELD_FLOAT)
						d.multi2:SetUnits(LM.GUI.UNIT_NONE)
						d.multi2:SetWheelInc(2)
						d.multi2:SetWheelInteger(true)
						l:AddChild(d.multi2, LM.GUI.ALIGN_FILL, 0)
						l:AddPadding(1)
						d.multi3 = LM.GUI.TextControl(0, LS_ShapesWindow.UseLargeFonts and "-0" or "0  0", self.MULTI3, LM.GUI.FIELD_FLOAT)
						d.multi3:SetUnits(LM.GUI.UNIT_NONE)
						d.multi3:SetWheelInc(2)
						d.multi3:SetWheelInteger(true)
						l:AddChild(d.multi3, LM.GUI.ALIGN_FILL, 0)
						l:AddPadding(1)
						d.multi4 = LM.GUI.TextControl(0, LS_ShapesWindow.UseLargeFonts and "-0" or "000", self.MULTI4, LM.GUI.FIELD_FLOAT) --34
						d.multi4:SetUnits(LM.GUI.UNIT_PERCENT)
						d.multi4:SetPercentageMode(true)
						d.multi4:SetWheelInc(0.1)
						d.multi4:SetWheelInteger(false)
						l:AddChild(d.multi4, LM.GUI.ALIGN_FILL, 0)
						l:AddPadding(1)
						d.applyBut = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/ls_mode_apply", MOHO.Localize("/LS/ShapesWindow/ApplyMode=Apply"), false, self.APPLY, true)
						d.applyBut:SetAlternateMessage(self.APPLY_ALT)
						l:AddChild(d.applyBut, LM.GUI.ALIGN_FILL, 0)
					l:Pop() --H
					--l:Indent(2)
				l:Pop() --V
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
				l:AddChild(d.infobar, LM.GUI.ALIGN_FILL, 2)
			l:Pop() --V
		end
	l:Pop() --V

	return d
end

--function LS_ShapesWindowDialog:UpdateWidgets(moho) --print("LS_ShapesWindowDialog:UpdateWidgets(" .. tostring(moho) .. "): ", " 🕗: " .. os.clock())
	-- This only run once upon opening the dialog even if its modeless, so using "Update()" function bellow for al purposes instead. 🤔 Not sure if at some point it may have some use...
--end

function LS_ShapesWindowDialog:Update() --print("LS_ShapesWindowDialog:Update(" .. tostring(moho) .. "): ", " 🕗: " .. os.clock()) --print(tostring(LS_ShapesWindow.LM_SelectShape.dragMode))
	--local caller = debug.getinfo(5) and debug.getinfo(5).name or "NULL" print(caller) --0: getinfo, 1: Update, 2: func, 3: NULL/NULL, 4: NULL/UpdateUI, 5: NULL/NULL
	local helper = MOHO.ScriptInterfaceHelper:new_local()
	local moho = helper:MohoObject()
	local pro = MOHO.IsMohoPro()
	local doc = moho.document --print("UP: " .. (doc and doc:Name()) or "No Doc") --20240103-1809: Back to normality after fixing the casue of opening document mess? (TBO!)
	--local doc = (LS_ShapesWindow.defDoc and LS_ShapesWindow.defDoc ~= moho.document) and LS_ShapesWindow.defDoc or moho.document --print("UP: " .. (doc and doc:Name()) or "No Doc") --20240102-1638: A try to fix/patch the new opening document mess for now... (TBO!)
	local docName = doc and doc:Name() or nil
	local docH = doc and doc:Height() or 240
	local toolName = (doc ~= nil and doc:Name() ~= "-") and moho:CurrentTool() or "" --20231223-2350: Extra-checking is for avoiding crashes upon auto-opening
	local tool = _G[toolName] --print(toolName, ", ", tool:Name(), ", ", tool.dragMode)
	local toolsDisabled = moho:DisableDrawingTools()
	local mode = LS_ShapesWindow.mode
	local modes = {[0] = "/Windows/Style/DefaultsForNewShapes=DEFAULTS (For new shapes)", "/Windows/Style/SHAPE=SHAPE", "/Windows/Style/STYLE=STYLE"}
	local l = self.GetLayout and self:GetLayout() or nil --20231223-2350: Extra-checking is for avoiding crashes upon auto-opening
	local msg = self.msg ~= nil and self.msg or MOHO.MSG_BASE
	local info = {sep = " • "} --[1] = "ℹ ", [2] = "🆔 ", [3] = "#️⃣ ", [4] = "♒ " --sep: •·∙⸱∣
	local itemsSel = self.itemList and math.floor(self.itemList:NumSelectedItems()) or 0
	local infoString = ""
	self.tempShape = moho:NewShapeProperties() or MOHO.MohoGlobals.NewShapeProperties

	local brush = moho:CurrentEditStyle() and tostring(moho:CurrentEditStyle().fBrushName:Buffer():gsub("%.[^.]+$", "")) or ""
	local styleName = moho:CurrentEditStyle() and tostring(moho:CurrentEditStyle().fName:Buffer()) or ""
	local style = moho:CurrentEditStyle() -- 20231010-0554: For some reason, "styleName" must be gathered before this assignment, otherwise it won't be possible to access "style" properties afterwards!
	local styleID = -1	--print(styleName .. " (" .. tostring(style) .. "): ", tostring(style.fFillCol.value.r), ", ", tostring(style.fFillCol.value.g), ", ", tostring(style.fFillCol.value.b))
	local styleUUID = style and style.fUUID:Buffer() or "" --doc:StyleByID(i) print(iStyle.fUUID:Buffer())
	local styles = doc and math.floor(doc:CountStyles()) or 0
	local styleSelID = LS_ShapesWindow.mode == 2 and math.floor(self.itemList:SelItem()) - 1 or -1
	local styleSel = doc and doc:StyleByID(styleSelID) or style
	local styleSelUUID = LS_ShapesWindow.mode == 2 and styleSel and styleSel.fUUID:Buffer() or ""
	local stylesSel = styleName and styleName ~= "" and 1 or LS_ShapesWindow:CountSelectedStyles(doc) --self.itemList and (math.floor(self.itemList:NumSelectedItems() + (self.itemList:IsItemSelected(0) == true and -1 or 0))) or 0
	local style1Name, style2Name = (self.tempShape and self.tempShape.fInheritedStyle) and tostring(self.tempShape.fInheritedStyle.fName:Buffer()) or "", (self.tempShape and self.tempShape.fInheritedStyle2) and tostring(self.tempShape.fInheritedStyle2.fName:Buffer()) or "" -- See note 20231010-0554 above!
	local style1, style2 = (styleName == "" and self.tempShape) and self.tempShape.fInheritedStyle or nil, (styleName == "" and self.tempShape) and self.tempShape.fInheritedStyle2 or nil
	local style1UUID, style2UUID = style1 and style1.fUUID:Buffer() or nil, style2 and style2.fUUID:Buffer() or nil
	local style1ID, style2ID = LS_ShapesWindow:StyleID(doc, style1), LS_ShapesWindow:StyleID(doc, style2)
	local styleUUID2Show = styleName ~= "" and styleUUID or (styleSelID > - 1 and styleSelUUID or styleUUID)
	local styleTable = {}

	if (style ~= nil) then
		--brush = style.fBrushName:Buffer():gsub("%.[^.]+$", "")
		if LS_ShapesWindow.advanced then --print(style.fLineWidth, ", ", moho:NewShapeLineWidth())
			self.fillCol:SetValue(style.fFillCol and style.fFillCol.value or MOHO.MohoGlobals.FillCol)
			self.lineCol:SetValue(style.fLineCol and style.fLineCol.value or MOHO.MohoGlobals.LineCol)
			self.lineWidth:SetValue((style.fLineWidth or moho:NewShapeLineWidth() or LS_ShapesWindow.MohoLineWidth) * docH) --tonumber(string.format("%.2f\n", (style.fLineWidth ~= nil and style.fLineWidth or moho:NewShapeLineWidth()) * docH))
			self.capsBut:SetValue(style.fLineCaps == nil or style.fLineCaps == 1) --self.capsBut:SetValue(style.fLineCaps == 1 and true or false) --style.fLineCaps ~= nil and (style.fLineCaps == 1 and true or false)
			self.brushBut:SetValue(style.fBrushName and style.fBrushName:Buffer() ~= "")
			self.brushBut:Enable(style.fBrushName and style.fBrushName:Buffer() ~= "")
			--print(self.colorSliderVal, ", ", self.colorSlider and self.colorSlider:Value() or "?")
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
		if styleName == "" then
			LS_ShapesWindow.mode = LS_ShapesWindow.mode ~= 2 and 0 or LS_ShapesWindow.mode
			if LS_ShapesWindow.mode == 0 then
				self.modeBut:SetLabel(MOHO.Localize(modes[LS_ShapesWindow.mode]):gsub("%s+%b()", "")) self.modeBut:Redraw()  --Mode: 0 (DEFAULTS) --:match("%w+")) -- Exclude everything between the patenthesis, including the preceding space, instead?
				--self.itemName:SetValue("")
			elseif LS_ShapesWindow.mode == 2 then
				self.modeBut:SetLabel(MOHO.Localize(modes[LS_ShapesWindow.mode])) self.modeBut:Redraw() --Mode: 2 (STYLE)
			end
			info[1] = moho:DrawingMesh() and "" or "ℹ " .. MOHO.Localize("/LS/ShapesWindow/NotAVectorLayer=Not a vector layer...") --"🦠" --"" .. MOHO.Localize("/Windows/Style/DefaultsForNewShapes=DEFAULTS (For new shapes)"):gsub("%s+%b()", "")
			info[2] = moho:DrawingMesh() and "#️⃣ " .. math.floor(moho:CountShapes()) or nil --info[2] = moho:CountShapes() > 0 and "#️⃣ " .. math.floor(moho:CountShapes()) or nil
		else
			LS_ShapesWindow.mode = 2
			self.modeBut:SetLabel(MOHO.Localize(modes[LS_ShapesWindow.mode])) self.modeBut:Redraw() --Mode: 2 (STYLE)
			self.itemName:SetValue(styleName or "?")
			info[1] = doc and "" or  "ℹ " .. MOHO.Localize("/LS/ShapesWindow/NoDocumentOpen=No document open...") --"🔘" --"" .. MOHO.Localize("/Windows/Style/STYLE=STYLE")
			--info[2] = shapeLUID > -1 and "🆔 " .. shapeLUID or "🆔 " .. "?" --string.format("%d", shape:ShapeID())
			info[2] = "🆔 " .. styleID
			info[3] = styles > 0 and "#️⃣ " .. itemsSel .. "/" .. styles or  "#️⃣ " .. styles
			info[4] = "🔣 " .. (styleUUID2Show ~= "" and styleUUID2Show or "?")
			info["UUID1"] = styleUUID2Show ~= "" and styleUUID2Show:match("([^%-]+)") or "" -- The first group
			info["UUID2"] = styleUUID2Show ~= "" and styleUUID2Show:match("(-.-)$") or "" -- All but the first group
		end
	end

	local layer = moho.layer
	local layerUUID = layer and layer:UUID()
	local lFrame = moho.layerFrame
	local lDrawing = moho.drawingLayer and moho:LayerAsVector(moho.drawingLayer) or nil
	local lDrawingUUID = lDrawing and lDrawing:UUID() or ""
	local mesh = moho:DrawingMesh()
	local pointsSel = moho:CountSelectedPoints()
	local edges = moho:CountEdges()
	local edgesSel = moho:CountSelectedEdges()

	---[[20231014-1955: Try to move all this to DoLayout? They may not need to be updated all the time after all...
	--if (msg >= self.MENU1 and msg <= self.MENU1 + self:CountRealItems(self.menu1) - 1) then -- Do nothing else than update the menu?
		self.menu1:SetChecked(self.MENU1, LS_ShapesWindow.pointsBasedSel)
		self.menu1:SetChecked(self.MENU1 + 1, LS_ShapesWindow.ignoreNonRegular)
		self.menu1:SetChecked(self.MENU1 + 2, LS_ShapesWindow.linkToStyle)
		self.menu1:SetChecked(self.MENU1 + 3, LS_ShapesWindow.openOnStartup)
		self.menu1:SetChecked(self.MENU1 + 4, LS_ShapesWindow.showInTools)
		self.menu1:SetChecked(self.MENU1 + 5, LS_ShapesWindow.beginnerMode)
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
		if self.swatchMenu:CountItems() == 0 then
			self.swatchMenu:AddItem(MOHO.Localize("/Windows/Layers/None=None"), 0, self.SELECTSWATCH)
			--d.swatchMenu:AddItem(MOHO.Localize("/Windows/Style/Default=Default"):upper() .. " " .. MOHO.Localize("/Windows/Style/Swatches=Swatches"):upper(), 0, self.SELECTSWATCH + 3) d.swatchMenu:SetEnabled(self.SELECTSWATCH + 3, false) --"/Windows/Style/Swatches=Swatches"
			self.swatchMenu:AddItem("", 0, 0)
			local count = self.SELECTSWATCH
			for i, doc in ipairs(LS_ShapesWindow.docList) do
				local swatchCount = 0
				local owner = doc:Path():find(moho:UserAppDir() .. "/Scripts/ScriptResources/ls_shapes_window/Swatches/") and " (🏭)" or (doc:Path():find(moho:UserAppDir() .. "/Swatches/") and " (👤)") or ""
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
							self.countFactory = doc:Path():find(moho:UserAppDir() .. "/Scripts/ScriptResources/ls_shapes_window/Swatches/") and self.countFactory + 1 or self.countFactory
							table.insert(self.swatches[i], {label = icon .. doc:Layer(j):Name(), shortcut = 0, msg = count, id = j, kind = kind, suffix = "", enable = true}) --self.swatchMenu:AddItem(icon .. doc:Layer(j):Name(), 0, count)
							if mesh:ShapeByName("SLIDER") ~= nil then
								--print(layer:Name())
							end
						end
					end
	
				end
				self.swatches[i].count = swatchCount
				--suffix = countValid > 0 and (doc:Path():find(moho:UserAppDir() .. "\\Scripts\\ScriptResources\\ls_shapes_window\\") and " (Factory)") or (doc:Path():find(moho:UserAppDir() .. "\\Swatches\\") and " (User)") or " (0)"
				--self.swatchMenu:AddItem(string.upper(doc:Name() .. suffix), 0, 0) self.swatchMenu:SetEnabled(0, false)
			end
			if #self.swatches > 0 then
				for i, chunk in ipairs(self.swatches) do
					if chunk.count and chunk.count > 0 then
						for j, item in ipairs(chunk) do
							if (item.kind == "chunk" and chunk.count and chunk.count > 0) or item.kind == "swatch" then
								self.swatchMenu:AddItem(item.label .. (item.msg == 0 and item.suffix or ""), item.shortcut, item.msg) self.swatchMenu:SetEnabled(0, false)
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
			self.swatchMenu:AddItem("", 0, 0)
			self.swatchMenu:AddItem(MOHO.Localize("/LS/ShapesWindow/CutomSwatches=Custom Swatches..."), 0, count + 1) self.swatchMenu:SetEnabled(count + 1, false) --"/Menus/Interval/Custom=Custom...
			self.swatchMenu:AddItem(MOHO.Localize("/LS/ShapesWindow/UseSelection=Use Selection"), 0,  count + 2) self.swatchMenu:SetEnabled(count + 2, false) --USE SELECTION (TEMP)
			self.swatchMenu:AddItem(MOHO.Localize("/LS/ShapesWindow/EditCurrentSwatch=Edit Current Swatch"), 0,  count + 3)
			self.swatchMenu:AddItem(MOHO.Localize("/LS/ShapesWindow/ReloadSwatches=Reload Swatches"), 0, count + 4)

			if LS_ShapesWindow.swatch ~= -1 and LS_ShapesWindow.swatch ~= self.swatch then
				self:UpdateColor(moho)
			end
		end

		self.swatchMenu:UncheckAll()
		--self.swatchMenu:SetChecked(self.SELECTSWATCH, LS_ShapesWindow.swatch == -1) -- None
		--self.swatchMenu:SetChecked(self.SELECTSWATCH + self:CountRealItems(self.swatchMenu) - 1 + 1, LS_ShapesWindow.swatch == -2) -- Use 
		self.swatchMenu:SetChecked((self.SELECTSWATCH + LS_ShapesWindow.swatch) + 1, true)
		self.swatchMenu:SetEnabled(self.SELECTSWATCH + self:CountRealItems(self.swatchMenu, self.SELECTSWATCH) - 2, LS_ShapesWindow.swatch > self.countFactory - 1)
		for i = self.SELECTSWATCH + 3, self.SELECTSWATCH + self:CountRealItems(self.swatchMenu, self.SELECTSWATCH) - 2 do --print(math.abs(self.SELECTSWATCH - i))
			--self.swatchMenu:SetChecked(i, LS_ShapesWindow.swatch == math.abs((self.SELECTSWATCH + 3) - i)) -- List Entry
		end

		if LS_ShapesWindow.brushList and self.brushMenu:CountItems() == 0 then
			local topEntries = 2
			local brushCount = topEntries
			local factCount, userCount = -topEntries, 0
			for brush in pairs(LS_ShapesWindow.brushList) do
				local brushPath = LS_ShapesWindow.brushList[brush]
				if brushPath and brushPath:match(moho:UserAppDir()) then
					userCount = userCount + 1
				end
				self.brushMenu:AddItemAlphabetically(brush, 0, self.SELECTBRUSH + brushCount)
				brushCount = brushCount + 1
			end
			factCount = (brushCount - topEntries) - userCount --print(brushCount, ", ", factCount, ", ", userCount)
			if brushCount > topEntries then --print(#LS_ShapesWindow.brushList, ", ", brushCount) 
				self.brushMenu:AddItem(nil, 0, 0)
				self.brushMenu:AddItem(MOHO.Localize("/LS/ShapesWindow/CancelAndCloseMenu=Cancel & Unfold"), 0, self.SELECTBRUSH + brushCount + 1)
			else
				self.brushMenu:AddItem(MOHO.Localize("/LS/ShapesWindow/NoBrushesListed=No Brushes Listed"), 0, self.SELECTBRUSH + brushCount + 1) --No Factory nor Custom Brushes Listed
				self.brushMenu:SetEnabled(self.SELECTBRUSH + brushCount + 1, false) 
			end
			--d.brushMenu:InsertItem(0, MOHO.Localize("/LS/ShapesWindow/ReloadBrushes=Reload Brushes"), 0, self.SELECTBRUSH)
			self.brushMenu:InsertItem(0, MOHO.Localize("/LS/ShapesWindow/ListFactoryBrushes=List Factory Brushes") .. (factCount > 0 and " (" .. factCount .. ")" or ""), 0, self.SELECTBRUSH)
			self.brushMenu:InsertItem(1, MOHO.Localize("/LS/ShapesWindow/ListCustomBrushes=List Custom Brushes") .. (userCount > 0 and " (" .. userCount .. ")" or ""), 0, self.SELECTBRUSH + 1)
			--self.brushMenu:InsertItem(1, MOHO.Localize("/LS/ShapesWindow/ListMultiBrushesOnly=List Multi-Brushes Only"), 0, self.SELECTBRUSH + 2) --TBC?
			self.brushMenu:InsertItem(2, nil, 0, 0)
			--d.brushMenu:InsertItem(3, MOHO.Localize("/Windows/Style/None=<None>"), 0, self.SELECTBRUSH + 2)
		end

		self.brushMenu:UncheckAll()
		self.brushMenu:SetCheckedLabel(brush, true)
		self.brushMenu:SetChecked(self.SELECTBRUSH, MOHO.hasbit(LS_ShapesWindow.brushDirectory, 1))
		self.brushMenu:SetChecked(self.SELECTBRUSH + 1, MOHO.hasbit(LS_ShapesWindow.brushDirectory, 2))

		--self.style1Menu:RemoveAllItems()
		--self.style1Menu:AddItem(MOHO.Localize("/Windows/Style/New=New"), 0, baseMsg)
		--self.style1Menu:AddItem("", 0, 0)
		--self.style1Menu:AddItem(MOHO.Localize("/Scripts/Utility/None=<None>"), 0, baseMsg)

		LS_ShapesWindow:BuildStyleChoiceMenu(self.style1Menu, doc, self.SELECTSTYLE1, self.DUMMY) --20240118-0806: Here is where style became an LM_String!
		LS_ShapesWindow:BuildStyleChoiceMenu(self.style2Menu, doc, self.SELECTSTYLE2, self.DUMMY)
	
		for i, but in ipairs(self.createButtons) do
			--but:Enable(((edgesSel > 0 or pointsSel > 0) and not toolsDisabled) or LS_ShapesWindow.mode > 1)
		end
	end

	--self.menu1Popup:Enable(self.menu1Popup and self.menu1:CountItems() > 0 or false)
	--self.menu2Popup:Enable(self.menu2Popup and self.menu2:CountItems() > 0 or false)
	--self.menu3Popup:Enable(self.menu3Popup and self.menu3:CountItems() > 0 or false)

	if (mesh == nil) or ((lDrawing and lDrawing:IsCurver()) or (lDrawing:IsWarpLayer() and (lDrawing:ContinuousTriangulation() or LS_ShapesWindow.ignoreNonRegular))) then -- Disable everything irrelevant if no valid/drawing layer is active ("Ignore Non-Regular" makes e.g. non-continuously-triangulated layers be also ignored).
		--l:Enable(false) -- Used classic enable/disable method due to this causes unwanted blinking at frame change and so...
		self.menu1Popup:Enable(true)
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
		self.selectMatchingBut:Enable(false)
		self.deleteBut:Enable(false)
		self.copyBut:Enable(true)
		self.pasteBut:Enable(self.copiedStyle and true or false)
		self.resetBut:Enable(true)
		if (self.layerUUID and self.layerUUID ~= layerUUID) then
			self:UpdateItem(moho) -- Clear itemPreview
		end
		
		self.skipBlock = true
		for i = self.itemList:CountItems(), 1, -1 do
			self.itemList:RemoveItem(i, false)
		end
		self.skipBlock = false
		self.itemList:Enable(false)
		self.itemList:Redraw()

		if LS_ShapesWindow.advanced then
			self.fillCheck:Enable(false)
			self.fillCheck:SetValue(true)
			self.fillCol:Enable(true)
			self.fillColOverride:Enable(LS_ShapesWindow.mode == 2 and style and styleName ~= "")
			self.fillColOverride:SetValue(style and style.fDefineFillCol)

			self.lineCheck:Enable(false)
			self.lineCheck:SetValue(true)
			self.lineCol:Enable(true)
			self.lineColOverride:Enable(LS_ShapesWindow.mode == 2 and style and styleName ~= "")
			self.lineColOverride:SetValue(style and style.fDefineLineCol)
			--self.widthLabel:Enable(true)
			self.lineWidth:Enable(true)
			self.lineWidthOverride:Enable(LS_ShapesWindow.mode == 2 and style and styleName ~= "")
			self.lineWidthOverride:SetValue(style and style.fDefineLineWidth)
			self.capsBut:Enable(true)
			for i, but in ipairs(self.createButtons) do
				but:Enable(false)
			end
			self.style1Menu:SetChecked(style1 and self.SELECTSTYLE1 + 1 + style1ID or self.SELECTSTYLE1, true)
			self.style1MenuPopup:Enable(styleName == "")
			self.style1MenuPopup:Redraw()
			self.swapBut:Enable(styleName == "" and style1UUID ~= style2UUID)
			self.style2Menu:SetChecked(style2 and self.SELECTSTYLE2 + 1 + style2ID or self.SELECTSTYLE2, true)
			self.style2MenuPopup:Enable(styleName == "")
			self.style2MenuPopup:Redraw()

			if LS_ShapesWindow.swatch > -1 then
				self.multiMenuPopup:Enable(false)
				self.multi1:Enable(false)
				self.multi2:Enable(false)
				self.multi3:Enable(false)
				self.multi4:Enable(false)
				self.applyBut:Enable(false)
			end
		end
		if (LS_ShapesWindow.showInfobar and self.infobar ~= nil) then
			infoString = table.concat(info, info.sep or " • "):gsub("^" .. info.sep .. " *", "")
			if (info.UUID2 ~= nil) then
				infoString = string.gsub(infoString, info.UUID2:gsub("-", "%%-"), "…")
			end
			self.infobar:SetValue(infoString)
		end

		if (doc == nil) then -- Disable everything else irrelevant if there is no document open
			self.menu1:SetEnabled(self.MENU1 + 6, false) -- Advanced (Creation Controls)
			self.menu1:SetEnabled(self.MENU1 + 7, false) -- Use Large Buttons
			self.menu1:SetEnabled(self.MENU1 + 8, false) -- Use Large Palette
			self.menu1:SetEnabled(self.MENU1 + 9, false) -- Show Infobar
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
				self.brushBut:Enable(false)
				self.brushMenuPopup:Enable(false)
				self.style1Menu:SetChecked(self.SELECTSTYLE1, true) self.style1MenuPopup:Redraw()
				self.swapBut:Enable(false)
				self.style2Menu:SetChecked(self.SELECTSTYLE2, true) self.style2MenuPopup:Redraw()
				if (LS_ShapesWindow.showInfobar and self.infobar ~= nil) then
					info[1] = doc and "" or  "ℹ " .. MOHO.Localize("/LS/ShapesWindow/NoDocumentOpen=No document open...") --"🔘"
					self.infobar:SetValue(table.concat(info, info.sep or " • "):gsub("^" .. info.sep .. " *", ""))
				end
			end
		end
		self.layerUUID = moho.layer and moho.layer:UUID()
		helper:delete()
		return --20240206-0515: This return complicates subsequent actions, consider its elimination...
	else -- Enable everything relevant if a valid/drawing layer is active
		--l:Enable(true) -- Used classic enable/disable method due to this causes unwanted blinking at frame change and so...
		self.menu1:SetEnabled(self.MENU1 + 6, true) -- Advanced (Creation Controls)
		self.menu1:SetEnabled(self.MENU1 + 7, true) -- Use Large Buttons
		self.menu1:SetEnabled(self.MENU1 + 8, true) -- Use Large Palette
		self.menu1:SetEnabled(self.MENU1 + 9, true) -- Show Infobar
		self.modeBut:Enable(true)
		self.pasteBut:Enable(self.copiedStyle and true or false)
		--[[20231208-0555: Here seems to be the problem with the unnecesary shape list refreshing upon frame change... STUDY!
		if (LS_ShapesWindow.mode ~= self.mode) then
			self.skipBlock = true
			for i = self.itemList:CountItems(), 1, -1 do
				self.itemList:RemoveItem(i, false)
			end
			self.skipBlock = false
		end
		--]]
		self.itemList:Enable(true) self.itemList:Redraw()

		if self.multiMenuPopup and LS_ShapesWindow.swatch > -1 then
			self.multiMenuPopup:Enable(true)
			self.multi1:Enable(true)
			self.multi2:Enable(true)
			self.multi3:Enable(true)
			self.multi4:Enable(true)
		end
	end

	---[[20231006-1745: Before selecting items in list much bellow, do here the "Points-Based Selection" thing if active (so then you can rely on shape/shapeID/etc. kind of values)
	if mesh ~= nil and not (lDrawing:IsCurver() or lDrawing:IsWarpLayer()) then
		if LS_ShapesWindow.pointsBasedSel and not (toolName:find("SelectShape") or toolName:find("Freehand") or toolName:find("Brush") or toolName:find("Eraser")) then
			if styleName == "" and pointsSel > 1 then -- Avoid Points-Based Selection select any shape if a style is being edited to allow normal Style workflow. 
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
	local shapeHandles = shape and shape:HasPositionDependentStyles() or false
	local shapeHandle1, shapeHandle2 = shapeHandles and shape:EffectHandle1(), shapeHandles and shape:EffectHandle2()
	local shapeFxOffset, shapeFxRotation, shapeFxScale = shape and shape.fEffectOffset, shape and shape.fEffectRotation, shape and shape.fEffectScale
	local shapes = mesh and math.floor(mesh:CountShapes()) or 0
	local shapesSel = math.floor(moho:CountSelectedShapes(true)) -- Use this instead LM_SelectShape:CountSelectedShapes??
	local shapeTable = {}

	if (shape ~= nil) then -- Shape/s selected...
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
					info[4] = "♒ ".. position .. "/" .. total --≈≋💧
				else
					self.baseBut:Enable(false)
					self.topBut:Enable(false)
					self.mergeBut:Enable(shapesSel > 1)
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
			self.style1Menu:SetChecked(style1 and self.SELECTSTYLE1 + 1 + style1ID or self.SELECTSTYLE1, true) self.style1MenuPopup:Redraw()
			self.style2Menu:SetChecked(style2 and self.SELECTSTYLE2 + 1 + style2ID or self.SELECTSTYLE2, true) self.style2MenuPopup:Redraw()
			local brushButVal = false
			for i = 0, shapes - 1 do
				local iShape = mesh:Shape(i)
				if (iShape.fSelected) then
					if iShape.fMyStyle.fBrushName:Buffer() ~= "" then
						brushButVal = true
						break
					end
				end
			end
			self.brushBut:SetValue(brushButVal)
			self.brushBut:Enable(brushButVal)
		end
		self.deleteBut:Enable(true)
		self.modeBut:SetLabel(MOHO.Localize(modes[LS_ShapesWindow.mode]):gsub("%s+%b()", "")) self.modeBut:Redraw() --Mode: 1 (SHAPE)
		info[1] = "" --"🦠" .. MOHO.Localize("/Windows/Style/SHAPE=SHAPE")
		info[2] = shapeLUID > -1 and "🆔 " .. shapeLUID or "🆔 " .. "?" --string.format("%d", shape:ShapeID())
		info[3] = shapes > 0 and "#️⃣ " .. shapesSel .. "/" .. shapes or shapes
		--[[202401160210: Moved bellow in order to allow updates upon deselecting and more...
		if not self.shape or self.shape ~= shape then
			self:UpdateItem(moho, shape, false) --20240103-0448: Had to avoid draw fills due to a last minute weird behavior upon undoing after modifyig shapes! (TODO & TBO!)
			--self:UpdateBrush(moho, shape) -- It seems LM_MeshPreview widget doesn't display brushes. Oh, well...
		end
		--]]
	else -- No shape selected...
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
			self.fillColOverride:Enable(styleName ~= "" or (style1 and style1.fDefineFillCol or style2 and style2.fDefineFillCol))
			self.fillColOverride:SetValue(style and style.fDefineFillCol)
			self.lineCheck:SetValue(true)
			self.lineCheck:Enable(false)
			self.lineCol:Enable(true)
			self.lineColOverride:Enable(styleName ~= "" or (style1 and style1.fDefineLineCol or style2 and style2.fDefineLineCol))
			self.lineColOverride:SetValue(style and style.fDefineLineCol)
			self.lineWidthOverride:Enable(styleName ~= "" or (style1 and style1.fDefineLineWidth or style2 and style2.fDefineLineWidth))
			self.lineWidthOverride:SetValue(style and style.fDefineLineWidth)
			self.style1Menu:SetChecked(style1 and self.SELECTSTYLE1 + 1 + style1ID or self.SELECTSTYLE1, true) self.style1MenuPopup:Redraw()
			self.style2Menu:SetChecked(style2 and self.SELECTSTYLE2 + 1 + style2ID or self.SELECTSTYLE2, true) self.style2MenuPopup:Redraw()
		end
		if LS_ShapesWindow.mode == 2 then
			info[1] = doc and "" or  "ℹ " .. MOHO.Localize("/LS/ShapesWindow/NoDocumentOpen=No document open...") .."🔘" --"" .. MOHO.Localize("/Windows/Style/STYLE=STYLE")
			info[2] = "🆔 " .. styleID
			info[3] = styles > 0 and "#️⃣ " .. itemsSel .. "/" .. styles or  "#️⃣ " .. styles
			info[4] = "🔣 " .. (styleUUID2Show ~= "" and styleUUID2Show or "?")
			info["UUID1"] = styleUUID2Show ~= "" and styleUUID2Show:match("([^%-]+)") or "" -- The first group
			info["UUID2"] = styleUUID2Show ~= "" and styleUUID2Show:match("(-.-)$") or "" -- All but the first group
		end
	end

	infoString = table.concat(info, info.sep or " • "):gsub("^" .. info.sep .. " *", "")
	if (LS_ShapesWindow.showInfobar) and self.infobar then
		self.infobar:SetToolTip(#infoString > 36 and infoString or "")
		if (info.UUID2 ~= nil) then
			infoString = string.gsub(infoString, info.UUID2:gsub("-", "%%-"), "…")
		end
		self.infobar:SetValue(infoString) --self.infobar:SetValue(#infoString > 30 and (infoString):sub(1, 30) .. "…" or infoString) -- 2023101011-1530: Discarted for now, since string.sub can "destroy" emojis and cause problems! 
		self.infobar:Enable(false)
	else
		if self.infobar then
			self.infobar:SetValue("")
		end
		--self.itemNameLabel:SetToolTip(MOHO.Localize("/Windows/Style/Name=Name") .. " (" .. infoString .. ")")
		self.itemPreview:SetToolTip(infoString)
	end

	if self.skipBlock == true then --if self.skipBlock == true and toolName:find("SelectPoints") then -- 20231007-1730: Perform ONLY widget updates above when called from HandlMessage/UpdateUI in order to avoid entering into endless loop!
		return
	end

	if LS_ShapesWindow.mode < 2 then --if SHAPE Modes
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

		local shape = shape or self.tempShape
		if (shape ~= nil) then
			local bbMin, bbMax = LM.Vector2:new_local(), LM.Vector2:new_local() shape:ShapeBounds(bbMin, bbMax, 0) --tonumber(string.format("%.3f", exact)
			--local bbChanged = math.max(math.abs(bbMin.x - self.bbMin.x), math.abs(bbMin.y - self.bbMin.y), math.abs(bbMax.x - self.bbMax.x),math.abs(bbMax.y - self.bbMax.y)) >= margin
			local fc, lc, lw, hf, ho, hp, eo, er, es = shape.fMyStyle.fFillCol:GetValue(0), shape.fMyStyle.fLineCol:GetValue(0), shape.fMyStyle.fLineWidth, tostring(shape.fHasFill), tostring(shape.fHasOutline), tostring(shape:HasPositionDependentStyles()), shape.fEffectOffset:GetValue(0), shape.fEffectRotation:GetValue(0), shape.fEffectScale:GetValue(0)
			shapeTable[-1] = math.floor(bbMin.x*10+.5)/10 .. math.floor(bbMin.y*10+.5)/10 .. math.floor(bbMax.x*10+.5)/10 .. math.floor(bbMax.y*10+.5)/10 .. fc.r .. fc.g .. fc.b .. fc.a .. lc.r .. lc.g .. lc.b .. lc.a .. lw .. hf .. ho .. hp .. eo.x .. eo.y .. er ..es .. shape.fInheritedStyleName:Buffer() .. shape.fInheritedStyleName2:Buffer() .. tostring(shape.fHidden)
			--print(tostring(self.shapeTable[-1])) --print(tostring(shapeTable[-1]))
			if (self.layerUUID and self.layerUUID ~= layerUUID) or (self.shape and self.shape ~= shape) or (self.shapeTable[-1] and self.shapeTable[-1] ~= shapeTable[-1]) or (shape and not self.shape) or (LS_ShapesWindow.mode ~= self.mode) then
				--print(math.floor(bbMin.x*10+.5)/10 .. ", " .. math.floor(bbMin.y*10+.5)/10 .. ", " .. math.floor(bbMax.x*10+.5)/10 .. ", " .. math.floor(bbMax.y*10+.5)/10 .. " Selected Shape Preview Update!")
				self:UpdateItem(moho, shape, true) --20240103-0448: Had to avoid draw fills due to a last minute weird behavior upon undoing after modifyig shapes! (TBO: ENABLED AGAIN)
				--self:UpdateBrush(moho, shape) -- It seems LM_MeshPreview widget doesn't display brushes. Oh, well...
			end
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
	else -- if STYLE Mode
		for i = 1, styles do -- Current styles state
			local iStyleName = tostring(doc:StyleByID(i - 1).fName:Buffer())
			local iStyle = doc:StyleByID(i - 1)
			styleTable[0] = lDrawingUUID
			styleTable[i] = iStyleName
		end	--print(#self.styleTable, ":", table.concat(self.styleTable, ", "))

		if self.itemList:CountItems() == 1 or self.styleTable and (#self.styleTable ~= #styleTable or table.concat(self.styleTable) ~= table.concat(styleTable) or (LS_ShapesWindow.mode ~= self.mode)) then
			self.skipBlock = true
			for i = self.itemList:CountItems(), 1, -1 do
				self.itemList:RemoveItem(i, false)
			end
			for i = 1, #styleTable do
				self.itemList:AddItem(styleTable[i], false)
			end
			--[[20240118-1634: Re-useing styleTable's names (just avove) instead getting them again to avoid style type change to LM_String bug upon accesing fName attribute!
			for i = 0, styles - 1 do
				local iStyleName = tostring(doc:StyleByID(i - 1).fName:Buffer())
				local iStyle = doc:StyleByID(i - 1)
				self.itemList:AddItem(iStyleName, false)
			end
			--]]
			self.skipBlock = false
		end

		if (style ~= nil) then
			local fc, lc, lw, df, dl, dw, bn = style.fFillCol.value, style.fLineCol.value, style.fLineWidth, tostring(style.fDefineFillCol), tostring(style.fDefineLineCol), tostring(style.fDefineLineWidth), style.fBrushName:Buffer()
			styleTable[-1] = fc.r .. fc.g .. fc.b .. fc.a .. lc.r .. lc.g .. lc.b .. lc.a .. lw .. df .. dl .. dw .. bn
		end
		if (self.layerUUID and self.layerUUID ~= layerUUID) or (self.styleSel and self.styleSel ~= styleSel) or (self.style and self.style ~= style) or (self.styleTable[-1] and self.styleTable[-1] ~= styleTable[-1]) or (style and not self.style) or (LS_ShapesWindow.mode ~= self.mode) then --print("Style Preview Update!")
			--self.tempShape.fMyStyle = style
			self:UpdateItem(moho, styleName ~= "" and style or styleSel, true) --20240103-0448: Had to avoid draw fills due to a last minute weird behavior upon undoing after modifyig shapes! (TBO: ENABLED AGAIN)
			--self:UpdateBrush(moho, shape) -- It seems LM_MeshPreview widget doesn't display brushes. Oh, well...
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
	self.selectAllBut:Enable((LS_ShapesWindow.mode < 2 and shapes > 0) or (LS_ShapesWindow.mode == 2 and style ~= nil and styles > 0)) --self.selectAllBut:SetLabel(LM_SelectShape:CountSelectedShapes(moho) == mesh:CountShapes() and "✅" or "☑", false) --self.selectAllBut:Redraw() -- 20230922: It seems to tail some text??
	self.deleteBut:SetToolTip(MOHO.Localize("/Windows/Style/Delete=Delete") .. (LS_ShapesWindow.mode > 1 and " (<alt> " .. MOHO.Localize("/LS/ShapesWindow/UnusedOny=Only If Unused") .. ")" or ""))
	self.selectMatchingBut:Enable((LS_ShapesWindow.mode < 2 and shape ~= nil and shapesSel == 1 and shapes > 1) or (LS_ShapesWindow.mode == 2 and style ~= nil and stylesSel == 1 and styles > 1))
	self.selectMatchingBut:SetToolTip(MOHO.Localize("/LS/ShapesWindow/SelectMatchingColor=Select Matching Color") .. " " .. (LS_ShapesWindow.mode < 2 and MOHO.Localize("/LS/ShapesWindow/Shapes=Shapes") or MOHO.Localize("/LS/ShapesWindow/Styles=Styles")) .. " (<alt> " .. MOHO.Localize("/LS/ShapesWindow/SelectIdentical=Select Identical") .. ")")
	self.checkerSelBut:SetValue(MOHO.MohoGlobals.SelectedShapeCheckerboard)

	if LS_ShapesWindow.advanced then 
		local createCursor = LS_ShapesWindow.mode < 2 and "ScriptResources/../../Support/Scripts/Tool/lm_select_shape_cursor" or "ScriptResources/../../Support/Scripts/Tool/lm_colorpoints_cursor"
		for i, but in ipairs(self.createButtons) do
			but:Enable(((edgesSel > 0 or pointsSel > 0) and not toolsDisabled) or LS_ShapesWindow.mode > 1)
			but:SetCursor(but:IsEnabled() and LM.GUI.Cursor(createCursor, 0, 0) or nil) --ScriptResources/../../Support/Scripts/Tool/lm_colorpoints_cursor
		end
		self.createButtons[1]:SetToolTip((LS_ShapesWindow.mode < 2) and MOHO.Localize("/LS/ShapesWindow/CreateFill=Create Fill") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/CreateShape/ConnectAndCreate=Connect And Create") .. ")" or MOHO.Localize("/LS/ShapesWindow/CreateFillColorOverriderStyle=Create Fill Color Overrider Style"))
		self.createButtons[2]:SetToolTip((LS_ShapesWindow.mode < 2) and MOHO.Localize("/LS/ShapesWindow/CreateStroke=Create Stroke") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/CreateShape/ConnectAndCreate=Connect And Create") .. ")" or MOHO.Localize("/LS/ShapesWindow/CreateStrokeColorOverriderStyle=Create Stroke Color Overrider Style"))
		self.createButtons[3]:SetToolTip((LS_ShapesWindow.mode < 2) and MOHO.Localize("/LS/ShapesWindow/CreateBoth=Create Both") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/CreateShape/ConnectAndCreate=Connect And Create") .. ")" or MOHO.Localize("/LS/ShapesWindow/CreateStyle=Create Style"))
		
		self.brushBut:SetToolTip(MOHO.Localize("/Dialogs/BrushPicker/Brush=Brush") .. ": " .. (brush ~= "" and brush or MOHO.Localize("/Windows/Layers/None=None") .. (LS_ShapesWindow.beginnerMode and " (" .. MOHO.Localize("/LS/ShapesWindow/PickBelow=Pick Below") .. ")" or "")))
		self.brushMenuPopup:SetCursor(LS_ShapesWindow.beginnerMode and LM.GUI.Cursor("ScriptResources/ls_shapes_window/ls_shape_brush_cursortip", 0, 0) or nil)
		self.style1MenuPopup:Enable(styleName == "") self.style1MenuPopup:Redraw()
		self.style1MenuPopup:SetToolTip(MOHO.Localize("/Windows/Style/Style1=Style 1") .. (style1Name ~= ""  and ": " .. style1Name or "") .. (LS_ShapesWindow.beginnerMode and " (" ..  MOHO.Localize("/LS/ShapesWindow/AppliesAbove=Applies Above") .. ")" or ""))
		self.style1MenuPopup:SetCursor(LS_ShapesWindow.beginnerMode and LM.GUI.Cursor("ScriptResources/ls_shapes_window/ls_shape_style_1_cursortip", 0, 0) or nil)
		self.swapBut:Enable(styleName == "" and style1UUID ~= style2UUID)
		self.style2MenuPopup:Enable(styleName == "") self.style2MenuPopup:Redraw()
		self.style2MenuPopup:SetToolTip(MOHO.Localize("/Windows/Style/Style2=Style 2") .. (style2Name ~= ""  and ": " .. style2Name or "") .. (LS_ShapesWindow.beginnerMode and " (" ..  MOHO.Localize("/LS/ShapesWindow/AppliesBellow=Applies Bellow") .. ")" or ""))
		self.style2MenuPopup:SetCursor(LS_ShapesWindow.beginnerMode and LM.GUI.Cursor("ScriptResources/ls_shapes_window/ls_shape_style_2_cursortip", 0, 0) or nil)
		self.swatchMenuPopup:SetToolTip(MOHO.Localize("/Windows/Style/Swatches=Swatches") .. " (" .. self.swatchMenu:FirstCheckedLabel():gsub("^%s+", "") .. ")")
		self.swatchMenuPopup:SetCursor(LS_ShapesWindow.beginnerMode and LM.GUI.Cursor("ScriptResources/ls_shapes_window/ls_swatches_cursortip", 0, 0) or nil) --"ScriptResources/../../Support/Scripts/Tool/lm_video_tracking_cursor"
		if LS_ShapesWindow.swatch ~= -1 and self.colorSlider then
			if LS_ShapesWindow.swatch ~= self.swatch then
				if self.swatchMenu:FirstCheckedLabel():match("🎛") then --20231030-1140: Kind of dirty solution based on current swatch label... Improve! (TODO)
					self.colorSlider:Enable(true)
					self.colorSlider:Redraw()
					self.colorSlider:SetCursor(LM.GUI.Cursor("ScriptResources/../../Support/Scripts/Tool/lm_zoom_camera_cursor", 0, 0))
				else
					self.colorSlider:Enable(false)
					self.colorSlider:SetCursor() -- Reset default cursor
				end
				self.colorPreview:Refresh() --self:UpdateColor(moho)
			end
			self.colorSlider:SetToolTip(LS_ShapesWindow.beginnerMode and MOHO.Localize("/LS/ShapesWindow/ColorSlider=Color Slider") or "")

			--[[
			if (self.v and tool and tool.prevMousePt ~= nil) then
				local curveID, segID  = -1, -1
				curveID, segID = self.v:PickEdge(tool.prevMousePt, curveID, segID, 6)

				if LS_ShapesWindow.multiMenuRules == true then
					if (shape and tool.dragMode > -1 or (curveID >= 0 and segID >= 0)) then
						LS_ShapesWindow.multiMenuRules = LS_ShapesWindow.multiMenuRules == false print(tostring(LS_ShapesWindow.multiMenuRules))
					end
				end
				
				if LS_ShapesWindow.multiMenuRules == false then print("!")
					if shape and tool.dragMode == 0 then
						if (curveID >= 0 and segID >= 0) and shape.fHasOutline then -- an edge was clicked on
							LS_ShapesWindow.multiMenuMode = LS_ShapesWindow.multiMenuRules == false and 1 or LS_ShapesWindow.multiMenuMode
						else
							LS_ShapesWindow.multiMenuMode = LS_ShapesWindow.multiMenuRules == false and 0 or LS_ShapesWindow.multiMenuMode
						end
					elseif tool.dragMode > 0 then
						LS_ShapesWindow.multiMenuMode = LS_ShapesWindow.multiMenuRules == false and tool.dragMode + 1 or LS_ShapesWindow.multiMenuMode
					end
				end
			end
			--]]
			if (tool ~= nil) then
				if toolName:find("SelectShape") then --toolName:find("SelectShape")
					if (self.v and tool.prevMousePt ~= nil) then
						local shapeID, curveID, segID  = -1, -1, -1
						shapeID, curveID, segID = self.v:PickShape(tool.prevMousePt), self.v:PickEdge(tool.prevMousePt, curveID, segID, 6) --print(shapeID, ", ", curveID, ", ", segID)

						if (shape and LS_ShapesWindow.LM_SelectShape.dragMode > -1 and (shapeID >= 0 or (curveID >= 0 and segID >= 0))) and (self.prevMousePtX and (self.prevMousePtX ~= tool.prevMousePt.x or self.prevMousePtY ~= tool.prevMousePt.y)) then
							LS_ShapesWindow.multiMenuRules = false
						end
						if LS_ShapesWindow.multiMenuRules == false then
							if shape and LS_ShapesWindow.LM_SelectShape.dragMode == 0 then
								if (curveID >= 0 and segID >= 0) and shape.fHasOutline then -- an edge was clicked on
									LS_ShapesWindow.multiMenuMode = 1
								else
									LS_ShapesWindow.multiMenuMode = 0
								end
							elseif LS_ShapesWindow.LM_SelectShape.dragMode > 0 then
								LS_ShapesWindow.multiMenuMode = 2
							end
						end
					end
				elseif tool.autoFill ~= nil and (tool.autoOutline ~= nil or tool.autoStroke ~= nil) then --toolName:find("Freehand") or toolName:find("Shape")
					if self.toolName and self.toolName ~= toolName then
						LS_ShapesWindow.multiMenuRules = false
					end
					if LS_ShapesWindow.multiMenuRules == false then --print(tostring(tool.autoFill), ", ", tostring(tool.autoOutline), ", ", tostring(tool.autoStroke))
						if (tool.autoFill ~= nil and tool.autoFill == true) and ((tool.autoOutline ~= nil and tool.autoOutline == false) or (tool.autoStroke ~= nil and tool.autoStroke == false)) then
							LS_ShapesWindow.multiMenuMode = 0
						elseif (tool.autoOutline ~= nil and tool.autoOutline == true) or (tool.autoStroke ~= nil and tool.autoStroke == true) then
							LS_ShapesWindow.multiMenuMode = 1
						end
					end
				elseif (tool.autoFillCheck ~= nil and tool.autoStrokeCheck  ~= nil) then
					if self.toolName and self.toolName ~= toolName then
						LS_ShapesWindow.multiMenuRules = false
					end
					if LM_TransformPoints ~= nil and (LM_TransformPoints.autoFill == true and LM_TransformPoints.autoStroke == false) then
						LS_ShapesWindow.multiMenuMode = 0
					elseif LM_TransformPoints ~= nil and LM_TransformPoints.autoStroke == true then
						LS_ShapesWindow.multiMenuMode = 1
					end
				end
			end

			if LS_ShapesWindow.swatch > -1 then
				--LS_ShapesWindow.multiMenuMode = (LS_ShapesWindow.multiMenuMode > 1 and shape and shape:HasPositionDependentStyles()) and 0 or LS_ShapesWindow.multiMenuMode
				self.multiMenu:SetEnabled(self.MULTI + 2, shapeHandles) -- FX
				self.multiMenu:SetEnabled(self.MULTI + 3, mesh ~= nil) -- Recolor (RGB)
				self.multiMenu:SetEnabled(self.MULTI + 4, mesh ~= nil) -- Recolor (HSB)
				self.multiMenu:SetEnabled(self.MULTI + 5, LS_ShapesWindow.multiMenuMode < 2) -- Copy HEX
				self.multiMenu:SetEnabled(self.MULTI + 6, LS_ShapesWindow.multiMenuMode > 1) -- Copy values
				self.multiMenu:SetEnabled(self.MULTI + 7, LS_ShapesWindow.multiValues.clipboard ~= nil) -- Paste values
				self.multiMenu:SetEnabled(self.MULTI + 8, LS_ShapesWindow.multiMenuMode > 1 and LS_ShapesWindow.multiMenuMode < 5) -- Reset Values
				self.multiMenu:SetEnabled(self.MULTI + 9, LS_ShapesWindow.multiMenuMode < 2 and shapesSel < 2) -- Invert Color
				self.multiMenu:SetEnabled(self.MULTI + 10, LS_ShapesWindow.multiMenuMode > 2 and LS_ShapesWindow.multiMenuMode < 5) -- Affects Fills
				self.multiMenu:SetEnabled(self.MULTI + 11, LS_ShapesWindow.multiMenuMode > 2 and LS_ShapesWindow.multiMenuMode < 5) -- Affects Strokes
				if self.multiMenu:IsEnabled(self.MULTI + LS_ShapesWindow.multiMenuMode) == false then
					LS_ShapesWindow.multiMenuMode = LS_ShapesWindow.multiMenuLast
				end
				self.multiMenu:UncheckAll()
				self.multiMenu:SetChecked(self.MULTI + LS_ShapesWindow.multiMenuMode, true)
				self.multiMenu:SetChecked(self.MULTI + 10, MOHO.hasbit(LS_ShapesWindow.multiMenuFlags, MOHO.bit(1)))
				self.multiMenu:SetChecked(self.MULTI + 11, MOHO.hasbit(LS_ShapesWindow.multiMenuFlags, MOHO.bit(2)))
				self.multiMenuPopup:SetToolTip(LS_ShapesWindow.beginnerMode and self.multiMenu:FirstCheckedLabel():gsub("(%b())", {["(RGBα)"] = "(Red, Green, Blue, Alpha)", ["(HSB)"] = "(Hue, Saturation, Brightness)"}) or self.multiMenu:FirstCheckedLabel())
				self.multiMenuPopup:SetCursor(LS_ShapesWindow.beginnerMode and LM.GUI.Cursor("ScriptResources/ls_shapes_window/ls_mode_cursortip", 0, 0) or nil)
				self.multiMenuPopup:Redraw()

				if LS_ShapesWindow.multiMenuMode < 2 then -- Fill/Stroke
					self.multi1:SetUnits(LM.GUI.UNIT_NONE)
					self.multi1:SetMaxDecimalPlaces(0)
					self.multi1:SetCursor(LM.GUI.Cursor("ScriptResources/ls_shapes_window/ls_cursor_col_r", 0, 0))
					self.multi1:SetValue(LS_ShapesWindow.multiMenuMode == 0 and self.fillCol:Value().r or self.lineCol:Value().r)

					self.multi2:SetUnits(LM.GUI.UNIT_NONE)
					self.multi2:SetMaxDecimalPlaces(0)
					self.multi2:SetCursor(LM.GUI.Cursor("ScriptResources/ls_shapes_window/ls_cursor_col_g", 0, 0))
					self.multi2:SetValue(LS_ShapesWindow.multiMenuMode == 0 and self.fillCol:Value().g or self.lineCol:Value().g)

					self.multi3:SetUnits(LM.GUI.UNIT_NONE)
					self.multi3:SetMaxDecimalPlaces(0)
					self.multi3:SetCursor(LM.GUI.Cursor("ScriptResources/ls_shapes_window/ls_cursor_col_b", 0, 0))
					self.multi3:SetValue(LS_ShapesWindow.multiMenuMode == 0 and self.fillCol:Value().b or self.lineCol:Value().b)
					
					self.multi4:SetUnits(LM.GUI.UNIT_PERCENT)
					self.multi4:SetMaxDecimalPlaces(0)
					self.multi4:SetPercentageMode(true)
					self.multi4:SetWheelInc(0.1)
					self.multi4:SetWheelInteger(false)
					self.multi4:SetCursor(LM.GUI.Cursor(LS_ShapesWindow.multiMenuMode < 2 and "ScriptResources/ls_shapes_window/ls_cursor_col_a" or nil, 0, 0))
					self.multi4:SetValue(LS_ShapesWindow.multiMenuMode == 0 and self.fillCol:Value().a / 255 or self.lineCol:Value().a / 255) --self.multi4:SetValue(LS_ShapesWindow.multiMenuMode == 0 and self.fillCol:Value().a / 255 * 100 or self.lineCol:Value().a / 255 * 100) --> Non-PercentageMode version
				
				elseif LS_ShapesWindow.multiMenuMode == 2 then -- FX Transform
					self.multi1:SetUnits(LM.GUI.UNIT_NONE)
					self.multi1:SetMaxDecimalPlaces(2)
					self.multi1:SetWheelInc(0.01)
					self.multi1:SetWheelInteger(false)
					self.multi1:SetCursor(LM.GUI.Cursor("ScriptResources/ls_shapes_window/ls_cursor_set_x", 0, 0))
					self.multi1:SetValue(shapeFxOffset and shapeFxOffset.value.x or 0)

					self.multi2:SetUnits(LM.GUI.UNIT_NONE)
					self.multi2:SetMaxDecimalPlaces(2)
					self.multi2:SetWheelInc(0.01)
					self.multi2:SetWheelInteger(false)
					self.multi2:SetCursor(LM.GUI.Cursor("ScriptResources/ls_shapes_window/ls_cursor_set_y", 0, 0))
					self.multi2:SetValue(shapeFxOffset and shapeFxOffset.value.y or 0)

					self.multi3:SetUnits(LM.GUI.UNIT_DEGREES)
					self.multi3:SetMaxDecimalPlaces(1)
					self.multi3:SetCursor(LM.GUI.Cursor("ScriptResources/ls_shapes_window/ls_cursor_transform_r", 0, 0))
					self.multi3:SetValue(shapeFxRotation and math.deg(shapeFxRotation.value) or 0)

					self.multi4:SetUnits(LM.GUI.UNIT_PERCENT)
					self.multi4:SetMaxDecimalPlaces(1)
					self.multi4:SetPercentageMode(true)
					self.multi4:SetWheelInc(0.05)
					self.multi4:SetWheelInteger(false)
					self.multi4:SetCursor(LM.GUI.Cursor("ScriptResources/ls_shapes_window/ls_cursor_transform_s", 0, 0))
					self.multi4:SetValue(shapeFxScale and shapeFxScale.value or 1)
				
				elseif LS_ShapesWindow.multiMenuMode == 3 or LS_ShapesWindow.multiMenuMode == 4 then -- Recolor RGB/HSB
					self.multi1:SetUnits(LS_ShapesWindow.multiMenuMode == 3 and LM.GUI.UNIT_NONE or LM.GUI.UNIT_DEGREES)
					self.multi1:SetMaxDecimalPlaces(0)
					self.multi1:SetWheelInc(1)
					self.multi1:SetWheelInteger(true)
					self.multi1:SetCursor(LM.GUI.Cursor(LS_ShapesWindow.multiMenuMode == 3 and "ScriptResources/ls_shapes_window/ls_cursor_col_r" or "ScriptResources/ls_shapes_window/ls_cursor_col_h", 0, 0))
					self.multi1:SetValue(LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode][1])

					self.multi2:SetUnits(LS_ShapesWindow.multiMenuMode == 3 and LM.GUI.UNIT_NONE or LM.GUI.UNIT_PERCENT)
					self.multi2:SetMaxDecimalPlaces(0)
					self.multi2:SetWheelInc(1)
					self.multi2:SetWheelInteger(true)
					self.multi2:SetCursor(LM.GUI.Cursor(LS_ShapesWindow.multiMenuMode == 3 and "ScriptResources/ls_shapes_window/ls_cursor_col_g" or "ScriptResources/ls_shapes_window/ls_cursor_col_s", 0, 0))
					self.multi2:SetValue(LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode][2])

					self.multi3:SetUnits(LS_ShapesWindow.multiMenuMode == 3 and LM.GUI.UNIT_NONE or LM.GUI.UNIT_PERCENT)
					self.multi3:SetMaxDecimalPlaces(0)
					self.multi3:SetWheelInc(1)
					self.multi3:SetWheelInteger(true)
					self.multi3:SetCursor(LM.GUI.Cursor("ScriptResources/ls_shapes_window/ls_cursor_col_b", 0, 0))
					self.multi3:SetValue(LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode][3])

					self.multi4:SetUnits(LM.GUI.UNIT_PERCENT)
					self.multi4:SetMaxDecimalPlaces(0)
					self.multi4:SetPercentageMode(true)
					self.multi4:SetWheelInc(0.1)
					self.multi4:SetWheelInteger(false)
					self.multi4:SetCursor(LM.GUI.Cursor("ScriptResources/ls_shapes_window/ls_cursor_col_a", 0, 0))
					self.multi4:SetValue((LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode][4] / 255) * 255)
					self.multi4:Enable(LS_ShapesWindow.multiMenuMode == 3)
				end
				self.applyBut:Enable(LS_ShapesWindow.multiMenuMode > 2)
				self.applyBut:SetToolTip(LS_ShapesWindow.multiMenuMode < 2 and MOHO.Localize("/LS/ShapesWindow/ApplyMode=Apply") or MOHO.Localize("/LS/ShapesWindow/ApplyMode=Apply") .. " (<alt> " .. MOHO.Localize("/LS/ShapesWindow/Randomized=Randomized") .. ")")
			end
		end
	end

	if (LS_ShapesWindow.beginnerMode ~= self.beginnerMode) or self.isNewRun then -- Avoid unnecesary tooltip updates
		self.menu1Popup:SetToolTip(LS_ShapesWindow.beginnerMode and MOHO.Localize("/Dialogs/LayerSettings/General=General") or "")
		--self.menu3Popup:SetToolTip(LS_ShapesWindow.beginnerMode and MOHO.Localize("/Windows/Library/More=More:"):gsub("[^%w]$", "") or "")
		self.modeBut:SetToolTip(LS_ShapesWindow.beginnerMode and MOHO.Localize("/LS/ShapesWindow/Mode=Mode: ") .. MOHO.Localize(modes[LS_ShapesWindow.mode] or ""))
		--self.itemNameLabel:SetToolTip(MOHO.Localize("/Windows/Style/Name=Name"))
		self.combineBlend:SetToolTip(LS_ShapesWindow.beginnerMode and MOHO.Localize("/Scripts/Tool/SelectShape/Blend=Blend:"):gsub("[^%w]$", "") .. " (" .. MOHO.Localize("/Dialogs/NudgeDlog/Amount=Amount") ..")" or "") -- Remove any non-alphanumeric ending character
		self.baseBut:SetToolTip(LS_ShapesWindow.beginnerMode and MOHO.Localize("/Scripts/Tool/SelectShape/SelectBottomOfCluster=Select bottom of Liquid Shape") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All") .. ")" or "")
		self.topBut:SetToolTip(LS_ShapesWindow.beginnerMode and MOHO.Localize("/Scripts/Tool/SelectShape/SelectTopOfCluster=Select top of Liquid Shape") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All") .. ")" or "")
		if LS_ShapesWindow.advanced then 
			self.lineWidth:SetToolTip(LS_ShapesWindow.beginnerMode and MOHO.Localize("/Dialogs/InsertText/BalloonWidth=Stroke Width") or "")
		end
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
	local shape = shape or self.tempShape
	if (shape ~= nil) then -- 20240123-0135: Addded the self.shape ~= nil part. TBO...
		local bbMin, bbMax = LM.Vector2:new_local(), LM.Vector2:new_local() shape:ShapeBounds(bbMin, bbMax, 0)
		local fc, lc, lw, hf, ho, hp, eo, er, es = shape.fMyStyle.fFillCol:GetValue(0), shape.fMyStyle.fLineCol:GetValue(0), shape.fMyStyle.fLineWidth, tostring(shape.fHasFill), tostring(shape.fHasOutline), tostring(shape:HasPositionDependentStyles()), shape.fEffectOffset:GetValue(0), shape.fEffectRotation:GetValue(0), shape.fEffectScale:GetValue(0)
		self.shapeTable[-1] = math.floor(bbMin.x*10+.5)/10 .. math.floor(bbMin.y*10+.5)/10 .. math.floor(bbMax.x*10+.5)/10 .. math.floor(bbMax.y*10+.5)/10 .. fc.r .. fc.g .. fc.b .. fc.a .. lc.r .. lc.g .. lc.b .. lc.a .. lw .. hf .. ho .. hp .. eo.x .. eo.y .. er ..es .. shape.fInheritedStyleName:Buffer() .. shape.fInheritedStyleName2:Buffer() .. tostring(shape.fHidden)
	end

	styles = doc and doc:CountStyles() or 0
	for i = 0, #self.styleTable do -- Ensure the table is empty before updating! Otherwise if it had more elements, they will remain and the system will think there are more shapes than actually are (force an unnecessary list update).
		self.styleTable[i] = nil
	end
	for i = 1, styles do -- Previous styles state
		local iStyleName = tostring(doc:StyleByID(i - 1).fName:Buffer())
		local iStyle = doc:StyleByID(i - 1)
		--local style = doc:StyleByID(i - 1)
		self.styleTable[0] = moho.drawingLayer:UUID()
		self.styleTable[i] = iStyleName
	end
	if (style ~= nil and self.style ~= nil) then
		local fc, lc, lw, df, dl, dw, bn = style.fFillCol.value, style.fLineCol.value, style.fLineWidth, tostring(style.fDefineFillCol), tostring(style.fDefineLineCol), tostring(style.fDefineLineWidth), style.fBrushName:Buffer()
		self.styleTable[-1] = fc.r .. fc.g .. fc.b .. fc.a .. lc.r .. lc.g .. lc.b .. lc.a .. lw .. df .. dl .. dw .. bn
	end

	self.toolName = (doc ~= nil and doc:Name() ~= "-") and moho:CurrentTool() or ""
	self.mode = LS_ShapesWindow.mode
	self.beginnerMode = LS_ShapesWindow.beginnerMode
	self.style = moho:CurrentEditStyle()
	self.styleSel = doc and doc:StyleByID(styleSelID) or style
	self.layerUUID = moho.layer and moho.layer:UUID()
	self.shape = moho:SelectedShape() or moho:NewShapeProperties() or MOHO.MohoGlobals.NewShapeProperties
	self.swatch = LS_ShapesWindow.swatch
	self.colorSliderVal = self.colorSlider and self.colorSlider:Value() or 1
	self.prevMousePtX, self.prevMousePtY = (tool and tool.prevMousePt ~= nil) and tool.prevMousePt.x or 0, (tool and tool.prevMousePt ~= nil) and tool.prevMousePt.y or 0
	self.isNewRun = false
	helper:delete()
end

function LS_ShapesWindowDialog:OnOK() --print("LS_ShapesWindowDialog:OnOK(): ", " 🕗: " .. os.clock()) LM.Snooze(1500)
	local helper = MOHO.ScriptInterfaceHelper:new_local()
	local moho = helper:MohoObject()
	local doc = moho.document

	if LS_ShapesWindow.dlog == nil and LS_ShapesWindow.shouldReopen then -- Reopen the just auto-closed window
		LS_ShapesWindow:Run(moho)
		LS_ShapesWindow.shouldReopen = false
	else
		LS_ShapesWindow.dlog = nil -- Mark the window closed
		LS_ShapesWindow.shouldOpen = false
	end

	if doc and doc:Name() then --20231229-1415: This check seems now necessary to avoid crashes upon closing Moho while dialog is open? But I'd swear not before...
		MOHO.Redraw()
		moho:UpdateUI()
	end
	helper:delete()
end

function LS_ShapesWindowDialog_Update(moho) --print("LS_ShapesWindowDialog_Update(" .. tostring(moho) .."): ", " 🕗: " .. os.clock())
	--[[20240121-2342: TODO, continue investigating why this moho object is not what one could expect...
	if moho.layer then print(moho.layer:Name()) end
	for k, v in pairs(moho) do --print(type(k), type(v))
		if type(v) == "table" then
			--print(tostring(K), ", ", tostring(v))
		end
	end
	--]]
	
	if LS_ShapesWindow.dlog then
		LS_ShapesWindow.dlog:Update(moho)
	end
end

-- Register the dialog to be updated when changes are made
table.insert(MOHO.UpdateTable, LS_ShapesWindowDialog_Update)

function LS_ShapesWindowDialog:DrawItem(mesh, t, sharp) --(M_Mesh, table, bool/float) void
	t = t or {close = true, {0,.2}, {.2,.4}, {.4,.2}, {.2,0}, {.4,-.2}, {.2,-.4}, {0,-.2}, {-.2,-.4}, {-.4,-.2}, {-.2,0}, {-.4,.2}, {-.2,.4}} --❌
	sharp = (sharp ~= nil and type(sharp) == "number") and sharp or (sharp == true and MOHO.PEAK or MOHO.SMOOTH)
	if (mesh ~= nil) then
		local height = t.height and t.height or 22
		local first = mesh:CountPoints()
		local p = LM.Vector2:new_local()
		for i = 1, #t do
			p.x, p.y, p.c, p.w = table.unpack(t[i])
			if (i == 1) then
				mesh:AddLonePoint(p, 0)
			else
				mesh:AppendPoint(p, 0)
				mesh:Point(mesh:CountPoints() - 1):SetCurvature(p.c and p.c or sharp, 0)
				mesh:Point(mesh:CountPoints() - 1).fWidth:SetValue(p.w and p.w / height or -1) --mesh:Point(mesh:CountPoints() - 1).fWidth.value = p.w and p.w / height or -1
				if (t.close and i == #t) then
					p:Set(t[1][1] and t[1][1] or 0, t[1][2] and t[1][2] or 0)
					mesh:AppendPoint(p, 0) --mesh:AppendPoint(LM.Vector2:new_local(t[1][1] and t[1][1] or 0, t[1][2] and t[1][2] or 0), 0)
					mesh:WeldPoints(first + #t, first, 0)
					mesh:Point(first):SetCurvature(t[1][3] and t[1][3] or sharp, 0)
					mesh:Point(first).fWidth:SetValue(t[1][4] and t[1][4] / height or -1) --mesh:Point(first).fWidth.value = t[1][4] and t[1][4] / height or -1
				end
				mesh:Point(i - 1):ResetControlHandles(0)
			end

		end
		--for i = first, mesh:CountPoints() - 1 do
			--mesh:Point(i):SetCurvature(MOHO.PEAK, 0)
			--mesh:Point(i):ResetControlHandles(0)
		--end
		mesh:SelectConnected()
	end
end

function LS_ShapesWindowDialog:UpdateItem(moho, item, fill) --(MohoDoc, M_Shape/M_Style, bool void) --print("LS_ShapesWindowDialog:UpdateItem: " .. os.clock())
	local lMesh = moho:DrawingMesh()
	local pMesh = self.itemPreview:Mesh()
	local pHeight = self.itemPreview:Height()
	local defShape, defStyle
	local offset = LM.Vector2:new_local()
	local scale = 0.725
	pMesh:Clear()
	pMesh:SelectNone()

	if (item and item.fMyStyle ~= nil) then -- Item is shape
		if (item:ShapeID() ~= -1) then -- Is actually a shape
			offset:Set(item:ShapeCenter())
			local single = LS_ShapesWindow:IsSingleCurve(item) --20240101-1730: Had to exclude multi-curve shapes due to "shape out of range" warnings/crashes. Multi-curve shapes didn't preview accurately anyway... 
			if item.fHasFill and single and not item.fHidden and item.fComboMode ~= MOHO.COMBO_INTERSECT and fill then --20231219-0342: Had to exclude hidden shapes due to a "shape out of range" crash upon reaching CombineShapes bellow if shape is in intersection liquid mode! TBO... 20240103-0000: Also had to leave fills out due to a weird Liquid Shapes preview issue upon undo.
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
						pMesh:Shape(0).fHasOutline = item.fHasOutline
						--if item.fHidden == true then item.fHidden = false end
						pMesh:CombineShapes(pMesh:Shape(0), item, MOHO.COMBO_ADD, 0.0, true)
						pMesh:Shape(1).fMyStyle = item.fMyStyle
						pMesh:Shape(1):SetName(item:Name())
						pMesh:Shape(0):SelectAllPoints()
						pMesh:DeleteShape(0)
						pMesh:DeleteSelectedPoints()

						--[[20231113-0520: Try to delete any segment not present in the original shape? (TODO)
						for copEdg = 0, pMesh:Shape(0):CountEdges() - 1 do
							local copCurID, copSegID = item:GetEdge(e)
							for origEdg = 0, item:CountEdges() - 1 do
								local origCurID, origSegID = item:GetEdge(e)

							end
						end
						--]]
					end
				end
			else
				for e = 0, item:CountEdges() - 1 do
					local cID, sID = item:GetEdge(e) --print(tostring(lMesh:Curve(cID).fClosed))
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
					pMesh:Shape(0):SetName(item:Name())
				end
			end

			if pMesh:CountShapes() > 0 then
				if item:HasPositionDependentStyles() and pMesh:Shape(0):HasPositionDependentStyles() then
					--local center, handle = item:EffectHandle1(), item:EffectHandle2()
					pMesh:Shape(0).fEffectOffset.value = item.fEffectOffset.value
					pMesh:Shape(0).fEffectScale.value = item.fEffectScale.value
					pMesh:Shape(0).fEffectRotation.value = item.fEffectRotation.value
				end
				--pMesh:Shape(0).fMyStyle.fFillCol = item.fMyStyle.fFillCol
				--pMesh:Shape(0).fMyStyle.fLineCol = item.fMyStyle.fLineCol
				--pMesh:Shape(0).fMyStyle.fLineWidth = item.fMyStyle.fLineWidth
			end

			--pMesh:SelectAll()
			--pMesh:PrepMovePoints()
			--self.itemPreview:AutoZoom()
			--pMesh:ScalePoints(0.75, 0.75, pMesh:SelectedCenter(), false)
		else -- Is default shape
			LS_ShapesWindowDialog:DrawItem(pMesh, {close = true, height = pHeight, {-.159,.165,.225}, {.37,.542,.56}, {.654,.05,.3}, {-.048,-.52,.4275}, {-.675,.115,.465}})
			if self.itemPreview:CreateShape(fill) then
				local beanShape = pMesh:Shape(0)
				beanShape.fMystyle = item.fMystyle
			end
		end
	elseif (item and item.fDefineFillCol ~= nil) then -- Item is Style
		local defBrush = item.fBrushName:Buffer() ~= ""
		local defFill, defLine, defWidth = item.fDefineFillCol, item.fDefineLineCol, item.fDefineLineWidth
		local ballShape = {close = true, height = pHeight, {0,.67,.391379}, {.67,0,.391379}, {0,-.67,.391379}, {-.67,0,.391379}}
		local stainShape = {close = true, height = pHeight, {-.066,.322,.6}, {.26,.614,MOHO.SMOOTH}, {.21,.286,.6}, {.614,.26,MOHO.SMOOTH}, {.377,.066,.6}, {.523,-.206,MOHO.SMOOTH}, {.34,-.21,.6}, {.26,-.614,MOHO.SMOOTH}, {.12,-.377,.6}, {-.17,-.486,MOHO.SMOOTH}, {-.153,-.34,.6}, {-.614,-.26,MOHO.SMOOTH}, {-.322,-.12,.6}, {-.614,.26,MOHO.SMOOTH}, {-.286,.153,.6}, {-.168,.486,MOHO.SMOOTH}}
		--local dropShape = {close = true, height = pHeight, {0,1.1666,MOHO.PEAK}, {.67,0,.391379}, {0,-.67,.391379,defWidth and 200 or nil}, {-.67,0,.391379}, {0,1.1666,MOHO.PEAK}}
		--scale = (defBrush or not defLine) and 0.67 or scale
		LS_ShapesWindowDialog:DrawItem(pMesh, defBrush and stainShape or ballShape)
		if self.itemPreview:CreateShape(defFill == true and true or false) then
			local shape = pMesh:Shape(0)
			if defFill then
				shape.fMyStyle.fFillCol = item.fFillCol
			end
			if defLine then
				shape.fMyStyle.fLineCol = item.fLineCol
			end
			if defFill and not defLine then
				shape.fMyStyle.fLineCol.value.a = 0
			end
			if defWidth then
				shape.fMyStyle.fLineWidth = 0.1333 --LS_ShapesWindow.MohoLineWidth * 2
			end
		end
	else -- No shape or style?
		if (item ~= nil) then
			LS_ShapesWindowDialog:DrawItem(pMesh)
			if self.itemPreview:CreateShape(true) then
				local noItem = pMesh:Shape(0)
				noItem.fMyStyle.fFillCol.value = (LS_ShapesWindow.UILightness_v12beta > 0.5 and MOHO.String2Color(LS_ShapesWindow.LightHighlight) or MOHO.String2Color(LS_ShapesWindow.DarkHighlight)) or LM.ColorOps.Red
				noItem.fHasOutline = false
				scale = 0.525
			end
		else
			pMesh:Clear()
			self.itemPreview:Refresh()
			return
		end
	end

	pMesh:SelectAll()
	pMesh:PrepMovePoints()
	self.itemPreview:AutoZoom()
	offset:Set(-.01, .01) -- Little south-east biased position correction
	pMesh:TransformPoints(offset, scale, scale, 0, pMesh:SelectedCenter())
	--pMesh:DeselectPoints()
	self.itemPreview:Refresh()
end

function LS_ShapesWindowDialog:UpdateBrush(moho, shape) --print("LS_ShapesWindowDialog:UpdateBrush: " .. os.clock())
	local pMesh = self.brushPreview:Mesh()
	shape = shape or moho:SelectedShape()
	if (pMesh ~= nil and shape ~= nil) then
		if pMesh:CountShapes() < 1 then
			local v = LM.Vector2:new_local()
			v:Set(-0.05, 0.05) pMesh:AddLonePoint(v, 0)
			v:Set(-0.05, 0.05) pMesh:AppendPoint(v, 0)
			pMesh:Point(0):SetCurvature(MOHO.PEAKED, 0)
			pMesh:Point(1):SetCurvature(MOHO.PEAKED, 0)
			pMesh:SelectConnected()
			if self.brushPreview:CreateShape(false) then
				pMesh:Shape(0).fMyStyle.fLineWidth = 0.9
			end
		end
		if pMesh:CountShapes() > 0 then
			--pMesh:Shape(0).fMyStyle.fLineWidth = shape.fMyStyle.fLineWidth --pMesh:Shape(0).fMyStyle.fLineCaps = 0 -- Tests...
			pMesh:Shape(0).fMyStyle.fBrushName = shape.fMyStyle.fBrushName --pMesh:Shape(0).fMyStyle.fBrushName:Set(tostring(shape.fMyStyle.fBrushName:Buffer())) -- It seems LM_MeshPreview widget doesn't display brushes. Oh, well...
		end
	end
	self.brushPreview:Refresh()
end

function LS_ShapesWindowDialog:UpdateColor(moho) --print("LS_ShapesWindowDialog:UpdateColor: " .. os.clock())
	--local lMesh = moho:DrawingMesh()
	--local pMesh = self.colorPreview and self.colorPreview:Mesh() or nil
	if self.colorPreview and self.colorPreview:Mesh() ~= nil then
		self:UpdatePreview(moho, self.colorPreview)
	end
end

function LS_ShapesWindowDialog:UpdatePreview(moho, preview) --print("LS_ShapesWindowDialog:UpdatePreview: " .. os.clock())
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
function LS_ShapesWindowDialog:UpdateColor(moho) --print("LS_ShapesWindowDialog:UpdateColor: " .. os.clock())
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

function LS_ShapesWindowDialog:HandleMessage(msg) --print("LS_ShapesWindowDialog:HandleMessage(" .. math.floor(msg) .. "): " .. LS_ShapesWindowDialog:WhatMsg(msg), " 🕗: " .. os.clock())
	--local caller = debug.getinfo(3) and debug.getinfo(3).name or "NULL" print(caller) --0: getinfo, 1: NULL/NULL, 2: SetSelItem/NULL, 3: NULL/Update, 4: NULL/func, 5: NULL/NULL
	local helper = MOHO.ScriptInterfaceHelper:new_local()
	local moho = helper:MohoObject()
	local frame = moho.frame
	local doc = moho.document --print("HM: " .. (doc and doc:Name()) or "No Doc") --20240103-1809: Back to normality after fixing the casue of opening document mess? (TBO!)
	--local doc = (LS_ShapesWindow.defDoc and LS_ShapesWindow.defDoc ~= moho.document) and LS_ShapesWindow.defDoc or moho.document --print("HM: " .. (doc and doc:Name()) or "No Doc") --20240102-1638: A try to fix/patch the new opening document mess for now... (TBO!)
	local docH = doc and doc:Height() or 240
	local toolName = (doc ~= nil and doc:Name() ~= "-") and moho:CurrentTool() or ""
	local tool = _G[toolName]
	local l = self:GetLayout()
	--local vHeight, vWidth = moho.view:Height(), moho.view:Width()
	local newVal = {0, 0, 0, 0}

	local styleName = moho:CurrentEditStyle() and tostring(moho:CurrentEditStyle().fName:Buffer()) or ""
	local style = moho:CurrentEditStyle() -- 20231010-0554: For some reason, "styleName" must be gathered before this assignment, otherwise then it won't be possible to access "style" properties!
	local styleID = -1
	local styles = doc and math.floor(doc:CountStyles()) or 0
	local styleSelID = LS_ShapesWindow.mode == 2 and math.floor(self.itemList:SelItem()) - 1 or -1
	local styleSel = doc and doc:StyleByID(styleSelID) or style
	local stylesSel = math.floor(self.itemList:NumSelectedItems() + (self.itemList:IsItemSelected(0) == true and -1 or 0))

	local style1Name, style2Name = (self.tempShape and self.tempShape.fInheritedStyle) and tostring(self.tempShape.fInheritedStyle.fName:Buffer()) or "", (self.tempShape and self.tempShape.fInheritedStyle2) and tostring(self.tempShape.fInheritedStyle2.fName:Buffer()) or "" -- See note 20231010-0554 above!
	local style1, style2 = (styleName == "" and self.tempShape) and self.tempShape.fInheritedStyle or nil, (styleName == "" and self.tempShape) and self.tempShape.fInheritedStyle2 or nil
	local style1UUID, style2UUID = style1 and style1.fUUID:Buffer() or nil, style2 and style2.fUUID:Buffer() or nil
	local style1ID, style2ID = LS_ShapesWindow:StyleID(doc, style1), LS_ShapesWindow:StyleID(doc, style2)
	
	self.tempShape = moho:NewShapeProperties() or MOHO.MohoGlobals.NewShapeProperties
	self.msg = msg or MOHO.MSG_BASE

	if (msg >= self.MENU1 and msg <= self.MENU1 + 14 + 1) then -- The + 1 is for "Testground" -- Process first of all stuff that can be accesed even without an open document.
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
		elseif (msg == self.MENU1 + 4) then -- Show In "Tools" Palette
			if (LS_ShapesWindow.alertShowInTools ~= 1 and LS_ShapesWindow.showInTools == true) then
				LS_ShapesWindow.alertShowInTools = LM.GUI.Alert(LM.GUI.ALERT_INFO, string.format(MOHO.Localize("/LS/ShapesWindow/ShowInToolsAlert1=The Tools palette button to open \"%s\" will be, and remain, hidden."), LS_ShapesWindow:UILabel()),
				MOHO.Localize("/LS/ShapesWindow/ShowInToolsAlert2=This helps saving space there, but you'll have to open the window by means of its \"Scripts\" menu entry from now on (therefore you can revert this setting at any time)"), "\n\n" .. MOHO.Localize("/LS/ShapesWindow/ShowInToolsAlert3=💡 You may want to consider checking \"Open On Startup\" option just above!"),
				MOHO.Localize("/LS/ShapesWindow/OK=OK"), MOHO.Localize("/LS/ShapesWindow/GotIt=Got It!"))
			end
			LS_ShapesWindow.showInTools = not LS_ShapesWindow.showInTools
			if (doc ~= nil) then
				moho:SetCurFrame(frame ~= 0 and 0 or 1)
				moho:SetCurFrame(frame)
			end
		elseif (msg == self.MENU1 + 5) then -- Beginner's Mode
			LS_ShapesWindow.beginnerMode = not LS_ShapesWindow.beginnerMode
		elseif (msg >= self.MENU1 + 6 and msg <= self.MENU1 + 9) then -- Try to encompass here options which require auto-reopening.
			if (msg == self.MENU1 + 6) and doc ~= nil then -- Advanced (Creation Controls)
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
					LS_ShapesWindow.shouldReopen = true
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
				if LS_ShapesWindow.advanced ~= self.menu1:IsChecked(self.MENU1 + 6) or LS_ShapesWindow.largeButtons ~= self.menu1:IsChecked(self.MENU1 + 7) or LS_ShapesWindow.largePalette ~= self.menu1:IsChecked(self.MENU1 + 7) or LS_ShapesWindow.showInfobar ~= self.menu1:IsChecked(self.MENU1 + 9) then -- Only Reopen window if necessary.
					--print("1: (msg == self.MENU1 + 7)")
					self.dummyList:SetSelItem(self.dummyList:GetItem(0), false)
					--print("2: (msg == self.MENU1 + 7)")
					if (LS_ShapesWindow.dlog) and doc ~= nil then -- It may be better not try to reopen without an open document, otherwise the lack of view (among other things) will make it open weirdly.
						LS_ShapesWindow.dlog = nil
						LS_ShapesWindow.shouldReopen = true
					end
					helper:delete()
					return
				end
			else
				helper:delete()
				return
			end
		elseif (msg == self.MENU1 + 11) then -- Help...
			LS_ShapesWindow.showHelp = not LS_ShapesWindow.isHelpVisible and true or false
			if (LS_ShapesWindow.showHelp and (not LS_ShapesWindow.isHelpVisible)) then
				if LS_ShapesWindow:FileExists(self.resPath .. '\\HELP.png') then
					local hDlog = LS_ShapesWindowDialog.h:new(moho)
					LS_ShapesWindow.isHelpVisible = true
					LS_ShapesWindow.showHelp = false

					if (hDlog:DoModal() == LM.GUI.MSG_CANCEL) then
						LS_ShapesWindow.isHelpVisible = false
						LS_ShapesWindow.showHelp = true
						return
					end
				elseif (LS_ShapesWindow:FileExists(self.resPath .. '\\@HELPME.url') == true) then
					LS_ShapesWindow:Open(self.resPath .. '\\@HELPME.url') --os.execute('start "" ' .. self.resPath .. '\\README.htm')
				elseif LS_ShapesWindow.repo then
					os.execute('start "" ' .. LS_ShapesWindow.repo .. "#top")
				else
					LM.Beep()
				end
			end
		elseif (msg == self.MENU1 + 12) then -- Visit Webpage...
			if (LS_ShapesWindow:FileExists(self.resPath .. '\\@VISITME.url') == true) then
				LS_ShapesWindow:Open(self.resPath .. '\\@VISITME.url')
			elseif LS_ShapesWindow.webpage then
				os.execute('start "" ' .. LS_ShapesWindow.webpage)
			else
				LM.Beep()
			end
		elseif (msg == self.MENU1 + 13) then -- Check For Updates...
			if LS_ShapesWindow.repoLatest then
				os.execute('start "" ' .. LS_ShapesWindow.repoLatest .. ("#YOURS IS v" .. LS_ShapesWindow.version):replace(" ", "-")) --os.execute('start "" "https://mohoscripts.com/script/"' .. (info.source):match("^.*[/\\](.*).lua$"))
			elseif (LS_ShapesWindow:FileExists(self.resPath .. '\\@UPDATEME.url') == true) then
				LS_ShapesWindow:Open(self.resPath .. '\\@UPDATEME.url')
			else
				LM.Beep()
			end
		elseif (msg == self.MENU1 + 14) then
			local years = LS_ShapesWindow.birth:sub(1,4) .. (tonumber(LS_ShapesWindow.build:sub(1, 4)) > tonumber(LS_ShapesWindow.birth:sub(1, 4)) and "-" .. LS_ShapesWindow.build:sub(1,4) or "")
			local block1a = string.format("%s %s (Build %s) for %s\n", LS_ShapesWindow:UILabel(), LS_ShapesWindow.version, LS_ShapesWindow.build, LS_ShapesWindow.target:replace(" ", " "))
			local block1b = string.format("%s %s %s %s", "Copyright ©", years, LS_ShapesWindow:Creator(), "(Lost Scripts™)")
			local block2 = LS_ShapesWindow:Description() .. "\n\n"
			local block3 = "All rights reserved - Click \"Read License\" for terms and conditions." --"Licensed under the Apache License, Version 2.0"
			--local blockSep = "\n" ..  ("_"):rep(math.max(block1a and #block1a or 0, block1b and #block1b or 0))
			local alert = LM.GUI.Alert(LM.GUI.ALERT_INFO, block1a .. block1b, block2, block3, MOHO.Localize("/Scripts/Menu/Credits/Title=Credits"), MOHO.Localize("/Dialogs/SLAPanel/ReadLicense=Read License"), MOHO.Localize("/Menus/File/CloseRender=Close")) --This script is freeware and released under the ... License. --Licensed under the ... License.
			if alert == 0 then
				local file = self.resPath .. "\\" .. "CREDITS.txt"
				local fileLines = LS_ShapesWindow:ReadFile(file)
				local alert = LM.GUI.Alert(LM.GUI.ALERT_INFO, "Credits & Acknowledgements", LS_ShapesWindow.List(fileLines, {kind = ""}), nil, MOHO.Localize("/Menus/File/CloseRender=Close"))
			elseif alert == 1 then
				local file = LS_ShapesWindow:FirstExistingFile(self.resPath, "LICENSE", "LICENSE.txt") --local file = self.resPath .. "\\" .. "LICENSE"
				local fileContent = LS_ShapesWindow:ReadFile(file, {asString = true})
				local minWidth = "\n" .. string.rep(" ", 170)
				local alert = LM.GUI.Alert(LM.GUI.ALERT_INFO, "Licence & Warranty", fileContent .. minWidth, nil, MOHO.Localize("/Menus/File/CloseRender=Close"))
			end
		elseif (msg == self.MENU1 + 15) then -- Last (Testground!)
			--print("...")
		end

		--if (doc ~= nil) then
			self:Update()
			MOHO.Redraw()
		--end
		helper:delete()
		return
	elseif (msg >= self.SELECTSWATCH and msg <= self.SELECTSWATCH + self:CountRealItems(self.swatchMenu, self.SELECTSWATCH) - 1) then
		local reopen = false
		if (msg == self.SELECTSWATCH) then --print("None") -- None
			reopen = LS_ShapesWindow.swatch ~= -1
			LS_ShapesWindow.swatch = (msg - self.SELECTSWATCH) - 1

			if reopen then
				self.dummyList:SetSelItem(self.dummyList:GetItem(0), false)
				if (LS_ShapesWindow.dlog) then
					LS_ShapesWindow.dlog = nil
					LS_ShapesWindow.shouldReopen = true
				end
			end
			helper:delete()
			return
		elseif (msg >= self.SELECTSWATCH + 1) and (msg <= self.SELECTSWATCH + self:CountRealItems(self.swatchMenu, self.SELECTSWATCH) - 4) then --print(">>> " .. (msg - self.SELECTSWATCH) - 1)
			reopen = LS_ShapesWindow.swatch == -1 and (msg - self.SELECTSWATCH) - 1 > -1
			LS_ShapesWindow.swatch = (msg - self.SELECTSWATCH) - 1

			--[[20231122: Pre-nested table system working code.
			local count, layer = 0, nil
			for i, doc in ipairs(LS_ShapesWindow.docList) do
				for j = doc:CountLayers() - 1, 0, -1 do
					layer = doc:Layer(j)
					count = count + 1
					if count == (msg - self.SELECTSWATCH) then
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
				for j = #chunk - 1, 0, -1 do print(msg - self.SELECTSWATCH, ", ", i, ", ", j)
					--layer = doc:Layer(j)
					count = count + 1
					if count == (msg - self.SELECTSWATCH) then
						LS_ShapesWindow.swatchDoc = i
						LS_ShapesWindow.swatchLayer = j --print(msg - self.SELECTSWATCH, ", ", LS_ShapesWindow.swatchDoc, ", ", LS_ShapesWindow.swatchLayer)
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
					if chunk[j] and chunk[j].msg == msg then --print(msg - self.SELECTSWATCH, ", ", chunk[j] and chunk[j].msg or "", ", ", i, ", ", j)
						LS_ShapesWindow.doc = LS_ShapesWindow.docList[i]
						LS_ShapesWindow.swatchDoc = i
						LS_ShapesWindow.swatchLayer = chunk[j].id and chunk[j].id or -1 --print(msg - self.SELECTSWATCH, ", ", LS_ShapesWindow.swatchDoc, ", ", LS_ShapesWindow.swatchLayer)
						break
					end
				end
			end

			if reopen then
				self.dummyList:SetSelItem(self.dummyList:GetItem(0), false)
				if (LS_ShapesWindow.dlog) then
					LS_ShapesWindow.dlog = nil
					LS_ShapesWindow.shouldReopen = true
				end
			end
			self:Update()
			self:UpdateColor(moho)
			self.swatchMenu:UncheckAll()
			self.swatchMenu:SetChecked(msg, true) --self.swatchMenuPopup:Redraw()
			helper:delete() --20240102-0425: This was missing for some reason and that seemed the cause for all the open documents mess?? (TBO!)
			return
		elseif (msg == self.SELECTSWATCH + self:CountRealItems(self.swatchMenu, self.SELECTSWATCH) - 4) then --print("Custom Swatches...") -- Custom Swatches...

		elseif (msg == self.SELECTSWATCH + self:CountRealItems(self.swatchMenu, self.SELECTSWATCH) - 3) then --print("Use Selection") -- Use Selection
			LS_ShapesWindow.swatch = -2
		elseif (msg == self.SELECTSWATCH + self:CountRealItems(self.swatchMenu, self.SELECTSWATCH) - 2) then --print("Edit Current Swatch") -- Edit Current Swatch
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
					if not (moho.layer:HasAction("SLIDER") and moho.layer:HasAction("SLIDER 2")) then
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
		elseif (msg == self.SELECTSWATCH + self:CountRealItems(self.swatchMenu, self.SELECTSWATCH) - 1) then --print("Reload Swatches")
			LS_ShapesWindow.docList = {}
			LS_ShapesWindow.docsLoaded = false
			self.swatchMenu:RemoveAllItems()
			LS_ShapesWindow:IsEnabled(moho)
			--self:UpdateColor(moho)
		else
			--LS_ShapesWindow.swatch = math.abs((self.SELECTSWATCH + 3) - msg) print(LS_ShapesWindow.swatch)
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
	local layersSel = doc and doc:CountSelectedLayers() or 1
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

	local undoable, multiUndoable = true, false
	if ((msg >= self.MENU1 and msg < self.FILLED) or msg == self.MODE or msg == self.CHANGE or msg == self.BASE_SHAPE or msg == self.BASE_SHAPE_ALT or msg == self.TOP_SHAPE or msg == self.TOP_SHAPE_ALT or msg == self.SELECTALL or msg == self.SELECTALL_ALT or msg == self.SELECTMATCHING or msg == self.SELECTMATCHING_ALT or msg == self.CHECKERSEL or msg == self.COPY or msg == self.COLORSLIDER or (msg >= self.FILLCOLOR and msg <= self.FILLCOLOR_END) or (msg >= self.LINECOLOR and msg <= self.LINECOLOR_END)) then
		undoable = false
	end
	if (msg == self.APPLY or msg == self.APPLY_ALT) then
		if (LS_ShapesWindow.multiMenuMode >=3 and LS_ShapesWindow.multiMenuMode <= 4) then
			multiUndoable = layersSel > 1
		end
	end
	if (doc ~= nil and undoable) then
		if (multiUndoable == true) then
			doc:PrepMultiUndo()
		else
			doc:PrepUndo(lDrawing)
		end
		doc:SetDirty()
	end

	if (msg == self.CHANGE) then
		if doc == nil and mesh == nil then
			self:Update()
			helper:delete()
			return 
		end
		if LS_ShapesWindow.mode < 2 then -- SHAPE Modes
			if self.skipBlock == true then -- Try to avoid unwanted call to Update/UpdateWidgets bellow upon selecting, no matter how, a list item!
				if LS_ShapesWindow.pointsBasedSel and not (toolName:find("SelectShape" or toolName:find("Freehand" or toolName:find("Brush") or toolName:find("Eraser")))) then --if (LS_ShapesWindow.pointsBasedSel and toolName:find("SelectPoints")) then
					if shapesSel == 0 then
						self.count = 0
					end
					if self.count and self.count == shapesSel then
						--self:Update()
						--if toolName:find("SelectShape") then -- Use this solution instead of UpdateUI() bellow? It's quicker cause doesn't update the entire UI, but e.g. Style window could get outdated!
							--LM_SelectShape:UpdateWidgets(moho)
						--end
						moho:UpdateUI() -- 20240110-0228: This seems the culprit for the freehand/eraser line width resicing issue in BETA 1! 🤔 But why the same doesn't apply to BETA 2.1?
						self.count = 0
					end
					self.count = self.count + 1
				end
				helper:delete()
				return -- 20230920-2103: Commented, since it seems to make dialog's widgets not update propertly... 20231006-2004: But now it's uncommented and works? 🤔
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
				if LS_ShapesWindow.pointsBasedSel and not (toolName:find("SelectShape" or toolName:find("Freehand" or toolName:find("Brush") or toolName:find("Eraser")))) then
					for i = 0, mesh:CountShapes() - 1 do
						local shape = mesh:Shape(i)
						if shape.fSelected == true then -- Select selected shape's points
							shape:SelectAllPoints()
						else -- 20231018-1645 TODO: There's an issue around all this and different shapes sharing points (e.g. if you select all shapes of a Grid WITH stroke).
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
					if toolName:find("SelectShape") then -- This will be quicker than UpdateUI(), but then Style window wouldn't update accordingly to selected item by list.
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
		else -- STYLE Mode
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
				if (self.tempShape ~= nil and styleSel) then
					self.tempShape.fInheritedStyleName:Set(styleSel.fUUID ~= nil and styleSel.fUUID:Buffer() or LM.String:new_local(""))
					--[[
					if styleSel.fDefineFillCol == true then
						self.tempShape.fMyStyle.fFillCol:SetValue(lDrawingFrame, styleSel.fFillCol.value)
					end
					if styleSel.fDefineLineCol == true then
						self.tempShape.fMyStyle.fLineCol:SetValue(lDrawingFrame, styleSel.fLineCol.value)
					end
					self.tempShape.fMyStyle.fLineWidth = styleSel.fDefineLineWidth == true and styleSel.fLineWidth or self.tempShape.fMyStyle.fLineWidth
					self.tempShape.fMyStyle.fLineCaps = styleSel.fLineCaps
					if (styleSel.fBrushName and styleSel.fBrushName:Buffer() ~= "") then
						self.tempShape.fMyStyle.fBrushName = styleSel.fBrushName
						self.tempShape.fMyStyle.fBrushIsColor = styleSel.fBrushIsColor --?
						self.tempShape.fMyStyle.fBrushAlign = styleSel.fBrushAlign
						self.tempShape.fMyStyle.fBrushRandomOrder = styleSel.fBrushRandomOrder
						self.tempShape.fMyStyle.fBrushMergedAlpha = styleSel.fBrushMergedAlpha
						self.tempShape.fMyStyle.fBrushTint = styleSel.fBrushTint
						self.tempShape.fMyStyle.fBrushRandomize = styleSel.fBrushRandomize
						self.tempShape.fMyStyle.fBrushJitter = styleSel.fBrushJitter
						self.tempShape.fMyStyle.fBrushSpacing = styleSel.fBrushSpacing
						self.tempShape.fMyStyle.fBrushSizeVariationAmp = styleSel.fBrushSizeVariationAmp
						self.tempShape.fMyStyle.fBrushSizeVariationScale = styleSel.fBrushSizeVariationScale
						self.tempShape.fMyStyle.fBrushRandomInterval = styleSel.fBrushRandomInterval
						self.tempShape.fMyStyle.fBrushAngleDrift = styleSel.fBrushAngleDrift
					end
					--]]
					moho:UpdateUI()
				end
				self:Update()
			end
		end
	elseif (msg == self.MODE) then
		if LS_ShapesWindow.mode < 2 then -- if SHAPE Modes
			if (mesh ~= nil and LS_ShapesWindow.mode == 1) then
				if shapeID and shapeID >= 0 then
					if not LS_ShapesWindow.pointsBasedSel then
						moho:DeselectShapes()
					else
						mesh:SelectNone()
					end
					self.selItem = 0
					MOHO.Redraw()
				end
			end
			LS_ShapesWindow.mode = 2
		elseif LS_ShapesWindow.mode == 2 then -- if STYLE Mode
			local mode
			if mesh ~= nil then
				mode = LS_ShapesWindow:StyleLeaver(moho, mesh)
			else
				--20231205-1925: Do nothing for now, among other things, cause it would require the creation of a temp vector layer, which would be visible for a sec upon the necessary UpdateUI...
			end
			LS_ShapesWindow.mode = 0
			self.selItem = 0
		end
		self:Update()
	elseif (msg == self.NAME) then
		if (shapeID and shapeID >= 0) then
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
		--LS_ShapesWindowDialog:DrawItem(mesh, {close = true, height = pHeight, {0,0.5,0.391379}, {0.5,0,0.391379}, {0,-0.5,0.391379}, {-0.5,0,0.391379}}) -- DELETE!
		if moho:CreateShape(true) then
			--shape = pMesh:Shape(0)
		end

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
			if (LS_ShapesWindow.pointsBasedSel and not toolName:find("SelectShape")) then
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
			if (LS_ShapesWindow.pointsBasedSel and not toolName:find("SelectShape")) then
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
				if (LS_ShapesWindow.pointsBasedSel and not toolName:find("SelectShape")) then
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
		if mesh:AnimatedShapeOrder() and lFrame ~= 0 then
			moho:UpdateUI()
		end
		self:Update()
	elseif (msg == self.LOWER or msg == self.LOWER_ALT) then
		for i = 0, shapes - 1 do
			if (mesh:Shape(i).fSelected) then
				mesh:LowerShape(i, msg == self.LOWER_ALT)
			end
		end
		MOHO.Redraw()
		if mesh:AnimatedShapeOrder() and lFrame ~= 0 then
			moho:UpdateUI()
		end
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
				if (LS_ShapesWindow.pointsBasedSel and not toolName:find("SelectShape")) then
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
				iStyle.fSelected = (msg == self.SELECTALL) and true or not iStyle.fSelected --20240102-2224: It seems to fail if only first item in list is selected... But why?
			end
		end
		moho:UpdateUI() -- It seems necessary in order to activate buttons accordingly list selection, plus it seems to solve the above note!
		self:Update()
		self.itemList:Redraw()
	elseif (msg == self.SELECTMATCHING or msg == self.SELECTMATCHING_ALT) then
		local count = 0
		local fillCol, lineCol
		if LS_ShapesWindow.mode < 2 then
			for i = 0, shapes - 1 do
				local iShape = mesh:Shape(i)
				if iShape and (mesh:ShapeID(iShape) ~= shapeID) then --and iShape:ArePropertiesEqual(shape)
					fillCol = (iShape.fMyStyle.fFillCol.value.r == shape.fMyStyle.fFillCol.value.r) and (iShape.fMyStyle.fFillCol.value.g == shape.fMyStyle.fFillCol.value.g) and (iShape.fMyStyle.fFillCol.value.b == shape.fMyStyle.fFillCol.value.b)
					lineCol = (iShape.fMyStyle.fLineCol.value.r == shape.fMyStyle.fLineCol.value.r) and (iShape.fMyStyle.fLineCol.value.g == shape.fMyStyle.fLineCol.value.g) and (iShape.fMyStyle.fLineCol.value.b == shape.fMyStyle.fLineCol.value.b)

					iShape.fSelected = fillCol and lineCol
					count = (fillCol and lineCol) and count + 1 or count
					if (msg == self.SELECTMATCHING_ALT) then
						if (fillCol and lineCol) and not iShape:ArePropertiesEqual(shape) then
							iShape.fSelected = false
							count = count - 1
						end
					end
					if iShape.fSelected == true and (LS_ShapesWindow.pointsBasedSel and not toolName:find("SelectShape")) then
						iShape:SelectAllPoints()
					end
				end	--print(i, ", ", tostring(iShape.fSelected), ", ", count)
			end
		else
			local style = (style and styleName ~= "") and style or styleSel
			local styleUUID = style.fUUID:Buffer()
			for i = 0, styles - 1 do
				local iStyle = doc:StyleByID(i)
				if iStyle ~= nil and (iStyle.fUUID:Buffer() ~= styleUUID) then
					fillCol = (iStyle.fFillCol.value.r == style.fFillCol.value.r) and (iStyle.fFillCol.value.g == style.fFillCol.value.g) and (iStyle.fFillCol.value.b == style.fFillCol.value.b) --and (iStyle.fFillCol.value.a == style.fFillCol.value.a)
					lineCol = (iStyle.fLineCol.value.r == style.fLineCol.value.r) and (iStyle.fLineCol.value.g == style.fLineCol.value.g) and (iStyle.fLineCol.value.b == style.fLineCol.value.b) --and (iStyle.fLineCol.value.a == style.fLineCol.value.a)

					iStyle.fSelected = fillCol and lineCol
					count = (fillCol and lineCol) and count + 1 or count
					if (msg == self.SELECTMATCHING_ALT) then
						if (fillCol and lineCol) and not iStyle:ArePropertiesEqual(style) then
							iStyle.fSelected = false
							count = count - 1
						end
					end
				end --print(i, ", ", tostring(iStyle.fSelected), ", ", count)
			end
			--[[20240109-0420: Previous, less functional, code...
			local style = (style and styleName ~= "") and style or styleSel --print(style.fName:Buffer())
			local styleUUID = style.fUUID:Buffer()
			for i = 0, styles - 1 do
				local iStyle = doc:StyleByID(i)
				if iStyle ~= nil and (iStyle.fUUID:Buffer() ~= styleUUID) and iStyle:ArePropertiesEqual(style) then
					iStyle.fSelected = true
					count = count + 1
				end
			end
			--]]
			if count > 0 then
				LS_ShapesWindow.mode = LS_ShapesWindow:StyleLeaver(moho, mesh, 2)
				moho:UpdateUI()
			end
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

						local chInfo = MOHO.MohoLayerChannel:new_local()
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
	elseif (msg == self.DELETE) or (msg == self.DELETE_ALT) then
		if (doc ~= nil) then
			local redraw
			local i = 0
			if LS_ShapesWindow.mode < 2 then -- SHAPE Modes
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
			else --STYLE Mode
				local host = layer
				if (msg == self.DELETE) then
					while i < doc:CountStyles() do
						local style = doc:StyleByID(i)
						if (style.fSelected) then
							redraw = redraw == nil and doc:IsStyleUsed(style, host) or redraw
							doc:RemoveStyle(style, nil)
						else
							i = i + 1
						end
					end
				else
					while i < doc:CountStyles() do
						local iStyle = doc:StyleByID(i)
						local delete = true
						if (iStyle and iStyle.fSelected) then
							for j = 0, doc:CountLayers() - 1 do
								local jLayer = doc:Layer(j)
								if doc:IsStyleUsed(iStyle, jLayer) then
									delete = false
									break
								end 
							end
							if delete then
								doc:RemoveStyle(iStyle, nil)
							else
								i = i + 1
							end
						else
							i = i + 1
						end
					end
					--[[
					while i < doc:CountStyles() do
						local iStyle = doc:StyleByID(i)
						if (iStyle and iStyle.fSelected) and not doc:IsStyleUsed(iStyle, host) then
							doc:RemoveStyle(iStyle, nil)
						else
							i = i + 1
						end
					end
					--]]
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
				--moho:NewKeyframe(CHANNEL_FILL)
				moho:UpdateUI()
			end
		end
	elseif (msg == self.FILLCOLOR_BEGIN) then
		self.editingColor = true
		self:HandleMessage(self.FILLCOLOR)
	elseif (msg == self.FILLCOLOR_END) then
		LS_ShapesWindow.multiMenuMode = 0
		if (LS_ShapesWindow.advanced and LS_ShapesWindow.swatch ~= -1) then
			self.multi1:SetValue(self.fillCol:Value().r)
			self.multi2:SetValue(self.fillCol:Value().g)
			self.multi3:SetValue(self.fillCol:Value().b)
			self.multi4:SetValue(self.fillCol:Value().a / 255 * 100) --(1 - self.fillCol:Value().a / 255) * 100
		end
		self.editingColor = false
	elseif (msg == self.FILLCOLOROVER) then --styleName ~= "" or (style1 and style1.fDefineLineWidth or style2 and style2.fDefineLineWidth)
		if (style ~= nil and (style1 and style1.fDefineFillCol) or (style2 and style2.fDefineFillCol) or (styleName ~= "")) then
			style.fDefineFillCol = not style.fDefineFillCol
		end
		if (mesh ~= nil and shape ~= nil) then
			--self.fillColOverride:Enable(shapeStyle1 and shapeStyle1.fDefineFillCol or shapeStyle2 and shapeStyle2.fDefineFillCol)
			--self.fillColOverride:SetValue(shape.fMyStyle.fDefineFillCol)
			shape.fMyStyle.fDefineFillCol = self.fillColOverride:Value()
		end
		MOHO.Redraw()
		moho:UpdateUI()
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
				--moho:NewKeyframe(CHANNEL_LINE)
				moho:UpdateUI()
			end
		end
	elseif (msg == self.LINECOLOR_BEGIN) then
		self.editingColor = true
		self:HandleMessage(self.LINECOLOR)
	elseif (msg == self.LINECOLOR_END) then
		LS_ShapesWindow.multiMenuMode = 1
		if (LS_ShapesWindow.advanced and LS_ShapesWindow.swatch ~= -1) then
			self.multi1:SetValue(self.lineCol:Value().r)
			self.multi2:SetValue(self.lineCol:Value().g)
			self.multi3:SetValue(self.lineCol:Value().b)
			self.multi4:SetValue(self.fillCol:Value().a / 255 * 100)
		end
		self.editingColor = false
	elseif (msg == self.LINECOLOROVER) then
		if (style ~= nil and (style1 and style1.fDefineLineCol) or (style2 and style2.fDefineLineCol) or (styleName ~= "")) then
			style.fDefineLineCol = not style.fDefineLineCol
		end
		if (mesh ~= nil and shape ~= nil) then
			--self.lineColOverride:Enable(shapeStyle1 and shapeStyle1.fDefineLineCol or shapeStyle2 and shapeStyle2.fDefineLineCol)
			--self.lineColOverride:SetValue(shape.fMyStyle.fDefineLineCol)
			shape.fMyStyle.fDefineLineCol = self.lineColOverride:Value()
		end
		MOHO.Redraw()
		moho:UpdateUI()
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
		if (style ~= nil and (style1 and style1.fDefineLineWidth) or (style2 and style2.fDefineLineWidth) or (styleName ~= "")) then
			style.fDefineLineWidth = not style.fDefineLineWidth
		end
		if (mesh ~= nil and shape ~= nil) then
			--self.lineWidthOverride:Enable(shapeStyle1 and shapeStyle1.fDefineLineWidth or shapeStyle2 and shapeStyle2.fDefineLineWidth)
			--self.lineWidthOverride:SetValue(shape.fMyStyle.fDefineLineWidth)
			shape.fMyStyle.fDefineLineWidth = self.lineWidthOverride:Value()
		end
		MOHO.Redraw()
		moho:UpdateUI()
	elseif (msg == self.ROUNDCAPS) then
		if (style ~= nil) then
			style.fLineCaps = self.capsBut:Value() and 1 or 0
		end
		if (mesh ~= nil) then
			for i = 0, shapes - 1 do
				local iShape = mesh:Shape(i)
				if (iShape.fSelected) then
					iShape.fMyStyle.fLineCaps = self.capsBut:Value() and 1 or 0
				end
			end
			MOHO.Redraw()
		else
			if (doc == nil) then
				self:Update()
			end
		end
		moho:UpdateUI()
	elseif (msg == self.BRUSH) then
		if (doc ~= nil) then
			if (style ~= nil) then
				style.fBrushName:Set("")
			end
			if (mesh ~= nil) then
				for i = 0, shapes - 1 do
					local iShape = mesh:Shape(i)
					if (iShape.fSelected) then
						iShape.fMyStyle.fBrushName:Set("")
					end
				end
				MOHO.Redraw()
			end
			moho:UpdateUI()
		else
			if (doc == nil) then
				self:Update()
			end
		end
	elseif (msg >= self.FILLED and msg <= self.FILLEDOUTLINED_ALT) then
		local m = msg - self.FILLED
		local creationMode = LM_CreateShape.creationMode
		if (mesh ~= nil and LS_ShapesWindow.mode < 2) then -- Shape Creation
			LM_CreateShape.creationMode = math.floor(m / 2) --- #self.createButtons
			LM_CreateShape:HandleMessage(moho, moho.view, msg % 2 == 0 and LM_CreateShape.CREATE or LM_CreateShape.CREATE_CONNECTED)
			LM_CreateShape.creationMode = creationMode
		elseif (doc ~= nil) then -- Style Creation
			local baseStyle = style --or self.tempShape.fMyStyle
			local newStyle = doc:AddStyle(MOHO.Localize("/Windows/Style/Style=Style") .. " " .. math.floor(doc:CountStyles() + 1))
			if (newStyle ~= nil) then
				--LS_ShapesWindow:MakeStyleNameUnique(doc, doc:CountStyles() - 1) --newStyle.fName:Set(newStyleName)
				newStyle.fFillCol = baseStyle.fFillCol
				newStyle.fLineCol = baseStyle.fLineCol
				newStyle.fLineWidth = baseStyle.fLineWidth
				newStyle.fLineCaps = baseStyle.fLineCaps
				newStyle.fBrushName = baseStyle.fBrushName
				if (msg == self.FILLED) then
					newStyle.fDefineFillCol = true
					newStyle.fDefineLineCol = false
				elseif (msg == self.OUTLINED) then
					newStyle.fDefineFillCol = false
					newStyle.fDefineLineCol = true
				elseif (msg == self.FILLEDOUTLINED) then
					newStyle.fDefineFillCol = true
					newStyle.fDefineLineCol = true
				end
				if style and styleName ~= "" then
					LS_ShapesWindow.mode = LS_ShapesWindow:StyleLeaver(moho, mesh, 2)
				end
				LS_ShapesWindow:StyleSelector(doc, doc:CountStyles() - 1)
				self:Update()
			end
		end
		moho:UpdateUI()
	elseif (msg == self.COPY or msg == self.PASTE) then
		if shape ~= nil then
			if msg == self.COPY then
				self.copiedShape = moho:NewShapeProperties()
				self.copiedStyle = self.copiedShape.fMyStyle
			else -- PASTE
				if mesh ~= nil and self.copiedStyle then
					for i = 0, shapes - 1 do
						local shape = mesh:Shape(i)
						if (shape.fSelected) then
							shape.fMyStyle = self.copiedStyle --shape:CopyStyleProperties(self.copiedStyle, false, false)
						end
					end
				end
			end
			MOHO.Redraw()
		else
			if style ~= nil then
				if msg == self.COPY then
					self.copiedShape = moho:NewShapeProperties()
					self.copiedStyle = moho:NewShapeProperties().fMyStyle
					if styleName ~= "" then -- 20240601-2010: The following code will only half work, e.g. possible effects will be discarded, though better than nothing according to note bellow... The question is, where CurrentEditStyle data is stored when using Style Window's Copy button? 🤔
						self.copiedShape:MakePlain()
						self.copiedShape.fMyStyle.fFillCol = moho:CurrentEditStyle().fFillCol
						self.copiedShape.fMyStyle.fLineCol = moho:CurrentEditStyle().fLineCol
						self.copiedShape.fMyStyle.fLineWidth = moho:CurrentEditStyle().fLineWidth
						self.copiedShape.fMyStyle.fLineCaps = moho:CurrentEditStyle().fLineCaps
						self.copiedShape.fMyStyle.fBrushName = moho:CurrentEditStyle().fBrushName
						--self.copiedStyle.fMyStyle = moho:CurrentEditStyle() -- 20240601-2010: This seems to cause problems for STYLE mode to work! (I guess due to it makes think the mode system you're still editing the copied style?) 
					else
						self.copiedStyle = self.copiedShape.fMyStyle
					end
				else -- PASTE
					if mesh ~= nil and self.copiedStyle then
						moho:PickStyleProperties(self.copiedShape)
					end
				end
				MOHO.Redraw()
			end
		end
		self:Update()
		moho:UpdateUI()
	elseif (msg == self.RESET or msg == self.RESET_ALT) then
		local mohoLineWidth =  LS_ShapesWindow.MohoLineWidth --0.005556 * 2
		if (style ~= nil) then
			style.fFillCol:SetValue(lDrawingFrame, MOHO.MohoGlobals.FillCol)
			style.fLineCol:SetValue(lDrawingFrame, MOHO.MohoGlobals.LineCol)
			style.fLineWidth = mohoLineWidth
			style.fLineCaps = 1
			if msg == self.RESET_ALT then
				style.fBrushName = LM.String:new_local("")
			end
			MOHO.Redraw()
		else --?? (TBC)
			if LS_ShapesWindow.advanced then 
				self.fillCol:SetValue(MOHO.MohoGlobals.FillCol)
				self.lineCol:SetValue(MOHO.MohoGlobals.LineCol)
				self.lineWidth:SetValue(mohoLineWidth * docH)
				self.capsBut:SetValue(true)
				self.brushBut:SetValue(false)
				--helper:delete()
				--return
			end
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
						--shape.fMyStyle.fBrushName = LM.String:new_local("")
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
	elseif (msg == self.COLORSWAP) then
		local fillCol, lineCol = LM.rgb_color:new_local(), LM.rgb_color:new_local()
		fillCol.r, fillCol.g, fillCol.b, fillCol.a = self.fillCol:Value().r, self.fillCol:Value().g, self.fillCol:Value().b, self.fillCol:Value().a
		lineCol.r, lineCol.g, lineCol.b, lineCol.a = self.lineCol:Value().r, self.lineCol:Value().g, self.lineCol:Value().b, self.lineCol:Value().a

		self.editingColor = true
		self.fillCol:SetValue(lineCol)
		self:HandleMessage(self.FILLCOLOR)
		self.lineCol:SetValue(fillCol)
		self:HandleMessage(self.LINECOLOR)
		self.editingColor = false
		if (doc == nil) then
			self:Update()
		end
		moho:UpdateUI()
	elseif (msg == self.STYLESWAP) then
		local style1, style2
		if (shape ~= nil) then
			for i = 0, shapes - 1 do
				local iShape = mesh:Shape(i)
				if (iShape.fSelected) then
					style1, style2 = iShape.fInheritedStyle, iShape.fInheritedStyle2
					iShape.fInheritedStyle = style2
					iShape.fInheritedStyle2 = style1
				end
			end
			MOHO.Redraw()
		else
			if (self.tempShape ~= nil) then
				style1, style2 = self.tempShape.fInheritedStyleName:Buffer(), self.tempShape.fInheritedStyleName2:Buffer()
				if (doc ~= nil) then
					self.tempShape.fInheritedStyleName:Set(style2)
					self.tempShape.fInheritedStyleName2:Set(style1)
				else
					self.tempShape.fInheritedStyleName = LM.String:new_local("")
					self.tempShape.fInheritedStyleName2 = LM.String:new_local("")
					self:Update()
				end
			end
		end
		moho:UpdateUI()
	elseif (msg >= self.MULTI1 and msg < self.APPLY) then
		local col = LM.rgb_color:new_local()
		if LS_ShapesWindow.multiMenuMode == 0 then -- Fill
			col.r = LM.Clamp(self.multi1:IntValue(), 0, 255) self.multi1:SetValue(col.r)
			col.g = LM.Clamp(self.multi2:IntValue(), 0, 255) self.multi2:SetValue(col.g)
			col.b = LM.Clamp(self.multi3:IntValue(), 0, 255) self.multi3:SetValue(col.b)
			col.a = LM.Clamp(self.multi4:FloatValue() * 255, 0, 255) self.multi4:SetValue(col.a / 255) --col.a = LM.Clamp(self.multi4:IntValue() / 100 * 255, 0, 255) self.multi4:SetValue(col.a / 255 * 100) --> Non-PercentageMode version
			self.fillCol:SetValue(col)
			self:HandleMessage(self.FILLCOLOR)
		elseif LS_ShapesWindow.multiMenuMode == 1 then -- Stroke
			col.r = LM.Clamp(self.multi1:IntValue(), 0, 255) self.multi1:SetValue(col.r)
			col.g = LM.Clamp(self.multi2:IntValue(), 0, 255) self.multi2:SetValue(col.g)
			col.b = LM.Clamp(self.multi3:IntValue(), 0, 255) self.multi3:SetValue(col.b)
			col.a = LM.Clamp(self.multi4:FloatValue() * 255, 0, 255) self.multi4:SetValue(col.a / 255)
			self.lineCol:SetValue(col)
			self:HandleMessage(self.LINECOLOR)
		elseif LS_ShapesWindow.multiMenuMode == 2 then -- FX Transform
			if (mesh ~= nil and shape ~= nil) then
				local offset = LM.Vector2:new_local() offset:Set(self.multi1:FloatValue(), self.multi2:FloatValue()) 
				local rotation, scale = self.multi3:FloatValue(), self.multi4:FloatValue()
				for i = 0, shapes - 1 do
					local iShape = mesh:Shape(i)
					if (iShape.fSelected) then
						if (iShape:HasPositionDependentStyles()) then
							iShape.fEffectOffset:SetValue(lDrawingFrame, offset)
							iShape.fEffectRotation:SetValue(lDrawingFrame, math.rad(rotation))
							iShape.fEffectScale:SetValue(lDrawingFrame, scale)
						end
					end
				end
				MOHO.Redraw()
				moho:UpdateUI()
			end
		elseif LS_ShapesWindow.multiMenuMode == 3 or LS_ShapesWindow.multiMenuMode == 4 then -- Recolor (RGB/HSB)
			newVal[1], newVal[2], newVal[3], newVal[4] = self.multi1:IntValue(), self.multi2:IntValue(), self.multi3:IntValue(), self.multi4:IntValue()
			if LS_ShapesWindow.multiMenuMode == 3 then
				if (newVal[1] < -255 or newVal[1] > 255) then -- R
					newVal[1] = LM.Clamp(newVal[1], -255, 255)
					self.multi1:SetValue(newVal[1])
				elseif (newVal[2] < -255 or newVal[2] > 255) then -- G
					newVal[2] = LM.Clamp(newVal[2], -255, 255)
					self.multi2:SetValue(newVal[2])
				elseif (newVal[3] < -255 or newVal[3] > 255) then -- B
					newVal[3] = LM.Clamp(newVal[3], -255, 255)
					self.multi3:SetValue(newVal[3])
				elseif (newVal[4] < 0 or newVal[4] > 100) then -- A
					newVal[4] = LM.Clamp(newVal[4], 0, 1)
					self.multi4:SetValue(newVal[4])
				end
			else
				if (newVal[1] < -360 or newVal[1] > 360) then -- Hue
					newVal[1] = LM.Clamp(newVal[1], -360, 360)
					self.multi1:SetValue(newVal[1])
				elseif (newVal[2] < -100 or newVal[2] > 100) then --Sat
					newVal[2] = LM.Clamp(newVal[2], -100, 100)
					self.multi2:SetValue(newVal[2])
				elseif (newVal[3] < -100 or newVal[3] > 100) then --Bri
					newVal[3] = LM.Clamp(newVal[3], -100, 100)
					self.multi3:SetValue(newVal[3])
				end
			end
			LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode][1] = self.multi1:IntValue()
			LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode][2] = self.multi2:IntValue()
			LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode][3] = self.multi3:IntValue()
			LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode][4] =  LS_ShapesWindow.multiMenuMode == 3 and self.multi4:FloatValue() or self.multi4:IntValue()
			moho:UpdateUI() -- 20240207-1945: This seems to make that confirm with enter key alse work here?
		end
	elseif (msg == self.APPLY or msg == self.APPLY_ALT) then
		if LS_ShapesWindow.multiMenuMode == 3 or LS_ShapesWindow.multiMenuMode == 4 then -- Recolor (RGB/HSB)
			local colTable = {LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode][1], LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode][2], LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode][3], LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode][4] * 255}
			local randomize = msg == self.APPLY_ALT
			for l = 0, layersSel - 1 do
				local layer = doc:GetSelectedLayer(l)
				if (layer:LayerType() == MOHO.LT_VECTOR) then
					mesh = moho:LayerAsVector(layer):Mesh()
					shapes = mesh:CountShapes()
					--if mesh ~= nil then
					for i = shapes -1, 0, -1 do
						local iShape = mesh:Shape(i)
						--[[20240208-0516: Doesn't work as expected, so using again the one bellow for now...
						if randomize then
							for k, v in ipairs(colTable) do --print(k, ", ", v)
								if k ~= 4 and v ~= 0 then
									if v > 0 then
										colTable[k] = math.random(0, v)
									else
										colTable[k] = math.random(v, 0)
									end
								end
							end
							--print ("Random is: ", colTable[1], ", ", colTable[2], ", ", colTable[3])
						end
						--]]
						if randomize then
							if LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode][1] ~= 0 then
								if LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode][1] > 0 then
									colTable[1] = math.random(0, LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode][1])
								else
									colTable[1] = math.random(LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode][1], 0)
								end
							end
							if LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode][2] ~= 0 then
								if LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode][2] > 0 then
									colTable[2] = math.random(0, LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode][2])
								else
									colTable[2] = math.random(LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode][2], 0)
								end
							end
							if LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode][3] ~= 0 then
								if LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode][3] > 0 then
									colTable[3] = math.random(0, LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode][3])
								else
									colTable[3] = math.random(LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode][3], 0)
								end
							end
							--print ("Random is: ", colTable[1], ", ", colTable[2], ", ", colTable[3])
						end

						local fillColor = iShape.fMyStyle.fFillCol:GetValue(lDrawingFrame):AsColorStruct()
						local lineColor = iShape.fMyStyle.fLineCol:GetValue(lDrawingFrame):AsColorStruct()
						local holdFillColor, holdLineColor = fillColor, lineColor
						--print ("Starting color is: ", ", ", holdFillColor.r, ", ", holdFillColor.g, ", ", holdFillColor.b)
						fillColor = LS_ShapesWindow.multiMenuMode == 3 and LS_ShapesWindow:alterRGB(holdFillColor, colTable) or LS_ShapesWindow:alterHSB(holdFillColor, colTable)
						lineColor = LS_ShapesWindow.multiMenuMode == 3 and LS_ShapesWindow:alterRGB(holdLineColor, colTable) or LS_ShapesWindow:alterHSB(holdLineColor, colTable)
						---[[Recoloring in only one step is not possible due to UI space limitations (but at least values are remembered between modes)
						--holdFillColor = fillColor
						--fillColor = LS_ShapesWindow:alterHSB(holdFillColor, colTable)
						--]]
			
						if (shape and iShape.fSelected) then -- Affect only current layer's selected shapes
							--print ("Ending fillColor is: ", fillColor.r, ", ", fillColor.g, ", ", fillColor.b)
							if MOHO.hasbit(LS_ShapesWindow.multiMenuFlags, MOHO.bit(1)) then
								iShape.fMyStyle.fFillCol:SetValue(lDrawingFrame, fillColor)
								iShape.fMyStyle.fFillCol:StoreValue()
							end
							if MOHO.hasbit(LS_ShapesWindow.multiMenuFlags, MOHO.bit(2)) then
								iShape.fMyStyle.fLineCol:SetValue(lDrawingFrame, lineColor)
								iShape.fMyStyle.fLineCol:StoreValue()
							end
						elseif (not shape or layersSel > 1) then -- Affect all shapes along all selected layers
							--print ("Ending fillColor is: ", fillColor.r, ", ", fillColor.g, ", ", fillColor.b)
							if MOHO.hasbit(LS_ShapesWindow.multiMenuFlags, MOHO.bit(1)) then
								iShape.fMyStyle.fFillCol:SetValue(lDrawingFrame, fillColor)
								iShape.fMyStyle.fFillCol:StoreValue()
							end
							if MOHO.hasbit(LS_ShapesWindow.multiMenuFlags, MOHO.bit(2)) then
								iShape.fMyStyle.fLineCol:SetValue(lDrawingFrame, lineColor)
								iShape.fMyStyle.fLineCol:StoreValue()
							end
						end
					end
				end
			end
			MOHO.Redraw()
			moho:UpdateUI()
		end
	elseif (msg >= self.MULTI and msg < self.SELECTSTYLE1) then
		local multiMenuBak = LS_ShapesWindow.multiMenuMode
		local values = {self.multi1:IntValue(), self.multi2:IntValue(), self.multi3:IntValue(), self.multi4:IntValue()}
		
		if (msg >= self.MULTI and msg <= self.MULTI + 4) then -- Menu Modes
			if tool and tool.prevMousePt then
				--tool.prevMousePt:Set(0, 0)
			end
			LS_ShapesWindow.multiMenuRules = true
			LS_ShapesWindow.multiMenuMode = msg - self.MULTI
			LS_ShapesWindow.multiMenuLast = msg - self.MULTI < 2 and msg - self.MULTI or 0
		elseif (msg >= self.MULTI + 5 and msg <= self.MULTI + 9) then -- Menu Actions
			if (msg == self.MULTI + 5) then -- Copy HEX
				moho:CopyText(MOHO.Rgb2Hex(values[1], values[2], values[3]))
				self.multiMenu:SetChecked(multiMenuBak - self.MULTI, true) --self.multiMenuPopup:Redraw()
				LS_ShapesWindow.multiMenuMode = multiMenuBak
			elseif (msg == self.MULTI + 6) then -- Copy Values
				LS_ShapesWindow.multiValues.clipboard = {self.multi1:Value(), self.multi2:Value(), self.multi3:Value(), self.multi4:Value()}
			elseif (msg == self.MULTI + 7) then -- Paste Values
				if (LS_ShapesWindow.multiValues.clipboard ~= nil) then
					if LS_ShapesWindow.multiMenuMode == 2 then -- FX Transform
						if (mesh ~= nil and shape ~= nil) then
							for i = 0, shapes - 1 do
								local iShape = mesh:Shape(i)
								if (iShape.fSelected) then
									if (iShape:HasPositionDependentStyles()) then
										local offset = LM.Vector2:new_local() offset:Set(LS_ShapesWindow.multiValues.clipboard[1], LS_ShapesWindow.multiValues.clipboard[2])
										iShape.fEffectOffset:SetValue(lDrawingFrame, offset)
										iShape.fEffectRotation:SetValue(lDrawingFrame, LS_ShapesWindow.multiValues.clipboard[3])
										iShape.fEffectScale:SetValue(lDrawingFrame, LS_ShapesWindow.multiValues.clipboard[4] / 100)
									end
								end
							end
							MOHO.Redraw()
							moho:UpdateUI()
						end
					elseif LS_ShapesWindow.multiMenuMode == 3 or LS_ShapesWindow.multiMenuMode == 4 then -- Recolor (RGB/HSB)
						LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode] = LS_ShapesWindow.multiValues.clipboard
					end
					MOHO.Redraw()
				else
					LM.Beep()
				end
			elseif (msg == self.MULTI + 8) then -- Reset Values
					if LS_ShapesWindow.multiMenuMode == 2 then -- FX Transform
						if (mesh ~= nil and shape ~= nil) then
							for i = 0, shapes - 1 do
								local iShape = mesh:Shape(i)
								if (iShape.fSelected) then
									if (iShape:HasPositionDependentStyles()) then
										iShape.fEffectOffset:SetValue(lDrawingFrame, lDrawingFrame == 0 and LM.Vector2:new_local() or iShape.fEffectOffset:GetValue(0))
										iShape.fEffectRotation:SetValue(lDrawingFrame, lDrawingFrame == 0 and 0 or iShape.fEffectRotation:GetValue(0))
										iShape.fEffectScale:SetValue(lDrawingFrame, lDrawingFrame == 0 and 1 or (iShape.fEffectScale:GetValue(0)))
									end
								end
							end
							MOHO.Redraw()
							moho:UpdateUI()
						end
					elseif LS_ShapesWindow.multiMenuMode == 3 or LS_ShapesWindow.multiMenuMode == 4 then -- Recolor (RGB/HSB)
						LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode] = {0, 0, 0, 0} --for i = 1, #LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode] do LS_ShapesWindow.multiValues[LS_ShapesWindow.multiMenuMode][i] = 0 end
					end
			elseif (msg == self.MULTI + 9) then -- Invert Color
				local col = LM.rgb_color:new_local()
				if LS_ShapesWindow.multiMenuMode == 0 or LS_ShapesWindow.multiMenuMode == 1 then -- 20240207-1825: It should work individally, accordingly to selected shapes!
					col.r = LM.Clamp(self.multi1:IntValue(), 0, 255) self.multi1:SetValue(col.r)
					col.g = LM.Clamp(self.multi2:IntValue(), 0, 255) self.multi2:SetValue(col.g)
					col.b = LM.Clamp(self.multi3:IntValue(), 0, 255) self.multi3:SetValue(col.b)
					col = LM.ColorOps:InvertColor(col.r, col.g, col.b)
					col.a = LM.Clamp(self.multi4:FloatValue() * 255, 0, 255) self.multi4:SetValue(col.a / 255) --col.a = LM.Clamp(self.multi4:IntValue() / 100 * 255, 0, 255) self.multi4:SetValue(col.a / 255 * 100) --> Non-PercentageMode version

					if LS_ShapesWindow.multiMenuMode == 0 then
						self.fillCol:SetValue(col)
						self:HandleMessage(self.FILLCOLOR)
					else
						self.lineCol:SetValue(col)
						self:HandleMessage(self.LINECOLOR)
					end
				end
			end
		else -- Menu Options
			if (msg == self.MULTI + 10) then -- Affects Fills
				if MOHO.hasbit(LS_ShapesWindow.multiMenuFlags, MOHO.bit(1)) then
					LS_ShapesWindow.multiMenuFlags = MOHO.clearbit(LS_ShapesWindow.multiMenuFlags, MOHO.bit(1))
				else
					LS_ShapesWindow.multiMenuFlags = MOHO.setbit(LS_ShapesWindow.multiMenuFlags, MOHO.bit(1))
				end
			elseif (msg == self.MULTI + 11) then -- Affects Strokes
				if MOHO.hasbit(LS_ShapesWindow.multiMenuFlags, MOHO.bit(2)) then
					LS_ShapesWindow.multiMenuFlags = MOHO.clearbit(LS_ShapesWindow.multiMenuFlags, MOHO.bit(2))
				else
					LS_ShapesWindow.multiMenuFlags = MOHO.setbit(LS_ShapesWindow.multiMenuFlags, MOHO.bit(2))
				end
			end
			if not MOHO.hasbit(LS_ShapesWindow.multiMenuFlags, MOHO.bit(1)) and not MOHO.hasbit(LS_ShapesWindow.multiMenuFlags, MOHO.bit(2)) then
				LS_ShapesWindow.multiMenuFlags = MOHO.setbit(LS_ShapesWindow.multiMenuFlags, MOHO.bit(msg == self.MULTI + 10 and 2 or 1)) -- Not only ensures at least one if both is checked but also so a switch!
			end
			--print(LS_ShapesWindow.multiMenuFlags)
		end
		self:Update()
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
		--self.style1Menu:UncheckAll()
		--self.style1Menu:SetChecked(self.SELECTSTYLE1, true)
		--self:Update()
	elseif (msg >= self.SELECTSTYLE2 and msg < self.SELECTBRUSH ) then
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
	elseif (msg >= self.SELECTBRUSH and msg < self.MSG_LIMIT) then
		local itemIndex, itemLabel = msg - self.SELECTBRUSH, self.brushMenu:ItemLabel(msg)
		if (msg >= self.SELECTBRUSH and msg <= self.SELECTBRUSH + 1) then
			if (msg == self.SELECTBRUSH) then -- List Factory Brushes Only
				LS_ShapesWindow.brushDirectory = MOHO.hasbit(LS_ShapesWindow.brushDirectory, 1) and LS_ShapesWindow.brushDirectory - 1 or LS_ShapesWindow.brushDirectory + 1
			elseif (msg == self.SELECTBRUSH + 1) then -- List User Brushes Only
				LS_ShapesWindow.brushDirectory = MOHO.hasbit(LS_ShapesWindow.brushDirectory, 2) and LS_ShapesWindow.brushDirectory - 2 or LS_ShapesWindow.brushDirectory + 2
			end
			self.brushMenu:RemoveAllItems()
			LS_ShapesWindow.brushList = LS_ShapesWindow:BrushLoader(moho, LS_ShapesWindow.brushDirectory)
			self:Update()
			helper:delete()
			return
		elseif (msg >= self.SELECTBRUSH + 2 and msg < self.SELECTBRUSH + LS_ShapesWindowDialog:CountRealItems(self.brushMenu, self.SELECTBRUSH) - 1) then
			local brushName = LS_ShapesWindow.brushList[itemLabel]:match("[^/\\]+$")
			if (style ~= nil) then
				style.fBrushName:Set(brushName)
			end
			if (mesh ~= nil) then
				local forceRedraw
				for i = 0, shapes - 1 do
					local iShape = mesh:Shape(i)
					if (iShape.fSelected) then
						iShape.fMyStyle.fBrushName:Set(brushName)
						forceRedraw = forceRedraw == nil and true or forceRedraw
					end
				end
				if forceRedraw == true then -- 20240111-0313: For some reason, this seems to be the only way to really update brush change in viewport!
					doc:PrepUndo(layer, true)
					doc:Undo()
					--layer:UpdateCurFrame(true)
					--doc:Refresh()
					--moho.view:DrawMe()
					--moho.view:RefreshView()
				end
				MOHO.Redraw()
			else
				if (doc == nil) then
					self:Update()
				end
			end
			--self:Update()
			moho:UpdateUI()
		else
			helper:delete()
			return
		end
	elseif LM.GUI.MSG_CANCEL then -- Triggered upon auto-closing.
		--return
		--helper:delete()
	end
	--moho:UpdateUI()
	helper:delete()
end

function LS_ShapesWindowDialog:WhatMsg(msg, t) --(int, table) str
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

LS_ShapesWindowDialog.h = {} --h stands "help"
LS_ShapesWindowDialog.h.DLOG_UPDATE = MOHO.MSG_BASE

function LS_ShapesWindowDialog.h:new()
	local d = LM.GUI.SimpleDialog(LS_ShapesWindow:UILabel() .. " · " .. MOHO.Localize("/LS/ShapesWindow/QuickGuide=Quick Guide"), LS_ShapesWindowDialog.h) --"/Menus/Help/Help=Help"
	local l = d:GetLayout()

	l:PushH(LM.GUI.ALIGN_TOP, 0)
		l:PushV(LM.GUI.ALIGN_FILL, 0)
			l:AddPadding(86)

			d.i1_1 = LM.GUI.RadioButton("1.1", self.DLOG_UPDATE + 1)
			--d.i1_1:SetCursor(LM.GUI.Cursor("ScriptResources/../../Support/Scripts/Tool/lm_zoom_camera_cursor", 0, 0))
			--d.i1_1:SetToolTip("1_1 If you select all the points that conforms a shape, the shape/s gets also selected, thus you can work with it in palette.")
			l:AddChild(d.i1_1, LM.GUI.ALIGN_LEFT, 0)
			l:AddPadding(-1)
			d.i1_2 = LM.GUI.RadioButton("1.2", self.DLOG_UPDATE + 2)
			l:AddChild(d.i1_2, LM.GUI.ALIGN_LEFT, 0)
			l:AddPadding(-1)
			d.i1_3 = LM.GUI.RadioButton("1.3", self.DLOG_UPDATE + 3)
			l:AddChild(d.i1_3, LM.GUI.ALIGN_LEFT, 0)

			l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, 0)	l:AddPadding(-2)


			d.i1_4 = LM.GUI.RadioButton("1.4", self.DLOG_UPDATE + 4)
			l:AddChild(d.i1_4, LM.GUI.ALIGN_LEFT, 0)
			l:AddPadding(-1)
			d.i1_5 = LM.GUI.RadioButton("1.5", self.DLOG_UPDATE + 5)
			l:AddChild(d.i1_5, LM.GUI.ALIGN_LEFT, 0)
			l:AddPadding(-1)
			d.i1_6 = LM.GUI.RadioButton("1.6", self.DLOG_UPDATE + 6)
			l:AddChild(d.i1_6, LM.GUI.ALIGN_LEFT, 0)

			l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, 0) l:AddPadding(-2)

			d.i1_7 = LM.GUI.RadioButton("1.7", self.DLOG_UPDATE + 7)
			l:AddChild(d.i1_7, LM.GUI.ALIGN_LEFT, 0)
			l:AddPadding(-1)
			d.i1_8 = LM.GUI.RadioButton("1.8", self.DLOG_UPDATE + 8)
			l:AddChild(d.i1_8, LM.GUI.ALIGN_LEFT, 0)
			l:AddPadding(-1)
			d.i1_9 = LM.GUI.RadioButton("1.9", self.DLOG_UPDATE + 9)
			l:AddChild(d.i1_9, LM.GUI.ALIGN_LEFT, 0)
			l:AddPadding(-1)
			d.i1_10 = LM.GUI.RadioButton("1.9", self.DLOG_UPDATE + 10)
			l:AddChild(d.i1_10, LM.GUI.ALIGN_LEFT, 0)

			l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, 0) l:AddPadding(-2)

			d.i1_11 = LM.GUI.RadioButton("1.11", self.DLOG_UPDATE + 11)
			l:AddChild(d.i1_11, LM.GUI.ALIGN_LEFT, 0)

			l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, 0) l:AddPadding(-2)

			d.i1_12 = LM.GUI.RadioButton("1.12", self.DLOG_UPDATE + 12)
			l:AddChild(d.i1_12, LM.GUI.ALIGN_LEFT, 0)
			l:AddPadding(-1)
			d.i1_13 = LM.GUI.RadioButton("1.13", self.DLOG_UPDATE + 13)
			l:AddChild(d.i1_13, LM.GUI.ALIGN_LEFT, 0)
			l:AddPadding(-1)
			d.i1_14 = LM.GUI.RadioButton("1.14", self.DLOG_UPDATE + 14)
			l:AddChild(d.i1_14, LM.GUI.ALIGN_LEFT, 0)

			l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, 0) l:AddPadding(-2)

			d.i1_15 = LM.GUI.RadioButton("1.15", self.DLOG_UPDATE + 15)
			l:AddChild(d.i1_15, LM.GUI.ALIGN_LEFT, 0)

			l:AddPadding(315)

			d.i2_1 = LM.GUI.RadioButton("2.1", self.DLOG_UPDATE + 16)
			l:AddChild(d.i2_1, LM.GUI.ALIGN_LEFT, 0)
			l:AddPadding(-1)
			d.i2_2 = LM.GUI.RadioButton("2.2", self.DLOG_UPDATE + 17)
			l:AddChild(d.i2_2, LM.GUI.ALIGN_LEFT, 0)
			l:AddPadding(-1)
			d.i2_3 = LM.GUI.RadioButton("2.3", self.DLOG_UPDATE + 18)
			l:AddChild(d.i2_3, LM.GUI.ALIGN_LEFT, 0)
			l:AddPadding(-1)
			d.i2_4 = LM.GUI.RadioButton("2.4", self.DLOG_UPDATE + 19)
			l:AddChild(d.i2_4, LM.GUI.ALIGN_LEFT, 0)
			l:AddPadding(-1)
			d.i2_5 = LM.GUI.RadioButton("2.5", self.DLOG_UPDATE + 20)
			l:AddChild(d.i2_5, LM.GUI.ALIGN_LEFT, 0)

			l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, 0) l:AddPadding(-2)

			d.i2_6 = LM.GUI.RadioButton("2.6", self.DLOG_UPDATE + 21)
			l:AddChild(d.i2_6, LM.GUI.ALIGN_LEFT, 0)
			l:AddPadding(-1)
			d.i2_7 = LM.GUI.RadioButton("2.7", self.DLOG_UPDATE + 22)
			l:AddChild(d.i2_7, LM.GUI.ALIGN_LEFT, 0)
			l:AddPadding(-1)
			d.i2_8 = LM.GUI.RadioButton("2.8", self.DLOG_UPDATE + 23)
			l:AddChild(d.i2_8, LM.GUI.ALIGN_LEFT, 0)
			l:AddPadding(-1)
			d.i2_9 = LM.GUI.RadioButton("2.9", self.DLOG_UPDATE + 24)
			l:AddChild(d.i2_9, LM.GUI.ALIGN_LEFT, 0)

			l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, 0) l:AddPadding(-2)

			d.i2_10 = LM.GUI.RadioButton("2.10", self.DLOG_UPDATE + 25)
			l:AddChild(d.i2_10, LM.GUI.ALIGN_LEFT, 0)

			l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, 0) l:AddPadding(-2)

			l:AddPadding(d.i1_1:Height() - 1)
			d.i2_11 = LM.GUI.RadioButton("2.1+", self.DLOG_UPDATE + 26)
			l:AddChild(d.i2_11, LM.GUI.ALIGN_LEFT, 0)
			l:AddPadding(-1)
		l:Pop()
		d.helpImgBut = LM.GUI.ImageButton("ScriptResources/ls_shapes_window/HELP", "", false, LM.GUI.MSG_CANCEL, false)
		l:AddChild(d.helpImgBut, LM.GUI.ALIGN_FILL, 0)
		l:AddPadding(d.i1_1:Width())
	l:Pop()

	l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, 0)
	l:AddPadding(-12)
	d.t = LM.GUI.DynamicText("", 1080)
	d.t:SetValue("Click a label to turn this text into the description of its adjacent element, press <Esc / OK / Cancel / GIANT button> to close...")
	l:AddChild(d.t, LM.GUI.ALIGN_LEFT, 8)
	l:AddPadding(-10)

	return d
end

function LS_ShapesWindowDialog.h:HandleMessage(what) --print("LS_ShapesWindowDialog.h:OnOK " , os.clock())
	if (what == self.DLOG_UPDATE + 1) then
		self.t:SetValue("1.1 - If you select all the points that conforms a shape, the shape/s gets also selected, thus you can work with it in palette.")
	elseif (what == self.DLOG_UPDATE + 2) then
		self.t:SetValue("1.2 - Shapes in vector layers like \"Mesh Warps\" won't be listed (Curver and Auto-triangulated layers are always ignored anyway).")
	elseif (what == self.DLOG_UPDATE + 3) then
		self.t:SetValue("1.3 - It ensures \" Shapes Window\" always match status with Moho's Style window (at some performance cost).")
	
	elseif (what == self.DLOG_UPDATE + 4) then
		self.t:SetValue("1.4 - If checked, the window will appear upon opening the first document (intended to work in partnership with option below).")
	elseif (what == self.DLOG_UPDATE + 5) then
		self.t:SetValue("1.5 - Shows/Hides the button in \"Tools\" palette. It helps to save space there at the cost of losing keyboard shortcut, if any... Once hidden, go to \"Scripts -> Lost Scripts - Shapes Window\" to open.")
	elseif (what == self.DLOG_UPDATE + 6) then
		self.t:SetValue("1.6 - Enables/disables certain tooltips that may be useful at the beginning but annoying in the end...")
	
	elseif (what == self.DLOG_UPDATE + 7) then
		self.t:SetValue("1.7 - Hide or show widgets related to shape creation, either because you don't need them or to save vertical space.")
	elseif (what == self.DLOG_UPDATE + 8) then
		self.t:SetValue("1.8 - Make buttons, and therefore clickable area, larger (with the advantage of increasing Swatches and shape preview area a little bit too).")
	elseif (what == self.DLOG_UPDATE + 9) then
		self.t:SetValue("1.9 - Make the window as taller as possible (accordingly to viewport height).")
	elseif (what == self.DLOG_UPDATE + 10) then
		self.t:SetValue("1.10 - Provides some info about selected item/s, but uncheck it should you want to save some vertical space.")

	elseif (what == self.DLOG_UPDATE + 11) then
		self.t:SetValue("1.11 - Restores the script to its factory settings.")

	elseif (what == self.DLOG_UPDATE + 12) then
		self.t:SetValue("1.12 - It opens this help :D")
	elseif (what == self.DLOG_UPDATE + 13) then
		self.t:SetValue("1.13 - It takes you to the script page at \"www.lost-scripts.github.io\"")
	elseif (what == self.DLOG_UPDATE + 14) then
		self.t:SetValue("1.14 - It takes you to the page with the latest release of the script so you can compare versions (yours should appear at the end of the URL for easy comparison).")

	elseif (what == self.DLOG_UPDATE + 15) then
		self.t:SetValue("1.15 - Opens a window from which you can consult information about copyright/license, credits, version... ")

	elseif (what == self.DLOG_UPDATE + 16) then
		self.t:SetValue("2.1 - Controls act on fill color/opacity (auto-activates upon clicking on a fill with the Select Shape tool).")
	elseif (what == self.DLOG_UPDATE + 17) then
		self.t:SetValue("2.2 - Controls act on stroke color/opacity (auto-activates upon clicking near a stroke with the Select Shape tool).")
	elseif (what == self.DLOG_UPDATE + 18) then
		self.t:SetValue("2.3 - Controls act on Shape FX handles \"preciselly\" (auto-activates upon clicking on a shape FX handle with the Select Shape tool).")
	elseif (what == self.DLOG_UPDATE + 19) then
		self.t:SetValue("2.4 - Allows recoloring selected shapes' fill/stroke (as per OPTIONS below) in a RGBα fashion, hold <alt> upon pressing \"Apply\" to randomize coloring!")
	elseif (what == self.DLOG_UPDATE + 20) then
		self.t:SetValue("2.5 - Allows recoloring selected shapes' fill/stroke (as per OPTIONS below) in a much more intuitive HSB (Hue/Saturation/Brightness) way, hold <alt> upon pressing \"Apply\" to randomize coloring!")

	elseif (what >= self.DLOG_UPDATE + 21 and what <= self.DLOG_UPDATE + 25) then
		self.t:SetValue("2.6~10 - Several color related utilities...")

	elseif (what == self.DLOG_UPDATE + 26) then
		self.t:SetValue("2.1+ - Whether if recoloring should just affect fills, strokes or both.")

	elseif (what == LM.GUI.MSG_CANCEL or what == LM.GUI.MSG_OK) then
		MOHO.ScriptInterface:Click()
	end
end

function LS_ShapesWindowDialog.h:OnOK() --print("LS_ShapesWindowDialog.h:OnOK " , os.clock())
	LS_ShapesWindow.isHelpVisible = false
	LS_ShapesWindow.showHelp = true

	--LS_ShapesWindow.dlog.ipMenu:SetEnabled(LS_ShapesWindow.dlog.IP_MENU + 8, not LS_ShapesWindow.isHelpVisible)
	--LS_ShapesWindow.dlog:UpdateWidgets()
end

-- **************************************************
-- The guts of this script
-- **************************************************

function LS_ShapesWindow:IsEnabled(moho) --print("LS_ShapesWindow:IsEnabled(" .. tostring(moho.document:Name()) .. ")", " 🕗: " .. os.clock())
	if (not self.docsLoaded) then
		local swatchDir = moho:UserAppDir()
		if (swatchDir ~= "") then
			swatchDir = swatchDir .. '/Scripts/ScriptResources/ls_shapes_window/Swatches/'
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
			swatchDir = swatchDir .. '/Swatches/'
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

	if (LS_ShapesWindow.dlog == nil or true) then
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
	--self.defTool = (moho and moho.CurrentTool) and moho:CurrentTool() or "" --20240120-0123: This here makes Moho crash...

	if (not self.brushList) then
		self.brushList = LS_ShapesWindow:BrushLoader(moho, self.brushDirectory)
	end

	if self.defDoc ~= nil and self.defDoc:Name() ~= "-" then
		if self.dlog == nil and self.openOnStartup and self.shouldOpen and self.lastMOHO ~= tostring(MOHO) then
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
		--self.dlogBypass = LS_ShapesWindowDialog:new(moho) self.dlogBypass = nil -- dlogGuard, dlogShield, dlogBait, dlogTrap, dlogPatch (whatever... not necessary anymore!)
		self.dlog:DoModeless()
	else
		if (self.dlog and self.dlog.dummyList ~= nil and moho.document ~= nil) then
			self.dlog.dummyList:SetSelItem(self.dlog.dummyList:GetItem(0), false)
			self.dlog = nil
			self.shouldReopen = false
		else
			LM.Beep()
		end
	end
end

function MOHO.bitpos(x) --(int) int
	return math.max(0, math.floor(math.log(x, 2)) + 1) --math.ceil(x / 2) --math.ceil(x / 2) or 1
end

function MOHO.Rgb2Hex(r, g, b)
	return string.format("%02X%02X%02X", r, g, b)
end

function MOHO.String2Color(colorString) --(str) int, int, int, int
	local r, g, b, a = colorString:match("(%d+)%s+(%d+)%s+(%d+)%s+(%d+)")
	local c = LM.rgb_color:new_local()
	c.r = LM.Clamp(tonumber(r) or 0, 0, 255)
	c.g = LM.Clamp(tonumber(g) or 0, 0, 255)
	c.b = LM.Clamp(tonumber(b) or 0, 0, 255)
	c.a = LM.Clamp(tonumber(a) or 255, 0, 255)
	return c
end

function LS_ShapesWindow:alterRGB(col, t) -- Based on Mike Kelley's "mk_adjust_colors"
	col.r = LM.Clamp(col.r + t[1], 0, 255)
	col.g = LM.Clamp(col.g + t[2], 0, 255)
	col.b = LM.Clamp(col.g + t[3], 0, 255)
	col.a = LM.Clamp(col.g + t[4], 0, 255)
	return col
end

function LS_ShapesWindow:alterHSB(col, t) -- Based on Mike Kelley's "mk_adjust_colors"
	local myHSL = LM.rgb_color:new_local()
	myHSL.r, myHSL.g, myHSL.b = col.r, col.g, col.b
	local hslColor = self:convertRGB(myHSL)

	--set newColor with values of fillColor/lineColor plus changeColor
	hslColor.r = ((hslColor.r + t[1]) % 360) -- do hue
	hslColor.g = LM.Clamp(hslColor.g + t[2], 0, 100) -- do saturation
	hslColor.b = LM.Clamp(hslColor.b + t[3], 0, 100) -- do brightness

	myHSL = self:convertHSB(hslColor)
	col.r, col.g, col.b = myHSL.r, myHSL.g, myHSL.b
	return col
end

function LS_ShapesWindow:convertRGB(col) -- From Mike Kelley's "mk_adjust_colors"
--	Convert an RGB value into an HSL value.
	local max, min, dif = 0, 0, 0
	local brightness, saturation, hue = 0, 0, 0
	local hsl = col

--	Get the maximum and minimum RGB components.
	max = math.max(col.r, col.g, col.b)
	min = math.min(col.r, col.g, col.b)

	diff = max - min
	brightness = (max * 100) / 255
	if diff == 0 then
		hue = 0
		saturation = 0
	else
		saturation = (255 * diff) / max
		if col.r == max then
			hue = (col.g - col.b) / diff
		elseif col.g == max then
			hue = 2 + (col.b - col.r) / diff
		else
			hue = 4 + (col.r - col.g) / diff
		end

		hue = hue * 60
		if hue < 0 then hue = hue + 360 end
	end
	saturation = (saturation * 100) / 255

	hsl.r = math.floor(hue + .5)
	hsl.g = math.floor(saturation + .5)
	hsl.b = math.floor(brightness + .5)
	return hsl
end

function LS_ShapesWindow:convertHSB(col) -- From Mike Kelley's "mk_adjust_colors"
--	convert an HSB value into an RGB one
	local p1, p2 = 0.00, 0.00
	local R, G, B = 0, 0, 0
	local hsbcolor = col
	local saturation = col.g / 100
	local brightness = col.b / 100
	local hue = col.r / 60
	local i = math.floor(hue)
	local f = hue - i
	local p = brightness * (1 - saturation)
	local t = brightness * (1 - (saturation * (1 - f)))
	local q = brightness * (1 - (saturation * f))

	if i == 0 then
		R, G, B = brightness, t, p
	end
	if i == 1 then
		R, G, B = q, brightness, p
	end
	if i == 2 then
		R, G, B = p, brightness, t
	end
	if i == 3 then
		R, G, B = p, q, brightness
	end
	if i == 4 then
		R, G, B = t, p, brightness
	end
	if i == 5 or i == 6 then
		R, G, B = brightness, p, q
	end

	hsbcolor.r = math.floor(R * 255)
	hsbcolor.g = math.floor(G * 255)
	hsbcolor.b = math.floor(B * 255)
	return hsbcolor
end

function LS_ShapesWindow:CompareVersion(a, b) --(str, str) int, int -- Sorting an array of semantic versions or SemVer (https://medium.com/geekculture/sorting-an-array-of-semantic-versions-in-typescript-55d65d411df2)
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

function LS_ShapesWindow:SuitPath(path) --(str) str
	return (package.config:sub(1,1) == "\\" and path:gsub("/", "\\")) or path:gsub("\\", "/")
end

function LS_ShapesWindow:FileExists(filePath) --(str) bool
	filePath = self.SuitPath and self:SuitPath(filePath) or filePath
	local f = io.open(filePath, "r")
	return f ~= nil and io.close(f)
end

function LS_ShapesWindow:FirstExistingFile(dir, ...) --(str, ...str) str? -- Returns first existing file path, or nil
	for i = 1, select("#", ...) do
		local name = select(i, ...)
		local sep = dir:sub(-1) == "\\" and "" or "\\"
		local path = self:SuitPath(dir .. sep .. name) --local path = self:PathJoin(dir, name) --local path = dir .. sep .. name
		if self:FileExists(path) then
			return path
		end
	end
end --Usage: file = LS:FirstExistingFile(self.resPath, "LICENSE", "LICENSE.txt")

function LS_ShapesWindow:ReadFile(filePath, a) --(str, tbl?) tbl|str, int
	filePath = self:SuitPath(filePath)
	a = a or {}
	a.asString = a.asString or false
	a.from = a.from or 1
	a.to = a.to or 9999 -- Default max lines to prevent huge loads (overcome by using `to` named arg if necessary)

	if not self:FileExists(filePath) then return a.asString and "" or {}, a.from end

	local lines = {}
	for line in io.lines(filePath) do
		lines[#lines + 1] = line
	end

	a.to = math.min(a.to, #lines)
	if a.from > a.to then return a.asString and "" or {}, a.from end

	local out = {}
	for i = a.from, a.to do
		out[#out + 1] = lines[i]
	end

	return a.asString and table.concat(out, "\n") or out, a.from
end
--[[Usage:
local lines, offset = LS_ShapesWindow:ReadFile(file, {from = 4, to = 8}) -- As table
for i, line in ipairs(lines) do
	print((i + offset - 1) .. ": " .. line)
end

local lines = LS_ShapesWindow:ReadFile(file, {asString = true, to = 8}) print(lines, offset) -- As string
--]]

function LS_ShapesWindow:GetOS() --str
	return package.config:sub(1, 1) == "\\" and "win" or "unix"
end

function LS_ShapesWindow:Open(location) --(str) void
	if LS_ShapesWindow:GetOS() == "unix" then
		os.execute('open "" "' .. location .. '"')
	else
		os.execute('start "" "' .. location .. '"')
	end
end

function LS_ShapesWindow:LoadDocument(moho, docPath) --(MohoDoc, str) void
	local doc = moho:LoadDocument(docPath)
	if (doc ~= nil) then
		table.insert(self.docList, doc)
		if (self.doc == nil) then
			self.doc = doc
		end
	end
end

function LS_ShapesWindow:CountSelectedStyles(doc) --(MohoDoc) int
	local count = 0
	if doc ~= nil then
		for i = 0, doc:CountStyles() - 1 do -- Check if the name is already taken by another style and, if so, pick that style's reference ID
			local style = doc:StyleByID(i)
			if style.fSelected == true then
				count = count  + 1
			end
		end
	end
	return count
end

function LS_ShapesWindow:MakeStyleNameUnique(doc, id, jump) --(MohoDoc, int, int) void
	if (doc ~= nil and id ~= nil and doc:StyleByID(id) ~= nil) then
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

--[[20231218-2014: Using "StyleID" instead... Delete?
function LS_ShapesWindow:StyleIDByUUID(doc, UUID) --(MohoDoc, str) int
	if doc ~= nil and UUID ~= nil then
		for i = 0, doc:CountStyles() - 1 do
			if (doc:StyleByID(i).fUUID:Buffer() == UUID) then
				return i
			end
		end
	end
end
--]]

function LS_ShapesWindow:StyleID(doc, style) --(MohoDoc, M_Style) int
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

function LS_ShapesWindow:StyleLeaver(moho, mesh, mode) --(moho, M_Mesh, int) int -- StyleDeactivator?
	mesh = mesh or moho:DrawingMesh()
	if (moho ~= nil and mesh ~= nil) then
		local styleName = moho:CurrentEditStyle() and tostring(moho:CurrentEditStyle().fName:Buffer()) or ""
		if styleName ~= "" then
			local v = LM.Vector2:new_local() v:Set(0, -100)
			mesh:SelectNone()
			mesh:AddLonePoint(v, 0)
			v:Set(0, -100.0001)
			mesh:AppendPoint(v, 0)
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

function LS_ShapesWindow:StyleSelector(doc, id) --(MohoDoc, int) void
	for i = 0, doc:CountStyles() - 1 do
		local style = doc:StyleByID(i)
		if (style ~= nil) then
			style.fSelected = i == id
		end
	end
end

function LS_ShapesWindow:BrushLoader(moho, dir, variantDir) --(MohoDoc, int, bool) dic
	dir = (dir and dir > 0) and dir or 0 -- 1: Factory, 2: User, 4: ...
	variantDir = variantDir or false
	local bitPos = math.max(0, math.floor(math.log(dir, 2)) + 1)
	local dirTable, brushTable = {moho:AppDir(variantDir), moho:UserAppDir()}, {}
	if (bitPos > 0 and bitPos <= #dirTable) then
		--local bitDir = MOHO.bit(dir)
		for i = 1, #dirTable do
			if MOHO.hasbit(dir, MOHO.bit(i)) then
				local brushDir = dirTable[i] .. '/Brushes/'
				if (dirTable[i] ~= "") then
					moho:BeginFileListing(brushDir)
					local fileName = moho:GetNextFile()
					while fileName ~= nil do
						local itemPath = brushDir .. fileName
						local isFolder = lfs.attributes(itemPath, "mode") == "directory" --*💬
						local isValidFile = string.match(fileName, "%.png$") or string.match(fileName, "%.mohobrush$") --🖌
						if isFolder or isValidFile then
							fileName = string.gsub(fileName, "%.[^.]+$", "") --fileName = string.gsub(fileName, "%..+$", "") --fileName = string.gsub(fileName, "%..*$", "")
							if (fileName and fileName ~= "") then
								brushTable[fileName] = itemPath --fileName .. (isFolder and " *" or "") --"🖌 " ..  fileName .. (isFolder and "..." or "")
							end
						end
						fileName = moho:GetNextFile()
					end
				end
			end
		end
	else
		--brushTable["..."] = ""
	end
	return brushTable
end

--[[
function LS_ShapesWindow:BrushLoader(moho, variantDir) --(MohoDoc, bool) dic
	variantDir = variantDir or false
	local brushTable = {}
	local brushAppDir, brushUserDir = moho:AppDir(variantDir), moho:UserAppDir()
	if (brushAppDir ~= "") then
		brushAppDir = brushAppDir .. '/Brushes/'
		moho:BeginFileListing(brushAppDir)
		local fileName = moho:GetNextFile()
		while fileName ~= nil do
			local itemPath = brushAppDir .. fileName
			brushTable[fileName] = itemPath
			fileName = moho:GetNextFile()
		end
	end
	if (brushUserDir ~= "") then
		brushUserDir = brushUserDir .. '/Brushes/'
		moho:BeginFileListing(brushUserDir)
		local fileName = moho:GetNextFile()
		while fileName ~= nil do
			local itemPath = brushUserDir .. fileName
			brushTable[fileName] = itemPath
			fileName = moho:GetNextFile()
		end
	end

	for item in pairs(brushTable) do
		--if item == "DashedTest001" then
			--print(item)
		--end
	end
	for k, v in pairs(brushTable) do
		--print(k, v)
	end
	return brushTable
end
-]]

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

function LS_ShapesWindow:MakeShapeNameUnique(mesh, id, jump) --(M_Mesh, int, int) void
	if (mesh ~= nil and id ~= nil and mesh:Shape(id) ~= nil) then
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

function LS_ShapesWindow:BuildStyleChoiceMenu(menu, doc, baseMsg, dummyMsg, exclude) --(LM_Menu, MohoDoc, MSG_BASE, int, int) void
	menu:RemoveAllItems()
	menu:AddItem(MOHO.Localize("/Windows/Style/None2=None"), 0, baseMsg) --‹› --¹ 
	if doc ~= nil then
		for i = 0, doc:CountStyles() - 1 do
			local styleName = tostring(doc:StyleByID(i).fName:Buffer())
			local style = doc:StyleByID(i)
			--local styleName = tostring(style.fName:Buffer())
			if (i ~= exclude and styleName ~= "") then
				if i == 0 then menu:AddItem("", 0, 0) end
				menu:AddItem(styleName, 0, baseMsg + 1 + i)
			end
		end
	end
end

function LS_ShapesWindow:IsSwatchLayer(moho, layer) --(MohoDoc, MohoLayer), bool
	return (layer and layer:LayerType() == MOHO.LT_VECTOR and moho:LayerAsVector(layer):Mesh():CountShapes() > 1) and not layer:IsRenderOnly()
end

function LS_ShapesWindow.BiasedRandom (prob, range, n) --(int, int, int) int
	return math.random () < prob and range or math.random(n + 1, range)
end

function LS_ShapesWindow.Round(x, n) --(float, int) int
	return tonumber(string.format("%." .. n .. "f", x))
end

function LS_ShapesWindow.Abbreviator(s) --(str) str, int
	local num = 0
	local abrev = string.gsub(s, "%a+", function(w) if #w > 4 then num = num + 1 return string.sub(w, 1, 3) .. "." else return w end end)
	return abrev, num
end

function LS_ShapesWindow.LineBreaker(s, numSpaces, sep) --(str, int, str) str
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

function LS_ShapesWindow.List(t, a) --(tbl, {kind = int|str, indent = int, spacing = int}) str
	a = a or {}
	a.kind = a.kind and (type(a.kind) == "number" and a.kind or tostring(a.kind)) or ("• ")
	a.indent = a.indent and string.rep(" ", a.indent) or string.rep(" ", 4)
	a.spacing = a.spacing and string.rep("\n", a.spacing or 0) or ""
	local counter = a.kind -- It can be number or string (symbol)
	local output = {}

	for i, line in ipairs(t) do
		local prefix
		if type(counter) == "number" then
			prefix = a.indent .. counter .. ". "
			counter = counter + 1
		else
			prefix = a.indent .. a.kind
		end
		table.insert(output, prefix .. line .. a.spacing)
	end
	return table.concat(output, "\n")
end --Usage: print(LS_ShapesWindow.List(fileLines, {kind = 1, indent = 8, spacing = 2}))

function string:replace(substring, replacement, n) --(str, str, ±int) str -- Plain bidirectional replacement (all characters are non-magic)
	local subject, pattern, repEscaped = self, substring:gsub("%%", "%%%%"):gsub("%p", "%%%0"), replacement:gsub("%%", "%%%%") -- object, escape all magic characters, escape literal %
	if not n or n >= 0 then return subject:gsub(pattern, repEscaped, n) end
	local positions = {}
	for first, last in subject:gmatch("()" .. pattern .. "()") do
		positions[#positions + 1] = first
		positions[#positions + 1] = last
	end
	n = math.max(-#positions // 2, n) -- limit to available matches
	for i = #positions + n * 2 + 1, #positions - 1, 2 do
		subject = subject:sub(1, positions[i] - 1) .. replacement .. subject:sub(positions[i + 1])
	end
	return subject
end

function LS_ShapesWindow:Credits() --() str -- Currently using  "CREDITS.txt"
	local s = [[
	• CREATOR:
	  
	        Rai López
	  
	  
	• SPECIAL THANKS:
	  
	        Lost Marble LLC & the Moho® team
	        Stanislav Zuliy (Stan)
	        Lukas Krepel
	        Mike Kelley
	        Wes (synthsin75)
	        Paul (hayasidist)
	        Sam (SimplSam)
	  
	  
	• ATTRIBUTIONS:
	  
	        Mike Kelley ("Recolor" functions)
	  
	  
	• OTHER:
	  
	        Kurt Jung & Aaron Brown 
	        Copilot & ChatGPT
	  
	]]

	return s
end --print(LS_ShapesWindow:Credits())

function LS_ShapesWindow:License(years, name, contact, company, id, width) --(str, str, str, str) str -- Currently using "LICENSE"
	years = years or self.birth or os.date("%Y")
	name = name or "Rai López"
	contact = contact or "rai.lopez@outlook.com"
	company = company or "Lost Scripts™"
	id = id or "LS"
	width = string.rep(" ", width or 170)

	local s = [[
	Copyright © %s, %s <%s>. All Rights Reserved.

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this %s project and its associated documentation files (the
	"Software") to use it for personal and commercial purposes, including the
	rights to copy and modify the Software, provided that:

	* The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.

	* Redistribution, publication, sublicensing, and/or sale of the Software are
	strictly prohibited without express permission from the copyright holder. That
	said, if the Software becomes permanently unavailable or demonstrably abandoned,
	such actions may be permitted so that the Software and its derivatives remain
	functional, with the sole requirement that proper attribution is given.

	* Derivative works may be distributed or sold under licensee's own terms,
	provided that such works do not contain the original Software in its entirety
	and they will not overwrite any part of the Software upon coexisting public
	installations (e.g., by using "%s" instead of licensee's own identifier).

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION, USE, OR OTHER DEALINGS IN THE SOFTWARE.
	%s
	]]

	return string.format(license, tostring(years), name, contact, company, id, width)
end --print(LS_ShapesWindow:License(years))