-- **************************************************
-- Provide Moho with the name+ of this script object
-- **************************************************

ScriptName = "LS_Shapes"
ScriptBirth = "20220918-0248"
ScriptBuild = "20250921-1615"
ScriptVersion = "0.4.1"
ScriptStage = "BETA"
ScriptTarget = "Moho® 14.3+ Pro"

-- **************************************************
-- General information about this script
-- **************************************************

LS_Shapes = {}

LS_Shapes.BASE_STR = 2320

function LS_Shapes:Name()
	return "Shapes Window"
end

function LS_Shapes:Version()
	return self.version -- 0.0.1.20220918.0248?
end

function LS_Shapes:Description()
	return MOHO.Localize("/LS/Shapes/Description=A persistent shape palette plus helpers for better management of Moho® vectors in general and the AMAZING new \"Liquid Shapes\" in particular.")
end

function LS_Shapes:Creator()
	return "Rai López"
end

function LS_Shapes:UILabel() -- NOTE: Runs upon dialog opening
	return(MOHO.Localize("/LS/Shapes/ShapesWindow=Shapes Window"))
end

function LS_Shapes:ColorizeIcon()
	return true
end

function LS_Shapes:LoadPrefs(prefs) --print("LS_Shapes:LoadPrefs(" .. tostring(prefs) .. ")", " 🕗: " .. os.clock())
	self.creationMode = prefs:GetInt("LM_CreateShape.creationMode", 2)
	self.pointBasedSel = prefs:GetBool("LS_Shapes.pointBasedSel", false)
	self.pointBasedSel3 = prefs:GetBool("LS_Shapes.pointBasedSel3", true)
	self.ignoreNonRegular = prefs:GetBool("LS_Shapes.ignoreNonRegular", true)
	self.syncWithStyle = prefs:GetBool("LS_Shapes.syncWithStyle", true)
	self.openOnStartup = prefs:GetBool("LS_Shapes.openOnStartup", false)
	self.shouldOpen = prefs:GetBool("LS_Shapes.shouldOpen", true)
	self.showInTools = prefs:GetBool("LS_Shapes.showInTools", true)
	self.beginnerMode = prefs:GetBool("LS_Shapes.beginnerMode", true)
	self.debugMode = prefs:GetBool("LS_Shapes.debugMode", false)
	self.advanced = prefs:GetBool("LS_Shapes.advanced", true)
	self.largeButtons = prefs:GetBool("LS_Shapes.largeButtons", false)
	self.largePalette = prefs:GetBool("LS_Shapes.largePalette", false)
	self.showInfobar = prefs:GetBool("LS_Shapes.showInfobar", true)
	self.swatch = prefs:GetInt("LS_Shapes.swatch", -1)
	self.swatchDoc = prefs:GetInt("LS_Shapes.swatchDoc", 1)
	self.swatchLayer = prefs:GetInt("LS_Shapes.swatchLayer", 1)
	self.swatchPath = prefs:GetString("LS_Shapes.swatchPath", "")
	self.brushDirectory = prefs:GetInt("LS_Shapes.brushDirectory", 2)
	self.multiMode = prefs:GetInt("LS_Shapes.multiMode", 0)
	self.multiFlags = prefs:GetInt("LS_Shapes.multiFlags", 0)
	self.useHsv = prefs:GetBool("LS_Shapes.useHsv", false)
	self.alertCantOpen = prefs:GetInt("LS_Shapes.alertCantOpen", 0)
	self.alertShowInTools = prefs:GetInt("LS_Shapes.alertShowInTools", 0)
	self.lastMOHO = prefs:GetString("LS_Shapes.lastMOHO", tostring(0))
	--self.endedByMoho = prefs:GetBool("LS_Shapes.endedByApp", false)
	--self.endedByUser = prefs:GetBool("LS_Shapes.endedByUser", false)

	self.DarkHighlight = prefs:GetString("DarkHighlight", "105 169 161 255") --224 160 0 255
	self.FirstRun2 = prefs:GetInt("FirstRun2", 0)
	self.HighlightColor = prefs:GetString("HighlightColor", "34 124 175 255") --224 160 0 255?
	self.LightHighlight = prefs:GetString("LightHighlight", "34 124 175 255") --34 124 175 255
	self.MohoLineWidth = prefs:GetFloat("MohoLineWidth", 0.005556 * 2) --0.011111
	self.UILightness_v12beta = prefs:GetFloat("UILightness_v12beta", 0.088000) --0.207000
	self.UseLargeFonts = prefs:GetBool("UseLargeFonts", false)
end

function LS_Shapes:SavePrefs(prefs) --print("LS_Shapes:SavePrefs(" .. tostring(prefs) .. ")", " 🕗: " .. os.clock()) LM.Snooze(1500)
	prefs:SetInt("LM_CreateShape.creationMode", self.creationMode)
	prefs:SetBool("LS_Shapes.pointBasedSel", self.pointBasedSel)
	prefs:SetBool("LS_Shapes.pointBasedSel3", self.pointBasedSel3)
	prefs:SetBool("LS_Shapes.ignoreNonRegular", self.ignoreNonRegular)
	prefs:SetBool("LS_Shapes.syncWithStyle", self.syncWithStyle)
	prefs:SetBool("LS_Shapes.openOnStartup", self.openOnStartup)
	prefs:SetBool("LS_Shapes.shouldOpen", true)
	prefs:SetBool("LS_Shapes.showInTools", self.showInTools)
	prefs:SetBool("LS_Shapes.beginnerMode", self.beginnerMode)
	prefs:SetBool("LS_Shapes.debugMode", self.debugMode)
	prefs:SetBool("LS_Shapes.advanced", self.advanced)
	prefs:SetBool("LS_Shapes.largeButtons", self.largeButtons)
	prefs:SetBool("LS_Shapes.largePalette", self.largePalette)
	prefs:SetBool("LS_Shapes.showInfobar", self.showInfobar)
	prefs:SetInt("LS_Shapes.swatch", self.swatch)
	prefs:SetInt("LS_Shapes.swatchDoc", self.swatchDoc)
	prefs:SetInt("LS_Shapes.swatchLayer", self.swatchLayer)
	prefs:SetString("LS_Shapes.swatchPath", self.swatchPath)
	prefs:SetInt("LS_Shapes.brushDirectory", self.brushDirectory)
	prefs:SetInt("LS_Shapes.multiMode", self.multiMode)
	prefs:SetInt("LS_Shapes.multiFlags", self.multiFlags)
	prefs:SetBool("LS_Shapes.useHsv", self.useHsv)
	prefs:SetInt("LS_Shapes.alertCantOpen", self.alertCantOpen)
	prefs:SetInt("LS_Shapes.alertShowInTools", self.alertShowInTools)
	prefs:SetInt("LS_Shapes.FirstRun2", self.FirstRun2)
	prefs:SetString("LS_Shapes.lastMOHO", tostring(MOHO))
	prefs:SetBool("LS_Message_end", true)
end

function LS_Shapes:ResetPrefs()
	LM_CreateShape.creationMode = 2
	LS_Shapes.pointBasedSel = false
	LS_Shapes.pointBasedSel3 = true
	LS_Shapes.ignoreNonRegular = true
	LS_Shapes.syncWithStyle = true
	LS_Shapes.openOnStartup = false
	LS_Shapes.showInTools = true
	LS_Shapes.beginnerMode = true
	LS_Shapes.debugMode = false
	LS_Shapes.advanced = true
	LS_Shapes.largeButtons = false
	LS_Shapes.largePalette = false -- 0: Max, 1: Full, 2: Half, 3: Third?
	LS_Shapes.showInfobar = true
	LS_Shapes.swatch = -1
	LS_Shapes.swatchDoc = 1
	LS_Shapes.swatchLayer = 1
	LS_Shapes.swatchPath = ""
	LS_Shapes.brushDirectory = 2
	LS_Shapes.multiMode = 0 -- 0: Fill, 1: Stroke, 2: FX, 3: Recolor
	LS_Shapes.multiFlags = 1 -- 1: Affects Fills, 2: Affects Strokes, 4: Affects Alpha, 8: ...
	LS_Shapes.useHsv = false
	LS_Shapes.alertCantOpen = 0
	LS_Shapes.alertShowInTools = 0
end

-- **************************************************
-- Recurring values
-- **************************************************

LS_Shapes.name = ScriptName
LS_Shapes.birth = ScriptBirth
LS_Shapes.build = ScriptBuild
LS_Shapes.version = ScriptVersion
LS_Shapes.stage = ScriptStage
LS_Shapes.target = ScriptTarget
LS_Shapes.UUID = "f5350aae-a7ad-4080-9685-a5ef32bd6faa"
LS_Shapes.pathInfo = debug.getinfo(1, 'S')
LS_Shapes.filepath = (LS_Shapes.pathInfo.source:sub(2, -#LS_Shapes.pathInfo.source:match("[^/\\]*.lua$") - 1)):gsub("\\", "/"):gsub("/$", "") -- E.g.: C:/Users/Rai/Projects/Moho Pro/Scripts/Menu/- Lost Scripts
LS_Shapes.filename = (LS_Shapes.pathInfo.source):match("^.*[/\\](.*).lua$") or "" -- E.g.: ls_shapes
LS_Shapes.basePath = (LS_Shapes.filepath:gsub("[/\\]+$", "")):match("^(.*)" .. ("[/\\][^/\\]+"):rep(2) .. "$") or LS_Shapes.filepath --(LS_Shapes.filepath:match("^(.*)" .. ("/[^/]+"):rep(2) .. "$")) -- E.g.: C:/Users/Rai/Projects/Moho Pro/Scripts
LS_Shapes.resources = "ScriptResources/" .. LS_Shapes.filename .. "/"
LS_Shapes.resourcesAlt = "ScriptResources/../../Support/Scripts/"
LS_Shapes.logPath = LS_Shapes.basePath .. "/" .. LS_Shapes.resources .. "LOG.txt"
LS_Shapes.log = nil
LS_Shapes.web = "https://lost-scripts.github.io/"
LS_Shapes.webpage = LS_Shapes.web .. "scripts/" .. LS_Shapes.filename
LS_Shapes.forge = "https://github.com/"
LS_Shapes.forgeArk = LS_Shapes.forge .. "lost-scripts/"
LS_Shapes.repo = LS_Shapes.forgeArk .. LS_Shapes.filename
LS_Shapes.repoLatest = LS_Shapes.repo .. "/releases/latest/" --https://github.com/lost-scripts/ls_shapes/releases/latest/#YOURS-IS-v0.3.0-BETA
LS_Shapes.repoDown = LS_Shapes.repoLatest .. "download/" .. LS_Shapes.filename .. ".zip" --https://stackoverflow.com/questions/24987542/is-there-a-link-to-github-for-downloading-a-file-in-the-latest-release-of-a-repo
LS_Shapes.M, LS_Shapes.m = MOHO, nil
LS_Shapes.doc = nil
LS_Shapes.docList = {}
LS_Shapes.docPath = ""
LS_Shapes.docsLoaded = false
LS_Shapes.dlog = nil
LS_Shapes.shouldOpen = false
LS_Shapes.shouldReopen = false
LS_Shapes.mode = 0 -- 0: DEFAULT, 1: SHAPE, 2: STYLE (Style Management), 3: GROUP (Point Group Mgmt.)
LS_Shapes.multiMenuRules = false
LS_Shapes.multiMenuLast = (LS_Shapes.multiMode and LS_Shapes.multiMode < 2) and LS_Shapes.multiMode or 0
LS_Shapes.multiValues = {[3] = {0, 0, 0, 1}} -- 3: Recolor
LS_Shapes.isHelpVisible = false
LS_Shapes.showHelp = false
--LS_Shapes.DarkHighlight = "224 160 0 255" --224 160 0 255
--LS_Shapes.FirstRun2 = 0
--LS_Shapes.HighlightColor = "224 160 0 255" --224 160 0 255
--LS_Shapes.LightHighlight = "34 124 175 255" --34 124 175 255
--LS_Shapes.MohoLineWidth = 0.005556
--LS_Shapes.UILightness_v12beta = 0.088000 --0.207000
--LS_Shapes.UseLargeFonts = false

-- **************************************************
-- Shapes Dialog
-- **************************************************

MOHO.MSGF_NONE = MOHO.bit(0) -- 2⁰ = 0 (MSG Flag of all defaults)
MOHO.MSGF_NOTUNDO = MOHO.bit(1) -- 2¹ = 2 (Default: Is undoable)
MOHO.MSGF_MULTIUNDO = MOHO.bit(2) -- 2² = 4 (Default: Is not multiundoable)
MOHO.MSGF_REOPEN = MOHO.bit(3) -- 2³ = 8 (Default: Should't reopen)
MOHO.MSGF_PASS = MOHO.bit(4) -- 2⁴ = 16 (Default: Shall not pass!)

local LS_ShapesDialog = {fName = "LS_ShapesDialog"}; LS_ShapesDialog.F = {}

LS_ShapesDialog.MODE					= MOHO.MSG_BASE + 0; LS_ShapesDialog.F.MODE = MOHO.MSGF_NOTUNDO -- (-40000)
LS_ShapesDialog.MODE_ALT				= MOHO.MSG_BASE + 1; LS_ShapesDialog.F.MODE_ALT = MOHO.MSGF_NOTUNDO
LS_ShapesDialog.NAME					= MOHO.MSG_BASE + 2
LS_ShapesDialog.VIS						= MOHO.MSG_BASE + 3

LS_ShapesDialog.RAISE					= MOHO.MSG_BASE + 4
LS_ShapesDialog.RAISE_ALT				= MOHO.MSG_BASE + 5
LS_ShapesDialog.LOWER					= MOHO.MSG_BASE + 6
LS_ShapesDialog.LOWER_ALT				= MOHO.MSG_BASE + 7
LS_ShapesDialog.ANIMORDER				= MOHO.MSG_BASE + 8
LS_ShapesDialog.ANIMORDER_ALT			= MOHO.MSG_BASE + 9

LS_ShapesDialog.SELECTALL				= MOHO.MSG_BASE + 10; LS_ShapesDialog.F.SELECTALL = MOHO.MSGF_NOTUNDO
LS_ShapesDialog.SELECTALL_ALT			= MOHO.MSG_BASE + 11; LS_ShapesDialog.F.SELECTALL_ALT = MOHO.MSGF_NOTUNDO
LS_ShapesDialog.SELECTMATCHING			= MOHO.MSG_BASE + 12; LS_ShapesDialog.F.SELECTMATCHING = MOHO.MSGF_NOTUNDO
LS_ShapesDialog.SELECTMATCHING_ALT		= MOHO.MSG_BASE + 13; LS_ShapesDialog.F.SELECTMATCHING_ALT = MOHO.MSGF_NOTUNDO
LS_ShapesDialog.SELECTPTBASED			= MOHO.MSG_BASE + 14; LS_ShapesDialog.F.SELECTPTBASED = MOHO.MSGF_NOTUNDO
LS_ShapesDialog.SELECTPTBASED_ALT		= MOHO.MSG_BASE + 15; LS_ShapesDialog.F.SELECTPTBASED_ALT = MOHO.MSGF_NOTUNDO
LS_ShapesDialog.CHECKERSEL				= MOHO.MSG_BASE + 16; LS_ShapesDialog.F.CHECKERSEL = MOHO.MSGF_NOTUNDO + MOHO.MSGF_PASS

LS_ShapesDialog.MERGE					= MOHO.MSG_BASE + 17
LS_ShapesDialog.DELETE					= MOHO.MSG_BASE + 18
LS_ShapesDialog.DELETE_ALT				= MOHO.MSG_BASE + 19
LS_ShapesDialog.COPY					= MOHO.MSG_BASE + 20; LS_ShapesDialog.F.COPY = MOHO.MSGF_NOTUNDO
LS_ShapesDialog.COPY_ALT				= MOHO.MSG_BASE + 21; LS_ShapesDialog.F.COPY_ALT = MOHO.MSGF_NOTUNDO
LS_ShapesDialog.PASTE					= MOHO.MSG_BASE + 22
LS_ShapesDialog.PASTE_ALT				= MOHO.MSG_BASE + 23; LS_ShapesDialog.F.PASTE_ALT = MOHO.MSGF_NOTUNDO
LS_ShapesDialog.RESET					= MOHO.MSG_BASE + 24; LS_ShapesDialog.F.RESET = MOHO.MSGF_PASS
LS_ShapesDialog.RESET_ALT				= MOHO.MSG_BASE + 25; LS_ShapesDialog.F.RESET_ALT = MOHO.MSGF_PASS

LS_ShapesDialog.COMBO_NORMAL			= MOHO.MSG_BASE + 26
LS_ShapesDialog.COMBO_ADD				= MOHO.MSG_BASE + 27
LS_ShapesDialog.COMBO_SUBTRACT			= MOHO.MSG_BASE + 28
LS_ShapesDialog.COMBO_INTERSECT			= MOHO.MSG_BASE + 29
LS_ShapesDialog.COMBO_BLEND_BUT			= MOHO.MSG_BASE + 30
LS_ShapesDialog.COMBO_BLEND_BUT_ALT		= MOHO.MSG_BASE + 31
LS_ShapesDialog.COMBO_BLEND				= MOHO.MSG_BASE + 32
LS_ShapesDialog.BASE_SHAPE				= MOHO.MSG_BASE + 33; LS_ShapesDialog.F.BASE_SHAPE = MOHO.MSGF_NOTUNDO
LS_ShapesDialog.BASE_SHAPE_ALT			= MOHO.MSG_BASE + 34; LS_ShapesDialog.F.BASE_SHAPE_ALT = MOHO.MSGF_NOTUNDO
LS_ShapesDialog.TOP_SHAPE				= MOHO.MSG_BASE + 35; LS_ShapesDialog.F.TOP_SHAPE = MOHO.MSGF_NOTUNDO
LS_ShapesDialog.TOP_SHAPE_ALT			= MOHO.MSG_BASE + 36; LS_ShapesDialog.F.TOP_SHAPE_ALT = MOHO.MSGF_NOTUNDO

LS_ShapesDialog.FILL					= MOHO.MSG_BASE + 37
LS_ShapesDialog.FILL_ALT				= MOHO.MSG_BASE + 38
LS_ShapesDialog.FILLCOLOR				= MOHO.MSG_BASE + 39; LS_ShapesDialog.F.FILLCOLOR = MOHO.MSGF_NOTUNDO
LS_ShapesDialog.FILLCOLOR_BEGIN			= MOHO.MSG_BASE + 40; LS_ShapesDialog.F.FILLCOLOR_BEGIN = MOHO.MSGF_NOTUNDO
LS_ShapesDialog.FILLCOLOR_END			= MOHO.MSG_BASE + 41; LS_ShapesDialog.F.FILLCOLOR_END = MOHO.MSGF_NOTUNDO
LS_ShapesDialog.FILLCOLOROVER			= MOHO.MSG_BASE + 42
LS_ShapesDialog.LINE					= MOHO.MSG_BASE + 43
LS_ShapesDialog.LINE_ALT				= MOHO.MSG_BASE + 44
LS_ShapesDialog.LINECOLOR				= MOHO.MSG_BASE + 45; LS_ShapesDialog.F.LINECOLOR = MOHO.MSGF_NOTUNDO
LS_ShapesDialog.LINECOLOR_BEGIN			= MOHO.MSG_BASE + 46; LS_ShapesDialog.F.LINECOLOR_BEGIN = MOHO.MSGF_NOTUNDO
LS_ShapesDialog.LINECOLOR_END			= MOHO.MSG_BASE + 47; LS_ShapesDialog.F.LINECOLOR_END = MOHO.MSGF_NOTUNDO
LS_ShapesDialog.LINECOLOROVER			= MOHO.MSG_BASE + 48
LS_ShapesDialog.LINEWIDTH				= MOHO.MSG_BASE + 49
LS_ShapesDialog.LINEWIDTHOVER			= MOHO.MSG_BASE + 50
LS_ShapesDialog.ROUNDCAPS				= MOHO.MSG_BASE + 51; LS_ShapesDialog.F.ROUNDCAPS = MOHO.MSGF_PASS
LS_ShapesDialog.BRUSH					= MOHO.MSG_BASE + 52
LS_ShapesDialog.COLORSWAP				= MOHO.MSG_BASE + 53; LS_ShapesDialog.F.COLORSWAP = MOHO.MSGF_PASS
LS_ShapesDialog.STYLESWAP				= MOHO.MSG_BASE + 54

LS_ShapesDialog.FILLED					= MOHO.MSG_BASE	+ 55
LS_ShapesDialog.FILLED_ALT				= MOHO.MSG_BASE + 56
LS_ShapesDialog.OUTLINED				= MOHO.MSG_BASE + 57
LS_ShapesDialog.OUTLINED_ALT			= MOHO.MSG_BASE + 58
LS_ShapesDialog.FILLEDOUTLINED			= MOHO.MSG_BASE + 59
LS_ShapesDialog.FILLEDOUTLINED_ALT		= MOHO.MSG_BASE + 60

LS_ShapesDialog.HSV						= MOHO.MSG_BASE + 61; LS_ShapesDialog.F.HSV = MOHO.MSGF_NOTUNDO
LS_ShapesDialog.MULTI1					= MOHO.MSG_BASE + 62
LS_ShapesDialog.MULTI2					= MOHO.MSG_BASE + 63
LS_ShapesDialog.MULTI3					= MOHO.MSG_BASE + 64
LS_ShapesDialog.MULTI4					= MOHO.MSG_BASE + 65
LS_ShapesDialog.APPLY					= MOHO.MSG_BASE + 66; LS_ShapesDialog.F.APPLY = {[3] = MOHO.MSGF_MULTIUNDO, [4] = MOHO.MSGF_MULTIUNDO}
LS_ShapesDialog.APPLY_ALT				= MOHO.MSG_BASE + 67; LS_ShapesDialog.F.APPLY_ALT = {[3] = MOHO.MSGF_MULTIUNDO, [4] = MOHO.MSGF_MULTIUNDO}
LS_ShapesDialog.SWATCHSLIDER			= MOHO.MSG_BASE + 68; LS_ShapesDialog.F.SWATCHSLIDER = MOHO.MSGF_NOTUNDO + MOHO.MSGF_PASS
LS_ShapesDialog.INFO					= MOHO.MSG_BASE + 69; LS_ShapesDialog.F.INFO = MOHO.MSGF_NOTUNDO

LS_ShapesDialog.DUMMY					= MOHO.MSG_BASE + 70
LS_ShapesDialog.CHANGE					= MOHO.MSG_BASE + 71; LS_ShapesDialog.F.CHANGE = MOHO.MSGF_NOTUNDO
LS_ShapesDialog.NONE					= MOHO.MSG_BASE + 72; LS_ShapesDialog.F.CHANGE = MOHO.MSGF_NOTUNDO

LS_ShapesDialog.MAINMENU				= MOHO.MSG_BASE +  300; LS_ShapesDialog.F.MAINMENU = {[6] = MOHO.MSGF_REOPEN, [7] = MOHO.MSGF_REOPEN, [8] = MOHO.MSGF_REOPEN, [9] = MOHO.MSGF_REOPEN}
LS_ShapesDialog.MULTIMENU				= MOHO.MSG_BASE +  400
LS_ShapesDialog.SELECTSTYLE1			= MOHO.MSG_BASE +  500
LS_ShapesDialog.SELECTSTYLE2			= MOHO.MSG_BASE + 1500	-- extremely unlikely to have anything close to 1000 styles
LS_ShapesDialog.SELECTSWATCH			= MOHO.MSG_BASE + 2500	-- extremely unlikely to have anything close to 1000 styles
LS_ShapesDialog.SELECTBRUSH				= MOHO.MSG_BASE + 3000	-- extremely unlikely to have anything close to  500 swatches
LS_ShapesDialog.MSG_LIMIT				= MOHO.MSG_BASE + 4500	-- extremely unlikely to have anything close to 1500 brushes?

--LS_Shapes.msgs = LS_ShapesDialog

--[[Test to assign values to MSGs by a simple table
LS_ShapesDialog.TEST, LS_ShapesDialog[MOHO.MSG_BASE + 4000] = MOHO.MSG_BASE + 4000, {name = "TEST", undoable = true, pass = false}
LS_ShapesDialog[MOHO.MSG_BASE + 4001]		= {name = "TEST+1", undoable = true, pass = false}
LS_ShapesDialog[MOHO.MSG_BASE + 4002]		= {name = "TEST+2", undoable = true, pass = false}
for k, v in pairs(LS_ShapesDialog.msgs) do
	if v.undoable then print(v.name .. " is undoable!") end
end--]]
--[[Test to assign values to MSGs by a function (more convoluted)
--LS_ShapesDialog.MSG_TEST, LS_ShapesDialog.MSG_TESTPLUS = (function() return MOHO.MSG_BASE + 4000, ({undoable = "true", pass = false}) end)()
--print(LS_ShapesDialog.MSG_TEST)
--print(LS_ShapesDialog.MSG_TESTPLUS.undoable) --print(tostring(LS_ShapesDialog.MSG_TEST("undoable")))--]]

function LS_ShapesDialog:new(moho) --print("LS_ShapesDialog:new(" .. tostring(moho) .. "): ", " 🕗: " .. os.clock()) -- NOTE: This print makes the dialog get closed upon closing the LCW! --MARK:-NEW(D)
	local d = LM.GUI.SimpleDialog(MOHO.Localize("/LS/Shapes/Shapes=Shapes"), LS_ShapesDialog)
	local l = d:GetLayout()
	local doc = moho.document
	local docH = doc and doc:Height() or 240
	local style = moho:CurrentEditStyle()
	local mainW = 150 --166
	local padH, padV = 3, 3
	local butW = 16
	local butW1 = LS_Shapes.largeButtons and 6 or 0
	local menuW = 22

	d.p = _G[LS_Shapes.name] -- Shortcut to script's table
	d.p.m = moho -- ⚠ WARNING: Be careful from where you retrieve this due to the inherent mutability of the moho object!

	d.v = moho.view -- The view object upon opening (try to avoid using it afterwards!)
	d.w = {} -- widgets, wTable?
	d.msg = MOHO.MSG_BASE
	d.change = self.CHANGE
	d.isNewRun = true
	d.mode = 0
	d.multiMode = LS_Shapes.multiMode
	d.info = {i="ℹ ", w="⚠ ", t="💡 ", id="🆔 ", uid="🔣 ", n="🔢 ", liq="♒ ", pt="🅿 ", sep=" · ", upd=true, cop=true, but=false, pip=false} -- upd: update, cop: copiable, but: button, pip: beep
	d.infoText = ""
	d.count = 0
	d.countFactory = 0
	d.swatches = {}
	d.skipBlock = false
	d.skipAll = false
	d.shapeTable, d.styleTable, d.groups = {}, {}, {old = {}}
	d.itemSel = 0
	--d.shapes = d.shapes and LM.Clamp(d.shapes + 2, 10, 40) or 20
	d.groupUI = nil
	d.vHeight = d.v and math.floor((d.v:Height() / (LS_Shapes.largePalette and 1 or 2))) - 214 or (LS_Shapes.largePalette and 648 or 324) --d.vHeight = d.vHeight and d.vHeight - 132 or 726
	d.beginnerMode = LS_Shapes.beginnerMode
	d.editingColor = false
	d.tempShape = moho:NewShapeProperties() or MOHO.MohoGlobals.NewShapeProperties
	d.userPath = moho:UserContentDir()
	d.resPath = d.userPath .. '\\Scripts\\ScriptResources\\' .. LS_Shapes.filename

	l:AddPadding(-12)
	l:Unindent(8)
	l:AddPadding(-12) ---14 (if modeBut)

	l:PushV(LM.GUI.ALIGN_LEFT, 0)
		--l:AddPadding(-4) -- Comment if modeBut
		l:PushH(LM.GUI.ALIGN_LEFT, 0)
			l:AddPadding(LS_Shapes.largeButtons and padH or 0) --l:AddPadding(-7)
			d.menu1 = LM.GUI.Menu("") --☰⁝⚙…
			d.menu1.conditionalItems = {}
			d.menu1Popup = LM.GUI.PopupMenu(LS_Shapes.UseLargeFonts and menuW + 4 or menuW, false) --LS_Shapes.UseLargeFonts and menuW + 4 or menuW
			--d.menu1Popup:SetToolTip(MOHO.Localize("/Dialogs/LayerSettings/General=General")) --"/Dialogs/LayerSettings/GeneralTab/Options=Options"
			d.menu1Popup:SetMenu(d.menu1)
			l:AddChild(d.menu1Popup, LM.GUI.ALIGN_LEFT, 6) --largeFonts = d.menu1Popup:Height() > 24 
			d.menu1:AddItem(MOHO.Localize("/LS/Shapes/SyncWithStyleWindow=Sync With Style Window"), 0, self.MAINMENU)
			--d.menu1:AddItem(MOHO.Localize("/LS/Shapes/ShowActualShapePreview=Show Actual Shape Preview"), 0, self.MAINMENU + 1) -- TODO?
			d.menu1:AddItem(MOHO.Localize("/LS/Shapes/IgnoreNonRegularVectorLayers=Ignore Non-Regular Vector Layers"), 0, self.MAINMENU + 1)
			--d.menu1:AddItem(MOHO.Localize("/LS/Shapes/AsleepWhileUsingDrawingTools=Asleep While Using Drawing Tools"), 0, self.MAINMENU + 2) -- & Click To Awake? -- TBC
			d.menu1:AddItem("", 0, 0)
			d.menu1:AddItem(MOHO.Localize("/LS/Shapes/OpenOnStartup=Open On Startup"), 0, self.MAINMENU + 2)
			d.menu1:AddItem(MOHO.Localize("/LS/Shapes/ShowInTools=Show In \"Tools\" Palette"), 0, self.MAINMENU + 3)
			d.menu1:AddItem(MOHO.Localize("/LS/Shapes/BeginnersMode=Beginner's Mode (Tooltippy)"), 0, self.MAINMENU + 4)
			d.menu1:AddItem(MOHO.Localize("/LS/Shapes/DebugMode=Debug Mode") .. " [?]", 0, self.MAINMENU + 5)
			d.menu1:AddItem("", 0, 0)
			d.menu1:AddItem(MOHO.Localize("/LS/Shapes/AdvancedMode=Advanced (Creation Controls)"), 0, self.MAINMENU + 6) d.menu1:SetEnabled(self.MAINMENU + 6, true) --Show Creation Controls?
			d.menu1:AddItem(MOHO.Localize("/LS/Shapes/UseLargeButtons=Use Large Buttons"), 0, self.MAINMENU + 7)
			d.menu1:AddItem(MOHO.Localize("/LS/Shapes/UseLargePalette=Use Large Palette (%d Items)"):match("[^%(]+"), 0, self.MAINMENU + 8) --MOHO.Localize("/Dialogs/ExportSettings/HalfDimensions=Use Large Palette (%dx%d)"):match("[^%(]+")
			d.menu1:AddItem(MOHO.Localize("/Windows/LayerComps/ShowComp=Show") .. " " .. "Infobar", 0, self.MAINMENU + 9)
			--d.menu1:AddItem(MOHO.Localize("/LS/Shapes/ResizeAndReopen=Resize & Reopen"), 0, self.MAINMENU + 9)
			d.menu1:AddItem("", 0, 0)
			d.menu1:AddItem(MOHO.Localize("/LS/Shapes/RestoreDefaults=Restore Defaults") .. " [?]", 0, self.MAINMENU + 10)
			d.menu1:AddItem("", 0, 0)
			if (LS_Shapes:FileExists(d.resPath .. '\\HELP.png') == true) or (LS_Shapes:FileExists(d.resPath .. '\\@HELPME.url') == true) or LS_Shapes.repo then
				table.insert (d.menu1.conditionalItems, self.MAINMENU + 11)
				d.menu1:AddItem(MOHO.Localize("/Menus/Help/Help=Help") .. "...", 0, d.menu1.conditionalItems[#d.menu1.conditionalItems])
			end
			if (LS_Shapes:FileExists(d.resPath .. '\\@VISITME.url') == true) or (LS_Shapes.webpage and LS_Shapes.webpage ~= "") then
				table.insert (d.menu1.conditionalItems, self.MAINMENU + 12)
				d.menu1:AddItem(MOHO.Localize("/LS/Shapes/VisitWebpage=Visit Webpage") .. "...", 0, d.menu1.conditionalItems[#d.menu1.conditionalItems])
			end
			if (LS_Shapes:FileExists(d.resPath .. '\\@UPDATEME.url') == true) or (LS_Shapes.repoLatest and LS_Shapes.repoLatest ~= "") then
				table.insert (d.menu1.conditionalItems, self.MAINMENU + 13)
				d.menu1:AddItem(MOHO.Localize("/Menus/Help/CheckForUpdates=Check For Updates..."), 0, d.menu1.conditionalItems[#d.menu1.conditionalItems])
			end
			if (#d.menu1.conditionalItems > 1) then
				d.menu1:AddItem("", 0, 0)
			end
			d.menu1:AddItem(MOHO.Localize("/Menus/Application/About=About") .. " " .. LS_Shapes:UILabel() .. "...", 0, self.MAINMENU + 14)
			--d.menu1:AddItem("...", 0, self.MAINMENU + 14) -- Last (Testground!)
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
		l:AddPadding(LS_Shapes.UseLargeFonts and -29 or -24) -- Used to be -27 or -22 for ShortButton
		l:PushH(LM.GUI.ALIGN_CENTER, 0)
			l:AddPadding(9)
			d.modeBut = LM.GUI.Button("    MODE    ", self.MODE) --"Room 4 Label"
			d.modeBut:SetAlternateMessage(self.MODE_ALT)
			l:AddChild(d.modeBut)
		l:Pop() --H
		l:AddPadding(2)
		--]]
		l:PushH(LM.GUI.ALIGN_LEFT, 0)
			--d.itemNameLabel = LM.GUI.DynamicText("    ", 18)
			--d.itemNameLabel:SetValue(" 🏷") -- Set labels text this way for full control over width.
			--d.itemNameLabel:SetToolTip(MOHO.Localize("/Windows/Style/Name=Name")) -- .. " (Tab key to confirm)"
			--l:AddChild(d.itemNameLabel, LM.GUI.ALIGN_CENTER)
			d.itemPreview = MOHO.MeshPreview(butW + butW1 + padH * 2, LS_Shapes.largeButtons and 24 or butW + butW1 + padH * 2)
			--d.itemPreview:SetToolTip(MOHO.Localize("/Windows/Style/SHAPE=SHAPE"):lower():gsub("^%l", string.upper))
			l:AddChild(d.itemPreview)

			d.itemVisCheck = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_visibility_" .. (math.random() < 0.5 and 0 or math.random(1, 5)), MOHO.Localize("/LS/Shapes/ShapeVisibility=Shape Visibility (Hide/Unhide)"), true, self.VIS, false)
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
				--butW = LM.Clamp(butW, d.raise:Width(), 24) --??
				if LS_Shapes.largeButtons then l:AddPadding(-1) l:AddChild(LM.GUI.TextList(butW + butW1, 0, 0), LM.GUI.ALIGN_FILL, 0) l:AddPadding(1) end
				
				l:AddPadding(3)
				d.raise = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_shape_order_raise", "", false, self.RAISE, true)
				d.raise:SetAlternateMessage(self.RAISE_ALT)
				--d.raise:SetContinuousMessages(0.2) -- It would require quite extra logic in HandleMessage...
				l:AddChild(d.raise, LM.GUI.ALIGN_FILL, 0)

				l:AddPadding(2)
				d.animOrder = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_shape_order_anim", "", true, self.ANIMORDER, true)
				d.animOrder:SetAlternateMessage(self.ANIMORDER_ALT)
				d.animOrder:SetToolTip(MOHO.Localize("/LS/Shapes/AnimatedShapeOrder=Animated Shape Order (<alt> Reset)"))
				d.animOrder.prop = {v = 11, pro = true, tooltip = false} table.insert(d.w, d.animOrder)
				l:AddChild(d.animOrder, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(2)

				d.lower = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_shape_order_lower", "", false, self.LOWER, true)
				d.lower:SetAlternateMessage(self.LOWER_ALT)
				--d.lower:SetContinuousMessages(0.2) -- It would require quite extra logic in HandleMessage...
				l:AddChild(d.lower, LM.GUI.ALIGN_FILL, 0)
			l:Pop() --V
			l:AddPadding(-butW - butW1)

			l:PushV(LM.GUI.ALIGN_BOTTOM, 0)
				d.selectAllBut = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_sel_all", MOHO.Localize("/Menus/Edit/SelectAll=Select All") .. " (<alt> " .. MOHO.Localize("/Menus/Edit/SelectInverse=Select Inverse") .. ")", false, self.SELECTALL, true) --<alt> Select Cluster
				d.selectAllBut:SetAlternateMessage(self.SELECTALL_ALT)
				l:AddChild(d.selectAllBut, LM.GUI.ALIGN_FILL)
				l:AddPadding(3)

				d.selectMatchingBut = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_sel_similar", "", false, self.SELECTMATCHING, true)
				d.selectMatchingBut:SetAlternateMessage(self.SELECTMATCHING_ALT)
				l:AddChild(d.selectMatchingBut, LM.GUI.ALIGN_FILL)
				l:AddPadding(3)

				d.selectPtBasedBut = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_sel_pt_based", "", true, self.SELECTPTBASED, true)
				d.selectPtBasedBut:SetAlternateMessage(self.SELECTPTBASED_ALT)
				l:AddChild(d.selectPtBasedBut, LM.GUI.ALIGN_FILL)
				l:AddPadding(3)

				d.checkerSelBut = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_shape_checker_sel", MOHO.Localize("/Windows/Style/CheckerSelection=Checker selection"), true, self.CHECKERSEL, true)
				l:AddChild(d.checkerSelBut, LM.GUI.ALIGN_FILL)

				l:AddPadding(4)
				l:AddChild(LM.GUI.TextList(butW + butW1, 1, 0), LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(4)

				d.mergeBut = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_shape_merge", MOHO.Localize("/Scripts/Tool/SelectShape/MergeCluster=Merge a Liquid Shape into a single shape"), false, self.MERGE, true)
				d.mergeBut.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.mergeBut)
				l:AddChild(d.mergeBut, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(3)

				d.deleteBut = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_delete", MOHO.Localize("/Windows/Style/Delete=Delete"), false, self.DELETE, true) --"<alt> Delete entire Liquid Shape"? 
				d.deleteBut:SetAlternateMessage(self.DELETE_ALT)
				l:AddChild(d.deleteBut, LM.GUI.ALIGN_FILL, 0)

				l:AddPadding(4)
				l:AddChild(LM.GUI.TextList(butW + butW1, 1, 0), LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(4)

				d.copyBut = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_edit_copy", MOHO.Localize("/Windows/Library/Copy=Copy") .. " (<alt> " .. MOHO.Localize("/LS/Shapes/HEXToClipboard=HEX To Clipboard") .. ")", false, self.COPY, true)
				d.copyBut:SetAlternateMessage(self.COPY_ALT)
				l:AddChild(d.copyBut, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(3)

				d.pasteBut = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_edit_paste", MOHO.Localize("/Windows/Style/Paste=Paste") .. " (<alt> " .. MOHO.Localize("/LS/Shapes/ColorFromClipboard=Color From Clipboard") .. ")", false, self.PASTE, true)
				d.pasteBut:SetAlternateMessage(self.PASTE_ALT)
				l:AddChild(d.pasteBut, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(3)

				d.resetBut = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_edit_reset" , MOHO.Localize("/Windows/Style/Reset=Reset"), false, self.RESET, true)
				d.resetBut:SetAlternateMessage(self.RESET_ALT)
				d.resetBut:SetToolTip(MOHO.Localize("/Windows/Style/Reset=Reset") .. " (<alt> " .. MOHO.Localize("/LS/Shapes/Full=Full") .. ")")
				l:AddChild(d.resetBut, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(3)
			l:Pop() --V

			l:AddPadding(2)
			l:PushH(LM.GUI.ALIGN_LEFT, 0)
				l:AddPadding(-1)
				local itemHeight = d.itemName:Height() -- 22 / 27
				local listHeight = LM.Clamp(d.vHeight % itemHeight == 0 and d.vHeight or d.vHeight + (itemHeight - d.vHeight % itemHeight) + 2, itemHeight * 16 + 2, itemHeight * 25 + 2) -- Try to ensure last item always fits (Min: 296?)
				--local listHeight = (d.itemName:Height() * d.shapes < d.vHeight) and d.itemName:Height() * d.shapes or d.vHeight -- Try to addapt to viewport height
				--l:AddPadding(-1)
				d.itemList = LM.GUI.ImageTextList(mainW, listHeight, self.CHANGE) --175
				d.itemList:SetAllowsMultipleSelection(true)
				d.itemList:SetDrawsPrimarySelection(true)
				d.itemList:AddItem((" "):rep(14) .. MOHO.Localize("/Windows/Style/None=<None>"), false)
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
				d.combineNormal = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_shape_combine_normal", MOHO.Localize("/Scripts/Tool/SelectShape/Normal=Normal"), true, self.COMBO_NORMAL, true)
				d.combineNormal.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.combineNormal)
				l:AddChild(d.combineNormal, LM.GUI.ALIGN_FILL, 0)
				if LS_Shapes.largeButtons then l:AddChild(LM.GUI.TextList(butW + butW1, 0, 0), LM.GUI.ALIGN_FILL, 0) end
			l:Pop() --V
			l:PushV(LM.GUI.ALIGN_CENTER, 0)
				d.combineAdd = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_shape_combine_add", "⊕‍ " .. MOHO.Localize("/Scripts/Tool/SelectShape/Add=Add"), true, self.COMBO_ADD, true) --" (+)"
				d.combineAdd.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.combineAdd)
				l:AddChild(d.combineAdd, LM.GUI.ALIGN_FILL, 0)
				if LS_Shapes.largeButtons then l:AddChild(LM.GUI.TextList(butW + butW1, 0, 0), LM.GUI.ALIGN_FILL, 0) end
			l:Pop() --V
			l:PushV(LM.GUI.ALIGN_CENTER, 0)
				d.combineSubtract = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_shape_combine_subtract", "⊖‍ " .. MOHO.Localize("/Scripts/Tool/SelectShape/Subtract=Subtract"), true, self.COMBO_SUBTRACT, true) --⊝" (-)"
				d.combineSubtract.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.combineSubtract)
				l:AddChild(d.combineSubtract, LM.GUI.ALIGN_FILL, 0)
				if LS_Shapes.largeButtons then l:AddChild(LM.GUI.TextList(butW + butW1, 0, 0), LM.GUI.ALIGN_FILL, 0) end
			l:Pop() --V
			l:PushV(LM.GUI.ALIGN_CENTER, 0)
				d.combineIntersect = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_shape_combine_intersect", "⊗‍ " .. MOHO.Localize("/Scripts/Tool/SelectShape/Clip=Clip"), true, self.COMBO_INTERSECT, true) --" (×)"
				d.combineIntersect.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.combineIntersect)
				l:AddChild(d.combineIntersect, LM.GUI.ALIGN_FILL, 0)
				if LS_Shapes.largeButtons then l:AddChild(LM.GUI.TextList(butW + butW1, 0, 0), LM.GUI.ALIGN_FILL, 0) end
			l:Pop() --V
			l:AddPadding(2)

			--if LS_Shapes.largeButtons then l:AddPadding(0) end
			d.combineBlendBut = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_shape_combine_blend", MOHO.Localize("/Scripts/Tool/SelectShape/Blend=Blend:"):gsub("[^%w]$", "") .. " (<alt> " .. MOHO.Localize("/Windows/Style/Reset=Reset") .. ")", true, self.COMBO_BLEND_BUT, true) --Remove any non-alphanumeric ending character
			d.combineBlendBut:SetAlternateMessage(self.COMBO_BLEND_BUT_ALT)
			d.combineBlendBut.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.combineBlendBut)
			l:AddChild(d.combineBlendBut, LM.GUI.ALIGN_FILL, 0)
			l:AddPadding(-4)
			d.combineBlend = LM.GUI.TextControl(0, LS_Shapes.largeButtons and (LS_Shapes.UseLargeFonts and "00" or "000") or "0.00", self.COMBO_BLEND, LM.GUI.FIELD_UFLOAT) --≈≋
			d.combineBlend:SetPercentageMode(true)
			d.combineBlend:SetWheelInc(1.0)
			d.combineBlend.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.combineBlend)
			l:AddChild(d.combineBlend, LM.GUI.ALIGN_FILL, 0)
			if true then l:AddPadding(0) end --not LS_Shapes.largeButtons

			l:PushV(LM.GUI.ALIGN_CENTER, 0)
				d.topBut = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_shape_sel_cluster_top", MOHO.Localize("/Scripts/Tool/SelectShape/SelectTopOfCluster=Select top of Liquid Shape") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All") .. ")", false, self.TOP_SHAPE, true)
				d.topBut:SetAlternateMessage(self.TOP_SHAPE_ALT)
				--d.topBut:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/SelectTopOfCluster=Select top of Liquid Shape"))
				d.topBut.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.topBut)
				if true then l:AddChild(d.topBut, LM.GUI.ALIGN_FILL, 0) end --not LS_Shapes.largeButtons

				d.baseBut = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_shape_sel_cluster_bottom", MOHO.Localize("/Scripts/Tool/SelectShape/SelectBottomOfCluster=Select bottom of Liquid Shape") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All") .. ")", false, self.BASE_SHAPE, true)
				d.baseBut:SetAlternateMessage(self.BASE_SHAPE_ALT)
				--d.baseBut:SetToolTip(MOHO.Localize("/Scripts/Tool/SelectShape/SelectBottomOfCluster=Select bottom of Liquid Shape"))
				d.baseBut.prop = {v = 14, pro = true, tooltip = false} table.insert(d.w, d.baseBut)
				if true then l:AddChild(d.baseBut, LM.GUI.ALIGN_FILL, 0) end --not LS_Shapes.largeButtons
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
		l:AddPadding(LS_Shapes.advanced and 4 or 0)

		if LS_Shapes.advanced then
			l:PushH(LM.GUI.ALIGN_FILL, 1)
				l:AddPadding(2)
				d.fillCheck = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_shape_fill", MOHO.Localize("/Scripts/Tool/SelectShape/Fill=Fill:"):gsub("[^%w]$", "") .. " (<alt>" .. MOHO.Localize("/LS/Shapes/AnimateVisibility=Animate its visibility instead)"), true, self.FILL, true)
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
				d.fillColOverride = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_shape_override", MOHO.Localize("/LS/Shapes/FillOverride=Fill Color Override"), true, self.FILLCOLOROVER, true)
				l:AddChild(d.fillColOverride, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(2)
				l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(2)

				d.createButtons = {}
				table.insert(d.createButtons, LM.GUI.ImageButton(LS_Shapes.resources .. "ls_create_fill", "", false, self.FILLED, true))
				table.insert(d.createButtons, LM.GUI.ImageButton(LS_Shapes.resources .. "ls_create_line", "", false, self.OUTLINED, true))
				table.insert(d.createButtons, LM.GUI.ImageButton(LS_Shapes.resources .. "ls_create_both", "", false, self.FILLEDOUTLINED, true))
				l:AddPadding(0)

				for i, but in ipairs(d.createButtons) do
					l:PushV(LM.GUI.ALIGN_CENTER, 0)
						l:AddChild(but, LM.GUI.ALIGN_FILL, 0)
						if LS_Shapes.largeButtons then l:AddChild(LM.GUI.TextList(butW + butW1, 0, 0), LM.GUI.ALIGN_CENTER, 0) end
					l:Pop() --V
					but:SetAlternateMessage(self.FILLED + (i * 2 - 1))
					l:AddPadding(i < #d.createButtons and 1 or 0)
				end
				l:AddPadding(1)
			l:Pop() --H

			l:PushH(LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(20)
				d.swapColBut = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_shape_color_swap", MOHO.Localize("/LS/Shapes/Swap=Swap!"), false, self.COLORSWAP, true)
				l:AddChild(d.swapColBut, LM.GUI.ALIGN_LEFT, 0)
			l:Pop() --H

			l:PushH(LM.GUI.ALIGN_FILL, 1)
				l:AddPadding(2)
				d.lineCheck = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_shape_line", MOHO.Localize("/Scripts/Tool/SelectShape/Stroke=Stroke:"):gsub("[^%w]$", "") .. " (<alt>" .. MOHO.Localize("/LS/Shapes/AnimateVisibility=Animate its visibility instead)"), true, self.LINE, true)
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
				d.lineColOverride = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_shape_override", MOHO.Localize("/LS/Shapes/FillOverride=Line Color Override"), true, self.LINECOLOROVER, true)
				l:AddChild(d.lineColOverride, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(4)
				d.lineWidth = LM.GUI.TextControl(0, LS_Shapes.UseLargeFonts and "00" or "000", self.LINEWIDTH, LM.GUI.FIELD_UFLOAT) --ø
				d.lineWidth:SetUnits(LM.GUI.UNIT_PIXELS) --LM.GUI.UNIT_NONE
				d.lineWidth:SetWheelInc(1.0)
				d.lineWidth:SetWheelInteger(true) --false?
				d.lineWidth:SetValue(style ~= nil and style.fLineWidth or LS_Shapes.MohoLineWidth * docH)
				l:AddChild(d.lineWidth, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(-2)
				d.lineWidthOverride = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_shape_override", MOHO.Localize("/LS/Shapes/FillOverride=Line Width Override"), true, self.LINEWIDTHOVER, true)
				l:AddChild(d.lineWidthOverride, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(4)
				l:PushV(LM.GUI.ALIGN_CENTER, 0)
					d.capsBut = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_shape_round_caps", MOHO.Localize("/Windows/Style/RoundCaps=Round caps"), true, self.ROUNDCAPS, true)
					d.capsBut:SetValue(style == nil or style.fLineCaps == 1)
					l:AddChild(d.capsBut, LM.GUI.ALIGN_FILL, 0)
					if LS_Shapes.largeButtons then l:AddChild(LM.GUI.TextList((butW + butW1) / 1.333, 0, 0), LM.GUI.ALIGN_FILL, 0) end
				l:Pop() --V 
				l:AddPadding(-2)
				--d.brushPreview = MOHO.MeshPreview(LS_Shapes.largeButtons and 22 or 16, 22) -- It seems LM_MeshPreview widget doesn't display brushes. Oh, well...
				--d.brushPreview:SetToolTip(MOHO.Localize("/Dialogs/BrushPicker/NoBrush=No Brush"))
				--l:AddChild(d.brushPreview)
				l:AddPadding(2)
				l:AddPadding(0)

				l:PushV(LM.GUI.ALIGN_CENTER, 0)
					d.brushBut = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_shape_brush", MOHO.Localize("/Dialogs/BrushPicker/Brush=Brush"), true, self.BRUSH, true) --/Dialogs/BrushPicker/NoBrush=No Brush
					l:AddChild(d.brushBut, LM.GUI.ALIGN_FILL, 0)
					l:PushV(LM.GUI.ALIGN_FILL, 0)
						l:AddPadding(-11) --15
						d.brushMenu = LM.GUI.Menu("🖌")
						d.brushMenuPopup = LM.GUI.PopupMenu(LS_Shapes.UseLargeFonts and menuW + 4 or 22, false) --LS_Shapes.largeButtons and butW + butW1 or 22
						d.brushMenuPopup:SetMenu(d.brushMenu)
						l:AddChild(d.brushMenuPopup, LM.GUI.ALIGN_FILL, 0)
					l:Pop() --V
				l:Pop() --V
				--l:AddChild(LM.GUI.Divider(true), LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(1)
			l:Pop() --H

			l:AddPadding(4)
			l:AddChild(LM.GUI.TextList(0, 1), LM.GUI.ALIGN_FILL, 0)
			l:PushV(LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(-2)
				--l:Unindent(2)
				l:PushV(LM.GUI.ALIGN_LEFT, 1)
					l:PushH(LM.GUI.ALIGN_LEFT, 0)
						l:AddPadding(LS_Shapes.UseLargeFonts and -24 or -20) -- Swipe left (-24 or -20)
						l:AddPadding(0) -- Allows right-side clipping provided that container below isn't wider?
						d.multiMenu = LM.GUI.Menu("Multi Menu")
						d.multiMenuPopup = LM.GUI.PopupMenu(LS_Shapes.UseLargeFonts and 56 or 44, true) -- Popup width (54 or 42)
						d.multiMenuPopup:SetToolTip(MOHO.Localize("/LS/Shapes/MultiFunctionMenu=Multi-Function Menu"))
						d.multiMenuPopup:SetMenu(d.multiMenu)
						d.multiMenu:AddItem("⚫ " .. MOHO.Localize("/LS/Shapes/Fill=Fill"), 0, self.MULTIMENU) 
						d.multiMenu:AddItem("⚪ " .. MOHO.Localize("/LS/Shapes/Stroke=Stroke"), 0, self.MULTIMENU + 1)
						d.multiMenu:AddItem("📌 " .. MOHO.Localize("/LS/Shapes/FXTransform=FX Transform"), 0, self.MULTIMENU + 2)
						d.multiMenu:AddItem("🌈‍ " .. MOHO.Localize("/LS/Shapes/Recolor=Recolor"), 0, self.MULTIMENU + 3)
						d.multiMenu:AddItem("", 0, 0)
						d.multiMenu:AddItem(MOHO.Localize("/LS/Shapes/CopyValues=Copy Values"), 0, self.MULTIMENU + 4) --✂
						d.multiMenu:AddItem(MOHO.Localize("/LS/Shapes/PasteValues=Paste Values"), 0, self.MULTIMENU + 5) --📋
						d.multiMenu:AddItem(MOHO.Localize("/LS/Shapes/ResetValues=Reset Values"), 0, self.MULTIMENU + 6) --↺
						d.multiMenu:AddItem("", 0, 0)
						d.multiMenu:AddItem("UTILITIES: ", 0, 0) d.multiMenu:SetEnabled(0, false)
						d.multiMenu:AddItem("   " .. MOHO.Localize("/LS/Shapes/InvertColor=Invert Color"), 0, self.MULTIMENU + 7) --◑
						d.multiMenu:AddItem("   " .. MOHO.Localize("/LS/Shapes/MultiplyColor=Multiply Colors"), 0, self.MULTIMENU + 8) --× Add Colors, Subtract Colors?
						d.multiMenu:AddItem("", 0, 0)
						d.multiMenu:AddItem("OPTIONS: ", 0, 0) d.multiMenu:SetEnabled(0, false)
						d.multiMenu:AddItem("   " .. MOHO.Localize("/LS/Shapes/AffectsFills=Affects Fills"), 0, self.MULTIMENU + 9)
						d.multiMenu:AddItem("   " .. MOHO.Localize("/LS/Shapes/AffectsStrokes=Affects Strokes"), 0, self.MULTIMENU + 10)
						d.multiMenu:AddItem("   " .. MOHO.Localize("/LS/Shapes/AffectsAlpha=Affects Alpha"), 0, self.MULTIMENU + 11)
						l:AddChild(d.multiMenuPopup, LM.GUI.ALIGN_FILL, 0)
						l:AddPadding(LS_Shapes.UseLargeFonts and -20 or -16) -- Right clipping (-20 or -16)
					l:Pop() --H
					d.hsvBut = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_color_hsb", MOHO.Localize("/LS/Shapes/UseHSB=Use HSB") .. (LS_Shapes.beginnerMode and " (" .. MOHO.Localize("/LS/Shapes/HSB=Hue, Sat. & Bright.") .. ")" or "") , true, self.HSV, true)
					l:AddChild(d.hsvBut, LM.GUI.ALIGN_FILL, 1)
				l:Pop() --V
				l:AddPadding(-d.multiMenuPopup:Height() - d.hsvBut:Height() - 1) -- + 2 (if Unindent/Indent)
				l:PushV(LM.GUI.ALIGN_RIGHT, 1)
					l:PushH(LM.GUI.ALIGN_RIGHT, 0)
						l:AddPadding(24) -- Left padding to avoid overlapping (along with Apply button padding below)
						d.multi1 = LM.GUI.TextControl(0, LS_Shapes.UseLargeFonts and "-0" or "000", self.MULTI1, LM.GUI.FIELD_FLOAT) --"0  0" --32
						d.multi1:SetUnits(LM.GUI.UNIT_NONE)
						d.multi1:SetWheelInc(2)
						d.multi1:SetWheelInteger(true)
						l:AddChild(d.multi1, LM.GUI.ALIGN_FILL, 0)
						l:AddPadding(1)
						d.multi2 = LM.GUI.TextControl(0, LS_Shapes.UseLargeFonts and "-0" or "000", self.MULTI2, LM.GUI.FIELD_FLOAT)
						d.multi2:SetUnits(LM.GUI.UNIT_NONE)
						d.multi2:SetWheelInc(2)
						d.multi2:SetWheelInteger(true)
						l:AddChild(d.multi2, LM.GUI.ALIGN_FILL, 0)
						l:AddPadding(1)
						d.multi3 = LM.GUI.TextControl(0, LS_Shapes.UseLargeFonts and "-0" or "000", self.MULTI3, LM.GUI.FIELD_FLOAT)
						d.multi3:SetUnits(LM.GUI.UNIT_NONE)
						d.multi3:SetWheelInc(2)
						d.multi3:SetWheelInteger(true)
						l:AddChild(d.multi3, LM.GUI.ALIGN_FILL, 0)
						l:AddPadding(1)
						d.multi4 = LM.GUI.TextControl(0, LS_Shapes.UseLargeFonts and "-0" or "000", self.MULTI4, LM.GUI.FIELD_FLOAT) --34
						d.multi4:SetUnits(LM.GUI.UNIT_PERCENT)
						d.multi4:SetPercentageMode(true)
						d.multi4:SetWheelInc(0.1)
						d.multi4:SetWheelInteger(false)
						l:AddChild(d.multi4, LM.GUI.ALIGN_FILL, 0)
						l:AddPadding(1)
					l:Pop() --H
					d.applyBut = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_mode_apply", MOHO.Localize("/LS/Shapes/ApplyMode=Apply") , false, self.APPLY, true)
					d.applyBut:SetAlternateMessage(self.APPLY_ALT)
					l:AddChild(d.applyBut, LM.GUI.ALIGN_FILL, 24) -- Left padding to avoid overlapping (along with padding above)
				l:Pop() --V
				--l:Indent(2)
			l:Pop() --V
		end

		if LS_Shapes.advanced then
			l:AddPadding(4)
			l:AddChild(LM.GUI.TextList(0, 1), LM.GUI.ALIGN_FILL, 0)
			l:PushH(LM.GUI.ALIGN_FILL, 0)
				l:Unindent(3)
				l:PushH(LM.GUI.ALIGN_LEFT, 0)
					l:AddPadding(-4)
					d.style1Menu = LM.GUI.Menu("Style 1") --¹²₁₂⒈⒉
					d.style1MenuPopup = LM.GUI.PopupMenu(math.floor((mainW + butW + butW1 + padH - menuW - 8) / 2), true) ---6
					--d.style1MenuPopup:SetToolTip(MOHO.Localize("/Windows/Style/Style1=Style 1") .. " (" .. MOHO.Localize("/LS/Shapes/AppliesAbove=Applies Above") .. ")")
					d.style1MenuPopup:SetMenu(d.style1Menu)
					l:AddChild(d.style1MenuPopup, LM.GUI.ALIGN_LEFT, 0)
				l:Pop() --H
				l:AddPadding(1)
				d.swapBut = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_shape_style_swap", MOHO.Localize("/LS/Shapes/Swap=Swap!"), false, self.STYLESWAP, true)
				l:AddChild(d.swapBut, LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(1)
				l:PushH(LM.GUI.ALIGN_LEFT, 0)
					l:AddPadding(-4)
					d.style2Menu = LM.GUI.Menu("Style 2")
					d.style2MenuPopup = LM.GUI.PopupMenu(math.floor((mainW + butW + butW1 + padH - menuW - 8) / 2), true) --6
					--d.style2MenuPopup:SetToolTip(MOHO.Localize("/Windows/Style/Style2=Style 2") .. " (" .. MOHO.Localize("/LS/Shapes/AppliesBelow=Applies Below") .. ")")
					d.style2MenuPopup:SetMenu(d.style2Menu)
					l:AddChild(d.style2MenuPopup)
				l:Pop() --H
				l:AddPadding(2)
				l:AddPadding(0)
				d.swatchMenu = LM.GUI.Menu("🎨") --⊞▦▩⩩⩨
				d.swatchMenuPopup = LM.GUI.PopupMenu(LS_Shapes.UseLargeFonts and menuW + 4 or menuW, false) --8 + 2?
				d.swatchMenuPopup:SetMenu(d.swatchMenu)
				l:AddChild(d.swatchMenuPopup)
				l:AddPadding(2)
				l:Indent(3)
			l:Pop() --H

			if LS_Shapes.swatch ~= -1 then
				l:AddPadding(3)
				--[[
				l:PushH(LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(-2)
					--d.dummySlider = LM.GUI.Slider(math.ceil(mainW / 1.111), true, true, 0) --LM.GUI.FOLLOW_LEFT
					d.swatchSlider = LM.GUI.Slider(mainW / 1.3, true, false, LS_ShapesDialog.SWATCHSLIDER) --LM.GUI.FOLLOW_LEFT
					d.swatchSlider:SetToolTip("Color Slider")
					d.swatchSlider:SetRange(-255, 0)
					d.swatchSlider:SetValue(-255)
					d.swatchSlider:SetSnapToTicks(false)
					l:AddChild(d.swatchSlider, LM.GUI.ALIGN_FILL, 0)
					l:AddPadding(-1)
					d.colorPreview = MOHO.MeshPreview(mainW - 2, mainW / 1.6)
					l:AddChild(d.colorPreview)
				l:Pop() --H
				--]]
				l:PushH(LM.GUI.ALIGN_LEFT, 0)
					l:AddPadding(-31)
					l:PushV(LM.GUI.ALIGN_LEFT, 0)
						--d.dummySlider = LM.GUI.Slider(math.ceil(mainW / 1.111), true, true, 0) --LM.GUI.FOLLOW_LEFT
						d.swatchSlider = LM.GUI.Slider((mainW + butW + butW1) / 1.6, true, false, LS_ShapesDialog.SWATCHSLIDER) --LM.GUI.FOLLOW_LEFT
						d.swatchSlider:SetRange(-255, 0)
						d.swatchSlider:SetValue(-255)
						--d.swatchSlider:SetNumTicks(8)
						--d.swatchSlider:SetShowTicks(true)
						d.swatchSlider:SetSnapToTicks(false)
						d.swatchSlider:Enable(false)
						l:AddChild(d.swatchSlider, LM.GUI.ALIGN_FILL, 0)
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
		if LS_Shapes.showInfobar then
			if LS_Shapes.advanced then 
				l:AddPadding(LS_Shapes.swatch == -1 and 1 or 0)
				--d.dummyList2 = LM.GUI.ImageTextList(0, 1, 0) -- Keep it just in case a separator be more necessary at some point... 
				--l:AddChild(d.dummyList2, LM.GUI.ALIGN_FILL, 0)
				--l:AddPadding(2)
				--l:AddPadding(LS_Shapes.swatch == -1 and 2 or 4)
			else
				l:AddPadding(1)
			end
			l:PushV(LM.GUI.ALIGN_FILL, 0)
				l:AddPadding(2)
				d.infoBut = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info_small", "Copy Info", true, self.INFO, true)
				l:AddChild(d.infoBut, LM.GUI.ALIGN_LEFT, 2)
				d.infobar = LM.GUI.DynamicText("ℹ Room For Some Info", 0) d.infobar:Enable(false)
				l:AddPadding(-(d.infobar:Height() - (LS_Shapes.UseLargeFonts and 7 or 4))) --print(d.i:Height(), d.infobar:Height()) --18
				l:AddChild(d.infobar, LM.GUI.ALIGN_FILL, d.infoBut:Width() + 4)
			l:Pop() --V
		end
	l:Pop() --V

	return d
end

--function LS_ShapesDialog:UpdateWidgets(moho) --print("LS_ShapesDialog:UpdateWidgets(" .. tostring(moho) .. "): ", " 🕗: " .. os.clock())
	-- This only run once upon opening the dialog even if its modeless, so using "Update()" function bellow for al purposes instead. 🤔 Not sure if at some point it may have some use...
--end

function LS_ShapesDialog:Update() --print("LS_ShapesDialog:Update(" .. tostring(moho) .. "): ", " 🕗: " .. os.clock()) --MARK:-UP(D)
	--local caller = debug.getinfo(5) and debug.getinfo(5).name or "NULL" --0: getinfo, 1: Update, 2: func, 3: NULL/NULL, 4: NULL/UpdateUI, 5: NULL/NULL
	local helper = MOHO.ScriptInterfaceHelper:new_local()
	local moho = helper:MohoObject() self.p.m = self.p and moho or nil
	local pro = MOHO.IsMohoPro()
	local doc = moho.document --local doc = (LS_Shapes.defDoc and LS_Shapes.defDoc ~= moho.document) and LS_Shapes.defDoc or moho.document --print("UP: " .. (doc and doc:Name()) or "No Doc") --20240102-1638: Attempt to patch the new opening document mess! --20240103-1809: Back to normality after fixing the cause? (TBO!)
	local docName = doc and doc:Name() or nil
	local docH = doc and doc:Height() or 240
	local frame = moho.frame
	local toolName = (doc ~= nil and doc:Name() ~= "-") and moho:CurrentTool() or "" --20231223-2350: Extra-checking is for avoiding crashes upon auto-opening
	local tool = _G[toolName] --print(toolName, ", ", tool:Name(), ", ", tool.dragMode)
	local toolsDisabled = moho:DisableDrawingTools()
	local mode = LS_Shapes.mode
	local modes = {[0] = "/Windows/Style/DefaultsForNewShapes=DEFAULTS (For new shapes)", "/Windows/Style/SHAPE=SHAPE", "/Windows/Style/STYLE=STYLE", "/LS/Shapes/GROUP=GROUP (For point groups)"}
	local l = self.GetLayout and self:GetLayout() or nil --20231223-2350: Extra-checking is for avoiding crashes upon auto-opening
	local msg = self.msg ~= nil and self.msg or MOHO.MSG_BASE
	self.tempShape = moho:NewShapeProperties() or MOHO.MohoGlobals.NewShapeProperties

	local itemCount = self.itemList and self.itemList:CountItems() or 1
	local itemsSel = self.itemList and math.floor(self.itemList:NumSelectedItems() + (self.itemList:IsItemSelected(0) == true and -1 or 0))
	local itemSel = self.itemList and math.floor(self.itemList:SelItem()) - 1 or -1
	local itemLabel = ""
	local itemsForBusy = 64 -- Minimum items to gray-out the list while busy 

	local brush = doc and moho:CurrentEditStyle() and tostring(moho:CurrentEditStyle().fBrushName:Buffer():gsub("%.[^.]+$", "")) or ""
	local styleName = doc and moho:CurrentEditStyle() and tostring(moho:CurrentEditStyle().fName:Buffer()) or "" -- 20250730-2130: Had to also check doc existence here & below to avoid (I think new in v14.3) crashes
	local style = doc and moho:CurrentEditStyle() -- 20231010-0554: For some reason, "styleName" must be gathered before this assignment, otherwise it won't be possible to access "style" properties afterwards!
	local styleID = -1 --print(styleName .. " (" .. tostring(style) .. "): ", tostring(style.fFillCol.value.r), ", ", tostring(style.fFillCol.value.g), ", ", tostring(style.fFillCol.value.b))
	local styleUUID = style and style.fUUID:Buffer() or "" --doc:StyleByID(i) print(iStyle.fUUID:Buffer())
	local styleCount = doc and math.floor(doc:CountStyles()) or 0
	local styleSelID = LS_Shapes.mode == 2 and math.floor(self.itemList:SelItem()) - 1 or -1
	local styleSel = doc and doc:StyleByID(styleSelID) or style
	local styleSelUUID = LS_Shapes.mode == 2 and styleSel and styleSel.fUUID:Buffer() or ""
	local stylesSel = styleName and styleName ~= "" and 1 or LS_Shapes:CountSelectedStyles(doc) --self.itemList and (math.floor(self.itemList:NumSelectedItems() + (self.itemList:IsItemSelected(0) == true and -1 or 0))) or 0
	local style1Name, style2Name = (self.tempShape and self.tempShape.fInheritedStyle) and tostring(self.tempShape.fInheritedStyle.fName:Buffer()) or "", (self.tempShape and self.tempShape.fInheritedStyle2) and tostring(self.tempShape.fInheritedStyle2.fName:Buffer()) or "" -- See note 20231010-0554 above!
	local style1, style2 = (styleName == "" and self.tempShape) and self.tempShape.fInheritedStyle or nil, (styleName == "" and self.tempShape) and self.tempShape.fInheritedStyle2 or nil
	local style1UUID, style2UUID = style1 and style1.fUUID:Buffer() or nil, style2 and style2.fUUID:Buffer() or nil
	local style1ID, style2ID = LS_Shapes:StyleID(doc, style1), LS_Shapes:StyleID(doc, style2)
	local styleUUIDToShow = styleName ~= "" and styleUUID or (styleSelID > - 1 and styleSelUUID or styleUUID)
	local styleTable = {}
	LS_Shapes:Log("START", moho)

	if (style ~= nil) then
		--brush = style.fBrushName:Buffer():gsub("%.[^.]+$", "")
		if LS_Shapes.advanced then --print(style.fLineWidth, ", ", moho:NewShapeLineWidth())
			self.fillCol:SetValue(style.fFillCol and style.fFillCol.value or MOHO.MohoGlobals.FillCol)
			self.lineCol:SetValue(style.fLineCol and style.fLineCol.value or MOHO.MohoGlobals.LineCol)
			self.lineWidth:SetValue((style.fLineWidth or moho:NewShapeLineWidth() or LS_Shapes.MohoLineWidth) * docH) --tonumber(string.format("%.2f\n", (style.fLineWidth ~= nil and style.fLineWidth or moho:NewShapeLineWidth()) * docH))
			self.capsBut:SetValue(style.fLineCaps == nil or style.fLineCaps == 1) --self.capsBut:SetValue(style.fLineCaps == 1 and true or false) --style.fLineCaps ~= nil and (style.fLineCaps == 1 and true or false)
			self.brushBut:SetValue(style.fBrushName and style.fBrushName:Buffer() ~= "")
			self.brushBut:Enable(style.fBrushName and style.fBrushName:Buffer() ~= "")
			--print(self.swatchSliderVal, ", ", self.swatchSlider and self.swatchSlider:Value() or "?")
		end
		for i = 0, styleCount - 1 do
			local iStyle = doc:StyleByID(i)
			if iStyle == style then
				styleID = math.floor(i)
				break
			elseif iStyle.fSelected then
				styleID = math.floor(i)
			end
		end
		if styleName == "" then
			self.info[1] = (doc and moho:DrawingMesh()) and "" or "v" .. LS_Shapes.version .. " " .. LS_Shapes.stage .. (LS_Shapes.debugMode and " · 🐞" or "") .. " · " .. MOHO.Localize("/LS/Shapes/NotAVector=No vector...")
			self.info[2] = (doc and moho:DrawingMesh()) and self.info.n .. math.floor(moho:CountShapes()) or nil
			self.info[3] = nil -- NOTE: Ensure next index of a potentially nil one is also nil to prevent concat errors!
		else
			LS_Shapes.mode = 2
			self.itemName:SetValue(styleName or "?")
			self.info[1] = self.info[1] or ""
			self.info[2] = self.info.id .. styleID --self.info[2] = shapeLUID > -1 and self.info.id .. shapeLUID or self.info.id .. "?" --string.format("%d", shape:ShapeID())
			self.info[3] = styleCount > 0 and self.info.n .. itemsSel .. "/" .. styleCount or self.info.n .. styleCount
			self.info[4] = self.info.uid .. (styleUUIDToShow ~= "" and styleUUIDToShow or "?")
			self.info["uid1"] = styleUUIDToShow ~= "" and styleUUIDToShow:match("([^%-]+)") or "" -- The first group
			self.info["uid2"] = styleUUIDToShow ~= "" and styleUUIDToShow:match("(-.-)$") or "" -- All but the first group
		end
	end

	local layer = moho.layer
	local layerUUID = doc and layer:UUID()
	local lFrame = doc and moho.layerFrame
	local lFrameAlt = doc and moho.frame + (layer and layer:TotalTimingOffset() or 0)
	local lDrawing = (doc and moho.drawingLayer) and moho:LayerAsVector(moho.drawingLayer) or nil
	local lDrawingUUID = lDrawing and lDrawing:UUID() or ""
	local lDrawingFrame = lDrawing and moho.drawingLayerFrame or 0
	local lDrawingFrameAlt = moho.frame + (lDrawing and lDrawing:TotalTimingOffset() or 0)
	local lDrawingOrderCh = (doc and moho:DrawingMesh() and moho:DrawingMesh():AnimatedShapeOrder()) and LS_Shapes:ChannelByID(moho, lDrawing, CHANNEL_SHAPE_ORDER) or nil -- 20250725: Must be before mesh assignment or there be dragons...
	local lDrawingOrderKey = lDrawingOrderCh and lDrawingOrderCh:HasKey(lFrameAlt) or false
	local mesh = doc and moho:DrawingMesh()
	local item = nil
	local itemID = -1
	local pointsSel = doc and moho:CountSelectedPoints()
	local edges = doc and moho:CountEdges()
	local edgesSel = doc and moho:CountSelectedEdges()
	local group = mesh and LS_Shapes:SelectedGroup(mesh)
	local groupID = group and mesh:GroupID(group) or -1
	local groupName = group and group:Name() or ""
	local groupCount = mesh and math.floor(mesh:CountGroups()) or 0
	local groupSelCount = 0
	local groupPtCount = group and math.floor(group:CountPoints()) or nil

	---[[20231014-1955: Try to move all this to DoLayout? They may not need to be updated all the time after all...
	--if (msg >= self.MAINMENU and msg <= self.MAINMENU + self:CountRealItems(self.menu1) - 1) then -- Do nothing else than update the menu?
		self.menu1:SetChecked(self.MAINMENU, LS_Shapes.syncWithStyle)
		self.menu1:SetChecked(self.MAINMENU + 1, LS_Shapes.ignoreNonRegular)
		self.menu1:SetChecked(self.MAINMENU + 2, LS_Shapes.openOnStartup)
		self.menu1:SetChecked(self.MAINMENU + 3, LS_Shapes.showInTools)
		self.menu1:SetChecked(self.MAINMENU + 4, LS_Shapes.beginnerMode)
		self.menu1:SetChecked(self.MAINMENU + 5, LS_Shapes.debugMode)
		self.menu1:SetChecked(self.MAINMENU + 6, LS_Shapes.advanced)
		self.menu1:SetChecked(self.MAINMENU + 7, LS_Shapes.largeButtons)
		self.menu1:SetChecked(self.MAINMENU + 8, LS_Shapes.largePalette)
		self.menu1:SetChecked(self.MAINMENU + 9, LS_Shapes.showInfobar)
		--helper:delete() return
	--end
	--]]

	--self.itemNameLabel:Enable(true)
	if LS_Shapes.advanced then
		if self.swatchMenu:CountItems() == 0 then
			self.swatchMenu:AddItem(MOHO.Localize("/Dialogs/BrushPicker/None=None"), 0, self.SELECTSWATCH)
			--d.swatchMenu:AddItem(MOHO.Localize("/Windows/Style/Default=Default"):upper() .. " " .. MOHO.Localize("/Windows/Style/Swatches=Swatches"):upper(), 0, self.SELECTSWATCH + 3) d.swatchMenu:SetEnabled(self.SELECTSWATCH + 3, false) --"/Windows/Style/Swatches=Swatches"
			self.swatchMenu:AddItem("", 0, 0)
			local count = self.SELECTSWATCH
			for i, doc in ipairs(LS_Shapes.docList) do
				local swatchCount = 0
				local owner = doc:Path():find(moho:UserAppDir() .. "/Scripts/ScriptResources/ls_shapes/Swatches/") and " (🏭)" or (doc:Path():find(moho:UserAppDir() .. "/Swatches/") and " (👤)") or ""
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
							self.countFactory = doc:Path():find(moho:UserAppDir() .. "/Scripts/ScriptResources/ls_shapes/Swatches/") and self.countFactory + 1 or self.countFactory
							table.insert(self.swatches[i], {label = icon .. doc:Layer(j):Name(), shortcut = 0, msg = count, id = j, kind = kind, suffix = "", enable = true}) --self.swatchMenu:AddItem(icon .. doc:Layer(j):Name(), 0, count)
							if mesh:ShapeByName("SLIDER") ~= nil then
								--print(layer:Name())
							end
						end
					end
	
				end
				self.swatches[i].count = swatchCount
				--suffix = countValid > 0 and (doc:Path():find(moho:UserAppDir() .. "\\Scripts\\ScriptResources\\ls_shapes\\") and " (Factory)") or (doc:Path():find(moho:UserAppDir() .. "\\Swatches\\") and " (User)") or " (0)"
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
			self.swatchMenu:AddItem(MOHO.Localize("/LS/Shapes/CutomSwatches=Custom Swatches..."), 0, count + 1)
			self.swatchMenu:AddItem(MOHO.Localize("/LS/Shapes/UseSelection=Use Selection"), 0, count + 2) self.swatchMenu:SetEnabled(count + 2, false) --TODO?
			self.swatchMenu:AddItem(MOHO.Localize("/LS/Shapes/EditCurrentSwatch=Edit Current Swatch"), 0, count + 3)
			self.swatchMenu:AddItem(MOHO.Localize("/LS/Shapes/ReloadSwatches=Reload Swatches"), 0, count + 4)

			if LS_Shapes.swatch ~= -1 and LS_Shapes.swatch ~= self.swatch then
				self:UpdateColor(moho)
			end
		end
		LS_Shapes:Log("1.1")
		self.swatchMenu:UncheckAll()
		--self.swatchMenu:SetChecked(self.SELECTSWATCH, LS_Shapes.swatch == -1) -- None
		--self.swatchMenu:SetChecked(self.SELECTSWATCH + self:CountRealItems(self.swatchMenu) - 1 + 1, LS_Shapes.swatch == -2) -- Use 
		self.swatchMenu:SetChecked((self.SELECTSWATCH + LS_Shapes.swatch + 1), true)
		self.swatchMenu:SetEnabled(self.SELECTSWATCH + self:CountRealItems(self.swatchMenu, self.SELECTSWATCH) - 2, LS_Shapes.swatch > self.countFactory - 1)
		for i = self.SELECTSWATCH + 3, self.SELECTSWATCH + self:CountRealItems(self.swatchMenu, self.SELECTSWATCH) - 2 do --print(math.abs(self.SELECTSWATCH - i))
			--self.swatchMenu:SetChecked(i, LS_Shapes.swatch == math.abs((self.SELECTSWATCH + 3) - i)) -- List Entry
		end

		if LS_Shapes.brushList and self.brushMenu:CountItems() == 0 then
			local topEntries = 2
			local brushCount = topEntries
			local factCount, userCount = -topEntries, 0
			for brush in pairs(LS_Shapes.brushList) do
				local brushPath = LS_Shapes.brushList[brush]
				if brushPath and brushPath:match(moho:UserAppDir()) then
					userCount = userCount + 1
				end
				self.brushMenu:AddItemAlphabetically(brush, 0, self.SELECTBRUSH + brushCount)
				brushCount = brushCount + 1
			end
			factCount = (brushCount - topEntries) - userCount --print(brushCount, ", ", factCount, ", ", userCount)
			if brushCount > topEntries then --print(#LS_Shapes.brushList, ", ", brushCount) 
				self.brushMenu:AddItem(nil, 0, 0)
				self.brushMenu:AddItem(MOHO.Localize("/LS/Shapes/CancelAndCloseMenu=Cancel & Unfold"), 0, self.SELECTBRUSH + brushCount + 1)
			else
				self.brushMenu:AddItem(MOHO.Localize("/LS/Shapes/NoBrushesListed=No Brushes Listed"), 0, self.SELECTBRUSH + brushCount + 1) --No Factory nor Custom Brushes Listed
				self.brushMenu:SetEnabled(self.SELECTBRUSH + brushCount + 1, false) 
			end
			--d.brushMenu:InsertItem(0, MOHO.Localize("/LS/Shapes/ReloadBrushes=Reload Brushes"), 0, self.SELECTBRUSH)
			self.brushMenu:InsertItem(0, MOHO.Localize("/LS/Shapes/ListFactoryBrushes=List Factory Brushes") .. (factCount > 0 and " (" .. factCount .. ")" or ""), 0, self.SELECTBRUSH)
			self.brushMenu:InsertItem(1, MOHO.Localize("/LS/Shapes/ListCustomBrushes=List Custom Brushes") .. (userCount > 0 and " (" .. userCount .. ")" or ""), 0, self.SELECTBRUSH + 1)
			--self.brushMenu:InsertItem(1, MOHO.Localize("/LS/Shapes/ListMultiBrushesOnly=List Multi-Brushes Only"), 0, self.SELECTBRUSH + 2) --TBC?
			self.brushMenu:InsertItem(2, nil, 0, 0)
			--d.brushMenu:InsertItem(3, MOHO.Localize("/Windows/Style/None=<None>"), 0, self.SELECTBRUSH + 2)
		end

		self.brushMenu:UncheckAll()
		self.brushMenu:SetCheckedLabel(brush, true)
		self.brushMenu:SetChecked(self.SELECTBRUSH, MOHO.hasbit(LS_Shapes.brushDirectory, 1))
		self.brushMenu:SetChecked(self.SELECTBRUSH + 1, MOHO.hasbit(LS_Shapes.brushDirectory, 2))

		--self.style1Menu:RemoveAllItems()
		--self.style1Menu:AddItem(MOHO.Localize("/Windows/Style/New=New"), 0, baseMsg)
		--self.style1Menu:AddItem("", 0, 0)
		--self.style1Menu:AddItem(MOHO.Localize("/Scripts/Utility/None=<None>"), 0, baseMsg)

		LS_Shapes:BuildStyleChoiceMenu(self.style1Menu, doc, self.SELECTSTYLE1, self.DUMMY) -- NOTE! (20240118-0806): Here is where style became an LM_String!
		LS_Shapes:BuildStyleChoiceMenu(self.style2Menu, doc, self.SELECTSTYLE2, self.DUMMY) -- ERROR (20250915-1745): invalid value (nil) at index 1 in table for 'concat' (during style creation by the Style window)
	
		for i, but in ipairs(self.createButtons) do
			--but:Enable(((edgesSel > 0 or pointsSel > 0) and not toolsDisabled) or LS_Shapes.mode > 1)
		end
	end

	--self.menu1Popup:Enable(self.menu1Popup and self.menu1:CountItems() > 0 or false)
	--self.menu2Popup:Enable(self.menu2Popup and self.menu2:CountItems() > 0 or false)
	--self.menu3Popup:Enable(self.menu3Popup and self.menu3:CountItems() > 0 or false)
	--MARK:NO LAYER
	if (mesh == nil) or ((lDrawing and lDrawing:IsCurver()) or (lDrawing:IsWarpLayer() and (lDrawing:ContinuousTriangulation() or LS_Shapes.ignoreNonRegular))) then -- Disable everything irrelevant if no valid/drawing layer is active ("Ignore Non-Regular" makes e.g. non-continuously-triangulated layers be also ignored)
		--l:Enable(false) -- Used classic enable/disable method due to this causes unwanted blinking at frame change and so...
		self.menu1Popup:Enable(true)
		self.modeBut:Enable(false)
		self.itemName:Enable(false)
		self.itemName:SetValue("")
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
		self.animOrder:Enable(false)
		self.animOrder:SetValue(false)
		self.lower:Enable(false)
		self.selectAllBut:Enable(false)
		self.selectMatchingBut:Enable(false)
		self.selectPtBasedBut:Enable(false)
		self.deleteBut:Enable(false)
		self.copyBut:Enable(true)
		self.pasteBut:Enable((self.copiedStyle and true or false) or (self.copiedColor and true or false))
		self.resetBut:Enable(true)
		if (self.layerUUID and self.layerUUID ~= layerUUID) then
			self:UpdateItem(moho) -- Clear itemPreview
		end
		self.skipBlock = true

		if self.itemList:SelItem() > 0 then
			self.skipAll = true
			self.itemList:SetSelItem(self.itemList:GetItem(0), false, false)
			self.skipAll = false
		end
		for i = self.itemList:CountItems(), 1, -1 do
			self.itemList:RemoveItem(i, false)
		end
		self.skipBlock = false
		self.itemList:Enable(false)
		self.itemList:Redraw()

		if LS_Shapes.advanced then
			self.fillCheck:Enable(false)
			self.fillCheck:SetValue(true)
			self.fillCol:Enable(true)
			self.fillColOverride:Enable(LS_Shapes.mode == 2 and style and styleName ~= "")
			self.fillColOverride:SetValue(style and style.fDefineFillCol)

			self.lineCheck:Enable(false)
			self.lineCheck:SetValue(true)
			self.lineCol:Enable(true)
			self.lineColOverride:Enable(LS_Shapes.mode == 2 and style and styleName ~= "")
			self.lineColOverride:SetValue(style and style.fDefineLineCol)
			--self.widthLabel:Enable(true)
			self.lineWidth:Enable(true)
			self.lineWidthOverride:Enable(LS_Shapes.mode == 2 and style and styleName ~= "")
			self.lineWidthOverride:SetValue(style and style.fDefineLineWidth)
			self.capsBut:Enable(true)
			for i, but in ipairs(self.createButtons) do but:Enable(false) end
			self.style1Menu:SetChecked(style1 and self.SELECTSTYLE1 + 1 + style1ID or self.SELECTSTYLE1, true)
			self.style1MenuPopup:Enable(styleName == "")
			self.style1MenuPopup:Redraw()
			self.swapBut:Enable(styleName == "" and style1UUID ~= style2UUID)
			self.style2Menu:SetChecked(style2 and self.SELECTSTYLE2 + 1 + style2ID or self.SELECTSTYLE2, true)
			self.style2MenuPopup:Enable(styleName == "")
			self.style2MenuPopup:Redraw()

			if LS_Shapes.swatch > -1 then
				self.multiMenuPopup:Enable(false)
				self.hsvBut:Enable(false)
				self.multi1:Enable(false)
				self.multi2:Enable(false)
				self.multi3:Enable(false)
				self.multi4:Enable(false)
				self.applyBut:Enable(false)
			end
		end
		if (LS_Shapes.showInfobar and self.infobar) then
			self.infoText = table.concat(self.info, self.info.sep or " · "):gsub("^" .. self.info.sep .. " *", "")
			if (self.info.uid2 ~= nil) then
				self.infoText = string.gsub(self.infoText, self.info.uid2:gsub("-", "%%-"), "…")
			end
			if self.info.upd then
				self.infobar:SetValue(self.infoText)
				self.infoBut:SetValue(false)
			end
			self.infoBut:Enable(true)
		end

		if (doc == nil) then -- Disable everything else irrelevant if there is no document open
			self.menu1:SetEnabled(self.MAINMENU + 6, false) -- Advanced (Creation Controls)
			self.menu1:SetEnabled(self.MAINMENU + 7, false) -- Use Large Buttons
			self.menu1:SetEnabled(self.MAINMENU + 8, false) -- Use Large Palette
			self.menu1:SetEnabled(self.MAINMENU + 9, false) -- Show Infobar
			self.copyBut:Enable(false)
			self.pasteBut:Enable(false)
			--[[20231214-0521: Commented in order to see if it's really necessary...
			if (LS_Shapes.mode > 1) then
				self.skipBlock = true
				for i = self.itemList:CountItems(), 1, -1 do
					self.itemList:RemoveItem(i, false)
				end
				self.skipBlock = false
			end
			--]]
			if LS_Shapes.advanced then
				self.brushBut:Enable(false)
				self.brushMenuPopup:Enable(false)
				self.style1Menu:SetChecked(self.SELECTSTYLE1, true) self.style1MenuPopup:Redraw()
				self.swapBut:Enable(false)
				self.style2Menu:SetChecked(self.SELECTSTYLE2, true) self.style2MenuPopup:Redraw()
				self.swatchMenuPopup:Enable(false)
				if (LS_Shapes.showInfobar and self.infobar) then
					self.info[1] = "v" .. LS_Shapes.version .. " " .. LS_Shapes.stage .. (LS_Shapes.debugMode and " · 🐞" or "") .. " · " .. MOHO.Localize("/LS/Shapes/NoDoc=No doc...")
					self.infobar:SetValue(table.concat(self.info, self.info.sep or " · "):gsub("^" .. self.info.sep .. " *", ""))
				end
			end
			if LS_Shapes.showInfobar then
				self.infoBut:Enable(false)
			end
		end
		self.layerUUID = (doc and moho.layer) and moho.layer:UUID()
		LS_Shapes:Log("END")
		helper:delete() return --20240206-0515: This return complicates subsequent actions, consider its elimination...
	else -- Enable everything relevant if a valid/drawing layer is active
		mesh.ls = mesh.ls or {}
		mesh.ls_fGroups = mesh and mesh.ls_fGroups or {old = {}}

		--l:Enable(true) -- Used classic enable/disable method due to this causes unwanted blinking at frame change and so...
		self.menu1:SetEnabled(self.MAINMENU + 6, true) -- Advanced (Creation Controls)
		self.menu1:SetEnabled(self.MAINMENU + 7, true) -- Use Large Buttons
		self.menu1:SetEnabled(self.MAINMENU + 8, true) -- Use Large Palette
		self.menu1:SetEnabled(self.MAINMENU + 9, true) -- Show Infobar
		self.modeBut:Enable(true)
		self.pasteBut:Enable((self.copiedStyle and true or false) or (self.copiedColor and true or false))
		--[[20231208-0555: Here seems to be the problem with the unnecesary shape list refreshing upon frame change... STUDY!
		if (LS_Shapes.mode ~= self.mode) then
			self.skipBlock = true
			for i = self.itemList:CountItems(), 1, -1 do
				self.itemList:RemoveItem(i, false)
			end
			self.skipBlock = false
		end
		--]]
		self.itemList:Enable(true) self.itemList:Redraw()

		if LS_Shapes.showInfobar then
			self.infoBut:Enable(true)
		end
	end
	LS_Shapes:Log("1.2")
	---[[20231006-1745: Before selecting items in list much bellow, do here the "Point-Based Selection" thing if active (so then you can rely on shape/shapeID/etc. kind of values)
	if LS_Shapes.mode < 2 then
		if LS_Shapes.pointBasedSel == true and not (lDrawing:IsCurver() or lDrawing:IsWarpLayer()) then
			if not (toolName:find("SelectShape") or toolName:find("Freehand") or toolName:find("Brush") or toolName:find("Eraser")) then
				if styleName == "" and mesh ~= nil and pointsSel > 1 then -- Avoid Point-Based Selection select any shape if a style is being edited to allow normal Style workflow
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
	elseif LS_Shapes.mode == 3 then
		self.fillCheck:Enable(false)
		self.fillCol:Enable(false)
		self.swapColBut:Enable(false)
		self.lineCheck:Enable(false)
		self.lineCol:Enable(false)
		self.lineWidth:Enable(false)
		self.capsBut:Enable(false)
		if LS_Shapes.pointBasedSel3 == true then
			if styleName == "" and mesh ~= nil and pointsSel > 0 then -- Avoid Point-Based Selection select any group if a style is being edited to allow normal Style workflow
				for i = 0, mesh:CountGroups() - 1 do
					local group = mesh:Group(i)
					group.ls_fSelected = true

					for j = 0, group:CountPoints() - 1 do
						local pt = group:Point(j)
						if not pt.fSelected then
							group.ls_fSelected = false
							break
						end
					end
				end
			end
		end
	end
	--]]
	LS_Shapes:Log("1.3")
	local shape = moho:SelectedShape()
	local shapeID = shape and math.floor(mesh:ShapeID(shape)) or -1
	local shapeLUID = shape and math.floor(shape:ShapeID()) or -1 -- LUID: Layer Unique ID
	local shapeName = shape and shape:Name() or ""
	local shapeHandles = shape and shape:HasPositionDependentStyles() or false
	local shapeHandle1, shapeHandle2 = shapeHandles and shape:EffectHandle1(), shapeHandles and shape:EffectHandle2()
	local shapeFxOffset, shapeFxRotation, shapeFxScale = shape and shape.fEffectOffset, shape and shape.fEffectRotation, shape and shape.fEffectScale
	local shapeCount = mesh and math.floor(mesh:CountShapes()) or 0
	local shapesSel = math.floor(moho:CountSelectedShapes(true)) -- Use this instead LM_SelectShape:CountSelectedShapes??
	local shapeTable = {}

	if (shape ~= nil) then -- Shape/s selected... MARK: SHAPE
		LS_Shapes.mode = 1
		style1, style2 = shape.fInheritedStyle, shape.fInheritedStyle2
		style1UUID, style2UUID = style1 and style1.fUUID:Buffer() or nil, style2 and style2.fUUID:Buffer() or nil
		style1ID, style2ID = LS_Shapes:StyleID(doc, style1), LS_Shapes:StyleID(doc, style2)

		if (pro) then
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
					self.combineBlendBut:Enable(lFrameAlt ~= 0)
					self.combineBlendBut:SetValue(shape.fComboBlend:HasKey(lFrameAlt))
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
					self.info[4] = self.info.liq .. position .. "/" .. total
				else
					self.baseBut:Enable(false)
					self.topBut:Enable(false)
					self.mergeBut:Enable(shapesSel > 1)
					self.info[4] = nil
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
				self.info[4] = nil
			end
		end

		self.itemPreview:Enable(true)
		self.itemVisCheck:SetValue(not shape.fHidden)
		if LS_Shapes.advanced then
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
			for i = 0, shapeCount - 1 do
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
		self.info[1] = ""
		self.info[2] = shapeLUID > -1 and self.info.id .. shapeLUID or self.info.id .. "?"
		self.info[3] = shapeCount > 0 and self.info.n .. shapesSel .. "/" .. shapeCount or shapeCount
		--[[202401160210: Moved bellow in order to allow updates upon deselecting and more...
		if not self.shape or self.shape ~= shape then
			self:UpdateItem(moho, shape, false) --20240103-0448: Had to avoid draw fills due to a last minute weird behavior upon undoing after modifyig shapes! (TODO & TBO!)
			--self:UpdateBrush(moho, shape) -- It seems LM_MeshPreview widget doesn't display brushes. Oh, well...
		end
		--]]
	else -- No shape selected... MARK: NO SHAPE
		LS_Shapes.mode = (LS_Shapes.mode == 2 or LS_Shapes.mode == 3) and LS_Shapes.mode or 0
		if (pro) then
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

		self.itemVisCheck:SetValue(true)
		self.itemPreview:Enable(false)
		if LS_Shapes.advanced then
			self.fillCheck:SetValue(true)
			self.fillCheck:Enable(false)
			self.fillCol:Enable(LS_Shapes.mode < 3 and true)
			self.fillColOverride:Enable(styleName ~= "" or (style1 and style1.fDefineFillCol or style2 and style2.fDefineFillCol))
			self.fillColOverride:SetValue(style and style.fDefineFillCol)
			self.lineCheck:SetValue(true)
			self.lineCheck:Enable(false)
			self.lineCol:Enable(LS_Shapes.mode < 3 and true)
			self.lineColOverride:Enable(styleName ~= "" or (style1 and style1.fDefineLineCol or style2 and style2.fDefineLineCol))
			self.lineColOverride:SetValue(style and style.fDefineLineCol)
			self.lineWidthOverride:Enable(styleName ~= "" or (style1 and style1.fDefineLineWidth or style2 and style2.fDefineLineWidth))
			self.lineWidthOverride:SetValue(style and style.fDefineLineWidth)
			self.style1Menu:SetChecked(style1 and self.SELECTSTYLE1 + 1 + style1ID or self.SELECTSTYLE1, true) self.style1MenuPopup:Redraw()
			self.style2Menu:SetChecked(style2 and self.SELECTSTYLE2 + 1 + style2ID or self.SELECTSTYLE2, true) self.style2MenuPopup:Redraw()
		end

		if LS_Shapes.mode < 2 then
			self.info[3], self.info[4] = nil -- NOTE: Removing also index 4 to avoid a gap that then break table.concat!
		elseif LS_Shapes.mode == 2 then
			self.info[1] = self.info.id .. styleID
			self.info[2] = styleCount > 0 and self.info.n .. itemsSel .. "/" .. styleCount or self.info.n .. styleCount
			self.info[3] = self.info.uid .. (styleUUIDToShow ~= "" and styleUUIDToShow or "?")
			self.info[4] = nil
			self.info["uid1"] = styleUUIDToShow ~= "" and styleUUIDToShow:match("([^%-]+)") or "" -- The first group
			self.info["uid2"] = styleUUIDToShow ~= "" and styleUUIDToShow:match("(-.-)$") or "" -- All but the first group
		elseif LS_Shapes.mode == 3 then
			self.info[1] = itemSel > -1 and self.info.id .. itemSel or ""
			self.info[2] = groupCount > 0 and self.info.n .. itemsSel .. "/" .. groupCount or self.info.n .. groupCount
			self.info[3] = groupCount > 0 and (groupPtCount ~= nil and self.info.pt .. groupPtCount) or nil
			self.info[4] = nil
		end
	end

	self.modeBut:SetLabel(MOHO.Localize(modes[LS_Shapes.mode]):gsub("%s+%b()", ""), false)
	if LS_Shapes.mode < 2 then -- SHAPE Modes
		--itemID = shapeCount > 0 and self.itemList:SelItem() > 0 and LM.Clamp(self.itemList:SelItem(), 0, shapeCount) - 1 or -1
		--item = mesh and itemID > -1 and mesh:ShapeByID(itemID) or nil
	elseif LS_Shapes.mode == 2 then -- STYLE Mode
		itemID = styleCount > 0 and self.itemList:SelItem() > 0 and LM.Clamp(self.itemList:SelItem(), 0, styleCount) - 1 or -1
		item = doc and itemID > -1 and doc:StyleByID(itemID) or nil
	else -- GROUP Mode
		itemID = mesh and groupCount > 0 and self.itemList:SelItem() > 0 and LM.Clamp(self.itemList:SelItem(), 0, groupCount) - 1 or -1
		item = mesh and itemID > -1 and mesh:Group(itemID) or nil
	end
	self.groupUI = item --self.groupUI = mesh and mesh:Group(self.itemList:SelItem() > 0 and self.itemList:SelItem() - 1) or nil

	if self.info.upd then
		self.infoText = table.concat(self.info, self.info.sep or " · "):gsub("^" .. self.info.sep .. " *", "")
	end
	if (LS_Shapes.showInfobar and self.infobar) then
		self.infobar:SetToolTip((LS_Shapes.beginnerMode and #self.infoText > 36) and self.infoText or "")
		if (self.info.uid2 ~= nil) then
			self.infoText = string.gsub(self.infoText, self.info.uid2:gsub("-", "%%-"), "…")
		end
		if self.info.upd then
			self.infobar:SetValue(self.infoText) --self.infobar:SetValue(#self.infoText > 30 and (self.infoText):sub(1, 30) .. "…" or self.infoText) -- 2023101011-1530: Discarted for now, since string.sub can "destroy" emojis and cause problems! 
			self.infoBut:SetValue(false)
		end
		self.infobar:Enable(false)
	else
		if self.infobar then
			self.infobar:SetValue("")
		end
		--self.itemNameLabel:SetToolTip(MOHO.Localize("/Windows/Style/Name=Name") .. " (" .. self.infoText .. ")")
		self.itemPreview:SetToolTip(self.infoText)
	end

	if self.skipBlock == true then --if self.skipBlock == true and toolName:find("SelectPoints") then -- 20231007-1730: Perform ONLY widget updates above when called from HandlMessage/UpdateUI in order to avoid entering into endless loop!
		LS_Shapes:Log("END")
		helper:delete() return
	end

	LS_Shapes:Log("1.4") --[Start of item update block]--
	if LS_Shapes.mode < 2 then -- Shape Modes... --MARK: CURSTATE
		---[[Performance Overhaul 
		self.skipBlock = true --local t1a = os.clock() -- Skip unnecessay HandleMessage parts during the whole refresh
		local currentCount, desiredCount = itemCount, shapeCount + 1 -- +1 for index 0 being always reserved to <None>
		local listIndex = 1 -- 1 cause index 0 in the list being always reserved to <None>
		--local fShapes = {}
		--lDrawing.ls_fShapes = {}

		-- 1) Delete leftovers
		if currentCount > desiredCount then
			self.itemList:Enable(currentCount - desiredCount < itemsForBusy)
			if self.itemList:SelItem() > 0 then -- Ensure no item is selected to avoid unwanted HM calls during deletions
				self.skipAll = true -- Skip entire whole HandleMessage content during this task
				self.itemList:SetSelItem(self.itemList:GetItem(0), false, false)
				self.skipAll = false
			end
			for i = currentCount, desiredCount, -1 do -- Remove extra items from bottom to top (avoids unnecessay HM calls)
				self.itemList:RemoveItem(i, false)
			end
			currentCount = desiredCount -- After deletion, the list now has exactly desiredCount items, this reassignment keeps currentCount in sync for the next phase
		end

		-- 2) Traverse shapes from last to first (shapeIndex goes from last shape to first to match the visual order expected in the UI)
		self.itemList:Enable(desiredCount - currentCount < itemsForBusy)
		for shapeIndex = shapeCount - 1, 0, -1 do
			local shape = mesh:Shape(shapeIndex)
			local shapeName = shape:Name()
			local shapeCombo = (shape.fComboMode == MOHO.COMBO_ADD and "+") or (shape.fComboMode == MOHO.COMBO_SUBTRACT and "- ") or (shape.fComboMode == MOHO.COMBO_INTERSECT and "×") or "  "
			local shapeVis = (shape.fHidden and " *" or "")
			local shapeSt1, shapeSt2 = shape.fInheritedStyle and " ·" or "", shape.fInheritedStyle2 and " ." or ""
			local shapeSt = (shapeSt1 ~= "" and shapeSt2 ~= "" and " :") or (shapeSt1 ~= "" and shapeSt1) or (shapeSt2 ~= "" and shapeSt2) or ""

			if shape == shape:BottomOfCluster() then
				itemLabel = "↳‍  " .. shapeCombo .. " "
			elseif shape == shape:TopOfCluster() then
				itemLabel = "↱‍  " .. shapeCombo .. " "
			elseif shape:IsInCluster() then
				itemLabel = "    " .. shapeCombo .. " "
			else
				itemLabel = ""
			end

			itemLabel = itemLabel .. shapeName .. shapeSt .. shapeVis

			if listIndex < currentCount then -- Update item if it already exists, otherwise add it
				if self.itemList:GetItem(listIndex) ~= itemLabel then
					self.itemList:SetItemLabel(listIndex, itemLabel)
				end
			else
				self.itemList:AddItem(itemLabel, false)
			end
			--fShapes[listIndex] = itemLabel -- Snapshot of current itemLabel state for potential later use?
			--lDrawing.ls_fShapes[listIndex] = itemLabel -- Save a duplicate in layer for potential future comparison?
			listIndex = listIndex + 1 -- Increment independently of shapeIndex, shapeIndex goes down (last shape → first), listIndex goes up (top of list → bottom)
		end

		-- 3) Restore item selection
		if self.itemList:SelItem() ~= shapeID then
			self.skipAll = true
			self.itemList:SetSelItem(self.itemList:GetItem(shapeID), false, false)
			self.skipAll = false
		end
		if not self.itemList:IsEnabled() then
			self.itemList:Enable(true) self.itemList:Redraw()
		end
		self.skipBlock = false --local t1b = os.clock() print(string.format("New: %.4f s", t1b - t1a))
		--]]

		local shape = shape or self.tempShape -- Start or of item preview update block
		if (shape ~= nil) then
			local bbMin, bbMax = LM.Vector2:new_local(), LM.Vector2:new_local() shape:ShapeBounds(bbMin, bbMax, 0) --tonumber(string.format("%.3f", exact)
			--local bbChanged = math.max(math.abs(bbMin.x - self.bbMin.x), math.abs(bbMin.y - self.bbMin.y), math.abs(bbMax.x - self.bbMax.x),math.abs(bbMax.y - self.bbMax.y)) >= margin
			local fc, lc, lw, hf, ho, hp, eo, er, es = shape.fMyStyle.fFillCol:GetValue(0), shape.fMyStyle.fLineCol:GetValue(0), shape.fMyStyle.fLineWidth, tostring(shape.fHasFill), tostring(shape.fHasOutline), tostring(shape:HasPositionDependentStyles()), shape.fEffectOffset:GetValue(0), shape.fEffectRotation:GetValue(0), shape.fEffectScale:GetValue(0)
			shapeTable[-1] = math.floor(bbMin.x*10+.5)/10 .. math.floor(bbMin.y*10+.5)/10 .. math.floor(bbMax.x*10+.5)/10 .. math.floor(bbMax.y*10+.5)/10 .. fc.r .. fc.g .. fc.b .. fc.a .. lc.r .. lc.g .. lc.b .. lc.a .. lw .. hf .. ho .. hp .. eo.x .. eo.y .. er ..es .. shape.fInheritedStyleName:Buffer() .. shape.fInheritedStyleName2:Buffer() .. tostring(shape.fHidden)
			--print(tostring(self.shapeTable[-1])) --print(tostring(shapeTable[-1]))
			if (self.layerUUID and self.layerUUID ~= layerUUID) or (self.shape and self.shape ~= shape) or (self.shapeTable[-1] and self.shapeTable[-1] ~= shapeTable[-1]) or (shape and not self.shape) or (LS_Shapes.mode ~= self.mode) then
				--print(math.floor(bbMin.x*10+.5)/10 .. ", " .. math.floor(bbMin.y*10+.5)/10 .. ", " .. math.floor(bbMax.x*10+.5)/10 .. ", " .. math.floor(bbMax.y*10+.5)/10 .. " Selected Shape Preview Update!")
				self:UpdateItem(moho, shape, true) --20240103-0448: Had to avoid draw fills due to a last minute weird behavior upon undoing after modifyig shapes! (TBO: ENABLED AGAIN)
				--self:UpdateBrush(moho, shape) -- It seems LM_MeshPreview widget doesn't display brushes. Oh, well...
			end
		end

		self.skipBlock = true -- Start of item selection block
		local add = false
		for i = 1, self.itemList:CountItems() - 1 do
			local shape = mesh:Shape(i - 1) --print(i, ": ", shape and "Name: " .. shape:Name() or "NO SHAPE")
			if shape.fSelected == true then
				if not self.itemList:IsItemSelected(shapeCount - i + 1) or shapesSel ~= itemsSel then
					self.itemList:SetSelItem(self.itemList:GetItem(shapeCount - i + 1), false, add) -- NOTE (20231008-0037): Changing redraw (2nd ar.) to false in a try to improve performace... (TBD) 
					add = true
				end
			end
		end
		if shapeID and shapeID >= 0 then
			self.itemName:Enable(true)
			self.itemName:SetValue(mesh:Shape(shapeID):Name())
			self.itemList:ScrollItemIntoView(shapeCount - shapeID, true)
		elseif shapeID < 0 then
			self.itemName:Enable(false)
			self.itemName:SetValue("  " .. MOHO.Localize("/LS/Shapes/ShapeManagement=Shape Management") .. "  ")

			if not self.itemList:IsItemSelected(0) then
				self.itemList:SetSelItem(self.itemList:GetItem(0), true, false) -- 20230920-1605: Had to pass false for redraw (2nd arg.) to avoid items deselection! 20231008-0036: Passing true again, otherwise <None> item isn't selected upon e.g. deselecting all
				self.itemList:ScrollItemIntoView(0, true) -- It doesn't seem to scroll to item 0
			end
		end
		self.itemVisCheck:Enable(self.itemList:SelItem() > 0)
		self.itemVisCheck:SetToolTip(MOHO.Localize("/LS/Shapes/ShapeVisibility=Shape Visibility (Hide/Unhide)"))
		self.deleteBut:Enable(shapesSel > 0)
		self.swapColBut:Enable(true)
		self.skipBlock = false
		LS_Shapes:Log("1.4.1")
	elseif LS_Shapes.mode == 2 then -- STYLE Mode
		---[[Performance Overhaul 
		self.skipBlock = true --local t1a = os.clock() -- Skip unnecessay HandleMessage parts during the whole refresh
		local currentCount, desiredCount = itemCount, styleCount + 1 -- +1 for index 0 being always reserved to <None>
		local listIndex = 1 -- 1 cause index 0 in the list being always reserved to <None>
		--local fStyles = {}
		--lDrawing.ls_fStyles = {}

		-- 1) Delete leftovers
		if currentCount > desiredCount then
			self.itemList:Enable(currentCount - desiredCount < itemsForBusy)
			if self.itemList:SelItem() > 0 then -- Ensure no item is selected to avoid unwanted HM calls during deletions
				self.skipAll = true -- Skip entire whole HandleMessage content during this task
				self.itemList:SetSelItem(self.itemList:GetItem(0), false, false)
				self.skipAll = false
			end
			for i = currentCount, desiredCount, -1 do -- Remove extra items from bottom to top (avoids unnecessay HM calls)
				self.itemList:RemoveItem(i, false)
			end
			currentCount = desiredCount -- After deletion, the list now has exactly desiredCount items, this reassignment keeps currentCount in sync for the next phase
		end

		-- 2) Traverse styles in natural order (index goes from first style to last)
		self.itemList:Enable(desiredCount - currentCount < itemsForBusy)
		for i = 1, styleCount do
			local styleName = tostring(doc:StyleByID(i - 1).fName:Buffer()) -- NOTE: The swapped order is to get around the style becoming an LM_String bug!
			local style = doc:StyleByID(i - 1)
			local styleDefLine = (style.fDefineLineWidth and style.fBrushName:Buffer() ~= "" and "; ") or style.fDefineLineWidth and "· " or style.fBrushName:Buffer() ~= "" and ", " or "  " --local defWidth = style.fDefineLineWidth and "· " or "  "
			local styleDefFillLine = (style.fDefineFillCol and style.fDefineLineCol and "◉‍ ")  or (style.fDefineFillCol and "◍‍ ") or (style.fDefineLineCol and "◎‍ ") or "○‍ " --○◌⊘⨂

			if doc and style then
				for j = 0, doc:CountLayers() - 1 do
					local jLayer = doc:Layer(j)
					style.ls_isUsed = false
					if doc:IsStyleUsed(style, jLayer) then
						style.ls_isUsed = true
						break
					end 
				end
			end
			itemLabel = styleDefFillLine .. styleDefLine .. styleName .. (style.ls_isUsed and " *" or "")

			if listIndex < currentCount then -- Update existing item or add a new one (use < instead of <= because when listIndex == currentCount that slot doesn't exist yet and trying to update it would lead to out-of-range errors, so we must add it instead)
				if self.itemList:GetItem(listIndex) ~= itemLabel then
					self.itemList:SetItemLabel(listIndex, itemLabel)
				end
			else
				self.itemList:AddItem(itemLabel, false)
			end
			--fStyles[listIndex] = itemLabel -- Snapshot of current itemLabel state for potential later use?
			--lDrawing.ls_fStyles[listIndex] = itemLabel -- Save a duplicate in layer for potential future comparison?
			listIndex = listIndex + 1 -- Increment independently of index
		end

		-- 3) Restore item selection
		if self.itemList:SelItem() ~= styleID then
			self.skipAll = true
			self.itemList:SetSelItem(self.itemList:GetItem(styleID), false, false)
			self.skipAll = false
		end
		if not self.itemList:IsEnabled() then
			self.itemList:Enable(true) self.itemList:Redraw()
		end
		self.skipBlock = false --local t1b = os.clock() print(string.format("New: %.4f s", t1b - t1a))
		--]]

		if (style ~= nil) then -- Start or of item preview update block
			local fc, lc, lw, df, dl, dw, bn = style.fFillCol.value, style.fLineCol.value, style.fLineWidth, tostring(style.fDefineFillCol), tostring(style.fDefineLineCol), tostring(style.fDefineLineWidth), style.fBrushName:Buffer()
			styleTable[-1] = fc.r .. fc.g .. fc.b .. fc.a .. lc.r .. lc.g .. lc.b .. lc.a .. lw .. df .. dl .. dw .. bn
		end
		if (self.layerUUID and self.layerUUID ~= layerUUID) or (self.styleSel and self.styleSel ~= styleSel) or (self.style and self.style ~= style) or (self.styleTable[-1] and self.styleTable[-1] ~= styleTable[-1]) or (style and not self.style) or (LS_Shapes.mode ~= self.mode) then --print("Style Preview Update!")
			--self.tempShape.fMyStyle = style
			self:UpdateItem(moho, styleName ~= "" and style or styleSel, true) --20240103-0448: Had to avoid draw fills due to a last minute weird behavior upon undoing after modifyig shapes! (TBO: ENABLED AGAIN)
			--self:UpdateBrush(moho, shape) -- It seems LM_MeshPreview widget doesn't display brushes. Oh, well...
		end

		self.skipBlock = true -- Start of item selection block
		local add = false
		if (style and styleName ~= "") then
			for i = 0, styleCount - 1 do --for i = 1, self.itemList:CountItems() - 1 do
				local iStyle = doc:StyleByID(i)
				if (iStyle and iStyle.fUUID:Buffer() == styleUUID) then
					iStyle.fSelected = true
					self.itemSel = i + 1
				else
					iStyle.fSelected = false
				end
			end
			--if self.itemList:NumSelectedItems() > 1 then
				--self.itemList:SetSelItem(self.itemList:GetItem(0), false, false) -- Select None before if current selItem is part of a multi-selection
			--end
			--if not self.itemList:IsItemSelected(self.itemSel) then
				self.itemList:SetSelItem(self.itemList:GetItem(self.itemSel), false, false)
				self.itemList:ScrollItemIntoView(self.itemSel, true)
			--end
		else -- 202401040525: Ensure <None> is selected when entering manually to STYLE Mode? (TBC/TODO)
			for i = 0, styleCount - 1 do
				local iStyle = doc:StyleByID(i) --print(iStyle.fName:Buffer(), ", ", tostring(iStyle.fSelected))
				if iStyle.fSelected == true then --and not self.itemList:IsItemSelected(i + 1)
					if not self.itemList:IsItemSelected(i + 1) or stylesSel ~= itemsSel then
						self.itemList:SetSelItem(self.itemList:GetItem(i + 1), false, add) -- 20231008-0037: Changing redraw (2nd ar.) to false in a try to improve performace... (TBD) 
						add = true
						--self.itemSel = 0
					end
				end
			end
			self.itemName:SetValue(self.itemList:SelItem() > 0 and styleSel.fName:Buffer() or "    " .. MOHO.Localize("/LS/Shapes/StyleManagement=Style Management") .. "    ")
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
		self.swapColBut:Enable(true)
		LS_Shapes:Log("1.4.2")
	elseif LS_Shapes.mode == 3 then -- GROUP Mode
		LS_Shapes:ProcessGroups(mesh, lDrawingUUID)

		---[[Performance Overhaul 
		self.skipBlock = true --local t1a = os.clock() -- Skip unnecessay HandleMessage parts during the whole refresh
		local currentCount, desiredCount = itemCount, groupCount + 1 -- +1 for index 0 being always reserved to <None>
		local listIndex = 1 -- 1 cause index 0 in the list being always reserved to <None>
		--local fGroups = {}
		--lDrawing.ls_fGroups = {}

		-- 1) Delete leftovers
		if currentCount > desiredCount then
			self.itemList:Enable(currentCount - desiredCount < itemsForBusy)
			if self.itemList:SelItem() > 0 then -- Ensure no item is selected to avoid unwanted HM calls during deletions
				self.skipAll = true -- Skip entire whole HandleMessage content during this task
				self.itemList:SetSelItem(self.itemList:GetItem(0), false, false)
				self.skipAll = false
			end
			for i = currentCount, desiredCount, -1 do -- Remove extra items from bottom to top (avoids unnecessay HM calls)
				self.itemList:RemoveItem(i, false)
			end
			currentCount = desiredCount -- After deletion, the list now has exactly desiredCount items, this reassignment keeps currentCount in sync for the next phase
		end

		-- 2) Traverse groups in natural order (index goes from first group to last)
		self.itemList:Enable(desiredCount - currentCount < itemsForBusy)
		for i = 1, groupCount do
			local group = mesh:Group(i -1)
			--local groupName = group:Name()

			itemLabel = group.ls_fLabel or "  " .. "?" -- It differs from the other modes due to in this case the info has been already collected by the `ProcessGroups` function

			if listIndex < currentCount then -- Update item if it already exists, otherwise add it
				if self.itemList:GetItem(listIndex) ~= itemLabel then
					self.itemList:SetItemLabel(listIndex, itemLabel)
				end
			else
				self.itemList:AddItem(itemLabel, false)
			end
			--fGroups[listIndex] = itemLabel -- Snapshot of current itemLabel state for potential later use?
			--lDrawing.ls_fGroups[listIndex] = itemLabel -- Save a duplicate in layer for potential future comparison?
			listIndex = listIndex + 1 -- Increment independently of index
		end

		-- 3) Restore item selection
		if self.itemList:SelItem() ~= groupID then
			self.skipAll = true
			self.itemList:SetSelItem(self.itemList:GetItem(groupID), false, false)
			self.skipAll = false
		end
		if not self.itemList:IsEnabled() then
			self.itemList:Enable(true) self.itemList:Redraw()
		end
		self.skipBlock = false --local t1b = os.clock() print(string.format("New: %.4f s", t1b - t1a))

		groupSelCount = LS_Shapes:CountSelectedGroups(mesh)

		if (group ~= nil) then -- Start or of item preview update block
			local ptCount, ptList = group:CountPoints(), table.concat(LS_Shapes:GroupPointIDs(mesh, group))
			mesh.ls_fGroups[-1] = ptCount .. ptList
		end
		if (self.layerUUID and self.layerUUID ~= layerUUID) or (self.group and self.group ~= group) or (mesh.ls_fGroups.old[-1] and mesh.ls_fGroups.old[-1] ~= mesh.ls_fGroups[-1]) or (group and not self.group) or (LS_Shapes.mode ~= self.mode) then --print("Group Preview Update!")
			self:UpdateItem(moho, group, false) --20240103-0448: Had to avoid draw fills due to a last minute weird behavior upon undoing after modifyig shapes! (TBO: ENABLED AGAIN)
		end

		self.skipBlock = true -- Start of item selection block
		local add, last = false, false
		if (groupSelCount > 0) then -- 20250814-2350: Necessary check to allow "None" can be highlighted if no group is marked as selected! 
			for i = 0, groupCount - 1 do
				local group = mesh:Group(i)
				if group.ls_fSelected == true then
					last = groupSelCount == itemsSel --print(group:Name(), ": ", tostring(groupSelCount), tostring(itemsSel), tostring(last), tostring(add))
					if not self.itemList:IsItemSelected(i + 1) or groupSelCount ~= itemsSel then
						self.itemList:SetSelItem(self.itemList:GetItem(i + 1), last, add)
						add = true
					end
				end
			end
		else
			self.itemList:SetSelItem(self.itemList:GetItem(0), true, false)
		end

		if self.groupUI and itemID >= 0 then
			self.itemName:Enable(true)
			self.itemName:SetValue(self.groupUI:Name())
			self.itemVisCheck:SetValue(not self.groupUI.ls_fHidden)
			self.itemList:ScrollItemIntoView(groupCount - mesh:GroupID(self.groupUI), true)
		elseif not self.groupUI and (itemID < 1 or groupSelCount < 1) then
			self.itemName:Enable(false)
			self.itemName:SetValue(" " .. MOHO.Localize("/LS/Shapes/GroupManagement=Point Group Manager") .. " ")

			if not self.itemList:IsItemSelected(0) then
				self.itemList:SetSelItem(self.itemList:GetItem(0), true, false) -- 20230920-1605: Had to pass false for redraw (2nd arg.) to avoid items deselection! 20231008-0036: Passing true again, otherwise <None> item isn't selected upon e.g. deselecting all
				self.itemList:ScrollItemIntoView(0, true) -- It doesn't seem to scroll to item 0
			end
		end
		self.itemVisCheck:Enable(self.itemList:SelItem() > 0)
		self.itemName:Enable(self.itemList:SelItem() > 0)
		self.itemVisCheck:SetToolTip(MOHO.Localize("/LS/Shapes/GroupVisibility=Group Visibility (Hide/Unhide)"))
		self.deleteBut:Enable(groupSelCount > 0)
		self.swapColBut:Enable(false)
		self.skipBlock = false
		LS_Shapes:Log("1.4.3")
	end
	LS_Shapes:Log("1.5") --[End of item update block]--

	self.modeBut:SetToolTip(LS_Shapes.beginnerMode and MOHO.Localize("/LS/Shapes/Mode=Mode: ") .. MOHO.Localize(modes[LS_Shapes.mode] or ""))
	self.raise:Enable((((LS_Shapes.mode < 2) and shapeID and shapeID >= 0) or (LS_Shapes.mode == 3 and itemsSel == 1)) and self.itemList:SelItem() > 1 or false)
	self.raise:SetToolTip(LS_Shapes.mode < 2 and (MOHO.Localize("/LS/Shapes/RaiseShape=Raise Shape") .. " (<alt> " .. MOHO.Localize("/LS/Shapes/RaiseToFront=To Front") .. ")" or "") or (MOHO.Localize("/LS/Shapes/RaiseItem=Raise Item") .. " (<alt> " .. MOHO.Localize("/LS/Shapes/RaiseToTop=To Top") .. ")" or ""))
	self.animOrder:Enable((LS_Shapes.mode < 2 and pro and lFrameAlt ~= 0 and mesh and mesh:AnimatedShapeOrder()))
	self.animOrder:SetValue(LS_Shapes.mode < 2 and pro and lDrawingOrderKey)
	self.lower:Enable((((LS_Shapes.mode < 2) and shapeID and shapeID >= 0) or (LS_Shapes.mode == 3 and itemsSel == 1)) and (self.itemList:SelItem() > 0 and not self.itemList:IsItemSelected(self.itemList:CountItems() - 1)) or false)
	self.lower:SetToolTip(LS_Shapes.mode < 2 and (MOHO.Localize("/LS/Shapes/LowerShape=Lower Shape") .. " (<alt> " .. MOHO.Localize("/LS/Shapes/LowerToBack=To Back") .. ")" or "") or MOHO.Localize("/LS/Shapes/LowerItem=Lower Item") .. " (<alt> " .. MOHO.Localize("/LS/Shapes/LowerToBottom=To Bottom") .. ")" or "")
	self.selectAllBut:Enable((LS_Shapes.mode < 2 and shapeCount > 0) or (LS_Shapes.mode == 2 and style ~= nil and styleCount > 0) or (LS_Shapes.mode == 3 and groupCount > 0)) --self.selectAllBut:SetLabel(LM_SelectShape:CountSelectedShapes(moho) == mesh:CountShapes() and "✅" or "☑", false) --self.selectAllBut:Redraw() -- 20230922: It seems to tail some text??
	self.deleteBut:SetToolTip(MOHO.Localize("/Windows/Style/Delete=Delete") .. (LS_Shapes.mode == 2 and " (<alt> " .. MOHO.Localize("/LS/Shapes/UnusedOny=Only If Unused") .. ")" or ""))
	self.selectMatchingBut:Enable((LS_Shapes.mode < 2 and shape ~= nil and shapesSel == 1 and shapeCount > 1) or (LS_Shapes.mode == 2 and style ~= nil and stylesSel == 1 and styleCount > 1) or (LS_Shapes.mode == 3 and groupSelCount < 2 and groupCount > 1)) --or (LS_Shapes.mode == 3 and groupSelCount == 1 and groupCount > 1)
	self.selectMatchingBut:SetToolTip((LS_Shapes.mode < 2 and MOHO.Localize("/LS/Shapes/SelectMatchingColorShapes=Select Matching-Color Shapes") or LS_Shapes.mode == 2 and MOHO.Localize("/LS/Shapes/SelectMatchingColorStyles=Select Matching-Color Styles") or LS_Shapes.mode == 3 and MOHO.Localize("/LS/Shapes/SelectMatchingGroups=Select Matching-Point Groups (Duplicates)")) .. (LS_Shapes.mode < 3 and " (<alt> " .. MOHO.Localize("/LS/Shapes/SelectIdentical=Select Identical") .. ")" or ""))
	self.selectPtBasedBut:Enable(doc ~= nil and (LS_Shapes.mode < 2 or LS_Shapes.mode == 3) or (LS_Shapes.mode == 2 and style ~= nil and itemsSel == 1 and styleSel.ls_isUsed))
	self.selectPtBasedBut:SetValue(LS_Shapes.mode < 2 and LS_Shapes.pointBasedSel or LS_Shapes.mode == 3 and LS_Shapes.pointBasedSel3)
	self.selectPtBasedBut:SetToolTip(LS_Shapes.mode ~= 2 and MOHO.Localize("/LS/Shapes/PointBasedSelection=Point-Based Selection (<alt> Keep Active)") or MOHO.Localize("/LS/Shapes/StyleBasedSelection=Style-Based Selection"))
	self.checkerSelBut:SetValue(MOHO.MohoGlobals.SelectedShapeCheckerboard)

	if LS_Shapes.advanced then 
		local createCursor = LS_Shapes.mode < 2 and LS_Shapes.resources .. "ls_cursor_create_shape" or LS_Shapes.mode == 2 and LS_Shapes.resources .. "ls_cursor_create_style" or LS_Shapes.resources .. "ls_cursor_create_group"
		for i, but in ipairs(self.createButtons) do
			if LS_Shapes.mode ~= 3 then
				but:Enable(((edgesSel > 0) and not toolsDisabled) or LS_Shapes.mode > 1)
			else
				if i == 1 then
					but:Enable(true)
				elseif i == 2 then
					but:Enable(pointsSel > 0 and groupSelCount == 1 and (moho and moho:CountSelectedPoints(false) ~= groupPtCount) or false)
				else
					but:Enable(false)
				end
			end
			but:SetCursor(but:IsEnabled() and LM.GUI.Cursor(createCursor .. "_" .. i, 0, 0) or nil)
		end
		self.createButtons[1]:SetToolTip((LS_Shapes.mode < 2 and MOHO.Localize("/LS/Shapes/CreateFill=Create Fill") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/CreateShape/ConnectAndCreate=Connect And Create") .. ")") or LS_Shapes.mode == 2 and MOHO.Localize("/LS/Shapes/CreateFillColorOverriderStyle=Create Fill Color Overrider Style") or MOHO.Localize("/LS/Shapes/CreatePointGroup=Create Point Group"))
		self.createButtons[2]:SetToolTip((LS_Shapes.mode < 2 and MOHO.Localize("/LS/Shapes/CreateStroke=Create Stroke") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/CreateShape/ConnectAndCreate=Connect And Create") .. ")") or LS_Shapes.mode == 2 and MOHO.Localize("/LS/Shapes/CreateStrokeColorOverriderStyle=Create Stroke Color Overrider Style") or MOHO.Localize("/LS/Shapes/UpdatePointGroup=Update Point Group"))
		self.createButtons[3]:SetToolTip((LS_Shapes.mode < 2 and MOHO.Localize("/LS/Shapes/CreateBoth=Create Both") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/CreateShape/ConnectAndCreate=Connect And Create") .. ")") or LS_Shapes.mode == 2 and MOHO.Localize("/LS/Shapes/CreateStyle=Create Style") or "")

		self.brushBut:SetToolTip(MOHO.Localize("/Dialogs/BrushPicker/Brush=Brush") .. ": " .. (brush ~= "" and brush or MOHO.Localize("/Dialogs/BrushPicker/None=None") .. (LS_Shapes.beginnerMode and " (" .. MOHO.Localize("/LS/Shapes/PickBelow=Pick Below") .. ")" or "")))
		self.brushMenuPopup:Enable(LS_Shapes.mode < 3)
		self.brushMenuPopup:SetCursor(LS_Shapes.beginnerMode and LM.GUI.Cursor(LS_Shapes.resources .. "ls_shape_brush_cursortip", 0, 0) or nil)
		self.swatchMenuPopup:Enable(LS_Shapes.mode < 3)
		self.style1MenuPopup:Enable(styleName == "" and LS_Shapes.mode ~= 3) self.style1MenuPopup:Redraw()
		self.style1MenuPopup:SetToolTip(MOHO.Localize("/Windows/Style/Style1=Style 1") .. (style1Name ~= "" and ": " .. style1Name or "") .. (LS_Shapes.beginnerMode and " (" .. MOHO.Localize("/LS/Shapes/AppliesAbove=Applies Above") .. ")" or ""))
		self.style1MenuPopup:SetCursor(LS_Shapes.beginnerMode and LM.GUI.Cursor(LS_Shapes.resources .. "ls_shape_style_1_cursortip", 0, 0) or nil)
		self.swapBut:Enable(LS_Shapes.mode < 3 and styleName == "" and style1UUID ~= style2UUID)
		self.style2MenuPopup:Enable(styleName == "" and LS_Shapes.mode ~= 3) self.style2MenuPopup:Redraw()
		self.style2MenuPopup:SetToolTip(MOHO.Localize("/Windows/Style/Style2=Style 2") .. (style2Name ~= "" and ": " .. style2Name or "") .. (LS_Shapes.beginnerMode and " (" .. MOHO.Localize("/LS/Shapes/AppliesBellow=Applies Bellow") .. ")" or ""))
		self.style2MenuPopup:SetCursor(LS_Shapes.beginnerMode and LM.GUI.Cursor(LS_Shapes.resources .. "ls_shape_style_2_cursortip", 0, 0) or nil)
		self.swatchMenuPopup:SetToolTip(MOHO.Localize("/Windows/Style/Swatches=Swatches") .. " (" .. self.swatchMenu:FirstCheckedLabel():gsub("^%s+", "") .. ")")
		self.swatchMenuPopup:SetCursor(LS_Shapes.beginnerMode and LM.GUI.Cursor(LS_Shapes.resources .. "ls_swatches_cursortip", 0, 0) or nil)

		if (tool ~= nil) then
			if toolName:find("SelectShape") then
				if (moho.view and tool.prevMousePt ~= nil) then
					local shapeID, curveID, segID = -1, -1, -1
					if (shape and LS_Shapes.LM_SelectShape and LS_Shapes.LM_SelectShape.dragMode > -1) then 
						LS_Shapes:Log("1.5.1") --print(4.11, tostring(moho.view), tostring(self.v))--
						shapeID = moho.view:PickShape(tool.prevMousePt) --20250821-0145: Continuos "Pick" functions calling seemed to be the cause of main window resizing crashes, so limiting calls by moving it under this condition for now (but picking can stop working after switching open documents?) -- 20250823-0305: Switch from using `self.v` to `moho.view`
						LS_Shapes:Log("1.5.2") --print(4.12, tostring(moho.view), tostring(self.v))--
						curveID, segID = moho.view:PickEdge(tool.prevMousePt, curveID, segID, 6)
						LS_Shapes:Log("1.5.3") --print(4.13, tostring(moho.view), tostring(self.v))--
						if (shapeID >= 0 or (curveID >= 0 and segID >= 0)) and (self.prevMousePtX and (self.prevMousePtX ~= tool.prevMousePt.x or self.prevMousePtY ~= tool.prevMousePt.y)) then
							LS_Shapes.multiMenuRules = false
						end
					end
					if LS_Shapes.multiMenuRules == false then
						if shape and LS_Shapes.LM_SelectShape and LS_Shapes.LM_SelectShape.dragMode == 0 then
							if (curveID >= 0 and segID >= 0) and shape.fHasOutline then -- An edge was clicked on
								LS_Shapes.multiMode = 1
							else
								LS_Shapes.multiMode = 0
							end
						elseif LS_Shapes.LM_SelectShape and LS_Shapes.LM_SelectShape.dragMode > 0 then
							LS_Shapes.multiMode = 2
						end
					end
				end
			elseif tool.autoFill ~= nil and (tool.autoOutline ~= nil or tool.autoStroke ~= nil) then --toolName:find("Freehand") or toolName:find("Shape")
				if self.toolName and self.toolName ~= toolName then
					LS_Shapes.multiMenuRules = false
				end
				if LS_Shapes.multiMenuRules == false then --print(tostring(tool.autoFill), ", ", tostring(tool.autoOutline), ", ", tostring(tool.autoStroke))
					if (tool.autoFill ~= nil and tool.autoFill == true) and ((tool.autoOutline ~= nil and tool.autoOutline == false) or (tool.autoStroke ~= nil and tool.autoStroke == false)) then
						LS_Shapes.multiMode = 0
					elseif (tool.autoOutline ~= nil and tool.autoOutline == true) or (tool.autoStroke ~= nil and tool.autoStroke == true) then
						LS_Shapes.multiMode = 1
					end
				end
			elseif (tool.autoFillCheck ~= nil and tool.autoStrokeCheck ~= nil) then
				if self.toolName and self.toolName ~= toolName then
					LS_Shapes.multiMenuRules = false
				end
				if LM_TransformPoints ~= nil and (LM_TransformPoints.autoFill == true and LM_TransformPoints.autoStroke == false) then
					LS_Shapes.multiMode = 0
				elseif LM_TransformPoints ~= nil and LM_TransformPoints.autoStroke == true then
					LS_Shapes.multiMode = 1
				end
			end
		end
		--LS_Shapes.multiMode -> 0: Fill, 1: Stroke, 2: FX, 3: Recolor --MARK:M. MENU
		--LS_Shapes.multiMode = (LS_Shapes.multiMode > 1 and shape and shape:HasPositionDependentStyles()) and 0 or LS_Shapes.multiMode
		self.multiMenuPopup:Enable(LS_Shapes.mode < 3)
		self.multiMenu:SetEnabled(self.MULTIMENU + 2, shapeHandles) -- FX
		self.multiMenu:SetEnabled(self.MULTIMENU + 3, mesh ~= nil) -- Recolor
		self.multiMenu:SetEnabled(self.MULTIMENU + 4, LS_Shapes.multiMode > 1) -- Copy values
		self.multiMenu:SetEnabled(self.MULTIMENU + 5, LS_Shapes.multiValues.clipboard ~= nil) -- Paste values
		self.multiMenu:SetEnabled(self.MULTIMENU + 6, LS_Shapes.multiMode > 1 and LS_Shapes.multiMode < 5) -- Reset Values
		self.multiMenu:SetEnabled(self.MULTIMENU + 7, LS_Shapes.multiMode < 2 and shapesSel < 2) -- Invert Color
		self.multiMenu:SetEnabled(self.MULTIMENU + 8, LS_Shapes.multiMode < 2 and shapesSel < 2) -- Multiply Colors
		self.multiMenu:SetEnabled(self.MULTIMENU + 9, LS_Shapes.multiMode > 2 and LS_Shapes.multiMode < 5) -- Affects Fills
		self.multiMenu:SetEnabled(self.MULTIMENU + 10, LS_Shapes.multiMode > 2 and LS_Shapes.multiMode < 5) -- Affects Strokes
		self.multiMenu:SetEnabled(self.MULTIMENU + 11, LS_Shapes.multiMode ~= 2) -- Affects Alpha
		if self.multiMenu:IsEnabled(self.MULTIMENU + LS_Shapes.multiMode) == false then
			LS_Shapes.multiMode = LS_Shapes.multiMenuLast
		end
		self.multiMenu:UncheckAll()
		self.multiMenu:SetChecked(self.MULTIMENU + LS_Shapes.multiMode, true)
		self.multiMenu:SetChecked(self.MULTIMENU + 9, MOHO.hasbit(LS_Shapes.multiFlags, MOHO.bit(1)))
		self.multiMenu:SetChecked(self.MULTIMENU + 10, MOHO.hasbit(LS_Shapes.multiFlags, MOHO.bit(2)))
		self.multiMenu:SetChecked(self.MULTIMENU + 11, MOHO.hasbit(LS_Shapes.multiFlags, MOHO.bit(4)))
		self.multiMenuPopup:SetToolTip(self.multiMenu:FirstCheckedLabel())
		self.multiMenuPopup:SetCursor(LS_Shapes.beginnerMode and LM.GUI.Cursor(LS_Shapes.resources .. "ls_mode_cursortip", 0, 0) or nil)
		self.multiMenuPopup:Redraw()
		self.hsvBut:Enable(LS_Shapes.mode < 3 and LS_Shapes.multiMode ~= 2)
		self.multi1:Enable(LS_Shapes.mode < 3)
		self.multi2:Enable(LS_Shapes.mode < 3)
		self.multi3:Enable(LS_Shapes.mode < 3)
		self.multi4:Enable(LS_Shapes.mode < 3)

		LS_Shapes:Log("1.5.4")

		if shape ~= self.shape or style ~= self.style then
			self._lastHue, self._lastSat = nil, nil
		end

		self.hsvBut:SetValue(LS_Shapes.useHsv)
		self.multi3:SetCursor(LM.GUI.Cursor(LS_Shapes.resources .. "ls_cursor_set_b", 0, 0))
		self.multi4:SetCursor(LM.GUI.Cursor(LS_Shapes.resources .. "ls_cursor_set_a", 0, 0))
		if LS_Shapes.multiMode < 2 then -- Fill/Stroke
			local col = (LS_Shapes.multiMode == 0) and self.fillCol:Value() or self.lineCol:Value()
			local hsv = LM.ColorOps:Rgb2Hsv(col)
			self._lastHue = self._lastHue == nil and hsv.h * 360 / 255 or self._lastHue
			self._lastSat = self._lastSat == nil and hsv.s / 255 or self._lastSat

			local hToShow = self._lastHue or hsv.h * 360 / 255; hToShow = math.floor(hToShow + 0.5)
			local sToShow = (hsv.v == 0) and self._lastSat or (hsv.s / 255); sToShow = math.floor(sToShow * 100 + 0.5) / 100
			local vToShow = hsv.v / 255; vToShow = math.floor(vToShow * 100 + 0.5) / 100
			local aToShow = hsv.a / 255
			self._lastHue, self._lastSat = hToShow, sToShow

			self.multi1:SetPercentageMode(false)
			self.multi1:SetUnits(LS_Shapes.useHsv and LM.GUI.UNIT_DEGREES or LM.GUI.UNIT_NONE)
			self.multi1:SetWheelInc(2)
			self.multi1:SetWheelInteger(true)
			self.multi1:SetCursor(LM.GUI.Cursor(LS_Shapes.resources .. (LS_Shapes.useHsv and "ls_cursor_set_h" or "ls_cursor_set_r"), 0, 0))
			self.multi1:SetValue(LS_Shapes.useHsv and hToShow or col.r)

			self.multi2:SetPercentageMode(LS_Shapes.useHsv)
			self.multi2:SetUnits(LS_Shapes.useHsv and LM.GUI.UNIT_PERCENT or LM.GUI.UNIT_NONE)
			self.multi2:SetMaxDecimalPlaces(0)
			self.multi2:SetWheelInc(2)
			self.multi2:SetWheelInteger(not LS_Shapes.useHsv)
			self.multi2:SetCursor(LM.GUI.Cursor(LS_Shapes.resources .. (LS_Shapes.useHsv and "ls_cursor_set_s" or "ls_cursor_set_g"), 0, 0))
			self.multi2:SetValue(LS_Shapes.useHsv and sToShow or col.g)

			self.multi3:SetPercentageMode(LS_Shapes.useHsv)
			self.multi3:SetUnits(LS_Shapes.useHsv and LM.GUI.UNIT_PERCENT or LM.GUI.UNIT_NONE)
			self.multi3:SetMaxDecimalPlaces(0)
			self.multi3:SetWheelInc(2)
			self.multi3:SetWheelInteger(not LS_Shapes.useHsv)
			self.multi3:SetValue(LS_Shapes.useHsv and vToShow or col.b)

			self.multi4:SetPercentageMode(true)
			self.multi4:SetUnits(LM.GUI.UNIT_PERCENT)
			self.multi4:SetMaxDecimalPlaces(1)
			self.multi4:SetWheelInc(2)
			self.multi4:SetWheelInteger(false)
			self.multi4:SetValue(LS_Shapes.useHsv and aToShow or col.a / 255)

		elseif LS_Shapes.multiMode == 3 then -- Recolor
			self.multi1:SetPercentageMode(false)
			self.multi1:SetUnits(LS_Shapes.useHsv and LM.GUI.UNIT_DEGREES or LM.GUI.UNIT_NONE)
			self.multi1:SetWheelInc(2)
			self.multi1:SetWheelInteger(true)
			self.multi1:SetCursor(LM.GUI.Cursor(LS_Shapes.resources .. (LS_Shapes.useHsv and "ls_cursor_set_h" or "ls_cursor_set_r"), 0, 0))
			self.multi1:SetValue(LS_Shapes.multiValues[LS_Shapes.multiMode][1])

			self.multi2:SetPercentageMode(LS_Shapes.useHsv)
			self.multi2:SetUnits(LS_Shapes.useHsv and LM.GUI.UNIT_PERCENT or LM.GUI.UNIT_NONE)
			self.multi2:SetMaxDecimalPlaces(0)
			self.multi2:SetWheelInc(0.2)
			self.multi2:SetWheelInteger(not LS_Shapes.useHsv)
			self.multi2:SetCursor(LM.GUI.Cursor(LS_Shapes.resources .. (LS_Shapes.useHsv and "ls_cursor_set_s" or "ls_cursor_set_g"), 0, 0))
			self.multi2:SetValue(LS_Shapes.multiValues[LS_Shapes.multiMode][2])

			self.multi3:SetPercentageMode(LS_Shapes.useHsv)
			self.multi3:SetUnits(LS_Shapes.useHsv and LM.GUI.UNIT_PERCENT or LM.GUI.UNIT_NONE)
			self.multi3:SetMaxDecimalPlaces(0)
			self.multi3:SetWheelInc(0.2)
			self.multi3:SetWheelInteger(not LS_Shapes.useHsv)
			self.multi3:SetValue(LS_Shapes.multiValues[LS_Shapes.multiMode][3])

			self.multi4:SetPercentageMode(true)
			self.multi4:SetUnits(LM.GUI.UNIT_PERCENT)
			self.multi4:SetMaxDecimalPlaces(1)
			self.multi4:SetWheelInc(2)
			self.multi4:SetWheelInteger(false)
			self.multi4:SetValue(LS_Shapes.multiValues[LS_Shapes.multiMode][4])

		elseif LS_Shapes.multiMode == 2 then -- FX Transform
			self.multi1:SetPercentageMode(false)
			self.multi1:SetUnits(LM.GUI.UNIT_NONE)
			self.multi1:SetMaxDecimalPlaces(2)
			self.multi1:SetWheelInc(0.01)
			self.multi1:SetWheelInteger(false)
			self.multi1:SetCursor(LM.GUI.Cursor(LS_Shapes.resources .. "ls_cursor_set_x", 0, 0))
			self.multi1:SetValue(shapeFxOffset and shapeFxOffset.value.x or 0)

			self.multi2:SetPercentageMode(false)
			self.multi2:SetUnits(LM.GUI.UNIT_NONE)
			self.multi2:SetMaxDecimalPlaces(2)
			self.multi2:SetWheelInc(0.01)
			self.multi2:SetWheelInteger(false)
			self.multi2:SetCursor(LM.GUI.Cursor(LS_Shapes.resources .. "ls_cursor_set_y", 0, 0))
			self.multi2:SetValue(shapeFxOffset and shapeFxOffset.value.y or 0)

			self.multi3:SetPercentageMode(false)
			self.multi3:SetUnits(LM.GUI.UNIT_DEGREES)
			self.multi3:SetMaxDecimalPlaces(1)
			self.multi3:SetCursor(LM.GUI.Cursor(LS_Shapes.resources .. "ls_cursor_set_r", 0, 0))
			self.multi3:SetValue(shapeFxRotation and math.deg(shapeFxRotation.value) or 0)

			self.multi4:SetPercentageMode(true)
			self.multi4:SetUnits(LM.GUI.UNIT_PERCENT)
			self.multi4:SetMaxDecimalPlaces(1)
			self.multi4:SetWheelInc(0.05)
			self.multi4:SetWheelInteger(false)
			self.multi4:SetCursor(LM.GUI.Cursor(LS_Shapes.resources .. "ls_cursor_set_s", 0, 0))
			self.multi4:SetValue(shapeFxScale and shapeFxScale.value or 1)
		end
		self.applyBut:Enable(LS_Shapes.multiMode > 2)
		self.applyBut:SetToolTip(LS_Shapes.multiMode < 2 and MOHO.Localize("") or MOHO.Localize("/LS/Shapes/ApplyMode=Apply") .. " (<alt> " .. MOHO.Localize("/LS/Shapes/Randomized=Randomized") .. ")")

		if LS_Shapes.swatch ~= -1 and self.swatchSlider then
			if LS_Shapes.swatch ~= self.swatch then
				if self.swatchMenu:FirstCheckedLabel():match("🎛") then --20231030-1140: Kind of dirty solution based on current swatch label... Improve! (TODO)
					self.swatchSlider:Enable(true)
					self.swatchSlider:Redraw()
					self.swatchSlider:SetCursor(LM.GUI.Cursor(LS_Shapes.resourcesAlt .. "Tool/lm_zoom_camera_cursor", 0, 0))
				else
					self.swatchSlider:Enable(false)
					self.swatchSlider:SetCursor() -- Reset default cursor
				end
				self.colorPreview:Refresh() --self:UpdateColor(moho)
			end
			self.swatchSlider:SetToolTip(LS_Shapes.beginnerMode and MOHO.Localize("/LS/Shapes/ColorSlider=Color Slider") or "")
		end
	end
	LS_Shapes:Log("1.6")
	if (LS_Shapes.beginnerMode ~= self.beginnerMode) or self.isNewRun then -- Avoid unnecesary tooltip updates
		self.menu1Popup:SetToolTip(LS_Shapes.beginnerMode and MOHO.Localize("/Dialogs/LayerSettings/General=General") or "")
		--self.menu3Popup:SetToolTip(LS_Shapes.beginnerMode and MOHO.Localize("/Windows/Library/More=More:"):gsub("[^%w]$", "") or "")
		--self.itemNameLabel:SetToolTip(MOHO.Localize("/Windows/Style/Name=Name"))
		self.combineBlend:SetToolTip(LS_Shapes.beginnerMode and MOHO.Localize("/Scripts/Tool/SelectShape/Blend=Blend:"):gsub("[^%w]$", "") .. " (" .. MOHO.Localize("/Dialogs/NudgeDlog/Amount=Amount") ..")" or "") -- Remove any non-alphanumeric ending character
		self.baseBut:SetToolTip(LS_Shapes.beginnerMode and MOHO.Localize("/Scripts/Tool/SelectShape/SelectBottomOfCluster=Select bottom of Liquid Shape") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All") .. ")" or "")
		self.topBut:SetToolTip(LS_Shapes.beginnerMode and MOHO.Localize("/Scripts/Tool/SelectShape/SelectTopOfCluster=Select top of Liquid Shape") .. " (<alt> " .. MOHO.Localize("/Scripts/Tool/SelectShape/SelectAll=Select All") .. ")" or "")
		if LS_Shapes.advanced then 
			self.lineWidth:SetToolTip(LS_Shapes.beginnerMode and MOHO.Localize("/Dialogs/InsertText/BalloonWidth=Stroke Width") or "")
		end
	end
	
	for k, v in ipairs(self.w) do --print(tostring(k), ", ", tostring(v), ", ", type(v))
		if type(v) == "userdata" and not pro then
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
	LS_Shapes:Log("1.7")  --MARK: OLDSTATE

	local shape = shape or self.tempShape
	if (shape ~= nil) then -- 20240123-0135: Addded the self.shape ~= nil part. TBO...
		local bbMin, bbMax = LM.Vector2:new_local(), LM.Vector2:new_local() shape:ShapeBounds(bbMin, bbMax, 0)
		local fc, lc, lw, hf, ho, hp, eo, er, es = shape.fMyStyle.fFillCol:GetValue(0), shape.fMyStyle.fLineCol:GetValue(0), shape.fMyStyle.fLineWidth, tostring(shape.fHasFill), tostring(shape.fHasOutline), tostring(shape:HasPositionDependentStyles()), shape.fEffectOffset:GetValue(0), shape.fEffectRotation:GetValue(0), shape.fEffectScale:GetValue(0)
		self.shapeTable[-1] = math.floor(bbMin.x*10+.5)/10 .. math.floor(bbMin.y*10+.5)/10 .. math.floor(bbMax.x*10+.5)/10 .. math.floor(bbMax.y*10+.5)/10 .. fc.r .. fc.g .. fc.b .. fc.a .. lc.r .. lc.g .. lc.b .. lc.a .. lw .. hf .. ho .. hp .. eo.x .. eo.y .. er ..es .. shape.fInheritedStyleName:Buffer() .. shape.fInheritedStyleName2:Buffer() .. tostring(shape.fHidden)
	end
	LS_Shapes:Log("1.8")

	if (style ~= nil and self.style ~= nil) then
		local fc, lc, lw, df, dl, dw, bn = style.fFillCol.value, style.fLineCol.value, style.fLineWidth, tostring(style.fDefineFillCol), tostring(style.fDefineLineCol), tostring(style.fDefineLineWidth), style.fBrushName:Buffer()
		self.styleTable[-1] = fc.r .. fc.g .. fc.b .. fc.a .. lc.r .. lc.g .. lc.b .. lc.a .. lw .. df .. dl .. dw .. bn
	end
	LS_Shapes:Log("1.09")

	self.toolName = (doc ~= nil and doc:Name() ~= "-") and moho:CurrentTool() or ""
	self.mode = LS_Shapes.mode
	self.beginnerMode = LS_Shapes.beginnerMode
	self.style = moho:CurrentEditStyle()
	self.styleSel = doc and doc:StyleByID(styleSelID) or style
	self.layerUUID = moho.layer and moho.layer:UUID()
	self.group = mesh and LS_Shapes:SelectedGroup(mesh)
	self.groupCount = mesh and math.floor(mesh:CountGroups()) or 0
	self.shape = moho:SelectedShape() or moho:NewShapeProperties() or MOHO.MohoGlobals.NewShapeProperties
	self.swatch = LS_Shapes.swatch
	self.swatchSliderVal = self.swatchSlider and self.swatchSlider:Value() or 1
	self.prevMousePtX, self.prevMousePtY = (tool and tool.prevMousePt ~= nil) and tool.prevMousePt.x or 0, (tool and tool.prevMousePt ~= nil) and tool.prevMousePt.y or 0
	self.info.upd = true
	self.isNewRun = false
	self.skipAll = false
	LS_Shapes.LM_SelectShape.dragMode = -1
	LS_Shapes:Log("END")
	helper:delete()
end

function LS_ShapesDialog:OnOK() --print("LS_ShapesDialog:OnOK(): ", " 🕗: " .. os.clock()) LM.Snooze(1500)
	local helper = MOHO.ScriptInterfaceHelper:new_local()
	local moho = helper:MohoObject() self.p.m = self.p and moho or nil
	local doc = moho.document

	if LS_Shapes.dlog == nil and LS_Shapes.shouldReopen then -- Reopen the just auto-closed dialog
		LS_Shapes:Run(moho)
		LS_Shapes.shouldReopen = false
	else
		LS_Shapes.dlog = nil -- Mark the dialog closed
		LS_Shapes.shouldOpen = false
	end

	if doc and doc:Name() then --20231229-1415: This check seems now necessary to avoid crashes upon closing Moho while dialog is open? But I'd swear not before...
		MOHO.Redraw()
		moho:UpdateUI()
	end
	helper:delete()
end

function LS_ShapesDialog_Update(moho) --print("LS_ShapesDialog_Update(" .. tostring(moho) .."): ", " 🕗: " .. os.clock())
	--[[20240121-2342: TODO, continue investigating why this moho object is not what one could expect...
	if moho.layer then print(moho.layer:Name()) end
	for k, v in pairs(moho) do --print(type(k), type(v))
		if type(v) == "table" then
			--print(tostring(K), ", ", tostring(v))
		end
	end
	--]]
	if LS_Shapes.dlog then
		LS_Shapes.dlog:Update(moho)
	end
end

table.insert(MOHO.UpdateTable, LS_ShapesDialog_Update) -- Register the dialog to be updated when changes are made

function LS_ShapesDialog:DrawItem(mesh, t, sharp) --(M_Mesh, tbl, bool/float) void
	t = t or {close = true, {0,.2}, {.2,.4}, {.4,.2}, {.2,0}, {.4,-.2}, {.2,-.4}, {0,-.2}, {-.2,-.4}, {-.4,-.2}, {-.2,0}, {-.4,.2}, {-.2,.4}} --❌
	sharp = (sharp ~= nil and type(sharp) == "number") and sharp or (sharp == true and MOHO.PEAKED or MOHO.SMOOTH)
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
			--mesh:Point(i):SetCurvature(MOHO.PEAKED, 0)
			--mesh:Point(i):ResetControlHandles(0)
		--end
		mesh:SelectConnected()
	end
end

function LS_ShapesDialog:UpdateItem(moho, item, fill) --(MohoDoc, M_Shape/M_Style, bool void) --print("LS_ShapesDialog:UpdateItem: " .. os.clock()) --MARK:-UPITEM()
	local doc = moho and moho.document or nil
	local lMesh = doc and moho:DrawingMesh()
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
			local single = LS_Shapes:IsSingleCurve(item) --20240101-1730: Had to exclude multi-curve shapes due to "shape out of range" warnings/crashes. Multi-curve shapes didn't preview accurately anyway... 
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
			LS_ShapesDialog:DrawItem(pMesh, {close = true, height = pHeight, {-.159,.165,.225}, {.37,.542,.56}, {.654,.05,.3}, {-.048,-.52,.4275}, {-.675,.115,.465}})
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
		--local dropShape = {close = true, height = pHeight, {0,1.1666,MOHO.PEAKED}, {.67,0,.391379}, {0,-.67,.391379,defWidth and 200 or nil}, {-.67,0,.391379}, {0,1.1666,MOHO.PEAKED}}
		--scale = (defBrush or not defLine) and 0.67 or scale
		LS_ShapesDialog:DrawItem(pMesh, defBrush and stainShape or ballShape)
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
				shape.fMyStyle.fLineWidth = 0.1333 --LS_Shapes.MohoLineWidth * 2
			end
		end
	elseif (item and item.ContainsPointID ~= nil or LS_Shapes.mode == 3) then -- Item is Point Group
		local folderShape = {close = true, height = pHeight, {-1.67,1,0}, {-1.33,1.55,0},{-.33,1.55,0},{0.16,1,0}, {1.67,1},{1.67,-1},{-1.67,-1}}
		local opacity = 240
		LS_ShapesDialog:DrawItem(pMesh, folderShape, 0.033)
		
		if (item and item.ContainsPointID) then
			opacity = item.ls_fHidden and 240 or 255
			for i = 0, LM.Clamp(item:CountPoints() - 1, 0, 2) do
				local dot = {close = false, height = pHeight, {-1.167 + i * 0.85,0}, {-0.67 + i * 0.85,0}}
				LS_ShapesDialog:DrawItem(pMesh, dot)
			end
		end
		if self.itemPreview:CreateShape(defFill == true and true or false) then
			local shape = pMesh:Shape(0)
			shape.fMyStyle.fLineCol.value.a = opacity
		end
	else -- No shape, style, or group?
		if (item ~= nil) then
			LS_ShapesDialog:DrawItem(pMesh)
			if self.itemPreview:CreateShape(true) then
				local noItem = pMesh:Shape(0)
				noItem.fMyStyle.fFillCol.value = (LS_Shapes.UILightness_v12beta > 0.5 and MOHO.String2Rgb(LS_Shapes.LightHighlight) or MOHO.String2Rgb(LS_Shapes.DarkHighlight)) or LM.ColorOps.Red
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

function LS_ShapesDialog:UpdateBrush(moho, shape) --print("LS_ShapesDialog:UpdateBrush: " .. os.clock())
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

function LS_ShapesDialog:UpdateColor(moho) --print("LS_ShapesDialog:UpdateColor: " .. os.clock())
	--local lMesh = moho:DrawingMesh()
	--local pMesh = self.colorPreview and self.colorPreview:Mesh() or nil
	if self.colorPreview and self.colorPreview:Mesh() ~= nil then
		self:UpdatePreview(moho, self.colorPreview)
	end
end

function LS_ShapesDialog:UpdatePreview(moho, preview) --print("LS_ShapesDialog:UpdatePreview: " .. os.clock())
	if LS_Shapes.doc ~= nil then -- 20231223-2345: Check to avoid crash upon auto-opening, better try to include the document as argument?
		LS_Shapes.swatchLayer = LS_Shapes.swatchLayer > LS_Shapes.doc:CountLayers() - 1 and LS_Shapes.doc:CountLayers() - 1 or LS_Shapes.swatchLayer --LM.Clamp(LS_Shapes.swatchLayer, 0, LS_Shapes.doc:CountLayers() - 1) --print(LS_Shapes.doc:Name(), ", ", moho.document:Name())
		local layer = LS_Shapes.doc:Layer(LS_Shapes.swatchLayer)
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
function LS_ShapesDialog:UpdateColor(moho) --print("LS_ShapesDialog:UpdateColor: " .. os.clock())
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

function LS_ShapesDialog:HandleMessage(msg) --print("LS_ShapesDialog:HandleMessage(" .. math.floor(msg) .. "): " .. LS_ShapesDialog:WhatMsg(msg), " 🕗: " .. os.clock()) --MARK:-HM(D)
	if self.skipAll == true then
		return
	end
	--local caller = debug.getinfo(3) and debug.getinfo(3).name or "NULL" print(caller) --0: getinfo, 1: NULL/NULL, 2: SetSelItem/NULL, 3: NULL/Update, 4: NULL/func, 5: NULL/NULL
	local helper = MOHO.ScriptInterfaceHelper:new_local()
	local moho = helper:MohoObject() self.p.m = self.p and moho or nil
	local doc = moho.document --print("HM: " .. (doc and doc:Name()) or "No Doc") --20240103-1809: Back to normality after fixing the casue of opening document mess? (TBO!)
	--local doc = (LS_Shapes.defDoc and LS_Shapes.defDoc ~= moho.document) and LS_Shapes.defDoc or moho.document --print("HM: " .. (doc and doc:Name()) or "No Doc") --20240102-1638: A try to fix/patch the new opening document mess for now... (TBO!)
	local docH = doc and doc:Height() or 240
	local frame = moho.frame
	local toolName = (doc ~= nil and doc:Name() ~= "-") and moho:CurrentTool() or ""
	local tool = _G[toolName]
	local l = self.GetLayout and self:GetLayout() or nil
	--local vHeight, vWidth = moho.view:Height(), moho.view:Width()
	local newVal = {0, 0, 0, 0}

	local itemsSel = self.itemList and math.floor(self.itemList:NumSelectedItems() + (self.itemList:IsItemSelected(0) == true and -1 or 0))
	local itemSel = self.itemList and math.floor(self.itemList:SelItem()) - 1 or -1
	local multiValues = (LS_Shapes.advanced and self.multi1) and {self.multi1:IntValue(), self.multi2:IntValue(), self.multi3:IntValue(), self.multi4:IntValue()} or {0, 0, 0, 0} --20250904-0145: Ternary patch, for now, to avoid "attempt to index a nil value (field 'multi1')" upon activating Advanced Mode
	local multiRgb = LM.ColorOps:RgbColor(multiValues[1], multiValues[2], multiValues[3], multiValues[4] / 100 * 255)
	local multiHsv = LM.ColorOps:Rgb2Hsv(multiRgb)

	local styleName = doc and moho:CurrentEditStyle() and tostring(moho:CurrentEditStyle().fName:Buffer()) or "" -- 20250730-2130: Had to also check doc existence here & below to avoid (I think new in v14.3) crashes
	local style = doc and moho:CurrentEditStyle() -- 20231010-0554: For some reason, "styleName" must be gathered before this assignment, otherwise then it won't be possible to access "style" properties!
	local styleID = -1
	local styleCount = doc and math.floor(doc:CountStyles()) or 0
	local styleSelID = LS_Shapes.mode == 2 and math.floor(self.itemList:SelItem()) - 1 or -1
	local styleSel = doc and doc:StyleByID(styleSelID) or style
	local stylesSel = math.floor(self.itemList:NumSelectedItems() + (self.itemList:IsItemSelected(0) == true and -1 or 0))

	local style1Name, style2Name = (self.tempShape and self.tempShape.fInheritedStyle) and tostring(self.tempShape.fInheritedStyle.fName:Buffer()) or "", (self.tempShape and self.tempShape.fInheritedStyle2) and tostring(self.tempShape.fInheritedStyle2.fName:Buffer()) or "" -- See note 20231010-0554 above!
	local style1, style2 = (styleName == "" and self.tempShape) and self.tempShape.fInheritedStyle or nil, (styleName == "" and self.tempShape) and self.tempShape.fInheritedStyle2 or nil
	local style1UUID, style2UUID = style1 and style1.fUUID:Buffer() or nil, style2 and style2.fUUID:Buffer() or nil
	local style1ID, style2ID = LS_Shapes:StyleID(doc, style1), LS_Shapes:StyleID(doc, style2)

	self.info[1], self.info[2], self.info[3], self.info[4] = nil
	self.tempShape = moho:NewShapeProperties() or MOHO.MohoGlobals.NewShapeProperties
	self.msg = msg or MOHO.MSG_BASE
	self.change = self.CHANGE + self.itemList:SelItem() + 1

	-- First of all, process everything that can be accessed even without an open doc
	if (msg >= self.MAINMENU and msg <= self.MAINMENU + 13 + 1) then -- The + 1 is for "Testground"
		if (msg == self.MAINMENU) then -- Link To Style Window
			LS_Shapes.syncWithStyle = not LS_Shapes.syncWithStyle
		elseif (msg == self.MAINMENU + 1) then -- Ignore Non-Regular Vector Layers
			LS_Shapes.ignoreNonRegular = not LS_Shapes.ignoreNonRegular
		elseif (msg == self.MAINMENU + 2) then -- Open On Startup
			LS_Shapes.openOnStartup = not LS_Shapes.openOnStartup
		elseif (msg == self.MAINMENU + 3) then -- Show In "Tools" Palette
			if (LS_Shapes.alertShowInTools ~= 1 and LS_Shapes.showInTools == true) then
				LS_Shapes.alertShowInTools = LM.GUI.Alert(LM.GUI.ALERT_INFO, string.format(MOHO.Localize("/LS/Shapes/ShowInToolsAlert1=The Tools palette button to open \"%s\" will be, and remain, hidden."), LS_Shapes:UILabel()),
				MOHO.Localize("/LS/Shapes/ShowInToolsAlert2=This helps saving space there, but you'll have to open the window by means of its \"Scripts\" menu entry from now on (therefore you can revert this setting at any time)"), "\n\n" .. MOHO.Localize("/LS/Shapes/ShowInToolsAlert3=💡 You may want to consider checking \"Open On Startup\" option just above!"),
				MOHO.Localize("/LS/Shapes/OK=OK"), MOHO.Localize("/LS/Shapes/GotIt=Got It!"), MOHO.Localize("/LS/Shapes/Cancel=Cancel"))
			end
			if LS_Shapes.alertShowInTools < 2 then
				LS_Shapes.showInTools = not LS_Shapes.showInTools
				if (doc ~= nil) then
					moho:SetCurFrame(frame ~= 0 and 0 or 1)
					moho:SetCurFrame(frame)
				end
			end
		elseif (msg == self.MAINMENU + 4) then -- Beginner's Mode
			LS_Shapes.beginnerMode = not LS_Shapes.beginnerMode
		elseif (msg == self.MAINMENU + 5) then -- Debug Mode
			local log = LS_Shapes:FileExists(self.resPath .. '\\LOG.txt')
			local alert = LM.GUI.Alert(LM.GUI.ALERT_INFO, string.format(MOHO.Localize("/LS/Shapes/DebugModeAlert2=Debug Mode is currently: %s"), LS_Shapes.debugMode and "ENABLED" or "DISABLED"),			
			MOHO.Localize("/LS/Shapes/DebugModeAlert2=This mode logs events in the \"ScriptResources\" folder. Please include the \"LOG.txt\" file, or at least its last few lines, when reporting a crash related issue, particularly if they form an incomplete log cycle (lacking an [ END ] marker) and the date and crash time match."), "\n\n" .. MOHO.Localize("/LS/Shapes/DebugModeAlert3=💡 The Debug Mode has minimal performance impact, so it's recommended to enable it if you suspect the script is causing unexpected crashes."),
			LS_Shapes.debugMode and MOHO.Localize("/LS/Shapes/Disable=Disable"):upper() or MOHO.Localize("/LS/Shapes/Enable=Enable"):upper(), log and MOHO.Localize("/LS/Shapes/OpenLog=Open Log...") or nil, MOHO.Localize("/LS/Shapes/Cancel=Cancel"))
			if alert == 0 then
				if not LS_Shapes.debugMode then
					LS_Shapes.debugMode = true
					moho:Click()
				else
					if LS_Shapes.log ~= nil then
						LS_Shapes.log:close()
						LS_Shapes.log = nil
					end
					LS_Shapes.debugMode = false
				end
			elseif alert == 1 then
				if log then
					LS_Shapes:Open(self.resPath .. '\\LOG.txt')
				else
					LM.Beep()
				end
			else
				-- Exit without changes
			end
		elseif (msg >= self.MAINMENU + 6 and msg <= self.MAINMENU + 9) then -- Try to encompass here options which require auto-reopening.
			if (msg == self.MAINMENU + 6) and doc ~= nil then -- Advanced (Creation Controls)
				LS_Shapes.advanced = not LS_Shapes.advanced
				--self.menu1:SetChecked(msg, LS_Shapes.advanced) -- Not necessary in this case, but another possibility of update entries' checkmarks...
			elseif (msg == self.MAINMENU + 7) and doc ~= nil then -- Use Large Buttons
				LS_Shapes.largeButtons = not LS_Shapes.largeButtons
			elseif (msg == self.MAINMENU + 8) and doc ~= nil then -- Use Large Palette
				LS_Shapes.largePalette = not LS_Shapes.largePalette
			elseif (msg == self.MAINMENU + 9) and doc ~= nil then -- Show Infobar
				LS_Shapes.showInfobar = not LS_Shapes.showInfobar
			end
			if (doc ~= nil) then
				self.dummyList:SetSelItem(self.dummyList:GetItem(0), false)
				if (LS_Shapes.dlog) then
					LS_Shapes.dlog = nil
					LS_Shapes.shouldReopen = true
				end
			end
			helper:delete()
			return
		elseif (msg == self.MAINMENU + 10) then -- Restore Defaults [?]
			local alert = LM.GUI.Alert(LM.GUI.ALERT_QUESTION,
			LS_Shapes:UILabel() .. ": " .. MOHO.Localize("/Dialogs/Preferences/ToolPrefs/RestoreDefaults=Restore Factory Defaults") .. "?",
			MOHO.Localize(doc ~= nil and "/LS/Shapes/TheWindowWillReopen=The window will reopen itself if necessary." or "/LS/Shapes/TheWindowWillClose=The window will close if necessary."), nil,
			MOHO.Localize("/Dialogs/ProjectSettings/RestoreDefaults=Restore Defaults"):gmatch("%w+")(), MOHO.Localize("/Strings/Cancel=Cancel")) --Restore: 0, Cancel: 1
			if alert == 0 then
				LS_Shapes:ResetPrefs()
				if LS_Shapes.advanced ~= self.menu1:IsChecked(self.MAINMENU + 5) or LS_Shapes.largeButtons ~= self.menu1:IsChecked(self.MAINMENU + 6) or LS_Shapes.largePalette ~= self.menu1:IsChecked(self.MAINMENU + 6) or LS_Shapes.showInfobar ~= self.menu1:IsChecked(self.MAINMENU + 8) then -- Only Reopen dialog if necessary.
					self.dummyList:SetSelItem(self.dummyList:GetItem(0), false)
					if (LS_Shapes.dlog) and doc ~= nil then -- It may be better not try to reopen without an open document, otherwise the lack of view (among other things) will make it open weirdly.
						LS_Shapes.dlog = nil
						LS_Shapes.shouldReopen = true
					end
					helper:delete()
					return
				end
			else
				helper:delete()
				return
			end
		elseif (msg == self.MAINMENU + 11) then -- Help...
			LS_Shapes.showHelp = not LS_Shapes.isHelpVisible and true or false
			if (LS_Shapes.showHelp and (not LS_Shapes.isHelpVisible)) then
				if LS_Shapes:FileExists(self.resPath .. '\\HELP.png') then
					local hDlog = LS_Shapes.h:new()
					LS_Shapes.isHelpVisible = true
					LS_Shapes.showHelp = false

					if (hDlog:DoModal() == LM.GUI.MSG_CANCEL) then
						LS_Shapes.isHelpVisible = false
						LS_Shapes.showHelp = true
						hDlog = nil --?
						return
					end
				elseif (LS_Shapes:FileExists(self.resPath .. '\\@HELPME.url') == true) then
					LS_Shapes:Open(self.resPath .. '\\@HELPME.url')
				elseif LS_Shapes.repo then
					os.execute('start "" ' .. LS_Shapes.repo .. "#top")
				else
					LM.Beep()
				end
			end
		elseif (msg == self.MAINMENU + 12) then -- Visit Webpage...
			if (LS_Shapes:FileExists(self.resPath .. '\\@VISITME.url') == true) then
				LS_Shapes:Open(self.resPath .. '\\@VISITME.url')
			elseif LS_Shapes.webpage then
				os.execute('start "" ' .. LS_Shapes.webpage)
			else
				LM.Beep()
			end
		elseif (msg == self.MAINMENU + 13) then -- Check For Updates...
			if LS_Shapes.repoLatest then
				os.execute('start "" ' .. LS_Shapes.repoLatest .. ("#YOURS IS v" .. LS_Shapes.version):replace(" ", "-")) --os.execute('start "" "https://mohoscripts.com/script/"' .. (info.source):match("^.*[/\\](.*).lua$"))
			elseif (LS_Shapes:FileExists(self.resPath .. '\\@UPDATEME.url') == true) then
				LS_Shapes:Open(self.resPath .. '\\@UPDATEME.url')
			else
				LM.Beep()
			end
		elseif (msg == self.MAINMENU + 14) then -- About...
			local years = LS_Shapes.birth:sub(1,4) .. (tonumber(LS_Shapes.build:sub(1, 4)) > tonumber(LS_Shapes.birth:sub(1, 4)) and "-" .. LS_Shapes.build:sub(1,4) or "")
			local block1a = string.format("%s %s (Build %s) for %s\n", LS_Shapes:UILabel(), LS_Shapes.version, LS_Shapes.build, LS_Shapes.target:replace(" ", " "))
			local block1b = string.format("%s %s %s %s", "Copyright ©", years, LS_Shapes:Creator(), "(Lost Scripts™)")
			local block2 = LS_Shapes:Description() .. "\n\n"
			local block3 = "All rights reserved - Click \"Read License\" for terms and conditions." --"Licensed under the Apache License, Version 2.0"
			--local blockSep = "\n" .. ("_"):rep(math.max(block1a and #block1a or 0, block1b and #block1b or 0))
			local alert = LM.GUI.Alert(LM.GUI.ALERT_INFO, block1a .. block1b, block2, block3, MOHO.Localize("/Scripts/Menu/Credits/Title=Credits"), MOHO.Localize("/Dialogs/SLAPanel/ReadLicense=Read License"), MOHO.Localize("/Menus/File/CloseRender=Close")) --This script is freeware and released under the ... License. --Licensed under the ... License.
			if alert == 0 then
				local file = self.resPath .. "\\" .. "CREDITS.txt"
				local fileLines = LS_Shapes:ReadFile(file)
				local alert = LM.GUI.Alert(LM.GUI.ALERT_INFO, "Credits & Acknowledgements", LS_Shapes.List(fileLines, {kind = ""}), nil, MOHO.Localize("/Menus/File/CloseRender=Close"))
			elseif alert == 1 then
				local file = LS_Shapes:FirstExistingFile(self.resPath, "LICENSE", "LICENSE.txt") --local file = self.resPath .. "\\" .. "LICENSE"
				local fileContent = LS_Shapes:ReadFile(file, {asString = true})
				local minWidth = "\n" .. string.rep(" ", 170)
				local alert = LM.GUI.Alert(LM.GUI.ALERT_INFO, "Licence & Warranty", fileContent .. minWidth, nil, MOHO.Localize("/Menus/File/CloseRender=Close"))
			end
		elseif (msg == self.MAINMENU + 15) then -- Last (Testground!)
			--print("...")
		end

		self:Update() -- Since it doesn't seem to be possible to trigger anything upon closing last document... well, this will help to disable irrelevant widgets as soon as user click on any menu entry (moved from the very top to here)
		if (doc ~= nil) then
			MOHO.Redraw()
		end
		helper:delete()
		return
	elseif (msg >= self.SELECTSWATCH and msg <= self.SELECTSWATCH + self:CountRealItems(self.swatchMenu, self.SELECTSWATCH) - 1) then --MARK: SS MENU
		local reopen = false
		if (msg == self.SELECTSWATCH) then --print("None") -- None
			reopen = LS_Shapes.swatch ~= -1
			LS_Shapes.swatch = (msg - self.SELECTSWATCH) - 1

			if reopen then
				self.dummyList:SetSelItem(self.dummyList:GetItem(0), false)
				if (LS_Shapes.dlog) then
					LS_Shapes.dlog = nil
					LS_Shapes.shouldReopen = true
				end
			end
			helper:delete()
			return
		elseif (msg > self.SELECTSWATCH) and (msg < self.SELECTSWATCH + self:CountRealItems(self.swatchMenu, self.SELECTSWATCH) - 4) then --print(">>> " .. (msg - self.SELECTSWATCH) - 1)
			reopen = LS_Shapes.swatch == -1 and (msg - self.SELECTSWATCH) - 1 > -1
			LS_Shapes.swatch = (msg - self.SELECTSWATCH) - 1

			--[[20231122: Pre-nested table system working code.
			local count, layer = 0, nil
			for i, doc in ipairs(LS_Shapes.docList) do
				for j = doc:CountLayers() - 1, 0, -1 do
					layer = doc:Layer(j)
					count = count + 1
					if count == (msg - self.SELECTSWATCH) then
					--if (layer:LayerType() == MOHO.LT_VECTOR) and not layer:IsRenderOnly() then --20231121-0716: Would need to check if it's a valid swatch in order to match Update state! But needs rethinking...
						LS_Shapes.swatchDoc = i
						LS_Shapes.swatchLayer = j
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
						LS_Shapes.swatchDoc = i
						LS_Shapes.swatchLayer = j --print(msg - self.SELECTSWATCH, ", ", LS_Shapes.swatchDoc, ", ", LS_Shapes.swatchLayer)
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
						LS_Shapes.doc = LS_Shapes.docList[i]
						LS_Shapes.swatchDoc = i
						LS_Shapes.swatchLayer = chunk[j].id and chunk[j].id or -1 --print(msg - self.SELECTSWATCH, ", ", LS_Shapes.swatchDoc, ", ", LS_Shapes.swatchLayer)
						break
					end
				end
			end

			if reopen then
				self.dummyList:SetSelItem(self.dummyList:GetItem(0), false)
				if (LS_Shapes.dlog) then
					LS_Shapes.dlog = nil
					LS_Shapes.shouldReopen = true
				end
			end
			self:Update()
			self:UpdateColor(moho)
			self.swatchMenu:UncheckAll()
			self.swatchMenu:SetChecked(msg, true) --self.swatchMenuPopup:Redraw()
			helper:delete() --20240102-0425: This was missing for some reason and that seemed the cause for all the open documents mess?? (TBO!)
			return
		elseif (msg == self.SELECTSWATCH + self:CountRealItems(self.swatchMenu, self.SELECTSWATCH) - 4) then --print("Custom Swatches...") -- Custom Swatches...
			LS_Shapes:Open(self.userPath .. "\\Swatches")
		elseif (msg == self.SELECTSWATCH + self:CountRealItems(self.swatchMenu, self.SELECTSWATCH) - 3) then --print("Use Selection") -- Use Selection
			LS_Shapes.swatch = -2
		elseif (msg == self.SELECTSWATCH + self:CountRealItems(self.swatchMenu, self.SELECTSWATCH) - 2) then --print("Edit Current Swatch") -- Edit Current Swatch
			if LS_Shapes.doc ~= nil then
				local doc, layer = LS_Shapes.docList[LS_Shapes.swatchDoc] --local layer = LS_Shapes.doc:Layer(LS_Shapes.swatchLayer)
				if doc ~= nil then
					--[[20240102-1744: Alternative mode for/if bellow one start failing again...
					local path = doc:Path():reverse()
					local sepPos = string.find(path, "[/\\]")
					if sepPos then
						local sep = path:sub(sepPos, sepPos)
						path = string.sub(path, sepPos + 1):reverse() --print(path)
						os.execute(sep == "/" and 'open "" "' or 'start "" "' .. path .. '"') -- Just open de directory for the momment...
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
					LS_Shapes.swatchLayer = LS_Shapes.swatchLayer > moho.document:CountLayers() - 1 and moho.document:CountLayers() - 1 or LS_Shapes.swatchLayer --LM.Clamp(LS_Shapes.swatchLayer, 0, moho.document:CountLayers() - 1) --print(doc:Name(), ", ", moho.document:Name())
					layer = moho.document:Layer(LS_Shapes.swatchLayer)
					moho:SetSelLayer(layer, false, true)
					if not (moho.layer:HasAction("SLIDER") and moho.layer:HasAction("SLIDER 2")) then
						--MOHO.MohoGlobals.GridOn = moho.gridOn == false and true or moho.gridOn
						--MOHO.MohoGlobals.GridSize = moho.gridSize ~= 11 and 11 or moho.gridSize
					end
					for i = 0, moho.document:CountLayers() - 1 do
						moho.document:Layer(i):SetVisible(i == LS_Shapes.swatchLayer) --print(doc:Layer(i):Name())
					end
					moho:UpdateUI()
					helper:delete()
					return
					--]]
				end
			end
		elseif (msg == self.SELECTSWATCH + self:CountRealItems(self.swatchMenu, self.SELECTSWATCH) - 1) then --print("Reload Swatches")
			LS_Shapes.docList = {}
			LS_Shapes.docsLoaded = false
			self.swatchMenu:RemoveAllItems()
			LS_Shapes:IsEnabled(moho)
			--self:UpdateColor(moho)
		else
			--LS_Shapes.swatch = math.abs((self.SELECTSWATCH + 3) - msg) print(LS_Shapes.swatch)
		end
		self:Update()
	elseif (msg >= self.MULTIMENU and msg < self.SELECTSTYLE1) then
		self.multiMode = msg - self.MULTIMENU -- Pre-update so it can be used (more) reliably below?
	end

	local pass = LS_Shapes.MsgFlag(self, msg, MOHO.MSGF_PASS) or false --print("Pass: " .. tostring(pass))
	if (doc == nil and not pass) then -- Ensure (barring exceptions) that nothing is run from here on after closing last doc, or things like LayerAsVector will make Moho crash...
		self:Update()
		helper:delete()
		return
	else
		for i = 0, styleCount - 1 do
			local iStyle = doc:StyleByID(i)
			if iStyle == style then
				styleID = math.floor(i)
				break
			elseif iStyle.fSelected then
				styleID = math.floor(i)
			end
		end
	end

	local layer = doc and moho.layer
	local layersSel = doc and doc:CountSelectedLayers() or 1
	local lFrame = layer and moho.layerFrame or 0
	local lFrameAlt = doc and moho.frame + (layer and layer:TotalTimingOffset() or 0)
	local lDrawing = (doc and moho.drawingLayer) and moho:LayerAsVector(moho.drawingLayer) or nil
	local lDrawingUUID = lDrawing and lDrawing:UUID() or ""
	local lDrawingFrame = lDrawing and moho.drawingLayerFrame or 0
	local lDrawingFrameAlt = moho.frame + (lDrawing and lDrawing:TotalTimingOffset() or 0)
	local mesh = doc and moho:DrawingMesh()
	local item = nil
	local itemID = -1
	local pointsSel = doc and moho:CountSelectedPoints(true)
	local group = mesh and LS_Shapes:SelectedGroup(mesh)
	local groupID = group and mesh:GroupID(group) or -1
	local groupName = group and group:Name() or ""
	local groupCount = mesh and math.floor(mesh:CountGroups()) or 0
	local groupSelCount = mesh and LS_Shapes:CountSelectedGroups(mesh) or 0
	local groupPtCount = group and math.floor(group:CountPoints()) or nil
	local shape = doc and moho:SelectedShape()
	local shapeID = shape and mesh:ShapeID(shape) or -1
	local shapeName = shape and shape:Name() or ""
	local shapeCount = mesh and mesh:CountShapes() or 0
	local shapesSel = doc and moho:CountSelectedShapes(true) -- There is also a LM_SelectShape:CountSelectedShapes
	local shapeStyle1 = shape ~= nil and shape.fInheritedStyle or nil
	local shapeStyle2 = shape ~= nil and shape.fInheritedStyle2 or nil

	if (style == nil and mesh == nil) then
		if msg < self.FILL and msg > self.RESET_ALT and msg ~= self.CHANGE then --print(msg, ", ", self.MAINMENU + self:CountRealItems(self.menu1) - 1) -- If doc but not object, exit should msg was other than options menu's
			helper:delete()
			return
		end
	end

	if LS_Shapes.mode < 2 then -- SHAPE Modes
		--itemID = shapeCount > 0 and self.itemList:SelItem() > 0 and LM.Clamp(self.itemList:SelItem(), 0, shapeCount) - 1 or -1
		--item = mesh and itemID > -1 and mesh:ShapeByID(itemID) or nil
	elseif LS_Shapes.mode == 2 then -- STYLE Mode
		itemID = styleCount > 0 and self.itemList:SelItem() > 0 and LM.Clamp(self.itemList:SelItem(), 0, styleCount) - 1 or -1
		item = doc and itemID > -1 and doc:StyleByID(itemID) or nil
	else -- GROUP Mode
		itemID = mesh and groupCount > 0 and self.itemList:SelItem() > 0 and LM.Clamp(self.itemList:SelItem(), 0, groupCount) - 1 or -1
		item = mesh and itemID > -1 and mesh:Group(itemID) or nil
	end
	self.groupUI = item --self.groupUI = mesh and mesh:Group(self.itemList:SelItem() > 0 and self.itemList:SelItem() - 1) or nil

	local undoable = not LS_Shapes.MsgFlag(self, msg, MOHO.MSGF_NOTUNDO) --print("Undoable: " .. tostring(undoable)) -- It is considered "undoable" if it does NOT have the MSGF_NOTUNDO flag
	local multiUndoable = LS_Shapes.MsgFlag(self, msg, MOHO.MSGF_MULTIUNDO) and (layersSel > 1) or false --print("Multiundoable: " .. tostring(multiUndoable))
	if (doc ~= nil and undoable) then
		if (multiUndoable == true) then
			doc:PrepMultiUndo()
		else
			doc:PrepUndo(lDrawing)
		end
		doc:SetDirty()
	end

	if (msg == self.CHANGE) then --MARK: CHANGE
		if (doc == nil and mesh == nil) then
			self:Update()
			helper:delete()
			return
		end
		if LS_Shapes.mode < 2 then -- SHAPE Modes
			if self.skipBlock == true then -- Try to avoid unwanted call to Update/UpdateWidgets bellow upon selecting, no matter how, a list item!
				if LS_Shapes.pointBasedSel and not (toolName:find("SelectShape" or toolName:find("Freehand" or toolName:find("Brush") or toolName:find("Eraser")))) then --if (LS_Shapes.pointBasedSel and toolName:find("SelectPoints")) then
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
					else
						if (doc ~= nil) then
							MOHO.Redraw() -- Ensure shapes display as selected if e.g. "Ctrl+A" is pressed wiht "Point-Based Selection" activated...
						end
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
				end
				---[=[Experimental Point-Based Selection Mode...
				if LS_Shapes.pointBasedSel and not (toolName:find("SelectShape" or toolName:find("Freehand" or toolName:find("Brush") or toolName:find("Eraser")))) then
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
				if LS_Shapes.syncWithStyle then
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
		elseif LS_Shapes.mode == 2 then -- STYLE Mode
			if self.skipBlock == true then -- Try to avoid unwanted call to Update/UpdateWidgets bellow upon selecting, no matter how, a list item!
				helper:delete()
				return -- 20230920-2103: Commented, since it seems to make dialog widgets not update propertly... 20231006-2004: But now it's uncommented and works? 🤔
			end
			if (doc ~= nil) then
				--styleID = self.itemList:SelItem() > 0 and doc	:CountStyles() - self.itemList:SelItem() or -1
				for i = 0, styleCount - 1 do
					local iStyle = doc:StyleByID(i) --doc:CountStyles() - i
					if iStyle ~= nil then
						iStyle.fSelected = self.itemList:IsItemSelected(i + 1)
					end
					--print(iStyle.fName:Buffer(), ", ", tostring(iStyle.fSelected))
				end
				if math.floor(self.itemList:SelItem()) - 1 ~= styleID then
					LS_Shapes.mode = LS_Shapes:StyleLeaver(moho, mesh, 2)
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
		elseif LS_Shapes.mode == 3 then -- GROUP Mode
			if self.skipBlock == true then -- Try to avoid unwanted call to Update/UpdateWidgets bellow upon selecting, no matter how, a list item!
				helper:delete()
				return
			end

			groupID = self.itemList:SelItem() > 0 and mesh:CountGroups() - self.itemList:SelItem() or -1
			if self.mode == LS_Shapes.mode then
				mesh:SelectNone()
			end

			for i = 0, groupCount - 1 do
				local group = mesh:Group(i)
				if group ~= nil then
					group.ls_fSelected = self.itemList:IsItemSelected(i + 1)
					if group.ls_fSelected then
						mesh:SelectGroup(group:Name())
					end
				end
			end
			if self.itemList:SelItem() < 1 and self.mode == LS_Shapes.mode then
				mesh:SelectNone()
			end
			MOHO.Redraw()
			self:Update() -- Ensure up-to-date labels
		end
	elseif (msg == self.MODE or msg == self.MODE_ALT) then
		if LS_Shapes.mode < 2 then -- if SHAPE Modes
			if (mesh ~= nil and LS_Shapes.mode == 1) then
				if shapeID and shapeID >= 0 then
					if not LS_Shapes.pointBasedSel then
						moho:DeselectShapes()
					else
						mesh:SelectNone()
					end
					self.itemSel = 0
					MOHO.Redraw()
				end
			end
			if (msg == self.MODE_ALT) then
				LS_Shapes.mode = 3
				self.itemList:SetSelItem(self.itemList:GetItem(0), true)
				self.itemList:ScrollItemIntoView(0, true)
				self.itemSel = 0
			else
				LS_Shapes.mode = 2
				self.itemList:SetSelItem(self.itemList:GetItem(0), true)
				self.itemList:ScrollItemIntoView(0, true)
				self.itemSel = 0
			end
		elseif LS_Shapes.mode == 2 then -- if STYLE Mode
			local mode
			if mesh ~= nil then
				mode = LS_Shapes:StyleLeaver(moho, mesh)
			else
				--20231205-1925: Do nothing for now, among other things, cause it would require the creation of a temp vector layer, which would be visible for a sec upon the necessary UpdateUI...
			end
			if (msg == self.MODE_ALT) then
				LS_Shapes.mode = 3
				self.itemList:SetSelItem(self.itemList:GetItem(0), true)
				self.itemList:ScrollItemIntoView(0, true)
				self.itemSel = 0
			else
				LS_Shapes.mode = 0
				self.itemSel = 0
			end
		elseif LS_Shapes.mode == 3 then -- if GROUP Mode
			LS_Shapes.mode = LS_Shapes.mode ~= 3 and 3 or 0
		end
		self:Update()
	elseif (msg == self.NAME) then --MARK: PROPS.
		if LS_Shapes.mode < 3 then -- SHAPE/STYLE modes
			if (shapeID and shapeID >= 0) then
				for i = 0, mesh:CountShapes() - 1 do
					local iShape = mesh:Shape(i)
					if (iShape.fSelected) then
						iShape:SetName(self.itemName:Value())
						LS_Shapes:MakeShapeNameUnique(mesh, i) --20250823-0125: Why would this line be commented out? Anyway, un-commented for now...
					end
				end
			elseif (style ~= nil and styleName ~= "") then -- Current Style (TAKE CARE NOT TO NAME DEFAULT NAMELESS STYLE!)
				style.fName:Set(self.itemName:Value()) --doc:RenameStyle(styleName, self.itemName:Value(), nil) -- Doesn't seem to do anything...
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
						LS_Shapes:MakeStyleNameUnique(doc, i)
					end
				end
			end
		else -- GROUP Mode
			for i = 0, mesh:CountGroups() - 1 do
				local iGroup = mesh:Group(i)
				if (iGroup.ls_fSelected) then
					iGroup.fName:Set(self.itemName:Value())
					LS_Shapes:MakeGroupNameUnique(mesh, i)
				end
			end
		end
		moho:UpdateUI()
	elseif (msg == self.VIS) then
		if (mesh ~= nil) then
			if (LS_Shapes.mode < 2) then -- SHAPE Modes
				if (shape ~= nil) then
					for i = 0, shapeCount - 1 do
						local shape = mesh:Shape(i)
						if (shape.fSelected) then
							shape.fHidden = not self.itemVisCheck:Value()
						end
					end
				end
			elseif (LS_Shapes.mode == 3) then -- GROUP Mode
				if (group or self.groupUI) then
					for i = 0, groupCount - 1 do
						local g = mesh:Group(i)
						if (g.ls_fSelected) then
							g.ls_fHidden = not self.itemVisCheck:Value()
						end
						if (g.ls_fSelected or g:Name() == self.groupUI:Name()) then -- 2nd condition is necessary to can hide duplicates from top to bottom!
							for j = 0, g:CountPoints() - 1 do
								local pt = g:Point(j)
								if g.ls_fHidden == true then
									pt.fHidden = true
								else
									pt.fHidden = false
								end
							end
						end
					end
				end
			end
		end
		MOHO.Redraw()
		self:Update()
	elseif (msg == self.RAISE or msg == self.RAISE_ALT) then
		local m = self.RAISE - msg -- 0/-1
		if LS_Shapes.mode < 2 then -- SHAPE Modes
			if msg == self.RAISE_ALT then
				mesh:RaiseShape(shapeID, true)
				self.itemList:SetSelItem(self.itemList:GetItem((shapeCount) - mesh:ShapeID(shape)), false, false) -- Can't use skipAll/Block in this case...
			else
				for i = shapeCount - 1, 0, -1 do
					if mesh:Shape(i).fSelected then
						mesh:RaiseShape(i, false)
					end
				end
			end
			MOHO.Redraw()
			if mesh and mesh:AnimatedShapeOrder() and lFrame ~= 0 then
				moho:UpdateUI()
			end
			self:Update()
		elseif LS_Shapes.mode == 3 then -- GROUP Mode
			if mesh then
				local idx = LS_Shapes:MoveGroup(mesh, itemSel, -1 + m) -- -1 = raise, -2 = to front/top
				if idx then
					self.itemList:SetSelItem(self.itemList:GetItem(idx), true, false)
				end
			end
		end
	elseif (msg == self.LOWER or msg == self.LOWER_ALT) then
		local m = msg - self.LOWER  -- 0/1
		if LS_Shapes.mode < 2 then -- SHAPE Modes
			if msg == self.LOWER_ALT then
				mesh:LowerShape(shapeID, true)
				self.itemList:SetSelItem(self.itemList:GetItem((shapeCount) - mesh:ShapeID(shape)), false, false) -- Can't use skipAll/Block in this case...
			else
				for i = 0, shapeCount - 1 do
					if mesh:Shape(i).fSelected then
						mesh:LowerShape(i, false)
					end
				end
			end
			MOHO.Redraw()
			if mesh and mesh:AnimatedShapeOrder() and lFrame ~= 0 then
				moho:UpdateUI()
			end
			self:Update()
		elseif LS_Shapes.mode == 3 then -- GROUP Mode
			if mesh then
				local idx = LS_Shapes:MoveGroup(mesh, itemSel, 1 + m) -- 1 = lower, 2 = to back/bottom
				if idx then
					self.itemList:SetSelItem(self.itemList:GetItem(idx), true, false)
				end
			end
		end
	elseif (msg == self.ANIMORDER or msg == self.ANIMORDER_ALT) then
		local lDrawingOrderCh = moho:DrawingMesh() and LS_Shapes:ChannelByID(moho, lDrawing, CHANNEL_SHAPE_ORDER) or nil -- 20250725: Channel access will ruin any following mesh access attempt!
		if (lDrawingOrderCh ~= nil) then
			if (msg == self.ANIMORDER) then
				if not lDrawingOrderCh:HasKey(lDrawingFrameAlt) then
					if frame ~= 0 then
						lDrawingOrderCh:StoreValue()
					else
						lDrawingOrderCh:SetValue(lDrawingFrameAlt, lDrawingOrderCh:GetValue(lDrawingFrameAlt))
					end
					MOHO.NewKeyframe(CHANNEL_SHAPE_ORDER)
				else
					lDrawingOrderCh:DeleteKey(lDrawingFrameAlt)
					layer:UpdateCurFrame(false)
				end
			else
				lDrawingOrderCh:SetValue(lDrawingFrame, lDrawingOrderCh:GetValue(0))
				layer:UpdateCurFrame(false)
			end
			MOHO.Redraw()
			--self:Update()
			moho:UpdateUI()
		end
	elseif (msg == self.SELECTALL or msg == self.SELECTALL_ALT) then -- NOTE: What if click once selected all, another click deselected all and holding <alt> selected similar? --MARK: SELECT
		if LS_Shapes.mode < 2 then
			if (mesh == nil or msg == self.SELECTALL and shapeCount == shapesSel) then -- If SHAPE Modes
				LM.Beep()
				helper:delete()
				return
			end
			for i = 0, shapeCount - 1 do
				local iShape = mesh:Shape(i)
				iShape.fSelected = (msg == self.SELECTALL) and true or not iShape.fSelected
				if (LS_Shapes.pointBasedSel and not toolName:find("SelectShape")) then
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
		elseif LS_Shapes.mode == 2 then -- If STYLE Mode
			if style and styleName ~= "" then
				LS_Shapes.mode = LS_Shapes:StyleLeaver(moho, mesh, 2)
			end
			if (msg == self.SELECTALL and styleCount == stylesSel) then 
				LM.Beep()
				helper:delete()
				return
			end
			for i = 0, styleCount - 1 do
				local iStyle = doc:StyleByID(i)
				iStyle.fSelected = (msg == self.SELECTALL) and true or not iStyle.fSelected --20240102-2224: It seems to fail if only first item in list is selected... But why?
			end
		else -- If GROUP Mode
			if (mesh == nil or msg == self.SELECTALL and groupCount == groupSelCount) then
				LM.Beep()
				helper:delete()
				return
			end
			mesh:DeselectPoints()

			for i = 0, groupCount - 1 do
				local group = mesh:Group(i)
				if (msg == self.SELECTALL) then
					group.ls_fSelected = true
					--mesh:SelectGroup(group:Name())
				else
					group.ls_fSelected = not group.ls_fSelected
					--for j = 0, group:CountPoints() - 1 do
						--local pt = group:Point(j)
						--pt.fSelected = group.ls_fSelected
					--end
				end
				if group.ls_fSelected then
					mesh:SelectGroup(group:Name())
				end
			end
			MOHO.Redraw()
		end
		moho:UpdateUI() -- It seems necessary in order to activate buttons according to list selection, plus it seems to solve the above note!
		self:Update()
		self.itemList:Redraw()
	elseif (msg == self.SELECTMATCHING or msg == self.SELECTMATCHING_ALT) then
		local count = 0
		local fillCol, lineCol
		if LS_Shapes.mode < 2 then -- SHAPE Modes
			for i = 0, shapeCount - 1 do
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
					if iShape.fSelected == true and (LS_Shapes.pointBasedSel and not toolName:find("SelectShape")) then
						iShape:SelectAllPoints()
					end
				end	--print(i, ", ", tostring(iShape.fSelected), ", ", count)
			end
		elseif LS_Shapes.mode == 2 then --STYLE Mode
			local style = (style and styleName ~= "") and style or styleSel
			local styleUUID = style.fUUID:Buffer()
			for i = 0, styleCount - 1 do
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
			for i = 0, styleCount - 1 do
				local iStyle = doc:StyleByID(i)
				if iStyle ~= nil and (iStyle.fUUID:Buffer() ~= styleUUID) and iStyle:ArePropertiesEqual(style) then
					iStyle.fSelected = true
					count = count + 1
				end
			end
			--]]
			if count > 0 then
				LS_Shapes.mode = LS_Shapes:StyleLeaver(moho, mesh, 2)
				moho:UpdateUI()
			end
		else -- GROUP Mode
			local groupsByKey, groupKeys = {}, {}
			for i = 0, groupCount - 1 do
				local g = mesh:Group(i)
				if g and g:CountPoints() > 0 then -- Collect point IDs for this group
					local ids = {}
					for j = 0, g:CountPoints() - 1 do
						table.insert(ids, mesh:PointID(g:Point(j)))
					end
					table.sort(ids) -- Sort IDs so order doesn't matter and, then, concatenate into a single key string
					local key = table.concat(ids, ",")
					groupsByKey[key] = groupsByKey[key] or {} -- Store group in groupsByKey under its key
					table.insert(groupsByKey[key], g)
					groupKeys[g] = key -- Keep a reverse lookup: group -> key
				end
			end

			if group then -- Group higlighted, thus highlight its duplicates
				local key = groupKeys[group]
				for _, g in ipairs(groupsByKey[key] or {}) do
					if g ~= group then
						g.ls_fSelected = true -- Mark as selected in our custom flag
						count = count + 1
					end
				end
				group.ls_fSelected = true -- Ensure the highlighted one is also marked
			else -- None highlighted, thus highlight all duplicate groups
				for _, list in pairs(groupsByKey) do
					if #list > 1 then -- Only process groups that have duplicates
						for _, g in ipairs(list) do
							g.ls_fSelected = true
							count = count + 1
							if LS_Shapes.pointBasedSel3 and g.ls_fSelected then
								mesh:SelectGroup(g:Name()) -- Select involved points if Point-Based Selection is enabled
							end
						end
					end
				end
			end
		end
		if count < 1 then
			--mesh:DeselectPoints()
			--self.itemList:SetSelItem(self.itemList:GetItem(0), true, false)
			LM.Beep()
		else
			MOHO.Redraw()
			self:Update()
			self.itemList:Redraw()
		end
	elseif (msg == self.SELECTPTBASED or msg == self.SELECTPTBASED_ALT) then
		if LS_Shapes.mode == 2 then -- STYLE Mode
			if mesh ~= nil then
				local isUsed = false
				for i = 0, shapeCount - 1 do
					local shape = mesh:Shape(i)
					if shape ~= nil then
						shape.fSelected = false
						if styleSel == shape.fInheritedStyle or styleSel == shape.fInheritedStyle2 then
							isUsed = true
							shape.fSelected = true
						end
					end
				end
				if isUsed then
					self:Update()
					MOHO.Redraw()
				else
					self.selectPtBasedBut:Enable(false)
					self.selectPtBasedBut:SetValue(false)
					LM.Beep()
				end
				helper:delete()
				return
			end
		end
		if (msg == self.SELECTPTBASED) then -- If applicable, make pointBasedSel "active" during self:Update() below...
			if LS_Shapes.mode < 2 then -- SHAPE Modes
				LS_Shapes.pointBasedSel = true
			elseif LS_Shapes.mode == 3 then -- GROUP MOde
				LS_Shapes.pointBasedSel3 = true
			end
		else
			if (self.selectPtBasedBut:Value() == true) then -- If button was checked...
				if LS_Shapes.mode < 2 then
					LS_Shapes.pointBasedSel = false
				elseif LS_Shapes.mode == 3 then
					LS_Shapes.pointBasedSel3 = false
				end
			else
				if LS_Shapes.mode < 2 then
					LS_Shapes.pointBasedSel = true
				elseif LS_Shapes.mode == 3 then
					LS_Shapes.pointBasedSel3 = true
				end
			end
		end

		self:Update()

		if (msg == self.SELECTPTBASED) then
			if LS_Shapes.mode < 2 then
				LS_Shapes.pointBasedSel = false
			elseif LS_Shapes.mode == 3 then
				LS_Shapes.pointBasedSel3 = false
			end
			self.selectPtBasedBut:SetValue(false)

			if LS_Shapes.mode < 2 then
				if (pointsSel < 2 or (moho:CountSelectedShapes(false) < 1)) and (self.selectPtBasedBut:Value() == false) then
					LM.Beep()
					helper:delete()
					return
				end
			elseif LS_Shapes.mode == 3 then
				if (pointsSel < 1 or (LS_Shapes:CountSelectedGroups(mesh) < 1)) and (self.selectPtBasedBut:Value() == false) then
					LM.Beep()
					helper:delete()
					return
				end
			end
		else
			if LS_Shapes.mode < 2 then -- If button was checked, uncheck, and vice versa (mode-dependent)
				LS_Shapes.pointBasedSel = not self.selectPtBasedBut:Value()
			elseif LS_Shapes.mode == 3 then
				LS_Shapes.pointBasedSel3 = not self.selectPtBasedBut:Value()
			end
			self:Update()
		end
		if (doc ~= nil and pointsSel > 1) then
			MOHO.Redraw()
		end
	elseif (msg == self.CHECKERSEL) then
		MOHO.MohoGlobals.SelectedShapeCheckerboard = not (MOHO.MohoGlobals.SelectedShapeCheckerboard)
		if (doc == nil) then
			self:Update()
		else
			MOHO.Redraw()
			moho:UpdateUI() --20250720-0250: It randomly chrashes Moho if no open document, thus enclosed here despite Style window sync won't be perfect...
		end
		--moho:UpdateUI()
	elseif (msg == self.MERGE) then
		LM_SelectShape:MergeShapes(moho, moho.view)
		MOHO.Redraw()
		self:Update()
	elseif (msg == self.DELETE) or (msg == self.DELETE_ALT) then --MARK: EDIT
		if (doc ~= nil) then
			local redraw
			local i = 0
			if LS_Shapes.mode < 2 then -- SHAPE Modes
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
			elseif LS_Shapes.mode == 2 then --STYLE Mode
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
			else -- GROUP Mode
				if (mesh and group) then
					while i < mesh:CountGroups() do
						local group = mesh:Group(i)
						if (group.ls_fSelected) then
							mesh:DeleteGroup(group:Name())
							redraw = redraw == nil and true or redraw
						else
							i = i + 1
						end
					end
				end
			end
			if redraw == true then
				--moho.view:DrawMe()
				MOHO.Redraw()
			end
			moho:UpdateUI() -- Contrary to self:Update(), it correctly updates infobar e.g. upon deleting shapes while Select Shape tool is active, but does it worth? 🤔
			--self:Update() -- 20231222-1430: Moved bellow UpdateUI(), otherwise it made the dialog switch to STYLE mode after shape deletion for no (known) reason... It may not be necessary anyway?
		else
			self:Update()
		end
	elseif (msg == self.COPY or msg == self.PASTE) then
		if shape ~= nil then
			if msg == self.COPY then
				self.copiedShape = moho:NewShapeProperties()
				self.copiedStyle = self.copiedShape.fMyStyle
			else -- PASTE
				if mesh ~= nil and self.copiedStyle then
					for i = 0, shapeCount - 1 do
						local shape = mesh:Shape(i)
						if (shape.fSelected) then
							shape:CopyStyleProperties(self.copiedShape) -- NOTE: Stop using `shape.fMyStyle = self.copiedStyle` due to occasional crashes (besides, the new way could allow skipping fill/line)
						end
					end
				else
					LM.Beep()
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
					else
						LM.Beep()
					end
				end
				MOHO.Redraw()
			end
		end
		self:Update()
		moho:UpdateUI()
	elseif (msg == self.COPY_ALT or msg == self.PASTE_ALT) then
		if (msg == self.COPY_ALT) then
			self.copiedColor = LM.ColorOps:Ls_ConvertColor(multiRgb, MOHO.LS_CT_HEX)
			self.copiedColor = self.copiedColor and not MOHO.hasbit(LS_Shapes.multiFlags, MOHO.bit(4)) and self.copiedColor:gsub("^#", ""):sub(1, 6) or self.copiedColor -- "rrggbb/rrggbbaa"

			if LM.ColorOps:Ls_ColorType(self.copiedColor, MOHO.LS_CT_HEX) then
				moho:CopyText(self.copiedColor)
				self:Update()
			else
				LM.Beep()
			end
		else -- PASTE_ALT
			local sourceCol = LM.ColorOps:Ls_ConvertColor(moho:ClipboardText():gsub("^#", ""):sub(1, 8), MOHO.LS_CT_RGB)
			if sourceCol then
				sourceCol = LM.ColorOps:Ls_CrushColor(sourceCol, self.fillCol:Value(), MOHO.hasbit(LS_Shapes.multiFlags, MOHO.bit(4)))
				self.editingColor = true
				if LS_Shapes.multiMode == 0 then -- Fill Mode
					self.fillCol:SetValue(sourceCol)
					self:HandleMessage(self.FILLCOLOR)
				elseif LS_Shapes.multiMode == 1 then -- Stroke Mode
					self.lineCol:SetValue(sourceCol)
					self:HandleMessage(self.LINECOLOR)
				end
				self.editingColor = false

				if (doc ~= nil) then
					moho:UpdateUI()
					MOHO.Redraw()
				end
			else
				LM.Beep()
			end
		end
	elseif (msg == self.RESET or msg == self.RESET_ALT) then
		local mohoLineWidth = LS_Shapes.MohoLineWidth --0.005556 * 2
		if (style ~= nil) then
			style.fFillCol:SetValue(lDrawingFrame, MOHO.MohoGlobals.FillCol)
			style.fLineCol:SetValue(lDrawingFrame, MOHO.MohoGlobals.LineCol)
			style.fLineWidth = mohoLineWidth
			style.fLineCaps = 1
			if msg == self.RESET_ALT then
				style.fBrushName = LM.String:new_local("")
			end
			MOHO.Redraw()
		else -- Allow resetting even if no open document
			if LS_Shapes.advanced then
				self.fillCol:SetValue(MOHO.MohoGlobals.FillCol)
				self.lineCol:SetValue(MOHO.MohoGlobals.LineCol)
				self.lineWidth:SetValue(mohoLineWidth * docH)
				self.capsBut:SetValue(true)
				self.brushBut:SetValue(false)
				self._lastHue = nil
				helper:delete()
				return
			end
		end
		if (mesh ~= nil) then
			for i = 0, shapeCount - 1 do
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
		self._lastHue = nil
		self:Update()
		moho:UpdateUI()
	elseif (msg == self.COMBO_NORMAL) then --MARK: COMBO
		for i = 0, shapeCount - 1 do
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
	elseif (msg == self.COMBO_ADD) then
		for i = 0, shapeCount - 1 do
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
	elseif (msg == self.COMBO_SUBTRACT) then
		for i = 0, shapeCount - 1 do
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
	elseif (msg == self.COMBO_INTERSECT) then
		for i = 0, shapeCount - 1 do
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
	elseif (msg == self.COMBO_BLEND_BUT or msg == self.COMBO_BLEND_BUT_ALT) then
		for i = 0, shapeCount - 1 do
			local shape = mesh:Shape(i)
			if (shape.fSelected) then
				if (msg == self.COMBO_BLEND_BUT) then
					if not shape.fComboBlend:HasKey(lDrawingFrameAlt) then
						if frame ~= 0 then
							shape.fComboBlend:StoreValue()
						else
							shape.fComboBlend:SetValue(lDrawingFrameAlt, shape.fComboBlend:GetValue(lDrawingFrameAlt))
						end
						MOHO.NewKeyframe(CHANNEL_BLEND_SEL)
					else
						shape.fComboBlend:DeleteKey(lDrawingFrameAlt)
						layer:UpdateCurFrame(false)
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
		MOHO.Redraw()
		self:Update()
		moho:UpdateUI()
	elseif (msg == self.COMBO_BLEND) then
		local blend = self.combineBlend:FloatValue()
		blend = LM.Clamp(blend, 0.0, 1.0)
		for i = 0, shapeCount - 1 do
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
			if (LS_Shapes.pointBasedSel and not toolName:find("SelectShape")) then
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
			if (LS_Shapes.pointBasedSel and not toolName:find("SelectShape")) then
				clusterBaseShape:SelectAllPoints()
			end
		end
		MOHO.Redraw()
		moho:UpdateUI()
	elseif (msg == self.BASE_SHAPE_ALT or msg == self.TOP_SHAPE_ALT) then -- TODO: <alt> to move regular selected shape/s above/bellow to the upper/under cluster (or entire cluster if shape is upper/under selected instead)
		if (shape:IsInCluster()) then
			local clusterShape = shape:BottomOfCluster()
			while (clusterShape ~= nil) do
				clusterShape.fSelected = true
				if (LS_Shapes.pointBasedSel and not toolName:find("SelectShape")) then
					clusterShape:SelectAllPoints()
				end
				clusterShape = clusterShape:NextInCluster()
			end
		else
			LM.Beep()
		end
		MOHO.Redraw()
		self:Update()
	elseif (msg == self.FILL) then --MARK: FILL MOD.
		---[=[LM_SelectShape:HandleMessage(moho, moho.view, LM_SelectShape.FILL)
		if (mesh ~= nil and shape ~= nil) then
			if (shape.fFillAllowed) then
				shape.fHasFill = self.fillCheck:Value()
			end
			if (shape:IsInCluster() and shape.fComboMode ~= MOHO.COMBO_INTERSECT) then
				shape:BottomOfCluster().fHasFill = self.fillCheck:Value()
			end

			for i = 0, shapeCount - 1 do
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
			for i = 0, shapeCount - 1 do
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
			for i = 0, shapeCount - 1 do
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
		self.coloredTable = {}
		if (style ~= nil) then
			local col = LM.rgb_color:new_local()
			col.r = style.fFillCol.value.r
			col.g = style.fFillCol.value.g
			col.b = style.fFillCol.value.b
			col.a = style.fFillCol.value.a
			table.insert(self.coloredTable, {col, style.fFillCol:HasKey(lDrawingFrame)})
		end
		if (mesh ~= nil) then
			for i = 0, shapeCount - 1 do
				local shape = mesh:Shape(i)
				if (shape.fSelected) then
					local col = LM.rgb_color:new_local()
					col.r = shape.fMyStyle.fFillCol.value.r
					col.g = shape.fMyStyle.fFillCol.value.g
					col.b = shape.fMyStyle.fFillCol.value.b
					col.a = shape.fMyStyle.fFillCol.value.a
					table.insert(self.coloredTable, {col, shape.fMyStyle.fFillCol:HasKey(lDrawingFrame)})
				end
			end
		end
		self:HandleMessage(self.FILLCOLOR)
	elseif (msg == self.FILLCOLOR_END) then
		self.editingColor = false
		if (style ~= nil) then
			local tableID = 1
			style.fFillCol:SetValue(lDrawingFrame, self.coloredTable[tableID][1])
			if (not self.coloredTable[tableID][2]) then
				style.fFillCol:DeleteKey(lDrawingFrame)
			end
			--tableID = tableID + 1
		end
		if (mesh ~= nil) then
			local tableID = 1
			for i = 0, shapeCount - 1 do
				local shape = mesh:Shape(i)
				if (shape.fSelected) then
					shape.fMyStyle.fFillCol:SetValue(lDrawingFrame, self.coloredTable[tableID][1])
					if (not self.coloredTable[tableID][2]) then
						shape.fMyStyle.fFillCol:DeleteKey(lDrawingFrame)
					end
					tableID = tableID + 1
				end
			end
		end
		LS_Shapes.multiMode = 0
		if LS_Shapes.advanced then -- Is all this really necessary?
			self.multi1:SetValue(self.fillCol:Value().r)
			self.multi2:SetValue(self.fillCol:Value().g / (LS_Shapes.useHsv and 255 or 1))
			self.multi3:SetValue(self.fillCol:Value().b / (LS_Shapes.useHsv and 255 or 1))
			self.multi4:SetValue(self.fillCol:Value().a / 255) --(1 - self.fillCol:Value().a / 255) * 100
			self._lastHue = nil
		end
		self.coloredTable = {}
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
	elseif (msg == self.LINE) then --MARK: LINE MOD.
		if (mesh ~= nil and shape ~= nil) then
			shape.fHasOutline = self.lineCheck:Value()
			if (shape:IsInCluster() and shape.fComboMode ~= MOHO.COMBO_INTERSECT) then
				shape:BottomOfCluster().fHasOutline = self.lineCheck:Value()
			end
			for i = 0, shapeCount - 1 do
				local shape = mesh:Shape(i)
				if (shape.fSelected) then
					shape.fHasOutline = self.lineCheck:Value()
				end
			end
			MOHO.Redraw()
			moho:UpdateUI()
		end
	elseif (msg == self.LINE_ALT) then
		local shapeLineCol = LM.ColorVector:new_local()
		for i = 0, shapeCount - 1 do
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
			for i = 0, shapeCount - 1 do
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
		self.coloredTable = {}
		if (style ~= nil) then
			local col = LM.rgb_color:new_local()
			col.r = style.fLineCol.value.r
			col.g = style.fLineCol.value.g
			col.b = style.fLineCol.value.b
			col.a = style.fLineCol.value.a
			table.insert(self.coloredTable, {col, style.fLineCol:HasKey(lDrawingFrame)})
		end
		if (mesh ~= nil) then
			for i = 0, shapeCount - 1 do
				local shape = mesh:Shape(i)
				if (shape.fSelected) then
					local col = LM.rgb_color:new_local()
					col.r = shape.fMyStyle.fLineCol.value.r
					col.g = shape.fMyStyle.fLineCol.value.g
					col.b = shape.fMyStyle.fLineCol.value.b
					col.a = shape.fMyStyle.fLineCol.value.a
					table.insert(self.coloredTable, {col, shape.fMyStyle.fLineCol:HasKey(lDrawingFrame)})
				end
			end
		end
		self:HandleMessage(self.LINECOLOR)
	elseif (msg == self.LINECOLOR_END) then
		self.editingColor = false
		if (style ~= nil) then
			local tableID = 1
			style.fLineCol:SetValue(lDrawingFrame, self.coloredTable[tableID][1])
			if (not self.coloredTable[tableID][2]) then
				style.fLineCol:DeleteKey(lDrawingFrame)
			end
			--tableID = tableID + 1
		end
		if (mesh ~= nil) then
			local tableID = 1
			for i = 0, shapeCount - 1 do
				local shape = mesh:Shape(i)
				if (shape.fSelected) then
					shape.fMyStyle.fLineCol:SetValue(lDrawingFrame, self.coloredTable[tableID][1])
					if (not self.coloredTable[tableID][2]) then
						shape.fMyStyle.fLineCol:DeleteKey(lDrawingFrame)
					end
					tableID = tableID + 1
				end
			end
		end
		LS_Shapes.multiMode = 1
		if LS_Shapes.advanced then -- Is all this really necessary?
			self.multi1:SetValue(self.lineCol:Value().r)
			self.multi2:SetValue(self.lineCol:Value().g)
			self.multi3:SetValue(self.lineCol:Value().b)
			self.multi4:SetValue(self.fillCol:Value().a / 255 * 100)
			self._lastHue = nil
		end
		self.coloredTable = {}
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
			for i = 0, shapeCount - 1 do
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
			for i = 0, shapeCount - 1 do
				local iShape = mesh:Shape(i)
				if (iShape.fSelected) then
					iShape.fMyStyle.fLineCaps = self.capsBut:Value() and 1 or 0
				end
			end
			MOHO.Redraw()
		end
		if (doc == nil) then
			self:Update()
		else
			MOHO.Redraw()
			moho:UpdateUI() --20250720-0250: It randomly chrashes Moho if no open document, thus enclosed here despite Style window sync won't be perfect...
		end
		--moho:UpdateUI()
	elseif (msg == self.BRUSH) then
		if (doc ~= nil) then
			if (style ~= nil) then
				style.fBrushName:Set("")
			end
			if (mesh ~= nil) then
				for i = 0, shapeCount - 1 do
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
		self._lastHue = nil
		if (doc ~= nil) then
			moho:UpdateUI()
		end
	elseif (msg == self.STYLESWAP) then
		local style1, style2
		if (shape ~= nil) then
			for i = 0, shapeCount - 1 do
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
	elseif (msg >= self.FILLED and msg <= self.FILLEDOUTLINED_ALT) then --MARK: CREATE
		local m = msg - self.FILLED
		local creationMode = LM_CreateShape.creationMode
		if (mesh ~= nil and LS_Shapes.mode < 2) then -- Shape Creation
			-- 1st step for allowing stacked shapes (kudos to synthsin for pioneering its reintroduction in his "lm_create_shape" mod)
			local v, c, stackCount = mesh:SelectedCenter(), mesh:CountShapes(), 0
			for i = 0, mesh:CountShapes() - 1 do
				local shape = mesh:Shape(i)
				if shape:AllPointsSelected() == true then
					stackCount = stackCount + 1
				end
			end
			if stackCount > 0 then
				--[[Start manual patching
				self.origPrepUndo = doc.PrepUndo
				self.origSetDirty = doc.SetDirty
				doc:PrepUndo(lDrawing)
				doc:SetDirty()
				moho.document.PrepUndo = function() end
				moho.document.SetDirty = function() end
				--]]
				LS_Shapes:PatchUndo(doc, lDrawing)
				mesh:AddLonePoint(v, 0)
				mesh:AppendPoint(v * 1.0001, 0)

				local penul, last = mesh:Point(mesh:CountPoints() - 2), mesh:Point(mesh:CountPoints() - 1)
				--penul.fHidden, last.fHidden = true, true -- I kinda like can se the points as visual indication...
				penul.fSelected, last.fSelected = true, true
				penul.fWidth:SetValue(0, 0); last.fWidth:SetValue(0, 0)
			end

			LM_CreateShape.creationMode = math.floor(m / 2)
			LM_CreateShape:HandleMessage(moho, moho.view, m % 2 == 0 and LM_CreateShape.CREATE or LM_CreateShape.CREATE_CONNECTED)
			LM_CreateShape.creationMode = creationMode

			-- 2nd step for allowing stacked shapes
			if stackCount > 0 then
				--[[End manual patching (restoration)
				doc.PrepUndo = origPrepUndo
				doc.SetDirty = origSetDirty
				--]]
				LS_Shapes:PatchUndo(doc)
				mesh:DeletePoint(mesh:CountPoints() - 1)
			end
			MOHO.Redraw()

			if c == mesh:CountShapes() then
				self.info[1], self.info.upd, self.info.cop = MOHO.Localize("/LS/Shapes/NoShapeWasCreated=No shape was created..."), false, false
				self.infobar:SetValue(table.concat(self.info, self.info.sep or " · "):gsub("^" .. self.info.sep .. " *", ""))
				self.infoBut:SetValue(true)
			else
				if stackCount > 0 then
					self.info[1], self.info.upd, self.info.cop, self.info.pip = string.format(MOHO.Localize("/LS/Shapes/StackedShapeCreated=Stacked shape created! (%d)"), stackCount), false, false, true
					self.infobar:SetValue(table.concat(self.info, self.info.sep or " · "):gsub("^" .. self.info.sep .. " *", ""))
					self.infoBut:SetValue(true)
				end --string.format(MOHO.Localize("/LS/Shapes/HelpTitle=Quick Guide (up to: %s)"), "v0.4.0")
			end
		elseif (doc ~= nil and LS_Shapes.mode == 2) then -- Style Creation
			if m % 2 < 2 then -- 0: No Alt
				local baseStyle = style --or self.tempShape.fMyStyle
				local newStyle = doc:AddStyle(MOHO.Localize("/Windows/Style/Style=Style") .. " " .. math.floor(doc:CountStyles() + 1))
				if (newStyle ~= nil) then
					--LS_Shapes:MakeStyleNameUnique(doc, doc:CountStyles() - 1) --newStyle.fName:Set(newStyleName)
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
						LS_Shapes.mode = LS_Shapes:StyleLeaver(moho, mesh, 2)
					end
					LS_Shapes:StyleSelector(doc, doc:CountStyles() - 1)
					self:Update()
				end
			else -- 1: Alt
				--[[ 20250921-1700: I pretended to add style duplication by holding <alt> but it seems buggy, so U-turning...
				if styleSel then
					doc:AddStyle(styleSel)
					local lastStyle = doc:CountStyles() - 1
					local styleName = doc:StyleByID(lastStyle).fName:Buffer()
					local style = doc:StyleByID(lastStyle)
					style.fName:Set(styleName .. " " .. math.floor(doc:CountStyles() + 1))
				end
				--]]
			end
		elseif (mesh ~= nil and LS_Shapes.mode == 3) then -- Group Creation/Update
			local ID = groupCount
			if (msg == self.FILLED or msg == self.FILLED_ALT) then
				if pointsSel > 0 then -- Create
					mesh:AddGroup("G" .. ID + 1)
					LS_Shapes:DeselectGroups(mesh, ID)
					self.itemList:ScrollItemIntoView(ID, false)

					if pointsSel == 1 then
						if (LS_Shapes.showInfobar and self.infobar) then
							self.info[1], self.info.upd, self.info.cop = MOHO.Localize("/LS/Shapes/LonePointGroupCreated=Lone-point group created"), false, false
							self.infobar:SetValue(table.concat(self.info, self.info.sep or " · "):gsub("^" .. self.info.sep .. " *", ""))
							self.infoBut:SetValue(true)
						end
					end
				else -- Can't create
					if (LS_Shapes.showInfobar and self.infobar) then
						self.info[1], self.info.cop = MOHO.Localize("/LS/Shapes/SelectSomePoints=Select some points first..."), false
						self.infobar:SetValue(table.concat(self.info, self.info.sep or " · "):gsub("^" .. self.info.sep .. " *", ""))
						self.infoBut:SetValue(true)
					end
					LM.Beep()
					helper:delete()
					return
				end
			elseif (msg == self.OUTLINED or msg == self.OUTLINED_ALT) then -- Update
				if (self.groupUI ~= nil and groupSelCount == 1) then
					ID = itemSel
					mesh:AddGroup(self.groupUI:Name())

				else
					LM.Beep()
				end
			end
			LS_Shapes:DeselectGroups(mesh, ID)
			self:Update()
		end
		moho:UpdateUI()
	elseif (msg == self.HSV) then
		LS_Shapes.useHsv = not LS_Shapes.useHsv
		local factor = LS_Shapes.useHsv and 1/100 or 100
		if LS_Shapes.multiMode == 3 then -- Compensate last memorized percentage values upon switching between RGB & HSV in Recolor mode
			LS_Shapes.multiValues[LS_Shapes.multiMode][1] = not LS_Shapes.useHsv and LM.Clamp(LS_Shapes.multiValues[LS_Shapes.multiMode][1], -255, 255) or LS_Shapes.multiValues[LS_Shapes.multiMode][1]
			LS_Shapes.multiValues[LS_Shapes.multiMode][2] = LS_Shapes.multiValues[LS_Shapes.multiMode][2] * factor 
			LS_Shapes.multiValues[LS_Shapes.multiMode][3] = LS_Shapes.multiValues[LS_Shapes.multiMode][3] * factor 
		end
		self:Update()
	elseif (msg >= self.MULTI1 and msg < self.APPLY) then --MARK: M. CTRLS
		local dragBut = LS_Shapes:GetDraggingButton(self.multi1, self.multi2, self.multi3, self.multi4)

		if LS_Shapes.multiMode < 2 then -- Fill/Stroke
			LS_Shapes.multiMenuRules = dragBut == 0 -- Use this if you want to prevent on L/R click mode change
			if LS_Shapes.multiMenuRules == false then
				LS_Shapes.multiMode = dragBut - 1
			end

			local col = LM.rgb_color:new_local()
			local toFill = (LS_Shapes.multiMode == 0) -- Current behavior

			if self.multiMode ~= LS_Shapes.multiMode then -- If mode change detected...
				local currentCol
				if LS_Shapes.multiMode == 0 then
					currentCol = self.fillCol:Value() -- Current fill color
				else
					currentCol = self.lineCol:Value() -- Current stroke color
				end
				if LS_Shapes.useHsv then
					local hsv = LM.ColorOps:Rgb2Hsv(currentCol)
					self.multi1:SetValue(hsv.h)
					self.multi2:SetValue(hsv.s / 255)
					self.multi3:SetValue(hsv.v / 255)
					self.multi4:SetValue(hsv.a / 255)
				else
					self.multi1:SetValue(currentCol.r)
					self.multi2:SetValue(currentCol.g)
					self.multi3:SetValue(currentCol.b)
					self.multi4:SetValue(currentCol.a / 255)
				end
			end

			if LS_Shapes.useHsv then
				local h = LM.Clamp(self.multi1:IntValue(), -360, 360) -- Read UI values
				local sPct = LM.Clamp(self.multi2:FloatValue(), 0, 1)
				local vPct = LM.Clamp(self.multi3:FloatValue(), 0, 1)
				local aPct = LM.Clamp(self.multi4:FloatValue(), 0, 1)
				LS_Shapes.multiValues[LS_Shapes.multiMode] = {h, sPct, vPct, aPct}

				self._lastHue, self._lastSat = h, sPct -- Update memories

				local h255 = h * 255 / 360
				local s255 = sPct * 255 -- Convert to scale 0–255 for hsv_color
				local v255 = vPct * 255
				local a255 = aPct * 255

				local hsv = LM.ColorOps:HsvColor(h255, s255, v255, a255) --print("HSV: " .. hsv.h) --Build HSV & convert to RGB
				col = LM.ColorOps:Hsv2Rgb(hsv) --print("RGB: " .. col.r)
			else -- RGB (normal)
				col.r = LM.Clamp(self.multi1:IntValue(), 0, 255)
				col.g = LM.Clamp(self.multi2:IntValue(), 0, 255)
				col.b = LM.Clamp(self.multi3:IntValue(), 0, 255)
				col.a = LM.Clamp(self.multi4:FloatValue() * 255, 0, 255)
				LS_Shapes.multiValues[LS_Shapes.multiMode] = {col.r, col.g, col.b, col.a}
			end

			if toFill then
				self.fillCol:SetValue(col)
				self:HandleMessage(self.FILLCOLOR)
			else
				self.lineCol:SetValue(col)
				self:HandleMessage(self.LINECOLOR)
			end
		elseif LS_Shapes.multiMode == 2 then -- FX Transform
			if (mesh ~= nil and shape ~= nil) then
				local offset = LM.Vector2:new_local() offset:Set(self.multi1:FloatValue(), self.multi2:FloatValue()) 
				local rotation, scale = self.multi3:FloatValue(), self.multi4:FloatValue()
				for i = 0, shapeCount - 1 do
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
		elseif LS_Shapes.multiMode == 3 then -- Recolor
			newVal[1], newVal[4] = self.multi1:IntValue(), self.multi4:FloatValue()
			if LS_Shapes.useHsv then -- Use HSV
				newVal[2], newVal[3] = self.multi2:FloatValue(), self.multi3:FloatValue()
				if (newVal[1] < -360 or newVal[1] > 360) then -- Hue
					newVal[1] = LM.Clamp(newVal[1], -360, 360)
					self.multi1:SetValue(newVal[1])
				elseif (newVal[2] < -1 or newVal[2] > 1) then -- Sat
					newVal[2] = LM.Clamp(newVal[2], -1, 1)
					self.multi2:SetValue(newVal[2])
				elseif (newVal[3] < -1 or newVal[3] > 1) then -- Bri
					newVal[3] = LM.Clamp(newVal[3], -1, 1)
					self.multi3:SetValue(newVal[3])
				elseif (newVal[4] < 0 or newVal[4] > 1) then -- Alp
					newVal[4] = LM.Clamp(newVal[4], 0, 1)
					self.multi4:SetValue(newVal[4])
				end
			else -- Use RGB
				newVal[2], newVal[3] = self.multi2:IntValue(), self.multi3:IntValue()
				if (newVal[1] < -255 or newVal[1] > 255) then -- R
					newVal[1] = LM.Clamp(newVal[1], -255, 255)
					self.multi1:SetValue(newVal[1])
				elseif (newVal[2] < -255 or newVal[2] > 255) then -- G
					newVal[2] = LM.Clamp(newVal[2], -255, 255)
					self.multi2:SetValue(newVal[2])
				elseif (newVal[3] < -255 or newVal[3] > 255) then -- B
					newVal[3] = LM.Clamp(newVal[3], -255, 255)
					self.multi3:SetValue(newVal[3])
				elseif (newVal[4] < 0 or newVal[4] > 1) then -- A
					newVal[4] = LM.Clamp(newVal[4], 0, 1)
					self.multi4:SetValue(newVal[4])
				end
			end
			LS_Shapes.multiValues[LS_Shapes.multiMode][1] = self.multi1:IntValue()
			LS_Shapes.multiValues[LS_Shapes.multiMode][2] = LS_Shapes.useHsv and self.multi2:FloatValue() or self.multi2:IntValue()
			LS_Shapes.multiValues[LS_Shapes.multiMode][3] = LS_Shapes.useHsv and self.multi3:FloatValue() or self.multi3:IntValue()
			LS_Shapes.multiValues[LS_Shapes.multiMode][4] = self.multi4:FloatValue() -- All modes use a last percentage field ATM
			moho:UpdateUI() -- 20240207-1945: This seems to make that confirm with enter key also work here?
		end
	elseif (msg == self.APPLY or msg == self.APPLY_ALT) then
		if LS_Shapes.multiMode == 3 then -- Recolor
			local randomize = msg == self.APPLY_ALT
			local colTable = {}
			colTable[1] = LS_Shapes.multiValues[LS_Shapes.multiMode][1]
			colTable[2] = LS_Shapes.multiValues[LS_Shapes.multiMode][2] * (LS_Shapes.useHsv and 100 or 1)
			colTable[3] = LS_Shapes.multiValues[LS_Shapes.multiMode][3] * (LS_Shapes.useHsv and 100 or 1)
			colTable[4] = LS_Shapes.multiValues[LS_Shapes.multiMode][4] * 255

			for i = 0, layersSel - 1 do
				local iLayer = doc:GetSelectedLayer(i)
				local iLayerDrawing = iLayer:LayerType() == MOHO.LT_SWITCH and moho.drawingLayer or iLayer
				if (iLayerDrawing:LayerType() == MOHO.LT_VECTOR) then
					local mesh = moho:LayerAsVector(iLayerDrawing):Mesh()
					if mesh ~= nil then
						for j = mesh:CountShapes() -1, 0, -1 do
							local jShape = mesh:Shape(j)
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
								if LS_Shapes.multiValues[LS_Shapes.multiMode][1] ~= 0 then
									if LS_Shapes.multiValues[LS_Shapes.multiMode][1] > 0 then
										colTable[1] = math.random(0, math.floor(LS_Shapes.multiValues[LS_Shapes.multiMode][1]))
									else
										colTable[1] = math.random(math.floor(LS_Shapes.multiValues[LS_Shapes.multiMode][1]), 0)
									end
								end
								if LS_Shapes.multiValues[LS_Shapes.multiMode][2] ~= 0 then
									if LS_Shapes.multiValues[LS_Shapes.multiMode][2] > 0 then
										colTable[2] = math.random(0, math.floor(LS_Shapes.multiValues[LS_Shapes.multiMode][2]))
									else
										colTable[2] = math.random(math.floor(LS_Shapes.multiValues[LS_Shapes.multiMode][2]), 0)
									end
								end
								if LS_Shapes.multiValues[LS_Shapes.multiMode][3] ~= 0 then
									if LS_Shapes.multiValues[LS_Shapes.multiMode][3] > 0 then
										colTable[3] = math.random(0, math.floor(LS_Shapes.multiValues[LS_Shapes.multiMode][3]))
									else
										colTable[3] = math.random(math.floor(LS_Shapes.multiValues[LS_Shapes.multiMode][3]), 0)
									end
								end --print ("Random is: ", colTable[1], ", ", colTable[2], ", ", colTable[3])
							end

							local fillColor = jShape.fMyStyle.fFillCol:GetValue(lDrawingFrame):AsColorStruct()
							local lineColor = jShape.fMyStyle.fLineCol:GetValue(lDrawingFrame):AsColorStruct()
							local holdFillColor, holdLineColor = fillColor, lineColor --print ("Starting color is: ", ", ", holdFillColor.r, ", ", holdFillColor.g, ", ", holdFillColor.b)
							fillColor = LS_Shapes.useHsv and LS_Shapes:alterHSB(holdFillColor, colTable) or LS_Shapes:alterRGB(holdFillColor, colTable)
							lineColor = LS_Shapes.useHsv and LS_Shapes:alterHSB(holdLineColor, colTable) or LS_Shapes:alterRGB(holdLineColor, colTable)
							--Recoloring in only one step is not possible due to UI space limitations (but at least values are remembered between modes)
							--holdFillColor = fillColor
							--fillColor = LS_Shapes:alterHSB(holdFillColor, colTable)
							if (jShape.fSelected) then -- Affect only current layer's selected shapes
								if MOHO.hasbit(LS_Shapes.multiFlags, MOHO.bit(1)) then --print ("Ending fillColor is: ", fillColor.r, ", ", fillColor.g, ", ", fillColor.b)
									jShape.fMyStyle.fFillCol:SetValue(lDrawingFrame, LM.ColorOps:Ls_CrushColor(fillColor, jShape.fMyStyle.fFillCol.value, MOHO.hasbit(LS_Shapes.multiFlags, MOHO.bit(4))))
									jShape.fMyStyle.fFillCol:StoreValue()
								end
								if MOHO.hasbit(LS_Shapes.multiFlags, MOHO.bit(2)) then
									jShape.fMyStyle.fLineCol:SetValue(lDrawingFrame, LM.ColorOps:Ls_CrushColor(lineColor, jShape.fMyStyle.fLineCol.value, MOHO.hasbit(LS_Shapes.multiFlags, MOHO.bit(4))))
									jShape.fMyStyle.fLineCol:StoreValue()
								end
							elseif (not shape or layersSel > 1) then -- Affect all shapes along all selected layers
								if MOHO.hasbit(LS_Shapes.multiFlags, MOHO.bit(1)) then --print ("Ending fillColor is: ", fillColor.r, ", ", fillColor.g, ", ", fillColor.b)
									jShape.fMyStyle.fFillCol:SetValue(lDrawingFrame, LM.ColorOps:Ls_CrushColor(fillColor, jShape.fMyStyle.fFillCol.value, MOHO.hasbit(LS_Shapes.multiFlags, MOHO.bit(4))))
									jShape.fMyStyle.fFillCol:StoreValue()
								end
								if MOHO.hasbit(LS_Shapes.multiFlags, MOHO.bit(2)) then
									jShape.fMyStyle.fLineCol:SetValue(lDrawingFrame, LM.ColorOps:Ls_CrushColor(lineColor, jShape.fMyStyle.fLineCol.value, MOHO.hasbit(LS_Shapes.multiFlags, MOHO.bit(4))))
									jShape.fMyStyle.fLineCol:StoreValue()
								end
							end
						end
					end
				end
			end
			MOHO.Redraw()
			moho:UpdateUI()
		end
	elseif (msg == self.SWATCHSLIDER) then --print(self.swatchSlider:Value())
		local layer, mesh
		if LS_Shapes.swatch ~= -1 and LS_Shapes.swatchDoc ~= nil then
			if LS_Shapes.doc:Layer(LS_Shapes.swatchLayer) ~= nil then
				layer = moho:LayerAsVector(LS_Shapes.doc:Layer(LS_Shapes.swatchLayer)) --moho:LayerAsVector(moho.layer) print(moho.document:Name(), ", ", moho.layer:Name())
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
								local ch = layer:Channel(i, 0, LS_Shapes.doc):ActionByName("SLIDER (DEFAULT)") --20231228-2015: Using LS_Shapes.doc instead moho.document to make it work without open doc/s (same applies bellow)
								if ch and ch:CountKeys() > 1 then
									ch:Reset(1)
									--print(MOHO.Localize("/Scripts/Menu/ListChannels/Channel=Channel ") .. i .. ": " .. chInfo.name:Buffer() .. MOHO.Localize("/Scripts/Menu/ListChannels/Keyframes= Keyframes: ") .. ch:CountKeys())
								end
							else
								--print(MOHO.Localize("/Scripts/Menu/ListChannels/Channel=Channel ") .. i .. ": " .. chInfo.name:Buffer())
								for subID = 0, chInfo.subChannelCount - 1 do
									local ch = layer:Channel(i, subID, LS_Shapes.doc):ActionByName("SLIDER (DEFAULT)")
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
					local percent = {math.abs((self.swatchSlider:Value() / 255)), 1}
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
		--[[20231123-0638: Working code (more or less) backup...
		local layer, mesh
		if LS_Shapes.swatch ~= -1 and LS_Shapes.swatchDoc ~= nil then
			if LS_Shapes.doc:Layer(LS_Shapes.swatchLayer) ~= nil then
				layer = moho:LayerAsVector(LS_Shapes.doc:Layer(LS_Shapes.swatchLayer))
				mesh = layer and layer:Mesh() or nil
				if layer:HasAction("SLIDER") and layer:ActionDuration("SLIDER") == 1 then
					local default = LM.String:new_local() default:Set("DEFAULT")
					local slider = LM.String:new_local() slider:Set("SLIDER")
					local slider2 = LM.String:new_local() slider2:Set("SLIDER")
					local percent = {math.abs((self.swatchSlider:Value() / 255)), 1}
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
	elseif (msg == self.INFO) then
		if self.infoText and self.infoText ~= "" then
			moho:CopyText(self.infoText)
		else
			LM.Beep()
		end
		self.infoBut:SetValue(false)
	elseif (msg >= self.MULTIMENU and msg < self.SELECTSTYLE1) then --MARK: M. MENU
		local multiMenuBak = LS_Shapes.multiMode

		if (msg >= self.MULTIMENU and msg <= self.MULTIMENU + 3) then -- Menu Modes
			if tool and tool.prevMousePt then
				--tool.prevMousePt:Set(0, 0)
			end
			LS_Shapes.multiMenuRules = true
			LS_Shapes.multiMode = msg - self.MULTIMENU
			LS_Shapes.multiMenuLast = msg - self.MULTIMENU < 2 and msg - self.MULTIMENU or 0
		elseif (msg >= self.MULTIMENU + 4 and msg <= self.MULTIMENU + 8) then -- Menu Actions
			if (msg == self.MULTIMENU + 4) then -- Copy Values
				LS_Shapes.multiValues.clipboard = {self.multi1:Value(), self.multi2:Value(), self.multi3:Value(), self.multi4:Value()}
			elseif (msg == self.MULTIMENU + 5) then -- Paste Values
				if (LS_Shapes.multiValues.clipboard ~= nil) then
					if LS_Shapes.multiMode == 2 then -- FX Transform
						if (mesh ~= nil and shape ~= nil) then
							for i = 0, shapeCount - 1 do
								local iShape = mesh:Shape(i)
								if (iShape.fSelected) then
									if (iShape:HasPositionDependentStyles()) then
										local offset = LM.Vector2:new_local() offset:Set(LS_Shapes.multiValues.clipboard[1], LS_Shapes.multiValues.clipboard[2])
										iShape.fEffectOffset:SetValue(lDrawingFrame, offset)
										iShape.fEffectRotation:SetValue(lDrawingFrame, LS_Shapes.multiValues.clipboard[3])
										iShape.fEffectScale:SetValue(lDrawingFrame, LS_Shapes.multiValues.clipboard[4] / 100)
									end
								end
							end
							MOHO.Redraw()
							moho:UpdateUI()
						end
					elseif LS_Shapes.multiMode == 3 then -- Recolor
						LS_Shapes.multiValues[LS_Shapes.multiMode] = LS_Shapes.multiValues.clipboard
					end
					MOHO.Redraw()
				else
					LM.Beep()
				end
			elseif (msg == self.MULTIMENU + 6) then -- Reset Values
					if LS_Shapes.multiMode == 2 then -- FX Transform
						if (mesh ~= nil and shape ~= nil) then
							for i = 0, shapeCount - 1 do
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
					elseif LS_Shapes.multiMode == 3 then -- Recolor
						LS_Shapes.multiValues[LS_Shapes.multiMode] = {0, 0, 0, 1}
					end
			elseif (msg == self.MULTIMENU + 7) then -- Invert Color
				local col = LM.rgb_color:new_local()
				if LS_Shapes.multiMode == 0 or LS_Shapes.multiMode == 1 then -- 20240207-1825: It should work individally, accordingly to selected shapes!
					col.r = LM.Clamp(self.multi1:IntValue(), 0, 255) self.multi1:SetValue(col.r)
					col.g = LM.Clamp(self.multi2:IntValue(), 0, 255) self.multi2:SetValue(col.g)
					col.b = LM.Clamp(self.multi3:IntValue(), 0, 255) self.multi3:SetValue(col.b)
					col = LM.ColorOps:InvertColor(col.r, col.g, col.b)
					col.a = LM.Clamp(self.multi4:FloatValue() * 255, 0, 255) self.multi4:SetValue(col.a / 255) --col.a = LM.Clamp(self.multi4:IntValue() / 100 * 255, 0, 255) self.multi4:SetValue(col.a / 255 * 100) --> Non-PercentageMode version

					if LS_Shapes.multiMode == 0 then
						self.fillCol:SetValue(col)
						self:HandleMessage(self.FILLCOLOR)
					else
						self.lineCol:SetValue(col)
						self:HandleMessage(self.LINECOLOR)
					end
				end
			elseif (msg == self.MULTIMENU + 8) then -- Multiply Color
				local fillCol, lineCol, fac, col = self.fillCol:Value(), self.lineCol:Value()
				if LS_Shapes.multiMode == 0 or LS_Shapes.multiMode == 1 then
					if LS_Shapes.multiMode == 0 then
						fac = self.fillCol:Value().a / 255
						col = LM.ColorOps:Ls_MultiplyColors(fillCol, lineCol, fac, MOHO.hasbit(LS_Shapes.multiFlags, MOHO.bit(4)))
						self.fillCol:SetValue(col)
						self:HandleMessage(self.FILLCOLOR)
					else
						fac = self.lineCol:Value().a / 255
						col = LM.ColorOps:Ls_MultiplyColors(fillCol, lineCol, fac, MOHO.hasbit(LS_Shapes.multiFlags, MOHO.bit(4)))
						self.lineCol:SetValue(col)
						self:HandleMessage(self.LINECOLOR)
					end
				end
			end
		else -- Menu Options
			if (msg == self.MULTIMENU + 9) then -- Affects Fills
				if MOHO.hasbit(LS_Shapes.multiFlags, MOHO.bit(1)) then
					LS_Shapes.multiFlags = MOHO.clearbit(LS_Shapes.multiFlags, MOHO.bit(1))
				else
					LS_Shapes.multiFlags = MOHO.setbit(LS_Shapes.multiFlags, MOHO.bit(1))
				end
			elseif (msg == self.MULTIMENU + 10) then -- Affects Strokes
				if MOHO.hasbit(LS_Shapes.multiFlags, MOHO.bit(2)) then
					LS_Shapes.multiFlags = MOHO.clearbit(LS_Shapes.multiFlags, MOHO.bit(2))
				else
					LS_Shapes.multiFlags = MOHO.setbit(LS_Shapes.multiFlags, MOHO.bit(2))
				end
			elseif (msg == self.MULTIMENU + 11) then -- Affects Alpha
				if MOHO.hasbit(LS_Shapes.multiFlags, MOHO.bit(4)) then
					LS_Shapes.multiFlags = MOHO.clearbit(LS_Shapes.multiFlags, MOHO.bit(4))
				else
					LS_Shapes.multiFlags = MOHO.setbit(LS_Shapes.multiFlags, MOHO.bit(4))
				end
			end
			if not MOHO.hasbit(LS_Shapes.multiFlags, MOHO.bit(1)) and not MOHO.hasbit(LS_Shapes.multiFlags, MOHO.bit(2)) then
				LS_Shapes.multiFlags = MOHO.setbit(LS_Shapes.multiFlags, MOHO.bit(msg == self.MULTIMENU + 8 and 2 or 1)) -- Not only ensures at least one if both is checked but also act as switch!
			end
			--print(LS_Shapes.multiFlags)
		end
		self._lastHue = nil
		self:Update()
	elseif (msg >= self.SELECTSTYLE1 and msg < self.SELECTSTYLE2) then --MARK: ITEM SEL.
		local style1Sel = (doc and doc:StyleByID(msg - self.SELECTSTYLE1 - 1)) and (doc and doc:StyleByID(msg - self.SELECTSTYLE1 - 1).fUUID) or LM.String:new_local("")
		if (shape ~= nil) then
			for i = 0, shapeCount - 1 do
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
			for i = 0, shapeCount - 1 do
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
		local itemIndex, itemName = msg - self.SELECTBRUSH, self.brushMenu:ItemLabel(msg)
		if (msg >= self.SELECTBRUSH and msg <= self.SELECTBRUSH + 1) then
			if (msg == self.SELECTBRUSH) then -- List Factory Brushes Only
				LS_Shapes.brushDirectory = MOHO.hasbit(LS_Shapes.brushDirectory, 1) and LS_Shapes.brushDirectory - 1 or LS_Shapes.brushDirectory + 1
			elseif (msg == self.SELECTBRUSH + 1) then -- List User Brushes Only
				LS_Shapes.brushDirectory = MOHO.hasbit(LS_Shapes.brushDirectory, 2) and LS_Shapes.brushDirectory - 2 or LS_Shapes.brushDirectory + 2
			end
			self.brushMenu:RemoveAllItems()
			LS_Shapes.brushList = LS_Shapes:BrushLoader(moho, LS_Shapes.brushDirectory)
			self:Update()
			helper:delete()
			return
		elseif (msg >= self.SELECTBRUSH + 2 and msg < self.SELECTBRUSH + LS_ShapesDialog:CountRealItems(self.brushMenu, self.SELECTBRUSH) - 1) then
			local brushName = LS_Shapes.brushList[itemName]:match("[^/\\]+$")
			if (style ~= nil) then
				style.fBrushName:Set(brushName)
			end
			if (mesh ~= nil) then
				local forceRedraw
				for i = 0, shapeCount - 1 do
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

	self.multiMode = LS_Shapes.multiMode
	helper:delete()
end

function LS_ShapesDialog:WhatMsg(msg, t) --(int, tbl) char
	t = t or self
	local what = "<NONE>"
	for k, v in pairs(t) do
		if v == msg then
			what = k
		end
	end
	return what
end

function LS_ShapesDialog:CountRealItems(w, msg) --(LM.GUI.Widget, int) int
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

LS_Shapes.h = {} --h stands "help"
LS_Shapes.h.DLOG_UPDATE = MOHO.MSG_BASE

function LS_Shapes.h:new() --MARK:-NEW(H)
	local d = LM.GUI.SimpleDialog(LS_Shapes:UILabel() .. "'s " .. MOHO.Localize("/LS/Shapes/HelpTitle=Quick Help"), LS_Shapes.h) --string.format(MOHO.Localize("/LS/Shapes/HelpTitle=Quick Guide (up to: %s)"), "v0.4.0")
	local l = d:GetLayout()
	local width = 1080
	d.w = {} -- widgets
	d.what = MOHO.MSG_BASE
	d.iSel = false

	l:AddPadding(-8)
	l:PushH(LM.GUI.ALIGN_TOP, 0)
		l:PushV(LM.GUI.ALIGN_FILL, 2)
			--[[
			d.i = LM.GUI.RadioButton(" ℹ ", self.DLOG_UPDATE)
			d.i:SetToolTip("Help according to: " .. "v0.4.0")
			d.i:SetCursor(LM.GUI.Cursor(LS_Shapes.resources .. "ls_cursor_help", 0, 0))
			d.i:SetValue(true)
			l:AddChild(d.i, LM.GUI.ALIGN_LEFT, 0) d.w[0] = d.i
			l:AddPadding(90)
			--]]
			l:AddPadding(113)
			d.i1_1  = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info",  "1.1", true, self.DLOG_UPDATE +  1, true) -- Unicode Char: Figure Space " " (U+2007)
			l:AddChild(d.i1_1, LM.GUI.ALIGN_CENTER, 12) d.w[ 1] = d.i1_1
			d.i1_2  = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info",  "1.2", true, self.DLOG_UPDATE +  2, true)
			l:AddChild(d.i1_2, LM.GUI.ALIGN_CENTER,  0) d.w[ 2] = d.i1_2

			l:AddPadding(0) l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, -2)

			d.i1_3  = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info",  "1.3", true, self.DLOG_UPDATE +  3, true)
			l:AddChild(d.i1_3, LM.GUI.ALIGN_CENTER,  0) d.w[ 3] = d.i1_3
			d.i1_4  = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info",  "1.4", true, self.DLOG_UPDATE +  4, true)
			l:AddChild(d.i1_4, LM.GUI.ALIGN_CENTER,  0) d.w[ 4] = d.i1_4
			d.i1_5  = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info",  "1.5", true, self.DLOG_UPDATE +  5, true)
			l:AddChild(d.i1_5, LM.GUI.ALIGN_CENTER,  0) d.w[ 5] = d.i1_5
			d.i1_6  = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info",  "1.6", true, self.DLOG_UPDATE +  6, true)
			l:AddChild(d.i1_6, LM.GUI.ALIGN_CENTER,  0) d.w[ 6] = d.i1_6

			l:AddPadding(0) l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, -2)

			d.i1_7  = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info",  "1.7", true, self.DLOG_UPDATE +  7, true)
			l:AddChild(d.i1_7, LM.GUI.ALIGN_CENTER,  0) d.w[ 7] = d.i1_7
			d.i1_8  = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info",  "1.8", true, self.DLOG_UPDATE +  8, true)
			l:AddChild(d.i1_8, LM.GUI.ALIGN_CENTER,  0) d.w[ 8] = d.i1_8
			d.i1_9  = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info",  "1.9", true, self.DLOG_UPDATE +  9, true)
			l:AddChild(d.i1_9, LM.GUI.ALIGN_CENTER,  0) d.w[ 9] = d.i1_9
			d.i1_10 = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info", "1.10", true, self.DLOG_UPDATE + 10, true)
			l:AddChild(d.i1_10, LM.GUI.ALIGN_CENTER, 0) d.w[10] = d.i1_10

			l:AddPadding(0) l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, -2)

			d.i1_11 = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info", "1.11", true, self.DLOG_UPDATE + 11, true)
			l:AddChild(d.i1_11, LM.GUI.ALIGN_CENTER, 0) d.w[11] = d.i1_11

			l:AddPadding(0) l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, -2)

			d.i1_12 = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info", "1.12", true, self.DLOG_UPDATE + 12, true)
			l:AddChild(d.i1_12, LM.GUI.ALIGN_CENTER, 0) d.w[12] = d.i1_12
			d.i1_13 = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info", "1.13", true, self.DLOG_UPDATE + 13, true)
			l:AddChild(d.i1_13, LM.GUI.ALIGN_CENTER, 0) d.w[13] = d.i1_13
			d.i1_14 = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info", "1.14", true, self.DLOG_UPDATE + 14, true)
			l:AddChild(d.i1_14, LM.GUI.ALIGN_CENTER, 0) d.w[14] = d.i1_14

			l:AddPadding(0) l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, -2)

			d.i1_15 = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info", "1.15", true, self.DLOG_UPDATE + 15, true)
			l:AddChild(d.i1_15, LM.GUI.ALIGN_CENTER, 0) d.w[15] = d.i1_15

			l:AddPadding(142)

			d.i2_1  = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info",  "2.1", true, self.DLOG_UPDATE + 16, true)
			l:AddChild(d.i2_1, LM.GUI.ALIGN_CENTER,  0) d.w[16] = d.i2_1
			d.i2_2  = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info",  "2.2", true, self.DLOG_UPDATE + 17, true)
			l:AddChild(d.i2_2, LM.GUI.ALIGN_CENTER,  0) d.w[17] = d.i2_2
			d.i2_3  = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info",  "2.3", true, self.DLOG_UPDATE + 18, true)
			l:AddChild(d.i2_3, LM.GUI.ALIGN_CENTER,  0) d.w[18] = d.i2_3
			d.i2_4  = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info",  "2.4", true, self.DLOG_UPDATE + 19, true)
			l:AddChild(d.i2_4, LM.GUI.ALIGN_CENTER,  0) d.w[19] = d.i2_4
			d.i2_5  = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info",  "2.5", true, self.DLOG_UPDATE + 20, true)
			l:AddChild(d.i2_5, LM.GUI.ALIGN_CENTER,  0) d.w[20] = d.i2_5

			l:AddPadding(0) l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, -2)

			l:AddPadding(LS_Shapes.Round(d.i1_1:Height() * 2 / 2))
			d.i2_6  = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info",  "2.6", true, self.DLOG_UPDATE + 21, true)
			l:AddChild(d.i2_6, LM.GUI.ALIGN_CENTER,  0) d.w[21] = d.i2_6
			l:AddPadding(LS_Shapes.Round(d.i1_1:Height() * 2 / 2))

			l:AddPadding(0) l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, -2)

			l:AddPadding(LS_Shapes.Round(d.i1_1:Height() * 2 / 2))
			d.i2_7  = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info",  "2.7", true, self.DLOG_UPDATE + 22, true)
			l:AddChild(d.i2_7, LM.GUI.ALIGN_CENTER,  0) d.w[22] = d.i2_7
			l:AddPadding(LS_Shapes.Round(d.i1_1:Height() * 2 / 2))

			l:AddPadding(0) l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, -2)

			l:AddPadding(d.i1_1:Height() * 3 / 2)
			d.i2_11 = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info",  "2.8", true, self.DLOG_UPDATE + 23, true) -- Unicode Char: Punctuation Space " " (U+2008)
			l:AddChild(d.i2_11, LM.GUI.ALIGN_CENTER, 0) d.w[23] = d.i2_11
			l:AddPadding(-1)
		l:Pop()

		l:AddPadding(4)
		d.helpImgBut = LM.GUI.ImageButton(LS_Shapes.resources .. "HELP", "", false, LM.GUI.MSG_CANCEL, false)
		d.helpImgBut:SetCursor(LM.GUI.Cursor(LS_Shapes.resources .. "ls_cursor_cancel", 0, 0))
		l:AddChild(d.helpImgBut, LM.GUI.ALIGN_CENTER, 0)
		l:AddPadding(4)

		l:PushV(LM.GUI.ALIGN_FILL, 2)
			l:AddPadding(530)
			d.i3_1  = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info",  "3.1", true, self.DLOG_UPDATE + 24, true)
			l:AddChild(d.i3_1, LM.GUI.ALIGN_CENTER, 12) d.w[24] = d.i3_1

			l:AddPadding(0) l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, -2)

			d.i3_2  = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info",  "3.2", true, self.DLOG_UPDATE + 25, true)
			l:AddChild(d.i3_2, LM.GUI.ALIGN_CENTER,  0) d.w[25] = d.i3_2
			l:AddPadding(178)

			d.i3_3  = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info",  "3.3", true, self.DLOG_UPDATE + 26, true)
			l:AddChild(d.i3_3, LM.GUI.ALIGN_CENTER,  0) d.w[26] = d.i3_3
			l:AddPadding(88)

			l:AddPadding(0) l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, -2)

			d.i3_4  = LM.GUI.ImageButton(LS_Shapes.resources .. "ls_info",  "3.4", true, self.DLOG_UPDATE + 27, true)
			l:AddChild(d.i3_4, LM.GUI.ALIGN_CENTER,  0) d.w[27] = d.i3_4
		l:Pop()
	l:Pop()

	l:AddPadding(-8)
	l:AddChild(LM.GUI.Divider(false), LM.GUI.ALIGN_FILL, 0)
	l:AddPadding(-14)

	width = (d.i1_1:Width() * 2) + d.helpImgBut:Width() + 4
	l:PushH(LM.GUI.ALIGN_FILL)
		d.t1i = LM.GUI.DynamicText("ℹ ", 0)
		d.t1i:SetToolTip("Help according to: " .. "v0.4.0")
		d.t1i:SetCursor(LM.GUI.Cursor(LS_Shapes.resources .. "ls_cursor_help", 0, 0))
		l:AddChild(d.t1i, LM.GUI.ALIGN_LEFT, 0)
		l:AddPadding(-17)
		d.t1 = LM.GUI.DynamicText("ℹ " .. MOHO.Localize("/LS/Shapes/HelpInfo=Info"), width)
		l:AddChild(d.t1, LM.GUI.ALIGN_LEFT, 0) --18
	l:Pop()

	l:AddPadding(-16)

	l:PushH(LM.GUI.ALIGN_FILL)
		d.close = LM.GUI.ShortButton(MOHO.Localize("/Menus/File/Close=Close"), LM.GUI.MSG_CANCEL)
		l:AddPadding(-7)
		d.t2 = LM.GUI.DynamicText("💡 " .. MOHO.Localize("/LS/Shapes/HelpTip=Tip"), width + 4 - d.close:Width())
		l:AddChild(d.t2, LM.GUI.ALIGN_BOTTOM, 0)
		l:AddPadding(0)
		l:AddChild(d.close, LM.GUI.ALIGN_BOTTOM, 0)
		l:AddPadding(-1)
	l:Pop()
	l:AddPadding(-1280) --10

	return d
end

function LS_Shapes.h:UpdateWidgets()
	self.what = self.what ~= nil and self.what or MOHO.MSG_BASE

	if not self.iSel then
		self.t1:SetValue(MOHO.Localize("/LS/Shapes/HelpInfo=Click on an info button to get the description of its adjacent element. Most widgets has a tootip anyway (specially if Main Menu's \"Begginer's Mode\" entry is checked). Press <Esc / Enter / Button> to close..."))
		self.t2:SetValue("💡 " .. MOHO.Localize("/LS/Shapes/HelpTip=The logic behind \"Modes\" is similar to Moho's Style window; if any shape is selected: SHAPE mode, if editing a style: STYLE mode, otherwise: DEFAULT (but switchable at will, plus with a GROUP mode by holding <alt>)."))
	end
end

function LS_Shapes.h:HandleMessage(what) --MARK: HM(H)
	self.what = what or MOHO.MSG_BASE
	self.iSel = false
	self.t2:SetValue("") --💡ℹ⚠💥🧪❓📝🎉

	for i = 1, #self.w do
		if self.w[i] ~= nil and i ~= what - MOHO.MSG_BASE then
			self.w[i]:SetValue(false)
		end
		self.iSel = self.iSel == false and self.w[i]:Value() == true and self.w[i]:Value() or self.iSel
	end

	if (what == self.DLOG_UPDATE) then
		--self:UpdateWidgets()
	elseif (what == self.DLOG_UPDATE +  1) then	-- 1. Main Menu
		self.t1:SetValue(MOHO.Localize(  "/LS/Shapes/Help1_1=1.1 - It ensures that Moho's Style window always matches the status of \"Shapes Window\" (at a small item click response time cost)."))
		self.t2:SetValue("💡 " .. MOHO.Localize("/LS/Shapes/Tip1_1=Keep this checked if you often work with both windows open to avoid confusion over current selection."))
	elseif (what == self.DLOG_UPDATE +  2) then
		self.t1:SetValue(MOHO.Localize(  "/LS/Shapes/Help1_2=1.2 - Shapes in vector layers like \"Mesh Warps\" won't be listed (Curver and Auto-triangulated layers are always ignored anyway)."))
	elseif (what == self.DLOG_UPDATE +  3) then
		self.t1:SetValue(MOHO.Localize(  "/LS/Shapes/Help1_3=1.3 - If active, the window will appear upon opening the first document (intended to work in partnership with option below)."))
	elseif (what == self.DLOG_UPDATE +  4) then
		self.t1:SetValue(MOHO.Localize(  "/LS/Shapes/Help1_4=1.4 -Whether or not the button appears in the \"Tools\" palette (hiding it can help save space there, but then you'll have to go to \"Scripts » - Lost Scripts » Shapes Window\" to open)."))
		self.t2:SetValue("💡 " .. MOHO.Localize("/LS/Shapes/Tip1_4=Having it visible not only allows you to open & close it with a click but also by a custom keyboard shortcut (e.g., setting <Shift + S> to it from \"Edit » Edit Keyboard Shortcuts...\")."))
	elseif (what == self.DLOG_UPDATE +  5) then
		self.t1:SetValue(MOHO.Localize(  "/LS/Shapes/Help1_5=1.5 - Enables/disables certain tooltips that may be useful at the beginning but annoying in the end..."))
	elseif (what == self.DLOG_UPDATE +  6) then
		self.t1:SetValue(MOHO.Localize(  "/LS/Shapes/Help1_6=1.6 - Opens the \"Debug Mode\" dialog. If ENABLED, a log file is generated. If the script causes Moho® to close unexpectedly, this log may contain valuable information for identifying and fixing the problem."))
		self.t2:SetValue("💡 " .. MOHO.Localize("/LS/Shapes/Tip1_6=You can access the log file by clicking the dialog's \"Open Log\" button or by navigating to it at: \"CCF/Scripts/ScriptResources/ls_shapes/LOG.txt\". We only need the last incomplete log cycle, if one exists..."))
	--------
	elseif (what == self.DLOG_UPDATE +  7) then
		self.t1:SetValue(MOHO.Localize(  "/LS/Shapes/Help1_7=1.7 - Hide or show widgets related to shape/style/group creation, either because you don't need them or to save vertical space."))
	elseif (what == self.DLOG_UPDATE +  8) then
		self.t1:SetValue(MOHO.Localize(  "/LS/Shapes/Help1_8=1.8 - Make buttons, and therefore clickable area, larger (with the advantage of increasing Swatches and shape preview area a little bit too)."))
	elseif (what == self.DLOG_UPDATE +  9) then
		self.t1:SetValue(MOHO.Localize(  "/LS/Shapes/Help1_9=1.9 - Make the window as taller as possible (accordingly to current viewport height)."))
	elseif (what == self.DLOG_UPDATE + 10) then
		self.t1:SetValue(MOHO.Localize("/LS/Shapes/Help1_10=1.10 - Provides some info about selected item/s, but uncheck it should you want to save some vertical space."))
	--------
	elseif (what == self.DLOG_UPDATE + 11) then
		self.t1:SetValue(MOHO.Localize("/LS/Shapes/Help1_11=1.11 - Restores the script to its factory settings."))
	--------
	elseif (what == self.DLOG_UPDATE + 12) then
		self.t1:SetValue(MOHO.Localize("/LS/Shapes/Help1_12=1.12 - Yep, it opens this help dialog :D"))
	elseif (what == self.DLOG_UPDATE + 13) then
		self.t1:SetValue(MOHO.Localize("/LS/Shapes/Help1_13=1.13 - Visit the script's webpage at \"www.lost-scripts.github.io\" for more details, info, or just to discuss."))
	elseif (what == self.DLOG_UPDATE + 14) then
		self.t1:SetValue(MOHO.Localize("/LS/Shapes/Help1_14=1.14 - It takes you to the page with the latest release of the script so you can compare versions."))
		self.t2:SetValue("💡 " .. MOHO.Localize("/LS/Shapes/Tip1_14=Yours should appear at the end of the URL for ease comparison."))
	--------
	elseif (what == self.DLOG_UPDATE + 15) then
		self.t1:SetValue(MOHO.Localize("/LS/Shapes/Help1_15=1.15 - Opens a dialog from where you can check information such as copyright/license, credits, version..."))

	elseif (what == self.DLOG_UPDATE + 16) then	-- 2. Tweak Menu
		self.t1:SetValue(MOHO.Localize(  "/LS/Shapes/Help2_1=2.1 - Controls act on fill color/opacity (auto-activates upon clicking on a fill with the Select Shape tool)."))
	elseif (what == self.DLOG_UPDATE + 17) then
		self.t1:SetValue(MOHO.Localize(  "/LS/Shapes/Help2_2=2.2 - Controls act on stroke color/opacity (auto-activates upon clicking near a stroke with the Select Shape tool)."))
	elseif (what == self.DLOG_UPDATE + 18) then
		self.t1:SetValue(MOHO.Localize(  "/LS/Shapes/Help2_3=2.3 - Controls act on Shape FX handles \"preciselly\" (auto-activates upon clicking on a shape FX handle with the Select Shape tool)."))
	elseif (what == self.DLOG_UPDATE + 19) then
		self.t1:SetValue(MOHO.Localize(  "/LS/Shapes/Help2_4=2.4 - Allows recoloring selected shapes' fill/stroke (as per OPTIONS below) in the classic RGBα fashion, hold <alt> upon pressing \"Apply\" to randomize coloring!"))
		self.t2:SetValue("💡 " .. MOHO.Localize("/LS/Shapes/Tip2_4=Under single-layer selection, recoloring affects selected shapes or all of them if no shape is selected. Under multi-layer selection, recoloring applies to all shapes on all selected layers."))
	elseif (what == self.DLOG_UPDATE + 20) then
		self.t1:SetValue(MOHO.Localize(  "/LS/Shapes/Help2_5=2.5 - Allows recoloring selected shapes' fill/stroke (as per OPTIONS below) in a much more intuitive HSB (Hue/Saturation/Brightness) way, hold <alt> upon pressing \"Apply\" to randomize coloring!"))
		self.t2:SetValue("💡 " .. MOHO.Localize("/LS/Shapes/Tip2_5=Under single-layer selection, recoloring affects selected shapes or all of them if no shape is selected. Under multi-layer selection, recoloring applies to all shapes on all selected layers."))
	--------
	elseif (what == self.DLOG_UPDATE + 21) then
		self.t1:SetValue(MOHO.Localize(  "/LS/Shapes/Help2_6=2.6 - Color related actions..."))
	--------
	elseif (what == self.DLOG_UPDATE + 22) then
		self.t1:SetValue(MOHO.Localize(  "/LS/Shapes/Help2_7=2.7 - Color related utilities..."))
	--------
	elseif (what == self.DLOG_UPDATE + 23) then
		self.t1:SetValue(MOHO.Localize(  "/LS/Shapes/Help2_8=2.8 - Color related options... E.g., whether recoloring should just affect fills, strokes, both, alpha..."))

	elseif (what == self.DLOG_UPDATE + 24) then	-- 3. Swatch Menu
		self.t1:SetValue(MOHO.Localize(  "/LS/Shapes/Help3_1=3.1 - Hides Swatch, which can help saving quite vertical space..."))
	--------
	elseif (what == self.DLOG_UPDATE + 25) then
		self.t1:SetValue(MOHO.Localize(  "/LS/Shapes/Help3_2=3.2 - Factory Swatches list."))
		self.t2:SetValue("⚠ " .. MOHO.Localize("/LS/Shapes/Tip3_2_=It's not recommended to modify these ones as they may be overwritten upon reinstalling or updating the script."))
		if self.i3_2:Value() == true then LM.Beep() end
	elseif (what == self.DLOG_UPDATE + 26) then
		self.t1:SetValue(MOHO.Localize(  "/LS/Shapes/Help3_3=3.3 - Custom Swatches list. Their place is your Custom Content Folder's \"Swatches\" directory and they are the ones you can create or modify at your convenience."))
	elseif (what == self.DLOG_UPDATE + 27) then
	--------
		self.t1:SetValue(MOHO.Localize(  "/LS/Shapes/Help3_4=3.4 - Opens your Custom Swatches folder."))
		self.t2:SetValue("💡 " .. MOHO.Localize("/LS/Shapes/Tip3_4=You can copy there any Factory Swatches from the script's ScriptResources directory as a starting point for your own ones."))
	elseif (what == self.DLOG_UPDATE + 28) then
		self.t1:SetValue(MOHO.Localize(  "/LS/Shapes/Help3_5=3.5 - WIP!"))
	elseif (what == self.DLOG_UPDATE + 29) then
		self.t1:SetValue(MOHO.Localize(  "/LS/Shapes/Help3_6=3.6 - Opens current Custom Swatch to modify or create new ones. They are simple Moho® projects which can contain anythig, including a pose called \"SLIDER\" for user interaction!"))
	elseif (what == self.DLOG_UPDATE + 30) then
		self.t1:SetValue(MOHO.Localize(  "/LS/Shapes/Help3_7=3.7 - Allows you to reload Swatches thus changes are available immediately after adding/modifying any of them."))
	elseif (what == LM.GUI.MSG_CANCEL or what == LM.GUI.MSG_OK) then
		--MOHO.ScriptInterface:Click()
		return
	end
	self:UpdateWidgets()
end

function LS_Shapes.h:OnOK() --print("LS_Shapes.h:OnOK " , os.clock())
	LS_Shapes.isHelpVisible = false
	LS_Shapes.showHelp = true

	--LS_Shapes.dlog.ipMenu:SetEnabled(LS_Shapes.dlog.IP_MENU + 8, not LS_Shapes.isHelpVisible)
	--LS_Shapes.dlog:UpdateWidgets()
end

-- **************************************************
-- The guts of this script
-- **************************************************

function LS_Shapes:IsEnabled(moho) --print("LS_Shapes:IsEnabled(" .. tostring(moho.document:Name()) .. ")", " 🕗: " .. os.clock())
	if (not self.docsLoaded) then
		local swatchDir = moho:UserAppDir()
		if (swatchDir ~= "") then
			swatchDir = swatchDir .. '/Scripts/ScriptResources/ls_shapes/Swatches/'
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

	if (LS_Shapes.dlog == nil or true) then
		return true
	end
	return false
end

function LS_Shapes:IsRelevant(moho) --print("LS_Shapes:IsRelevant(" .. tostring(moho.document:Name()) .. ")", " 🕗: " .. os.clock())
	self.defMoho = moho
	self.defDoc = self.defMoho.document
	self.defLayer = (self.defDoc and self.defDoc:CountLayers() > 0) and self.defDoc:Layer(0) or nil
	self.defDrawLayer = self.defLayer:LayerType() == MOHO.LT_SWITCH and moho.drawingLayer or self.defLayer
	self.defVecLayer = self.defDrawLayer and moho:LayerAsVector(self.defDrawLayer) or nil
	self.defMesh = self.defVecLayer and self.defVecLayer:Mesh() or nil
	--self.defTool = (moho and moho.CurrentTool) and moho:CurrentTool() or "" --20240120-0123: This here makes Moho crash...

	if (not self.brushList) then
		self.brushList = LS_Shapes:BrushLoader(moho, self.brushDirectory)
	end

	if self.defDoc ~= nil and self.defDoc:Name() ~= "-" then
		if self.dlog == nil and self.openOnStartup and self.shouldOpen and self.lastMOHO ~= tostring(MOHO) then
			self:Run(moho) --LS_ShapesDialog:Update(moho)
		end
	end

	if self:CompareVersion(moho:AppVersion(), 14.0) < 0 or not self.showInTools then
		return false
	end
	return true
end

function LS_Shapes:Run(moho)
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
					self.alertCantOpen = LM.GUI.Alert(LM.GUI.ALERT_INFO, reminder .. "The \"" .. LS_Shapes:UILabel() .. "\" couldn't be opened due to currently active tool (\"" .. _G[tool]:UILabel() .. "\" in this case) has a dialog and that may cause problems.", "Please, select a different one in \"Tools\" palette with that in mind and try again... Once \"" .. LS_Shapes:UILabel() .. "\" is open, you are free to activate and work breezily with any tool.", nil, "OK", (reminder == "" and "Got it!" or nil), nil) --OK: 0, Got it: 1
					self.alertCantOpen = reminder ~= "" and 1 or self.alertCantOpen
				else
					LM.Beep()
				end
				self.prevClock = os.clock()
				return
			end
		end
		--]]

		self.dlog = LS_ShapesDialog:new(moho)
		--self.dlogBypass = LS_ShapesDialog:new(moho) self.dlogBypass = nil -- dlogGuard, dlogShield, dlogBait, dlogTrap, dlogPatch (whatever... not necessary anymore!)
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

-- **************************************************
-- Recurring functions --MARK:-FUNCS
-- **************************************************

function LS_Shapes:Log(...) --([char:action]/[char:message]/[char:print], [bool:keep], [userdata:moho] <unordered>) void
	if not self.debugMode then return end

	if not self.log then -- If there is no file open, open it
		self.logPath = self.basePath .. "/" .. self.resources .. "LOG.txt"
		self.log = io.open(self.logPath, "a+")
		if not self.log then return end
	end

	local action, message, printToo, keep, moho -- Optional&Unordered args assignment
	for _, v in ipairs{...} do
		if type(v) == "string" then
			local vUp = v:upper() -- Detect START/END ignoring case
			if vUp == "START" or vUp == "END" then
				action = vUp
			elseif vUp == "PRINT" then
				printToo = true
			else
				message = v
			end
		elseif type(v) == "boolean" then
			keep = v or false
		elseif type(v) == "userdata" then
			moho = v
		end
	end

	local data = {} -- Filename+V/Function/Line, OS+MohoP/D+V, Flags:G/L, Frame:G/L, DocExists, Styles, DocLayers, SelLayers, LayerType, Shapes/Sel
	if action == "START" then
		data.i, data.M = debug.getinfo(2, "nSl"), MOHO.MohoGlobals
		data[1] = package.config:sub(1, 1) == "\\" and "Win" or "Mac"
		data[1] = data[1] .. "/" .. (data.i and (self.filename and self.version) and (self.filename .. "[v" .. self.version .. "]/" or "") .. (data.i.name or " Anonymous") .. "/" .. data.i.currentline or "")
		data[3] = "QF:" .. math.floor(data.M.QualityFlags)
		if moho then
			data[2] = (data[2] and "/" or "") .. (moho:IsPro() and "MP" or "MD") .. moho:AppVersion()
			data[4] = "FR:" .. math.floor(moho.frame) .. (moho.frame ~= moho.layerFrame and "/" .. math.floor(moho.layerFrame) or "")
			if moho.document then
				data[5] = "MD:" .. (moho.document and "✔" or "✖")
				data[6] = "ST:" .. math.floor(moho.document:CountStyles())
				data[7] = "DL:" .. math.floor(moho.document:CountLayers())
				data[8] = "SL:" .. math.floor(moho.document:CountSelectedLayers())
				if moho.layer then
					data[3] = data[3] .. "/" .. math.floor(moho.layer:QualityFlags())
					data[9] = "LT:" .. math.floor(moho.layer:LayerType())
					data[10] = "SH:" .. math.floor(moho:CountShapes()) .. "/" .. math.floor(moho:CountSelectedShapes(true))
				end
			end --print(table.concat(data, ", "))
		end
	end

	self.logKeeping = action == "START" and keep or (self.logKeeping or false) -- Persistent states...
	self.logPrinting = action == "START" and printToo or (self.logPrinting or false)

	local limit, attr = (100 * (self.logKeeping and 2 or 1)) * 1024, lfs and lfs.attributes(self.logPath) or nil -- Size limit with pruning of oldest half (100/200 KB)
	if attr and attr.size > limit then
		local lines = {} -- Read all lines
		for line in io.lines(self.logPath) do
			table.insert(lines, line)
		end

		local startKeep, keep = math.floor(#lines / 2) + 1, {} -- Calculate from where to keep (most recent half)
		for i = startKeep, #lines do
			table.insert(keep, lines[i])
		end

		self.log:close() -- Rewrite only the part we are keeping
		local fw = io.open(self.logPath, "w")
		for _, l in ipairs(keep) do
			fw:write(l .. "\n")
		end
		fw:close()
		self.log = io.open(self.logPath, "a+") -- Reopen to continue writing
	end

	local line, lapse = nil, nil
	local function ts()
		if action == "START" then
			self.logTime = os.clock()
		elseif action == "END" and self.logTime then
			lapse = math.floor(((os.clock() - self.logTime) * 1000) + 0.5)
			self.logTime = nil
		end
		return os.date(action and "%y%m%d %H:%M:%S." or " %H:%M:%S.") .. string.format("%03d", math.floor((os.clock()%1) * 1000))
	end

	if action == "START" then -- If it is START, clear the previous block if it finished successfully
		self.logTime, self.logCount = os.clock(), 0
		if not self.logKeeping then
			local lines, endIdx, startIdx = {}
			for line in io.lines(self.logPath) do
				table.insert(lines, line)
			end
			for i = #lines, 1, -1 do
				if lines[i]:find("%[END%]") then endIdx = i; break end
			end
			if endIdx then
				for i = endIdx, 1, -1 do
					if lines[i]:find("%[START%]") then startIdx = i; break end
				end
			end
			if startIdx and endIdx then
				for i = endIdx, startIdx, -1 do table.remove(lines, i) end
				local fw = io.open(self.logPath, "w")
				for _, l in ipairs(lines) do fw:write(l .. "\n") end
				fw:close()
			end
		end

		local lastLine -- Insert blank line only if the last line is not empty
		for line in io.lines(self.logPath) do lastLine = line end
		if lastLine and lastLine:match("%S") then
			self.log:write("\n")
		end

		line = ts() .. ": [START]" .. (message and " " .. message or "") .. (#data > 0 and " (" .. table.concat(data, ", ") ..")" or "") .. "\n"
		if self.logPrinting then print(line) end
		self.log:write(line)
		self.log:flush()
		return
	end

	if action == "END" then -- If it is END, write and clear the most recent block
		line = ts() .. ": [ END ]" .. (message and " " .. message or "") .. (lapse and " (" .. lapse .. "ms)" or "") .. "\n"
		if self.logPrinting then print(line .. "\n") end
		self.log:write(line)
		self.log:flush()
		self.logCount = nil
		if not self.logKeeping then
			local lines, endIdx, startIdx = {}
			for line in io.lines(self.logPath) do
				table.insert(lines, line)
			end
			for i = #lines, 1, -1 do
				if lines[i]:find("%[ END %]") then endIdx = i; break end
			end
			if endIdx then
				for i = endIdx, 1, -1 do
					if lines[i]:find("%[START%]") then startIdx = i; break end
				end
			end
			if startIdx and endIdx then
				for i = endIdx, startIdx, -1 do table.remove(lines, i) end
				local fw = io.open(self.logPath, "w")
				for _, l in ipairs(lines) do fw:write(l .. "\n") end
				fw:close()
			end

			self.logKeeping = false -- Reset "keep mode" status
		end
		return
	end

	-- Normal case
	self.logCount = (self.logCount or 0) + 1
	line = (" "):rep(6) .. ts() .. ":" .. (message and " " .. message or " [" .. self.logCount .. "]") .. "\n"
	if self.logPrinting then print(line) end
	self.log:write(line)
	self.log:flush()
end

function LS_Shapes.MsgDebug(self, ...) --(tbl, int...) void
	local args, sum = {...}, 0
	for i = 1, #args do
		sum = sum + args[i]
	end

	local function flagNames(sum)
		local t, total = {}, 0
		for k, v in pairs(MOHO) do
			if type(v) == "number" and MOHO.hasbit(sum, v) and k:find("^MSGF_") then
				if #args == 0 or table.contains(args, v) then
					table.insert(t, k)
					total = total + v
				end
			end
		end
		return table.concat(t, " | "), math.floor(total), #t
	end

	for msgName, flags in pairs(self.F) do
		local id = self[msgName]
		local check = function(val, suffix)
			local names, total, count = flagNames(val)
			if sum == 0 then
				if val > 0 then
					print(msgName .. suffix .. " (" .. math.floor(id) .. ") has flag" .. (count > 1 and "s: " or ": ") .. names .. " (" .. total .. ")")
				end
			elseif MOHO.hasbit(val, sum) then
				print(names .. " (" .. total .. ") flag" .. (count > 1 and "s are" or " is") .. " present in: " .. msgName .. suffix .. " (" .. math.floor(id) .. ")")
			end
		end

		if type(flags) == "number" then
			check(flags, "")
		elseif type(flags) == "table" then
			for k, v in pairs(flags) do
				check(v, "[" .. k .. "]")
			end
		end
	end
end --Usage: LS_Shapes.MsgDebug(self) or LS_Shapes.MsgDebug(self, MOHO.MSGF_NOTUNDO...)

function LS_Shapes.MsgFlag(self, msg, ...) --(tbl, int, int...) bool -- NOTE: Returns true if MSG contains all given flags. If you want to know if it *doesn't* have any, use `not LS_Shapes.MsgFlag()`
	local flags, flagSum = {...}, 0
	for i = 1, #flags do
		flagSum = flagSum | flags[i] -- Binary OR for semantic clarity
	end

	for name, id in pairs(self.F) do
		if self[name] == msg then
			local entry = self.F[name]
			if type(entry) == "number" then
				return MOHO.hasbit(entry, flagSum)
			elseif type(entry) == "table" then
				local idx = self.multiMode
				local subFlag = entry[idx]
				return subFlag and MOHO.hasbit(subFlag, flagSum) or false
			end
		end
	end
	return false
end --Usage: print(tostring(LS_Shapes.MsgFlag(self, LS_ShapesDialog.SWATCHSLIDER, MOHO.MSGF_NOTUNDO...)))

function LS_Shapes:PatchUndo(doc, layerOrMulti, shallow, willOnlyAddPoints, action) --(MohoDoc, [MohoLayer|bool], bool, bool, function) void
	doc = doc or moho.document
	shallow = shallow or false
	willOnlyAddPoints = willOnlyAddPoints or false
	if not doc then return end

	-- Patching phase
	if not self._origPrepUndo and not self._origPrepMultiUndo then
		--local isMulti, isLayer = layerOrMulti == true, type(layerOrMulti) == "userdata" -- If you wanted to normalize at the beginning...
		self._origPrepUndo, self._origPrepMultiUndo, self._origSetDirty = doc.PrepUndo, doc.PrepMultiUndo, doc.SetDirty -- Save originals

		-- Own Undo before patching
		if layerOrMulti ~= false then
			if layerOrMulti == true then -- or just `isMulti` if normalized
				doc:PrepMultiUndo(shallow)
			elseif type(layerOrMulti) == "userdata" then -- or just `isLayer` if normalized
				doc:PrepUndo(layerOrMulti, shallow, willOnlyAddPoints)
			end
			doc:SetDirty()
		end
		-- Patch only what's necessary
		if layerOrMulti ~= false then
			if layerOrMulti == true then -- or just `isMulti` if normalized
				doc.PrepMultiUndo = function() end
			elseif type(layerOrMulti) == "userdata" then -- or just `isLayer` if normalized
				doc.PrepUndo = function() end
			end
			doc.SetDirty = function() end
		end
		-- If there is an action block, execute it protected and restore
		if type(action) == "function" then
			local ok, err = pcall(action)
			self:PatchUndo(doc) -- Always restore
			if not ok then error(err) end
		end
	else
		-- Restoration phase
		if not self._origPrepUndo and not self._origPrepMultiUndo then return end -- Extra protection, do nothing if no originals saved
		doc.PrepUndo, doc.PrepMultiUndo, doc.SetDirty = self._origPrepUndo, self._origPrepMultiUndo, self._origSetDirty
		self._origPrepUndo, self._origPrepMultiUndo, self._origSetDirty = nil, nil, nil	-- Clear references
	end
end --[[Usage:
1) Linear mode; the change is trivial and unlikely to fail (no pcall, manual restore):
self:PatchUndo(doc, lDrawing, false, false) -- patch
-- your code...
self:PatchUndo(doc) -- restore

2) Callback mode, the code block may fail and you want guaranteed restore without manual call (pcall integrated, auto-restore):
self:PatchUndo(doc, lDrawing, false, false, function()
	-- your code...
end) --]]

MOHO.LS_CT_UNK = 0
MOHO.LS_CT_RGB = 1
MOHO.LS_CT_HSV = 2
MOHO.LS_CT_VEC = 3
MOHO.LS_CT_HEX = 4
MOHO.LS_CT_STR = 5
MOHO.LS_CT_TBL = 6

function MOHO:GetConstants(prefix, value) --(char, int)
	local matches = {}
	for k, v in pairs(self) do
		if type(k) == "string" and k:match("^" .. prefix) then
			if value == nil or v == value then
				table.insert(matches, k)
			end
		end
	end
	return #matches > 0, #matches, matches
end -- Use: ok, count, list = MOHO:GetConstants("LS_CT") for _, name in ipairs(list) do print(name, MOHO[name]) end

-----------------
-- MARK: COLOR --
-----------------

function LS.ColorOps:Ls_SetRgb(col, newCol, ignoreAlpha) --(rgb_color|tbl, rgb_color|tbl, bool) rgb_color|tbl (just in case a return is needed?)
	col = col or LM.rgb_color:new_local()
	col.r = LM.Clamp(newCol.r or newCol[1] or 0, 0, 255) 
	col.g = LM.Clamp(newCol.g or newCol[2] or 0, 0, 255) 
	col.b = LM.Clamp(newCol.b or newCol[3] or 0, 0, 255) 
	col.a = (ignoreAlpha and col.a) or LM.Clamp(newCol.a or newCol[4] or 0, 0, 255)
	return col
end

function LM.ColorOps:Ls_Rgb2Vec(col) --(rgb_color) ColorVector
	local cv = LM.ColorVector:new_local()
	cv.r = LM.Clamp(col.r, 0, 255) / 255
	cv.g = LM.Clamp(col.g, 0, 255) / 255
	cv.b = LM.Clamp(col.b, 0, 255) / 255
	cv.a = LM.Clamp(col.a, 0, 255) / 255
	return cv
end

function LM.ColorOps:Ls_MultiplyColors(col1, col2, factor, multiplyAlpha) --(rgb_color, rgb_color, float, bool) rgb_color
	local c1, c2 = LM.ColorOps:Ls_Rgb2Vec(col1), LM.ColorOps:Ls_Rgb2Vec(col2)
	local mc = c1 * c2
	local c = (factor and factor < 1) and mc * factor + c1 * (1.0 - factor) or mc -- result = (multiplied color * factor) + (original color * (1 - factor))
	c.a = not multiplyAlpha and 1.0 or c.a
	return c:AsColorStruct()
end

function LM.ColorOps:Ls_ColorType(col) --(userdata | table | char) int, bool
	local kind, hasAlpha, r, g, b, a
	if type(col) == "userdata" then -- vec/hsv/rgb
		if col.Normalize then -- ColorVector
			kind, hasAlpha = MOHO.LS_CT_VEC, col.a and true or false
		elseif col.h then -- hsv_color
			kind, hasAlpha = MOHO.LS_CT_HSV, col.a and true or false
		else -- rgb_color
			kind, hasAlpha = MOHO.LS_CT_RGB, col.a and true or false
		end
	elseif type(col) == "table" then -- Dic/Array: {r=0, ..., a=255} or {0, ..., 255}
		r, g, b, a, hasAlpha, kind = col.r or col[1] or 0, col.g or col[2] or 0, col.b or col[3] or 0, col.a or col[4], col.a and true or false, MOHO.LS_CT_TBL
	elseif type(col) == "string" then -- HEX/MohoSetting
		local hex = col:gsub("#", "")
		if (#hex == 6 or #hex == 8) and hex:match("^%x+$") then -- HEX: "#RRGGBB" or "#RRGGBBAA"
			kind, hasAlpha = MOHO.LS_CT_HEX, #hex == 8
		else -- MohoSetting: "R G B" or "R G B A"
			r, g, b, a = col:match("(%d+)%s+(%d+)%s+(%d+)%s*(%d*)")
			if r and g and b then
				kind, hasAlpha = MOHO.LS_CT_STR, a ~= ""
			end
		end
	end
	return kind, hasAlpha
end

function LM.ColorOps:Ls_ConvertColor(col, targetType) --(userdata | table | char) userdata | table | char
	local srcType, hasAlpha = LM.ColorOps:Ls_ColorType(col)
	if not srcType or not MOHO:GetConstants("LS_CT", targetType) then -- Strict validation (something's not fulfilled; nothing is returned)
		return nil
	end

	local rgb, tbl
	if srcType == MOHO.LS_CT_RGB then -- Step 1: convert to rgb_color
		rgb = col
	elseif srcType == MOHO.LS_CT_VEC then
		rgb = LM.ColorOps:RgbColor(col.r * 255, col.g * 255, col.b * 255, col.a * 255) -- Not rounded, e.g. LM.Round(col.r) * 255), for accuracy; assumed to be handled internally
	elseif srcType == MOHO.LS_CT_HSV then
		rgb = LM.ColorOps:Hsv2Rgb(col)
	elseif srcType == MOHO.LS_CT_TBL then
		tbl = (col.r and col[1] and 2) or (col.r and 1) or (col[1] and 0) -- 2: both, 1: array, 0: dic
		rgb = LM.ColorOps:RgbColor(col.r or col[1] or 0, col.g or col[2] or 0, col.b or col[3] or 0, col.a or col[4] or 255) -- Add support for hsv fields too? (TBC)
	elseif srcType == MOHO.LS_CT_HEX then
		local hex = col:gsub("#", "")
		rgb = LM.ColorOps:RgbColor(tonumber(hex:sub(1, 2), 16), tonumber(hex:sub(3,4), 16), tonumber(hex:sub(5,6), 16), (#hex == 8) and tonumber(hex:sub(7, 8), 16) or 255)
	elseif srcType == MOHO.LS_CT_STR then
		local r, g, b, a = col:match("(%d+)%s+(%d+)%s+(%d+)%s*(%d*)")
		rgb = LM.ColorOps:RgbColor(tonumber(r) or 0, tonumber(g) or 0, tonumber(b) or 0, tonumber(a) or 255)
	end

	if targetType == MOHO.LS_CT_RGB then -- Step 2: Convert to target format
		return rgb
	elseif targetType == MOHO.LS_CT_VEC then
		local cv = LM.ColorVector:new_local() cv:Set(rgb.r / 255, rgb.g / 255, rgb.b / 255, rgb.a / 255) return cv
	elseif targetType == MOHO.LS_CT_HSV then 
		return LM.ColorOps:Rgb2Hsv(rgb) -- NOTE: Hsv2Rgb expects h, s, v in the range 0–255. If your hsv_color comes from normalized 0-1 values, scale them (* 255) before creating it!
	elseif targetType == MOHO.LS_CT_TBL then
		return (tbl == 0 and {r=rgb.r, g=rgb.g, b=rgb.b, a=rgb.a}) or (tbl == 1 and {rgb.r, rgb.g, rgb.b, rgb.a}) or {r=rgb.r, g=rgb.g, b=rgb.b, a=rgb.a, rgb.r, rgb.g, rgb.b, rgb.a}
	elseif targetType == MOHO.LS_CT_HEX then
		return string.format("%02x%02x%02x%s", rgb.r, rgb.g, rgb.b, hasAlpha and string.format("%02x", rgb.a) or "")
	elseif targetType == MOHO.LS_CT_STR then
		return string.format("%d %d %d%s", rgb.r, rgb.g, rgb.b, hasAlpha and (" " .. rgb.a) or "")
	end
end

function LM.ColorOps:Ls_CrushColor(crusher, crushed, alpha) --(userdata, userdata, bool [nil|true|false]) rgb_color
	local crType, crHasA, rgb, a = LM.ColorOps:Ls_ColorType(crusher)
	if crType == MOHO.LS_CT_VEC then -- ColorVector > scale to 0–255
		rgb = LM.ColorOps:RgbColor(crusher.r * 255, crusher.g * 255, crusher.b * 255, (crusher.a or 1) * 255) -- Not rounded, e.g. LM.Round(crusher.r) * 255), for accuracy; assumed to be handled internally
	elseif crType == MOHO.LS_CT_HSV then -- hsv_color > convert to rgb_color
		rgb = LM.ColorOps:Hsv2Rgb(crusher)
	elseif crType == MOHO.LS_CT_RGB then -- rgb_color or object with r/g/b/a in 0–255
		rgb = crusher
	else
		return nil
	end
	if alpha == nil or (alpha == false and not crHasA) then -- No alpha at all...
		a = 255
	elseif alpha == true then -- Use crusher's alpha
		a = crHasA and crusher.a or 255
	else -- alpha == false (Use crushed's alpha)
		a = crushed.a
	end
	return LM.ColorOps:RgbColor(rgb.r, rgb.g, rgb.b, a)
end

function LS_Shapes:alterRGB(col, t) --(rgb_color, tbl) rgb_color -- Based on Mike Kelley's "mk_adjust_colors"
	col.r = LM.Clamp(col.r + t[1], 0, 255)
	col.g = LM.Clamp(col.g + t[2], 0, 255)
	col.b = LM.Clamp(col.b + t[3], 0, 255)
	col.a = LM.Clamp(col.a + t[4], 0, 255)
	return col
end

function LS_Shapes:alterHSB(col, t) --(rgb_color, tbl) rgb_color -- Based on Mike Kelley's "mk_adjust_colors"
	local myHSL = LM.rgb_color:new_local()
	myHSL.r, myHSL.g, myHSL.b = col.r, col.g, col.b
	local hslColor = self:convertRGB(myHSL)

	-- Set newColor with values of fillColor/lineColor plus changeColor
	hslColor.r = ((hslColor.r + t[1]) % 360) -- do hue
	hslColor.g = LM.Clamp(hslColor.g + t[2], 0, 100) -- do saturation
	hslColor.b = LM.Clamp(hslColor.b + t[3], 0, 100) -- do brightness

	myHSL = self:convertHSB(hslColor)
	col.r, col.g, col.b = myHSL.r, myHSL.g, myHSL.b
	return col
end

function LS_Shapes:convertRGB(col) --(rgb_color) rgb_color -- From Mike Kelley's "mk_adjust_colors"
	-- Convert an RGB value into an HSL value.
	local max, min, dif = 0, 0, 0
	local brightness, saturation, hue = 0, 0, 0
	local hsl = col

	-- Get the maximum and minimum RGB components.
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

function LS_Shapes:convertHSB(col) --(rgb_color) rgb_color -- From Mike Kelley's "mk_adjust_colors"
	-- Convert an HSB value into an RGB one
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

--------------
-- MARK: OS --
--------------

function LS_Shapes:SuitPath(path) --(char) char
	return (package.config:sub(1, 1) == "\\" and path:gsub("/", "\\")) or path:gsub("\\", "/")
end

function LS_Shapes:FileExists(filepath) --(char) bool
	filepath = self.SuitPath and self:SuitPath(filepath) or filepath
	local f = io.open(filepath, "r")
	return f ~= nil and io.close(f)
end

function LS_Shapes:FirstExistingFile(dir, ...) --(char, ...char) char? -- Returns first existing file path, or nil
	for i = 1, select("#", ...) do
		local name = select(i, ...)
		local sep = dir:sub(-1) == "\\" and "" or "\\"
		local path = self:SuitPath(dir .. sep .. name) --local path = self:PathJoin(dir, name) --local path = dir .. sep .. name
		if self:FileExists(path) then
			return path
		end
	end
end --Usage: file = LS:FirstExistingFile(self.resPath, "LICENSE", "LICENSE.txt")

function LS_Shapes:ReadFile(filepath, a) --(char, tbl?) tbl|char, int
	filepath = self:SuitPath(filepath)
	a = a or {}
	a.asString = a.asString or false
	a.from = a.from or 1
	a.to = a.to or 9999 -- Default max lines to prevent huge loads (overcome by using `to` named arg if necessary)

	if not self:FileExists(filepath) then return a.asString and "" or {}, a.from end

	local lines = {}
	for line in io.lines(filepath) do
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
local lines, offset = LS_Shapes:ReadFile(file, {from = 4, to = 8}) -- As table
for i, line in ipairs(lines) do
	print((i + offset - 1) .. ": " .. line)
end

local lines = LS_Shapes:ReadFile(file, {asString = true, to = 8}) print(lines, offset) -- As string
--]]

function LS_Shapes:GetOS() --char
	return package.config:sub(1, 1) == "\\" and "win" or "unix"
end

function LS_Shapes:Open(path) --(char) void
	path = self:SuitPath(path):gsub("%%", "%%%%") -- Escape the % to avoid problems with os.execute
	os.execute(self:GetOS() == "unix" and 'open "' .. path .. '"' or 'explorer "' .. path .. '"')
end

function LS_Shapes:LoadDocument(moho, docPath) --(moho, char) void
	local doc = moho:LoadDocument(docPath)
	if (doc ~= nil) then
		table.insert(self.docList, doc)
		if (self.doc == nil) then
			self.doc = doc
		end
	end
end

function LS_Shapes:GetDraggingButton(...) --(LM_TextControl, LM_Slider, ...) int
	local widgets = {...}
	for _, widget in ipairs(widgets) do
		if widget and widget:IsMouseDragging(1) then
			return 1 -- LMB
		elseif widget and widget:IsMouseDragging(2) then
			return 2 -- RMB
		end
	end
	return 0 -- No button is being dragged on any given widget
end

function LS_Shapes:Lapse(wait) -- (float) bool, float
	wait = wait or self.wait or 1
	local now = os.clock()
	local delta = now - (self.lapse or 0)
	if type(self.lapse) ~= "number" or delta >= wait then
		self.lapse = now
		return true, 0
	end
	return false, wait - delta
end

-------------------
-- MARK: OBJECTS --
-------------------

function LS_Shapes:ChannelByID(moho, layer, id, subID, debug) --(moho, MohoLayer, int, int, bool) chan, chanInfo -- 20250725: For some reason, it must be run before assigning `mesh` variable or it'll be messed up!
	subID, debug = subID or -1, debug or false
	local ch, chInfo, done, sTime = nil, MOHO.MohoLayerChannel:new_local(), false, os.clock()

	for i = 0, layer:CountChannels() - 1 do
		layer:GetChannelInfo(i, chInfo) --channelID | name | selectionBased | separableDimensions | subChannelCount

		if done then break end
		if (chInfo.channelID == id) then
			ch = layer:Channel(i, 0, moho.document)
			if ((chInfo.subChannelCount > 0 or chInfo.selectionBased) and subID > -1) then
				for j = 0, chInfo.subChannelCount - 1 do
					if (chInfo.channelID == id and j == LM.Clamp(subID, 0, chInfo.subChannelCount - 1)) then
						ch = layer:Channel(i, j, moho.document)
						done = true
						break
					end
				end
			end
			break
		end
	end
	if ch then
		if ch:ChannelType() == MOHO.CHANNEL_VAL then ch = moho:ChannelAsAnimVal(ch)
		elseif ch:ChannelType() == MOHO.CHANNEL_VEC2 then ch = moho:ChannelAsAnimVec2(ch)
		elseif ch:ChannelType() == MOHO.CHANNEL_VEC3 then ch = moho:ChannelAsAnimVec3(ch)
		elseif ch:ChannelType() == MOHO.CHANNEL_BOOL then ch = moho:ChannelAsAnimBool(ch)
		elseif ch:ChannelType() == MOHO.CHANNEL_COLOR then ch = moho:ChannelAsAnimColor(ch)
		elseif ch:ChannelType() == MOHO.CHANNEL_STRING then ch = moho:ChannelAsAnimString(ch)
		end
		if debug then
			print("Channel " .. chInfo.name:Buffer() .. " (" .. math.floor(chInfo.channelID) .. ") " .. "has: " .. chInfo.subChannelCount .. " subchannels, " .. math.floor(ch:CountKeys()) .. " keys and... is sel. based? " .. tostring(chInfo.selectionBased) .. string.format(" (%.6f sec", os.clock() - sTime) .. ")")
		end
		return ch, chInfo
	end
end -- Usage: LS_Shapes:ChannelByID(moho, moho.drawingLayer, CHANNEL_SHAPE_ORDER) -- NOTE (never forget): If a function is used in a ternary expression, only its first multi-value is preserved!

function LS_Shapes:CountSelectedStyles(doc) --(MohoDoc) int
	local count = 0
	if doc ~= nil then
		for i = 0, doc:CountStyles() - 1 do -- Check if the name is already taken by another style and, if so, pick that style's reference ID
			local style = doc:StyleByID(i)
			if style.fSelected == true then
				count = count + 1
			end
		end
	end
	return count
end

function LS_Shapes:MakeStyleNameUnique(doc, id, jump) --(MohoDoc, int, int) void
	if (doc ~= nil and id ~= nil and doc:StyleByID(id) ~= nil) then
		local count = 0 + (jump or 1)
		local baseName = doc:StyleByID(id).fName:Buffer() -- Item's original name
		local newName = baseName -- Current name of the item, which goes updating
		local namesake = id
		for i = 0, doc:CountStyles() - 1 do -- Check if the name is already taken by another item and, if so, pick that item's reference ID
			local style = doc:StyleByID(i)
			if style.fName:Buffer() == baseName and i ~= id then
				namesake = i
			end
		end
		if doc:Style(newName) ~= nil and doc:StyleByID(namesake) ~= doc:StyleByID(id) then -- We check if there is another item with the current name, not with the original one
			while doc:Style(newName) do -- As long as there is another item with the current name and it's not the same as the one we are renaming...
				count = count + 1
				newName = baseName .. " " .. count -- We generate the new name using the original name and the counter
			end
		end
		doc:StyleByID(id).fName:Set(newName) -- We assign the new name to the item using the current name
	end
end

--[[20231218-2014: Using "StyleID" instead... Delete?
function LS_Shapes:StyleIDByUUID(doc, UUID) --(MohoDoc, char) int
	if doc ~= nil and UUID ~= nil then
		for i = 0, doc:CountStyles() - 1 do
			if (doc:StyleByID(i).fUUID:Buffer() == UUID) then
				return i
			end
		end
	end
end
--]]

function LS_Shapes:StyleID(doc, style) --(MohoDoc, M_Style) int
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

function LS_Shapes:StyleLeaver(moho, mesh, mode) --(moho, M_Mesh, int) int -- StyleDeactivator?
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

function LS_Shapes:StyleSelector(doc, id) --(MohoDoc, int) void
	for i = 0, doc:CountStyles() - 1 do
		local style = doc:StyleByID(i)
		if (style ~= nil) then
			style.fSelected = i == id
		end
	end
end

function LS_Shapes:BrushLoader(moho, dir, variantDir) --(MohoDoc, int, bool) dic
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
								brushTable[fileName] = itemPath --fileName .. (isFolder and " *" or "") --"🖌 " .. fileName .. (isFolder and "..." or "")
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
function LS_Shapes:BrushLoader(moho, variantDir) --(MohoDoc, bool) dic
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
--]]

function LS_Shapes:GetPointsKey(group) --(M_PointGroup) char
	local IDs = {}
	for i = 0, group:CountPoints() - 1 do
		table.insert(IDs, group:Point(i).fID)
	end
	table.sort(IDs)
	return table.concat(IDs, "-")
end

function LS_Shapes:ProcessGroups(mesh, layerUUID) --(M_Mesh, char) void
	if mesh ~= nil then
		mesh.ls = mesh.ls or {}
		mesh.ls_fLayerUUID = layerUUID or ""
		mesh.ls_fGroups = mesh and mesh.ls_fGroups or {old = {}}
		mesh.ls_fGroupLabels = ""

		for i = 0, mesh:CountGroups() - 1 do
			local group = mesh:Group(i)
			local fSelectedDone, fSelPartlyDone, fHiddenDone
			group.ls_fID = mesh:GroupID(group)
			group.ls_fSelected = group.ls_fSelected
			group.ls_fSelPartly = false
			group.ls_fHidden = true
			group.ls_fLabel = ""

			for j = 0, group:CountPoints() - 1 do
				local pt = group:Point(j)
				if not pt.fHidden and not fHiddenDone then
					group.ls_fHidden = false
					fHiddenDone = true
				end
				if pt.fSelected and not fSelPartlyDone then
					group.ls_fSelPartly = true
					fSelPartlyDone = true
				end
			end

			group.ls_fLabel = ((group.ls_fSelPartly == true and not group.ls_fSelected) and "· " or "  ") .. group:Name() .. (group.ls_fHidden == true and " *" or "") -- Unicode Character: Hair Space " " (U+200A)
			mesh.ls_fGroupLabels = mesh.ls_fGroupLabels .. group.ls_fLabel
			mesh.ls_fGroups[0] = layerUUID
			if mesh.ls_fGroups[i + 1] ~= group and group then
				mesh.ls_fGroups[i + 1] = group
			end
		end
	end
end

function LS_Shapes:DeselectGroups(mesh, except) --(M_Mesh, int) void
	if mesh ~= nil then
		for i = 0, mesh:CountGroups() - 1 do
			mesh:Group(i).ls_fSelected = except ~= nil and i == except or false
		end
	end
end

function LS_Shapes:SelectedGroup(mesh, strict) --(M_Mesh, bool?) M_PointGroup -- NOTE: Get selected group found accordingly their actual order. With strict nothing else must be selected (TBC?)
	local group, groupSel, groupPts = nil, false, nil
	if mesh ~= nil and mesh:CountGroups() > 0 then
		for i = 0, mesh:CountGroups() - 1 do
			group = mesh:Group(i)
			groupPts = group:CountPoints()
			for j = 0, groupPts - 1 do
				local pt = group:Point(j)
				if not pt.fSelected then
					break
				else
					if j == groupPts - 1 then
						return group
					end
				end
			end
		end
	end
end

function LS_Shapes:CountSelectedGroups(mesh, strict) --(M_Mesh, bool?) int -- NOTE: Count selected groups. With strict, nothing else must be selected to count (TBC?)
	local count = 0
	if mesh ~= nil then
		for i = 0, mesh:CountGroups() - 1 do 
			local group = mesh:Group(i)
			if group.ls_fSelected == true then
				count = count + 1
			end
		end
	end
	return count
end

function LS_Shapes:GroupPointIDs(mesh, group) --(M_Mesh, M_PointGroup) tbl
	local ptTable = {}
	if mesh ~= nil and group ~= nil then
		local groupPts, pt = group:CountPoints(), nil
		for i = 0, groupPts - 1 do
			pt = group:Point(i)
			ptTable[i + 1] = math.floor(mesh:PointID(pt))
		end
	end
	return ptTable
end

function LS_Shapes:GroupByName(mesh, name)
	for i = 0, mesh:CountGroups() - 1 do
		local group = mesh:Group(i)
		if group and group:Name() == name then
			return group
		end
	end
	return nil
end

function LS_Shapes:MakeGroupNameUnique(mesh, id, jump) --(M_Mesh, int, int) void
	if (mesh ~= nil and id ~= nil and mesh:Group(id) ~= nil) then
		local count = 0 + (jump or 1)
		local baseName = mesh:Group(id):Name() -- Item's original name
		local newName = baseName -- Current name of the item, which goes updating
		local namesake = id
		local nameTaken = false
		for i = 0, mesh:CountGroups() - 1 do -- Check if the name is already taken by another item and, if so, pick that item's reference ID
			local group = mesh:Group(i)
			if group:Name() == baseName and i ~= id then
				namesake = i
				nameTaken = nameTaken == false and true
			end
		end
		if nameTaken and mesh:Group(namesake) ~= mesh:Group(id) then -- We check if there is another item with the current name, not with the original one
			while self:GroupByName(mesh, newName) do -- As long as there is another item with the current name and it's not the same as the one we are renaming...
				count = count + 1
				newName = baseName .. " " .. count -- We generate the new name using the original name and the counter
			end
		end
		mesh:Group(id).fName:Set(newName) -- We assign the new name to the item using the current name
	end
end

--[[20250815-0405: Simplified version, but differs from the other "NameUnique" functions, which well may deserve an update... (TBC)
function LS_Shapes:MakeGroupNameUnique(mesh, id, jump) --(M_Mesh, int, int) void
	if (mesh and id and mesh:Group(id)) then
		local baseName = mesh:Group(id):Name()
		local newName = baseName
		local count = jump or 2
		for i = 0, mesh:CountGroups() - 1 do
			if i ~= id and mesh:Group(i):Name() == newName then
				newName = baseName .. " " .. count
				count = count + 1
				i = -1 -- restart loop to recheck against all
			end
		end
		mesh:Group(id).fName:Set(newName)
	end
end
--]]

function LS_Shapes:GetGroupPoints(mesh, groupIndex) --(M_Mesh, int) tbl
	local ids = {}
	local group = mesh:Group(groupIndex)
	if group then
		for i = 0, group:CountPoints() - 1 do
			table.insert(ids, mesh:PointID(group:Point(i)))
		end
	end
	return ids
end

	--offset = offset or 1
	--local targetIdx = (dir < -1 and 0) or (dir > 1 and mesh:CountGroups() - 1) or idx + dir
	--if targetIdx < 0 or targetIdx >= mesh:CountGroups() then
		--return nil
	--end

function LS_Shapes:MoveGroup(mesh, idx, dir, offset) --(M_Mesh, int, int[-1:🔼,-2:⏫,1:🔽,2:⏬], int) int
	offset = offset or 1
	local count = mesh:CountGroups()
	if count < 2 then return nil end

	-- 🚩 Special K: moving to the top or bottom step by step
	if dir == -2 then
		while idx > 0 do
			idx = self:MoveGroup(mesh, idx, -1, 0) - 0 -- offset 0 to avoid accumulation
		end
		return idx + offset
	elseif dir == 2 then
		while idx < count - 1 do
			idx = self:MoveGroup(mesh, idx, 1, 0) - 0
		end
		return idx + offset
	end

	-- 🔄 Normal movement ±1 (direct swap)
	local targetIdx = idx + dir
	if targetIdx < 0 or targetIdx >= count then
		return nil
	end

	local nameA, nameB = mesh:Group(idx):Name(), mesh:Group(targetIdx):Name()
	local idsA, idsB = self:GetGroupPoints(mesh, idx), self:GetGroupPoints(mesh, targetIdx)
	if #idsA == 0 or #idsB == 0 then return targetIdx + offset end

	-- Overwrite group B with points from A
	mesh:SelectNone()
	mesh:Point(idsA[1]).fSelected = true
	mesh:AddGroup(nameB)
	local groupB = mesh:Group(targetIdx)
	for i = 2, #idsA do groupB:AddPointID(idsA[i]) end

	-- Overwrite group A with points from B
	mesh:SelectNone()
	mesh:Point(idsB[1]).fSelected = true
	mesh:AddGroup(nameA)
	local groupA = mesh:Group(idx)
	for i = 2, #idsB do groupA:AddPointID(idsB[i]) end

	--Exchange names
	groupA.fName:Set(nameB)
	groupB.fName:Set(nameA)

	return targetIdx + offset -- final index of the moved group
end

function LS_Shapes:CountCurves(moho, shape) --(moho, M_Shape) int
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

function LS_Shapes:IsSingleCurve(shape) --(M_Shape) bool
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

function LS_Shapes:MakeShapeNameUnique(mesh, id, jump) --(M_Mesh, int, int) void
	if (mesh ~= nil and id ~= nil and mesh:Shape(id) ~= nil) then
		local count = 0 + (jump or 1)
		local baseName = mesh:Shape(id):Name() -- Item's original name
		local newName = baseName -- Current name of the item, which goes updating
		local namesake = id
		for i = 0, mesh:CountShapes() - 1 do -- Check if the name is already taken by another item and, if so, pick that item's reference ID
			local shape = mesh:Shape(i)
			if shape:Name() == baseName and i ~= id then
				namesake = i
			end
		end
		if mesh:ShapeByName(newName) ~= nil and mesh:Shape(namesake) ~= mesh:Shape(id) then -- We check if there is another item with the current name, not with the original one
			while mesh:ShapeByName(newName) do -- As long as there is another item with the current name and it's not the same as the one we are renaming...
				count = count + 1
				newName = baseName .. " " .. count -- We generate the new name using the original name and the counter
			end
		end
		mesh:Shape(id):SetName(newName) -- We assign the new name to the item using the current name
	end
end

function LS_Shapes:IsSwatchLayer(moho, layer) --(MohoDoc, MohoLayer), bool
	return (layer and layer:LayerType() == MOHO.LT_VECTOR and moho:LayerAsVector(layer):Mesh():CountShapes() > 1) and not layer:IsRenderOnly()
end

--------------
-- MARK: UI --
--------------

function LS_Shapes:BuildLabel(t, sep) --(tbl|char, char) char
	sep = sep or " "
	if type(t) == "table" then
		t = table.concat(t, sep)
	end 
	return t
end --print(LS_Shapes:BuildLabel({"PREF", "NAME", "SUFF"}, ""))

function LS_Shapes:BuildStyleChoiceMenu(menu, doc, baseMsg, dummyMsg, exclude) --(LM_Menu, MohoDoc, MSG_BASE, int, int) void
	menu:RemoveAllItems()
	menu:AddItem(MOHO.Localize("/Windows/Style/None2=None"), 0, baseMsg) --‹› --¹ 
	if doc ~= nil then
		for i = 0, doc:CountStyles() - 1 do
			local styleName = tostring(doc:StyleByID(i).fName:Buffer()) or "?"
			local style = doc:StyleByID(i) -- NOTE: The swapped order is to get around the style becoming an LM_String bug!
			--local styleName = tostring(style.fName:Buffer())
			if (i ~= exclude and styleName ~= "") then
				if i == 0 then menu:AddItem("", 0, 0) end
				menu:AddItem(styleName, 0, baseMsg + 1 + i)
			end
		end
	end
end

--------------------
-- MARK: MATH/STR --
--------------------

function MOHO.bitpos(x) --(int) int
	return math.max(0, math.floor(math.log(x, 2)) + 1) --math.ceil(x / 2) --math.ceil(x / 2) or 1
end

function LS_Shapes:CompareVersion(a, b) --(char, char) int, int -- Sorting an array of semantic versions or SemVer (https://medium.com/geekculture/sorting-an-array-of-semantic-versions-in-typescript-55d65d411df2)
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
end --print(tostring(LS_Shapes:CompareVersion("13.5.6", "14.0")))

function LS_Shapes.BiasedRandom (prob, range, n) --(int, int, int) int
	return math.random () < prob and range or math.random(n + 1, range)
end

function LS_Shapes.Round(x, n) --(float, int) int
	return tonumber(string.format("%." .. (n or 0) .. "f", x))
end

function LS_Shapes.Abbreviator(s) --(char) char, int
	local num = 0
	local abrev = string.gsub(s, "%a+", function(w) if #w > 4 then num = num + 1 return string.sub(w, 1, 3) .. "." else return w end end)
	return abrev, num
end

function LS_Shapes.LineBreaker(s, numSpaces, sep) --(char, int, char) char
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

function LS_Shapes.List(t, a) --(tbl, {kind = int|char, indent = int, spacing = int}) char
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
end --Usage: print(LS_Shapes.List(fileLines, {kind = 1, indent = 8, spacing = 2}))

function string:replace(substring, replacement, n) --(char, char, ±int) char -- Plain bidirectional replacement (all characters are non-magic)
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

function LS_Shapes:Credits() --() char -- Currently using "CREDITS.txt"
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
	  
	        Copilot & ChatGPT?
	  
	]]

	return s
end --print(LS_Shapes:Credits())

function LS_Shapes:License(years, name, contact, company, id, width) --(char, char, char, char) char -- Currently using "LICENSE"
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
end --print(LS_Shapes:License(years))