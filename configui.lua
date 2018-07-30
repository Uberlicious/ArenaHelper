ArenaHelperDB = {}

local CF=CreateFrame("Frame")
CF:RegisterEvent("PLAYER_LOGIN")
CF:SetScript("OnEvent", function(self, event)

print("Welcome to |cff009cffArenaHelper|r use |CFFFE8A0E/arenahelper|r for Options.")

--STANDART CONFIG
	local function db()
		ArenaHelperDB.NameplateNum = true
	end
end

end) 

--ArenaHelper
local ArenaHelper = CreateFrame("Frame", "ArenaHelperConfig", UIParent, "ButtonFrameTemplate")
SetPortraitToTexture(ArenaHelper.portrait, "Interface\\Icons\\Inv_helmet_06")
ArenaHelper:SetSize(475, 605)
ArenaHelper:SetPoint("CENTER")
ArenaHelper:SetClampedToScreen(true)
ArenaHelper:EnableMouse(true)
ArenaHelper:SetMovable(true)
ArenaHelper:RegisterForDrag("LeftButton")
ArenaHelper:SetScript(
	"OnDragStart",
	function(self)
		self:StartMoving()
	end
)
ArenaHelper:SetScript(
	"OnDragStop",
	function(self)
		self:StopMovingOrSizing()
	end
)
ArenaHelper:Hide()

for i, v in pairs(
	{
		ArenaHelperConfigBg,
		ArenaHelperConfigTitleBg
	}
) do
	v:SetVertexColor(.40, .40, .40)
end

for i, v in pairs(
	{
		ArenaHelperConfigPortraitFrame,
		ArenaHelperConfigTopRightCorner,
		ArenaHelperConfigTopLeftCorner,
		ArenaHelperConfigBotRightCorner,
		ArenaHelperConfigBotLeftCorner,
		ArenaHelperConfigRightBorder,
		ArenaHelperConfigLeftBorder,
		ArenaHelperConfigTopBorder,
		ArenaHelperConfigBottomBorder,
		ArenaHelperConfigInsetInsetBottomBorder,
		ArenaHelperConfigInsetInsetBorderBottom,
		ArenaHelperConfigInsetInsetBotLeftCorner,
		ArenaHelperConfigInsetInsetBotRightCorner,
		ArenaHelperConfigInsetInsetLeftBorder,
		ArenaHelperConfigInsetInsetRightBorder,
		ArenaHelperConfigInsetInsetTopBorder,
		ArenaHelperConfigInsetInsetTopLeftCorner,
		ArenaHelperConfigInsetInsetTopRightCorner,
		ArenaHelperConfigBtnCornerRight,
		ArenaHelperConfigBtnCornerLeft,
		ArenaHelperConfigButtonBottomBorder
	}
) do
	v:SetVertexColor(.30, .30, .30)
end

--ArenaHelper SHOW
local function ArenaHelperSHOW()
	--Backdrop
	local backdrop = {
		bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background",
		edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
		tile = true,
		tileSize = 32,
		edgeSize = 32,
		insets = {
			left = 10,
			right = 10,
			top = 10,
			bottom = 10
		}
	}

	--[[ TargetCastbar ]] local function SETTOOLTIP()
		--FRAME
		local SETTOOLTIP = CreateFrame("Frame", "ToolTip", UIParent)
		SETTOOLTIP:SetSize(235, 145)
		SETTOOLTIP:SetPoint("CENTER")
		SETTOOLTIP:SetBackdrop(backdrop)
		SETTOOLTIP:SetBackdropBorderColor(0.5, 0.5, 0.5)

		local SETTOOLTIPTitle = SETTOOLTIP:CreateFontString(nil, nil, "GameFontNormalLarge")
		SETTOOLTIPTitle:SetPoint("TOP", 0, -16)
		SETTOOLTIPTitle:SetText("Tooltip Settings")

		--TOOLTIP X
		local SETTOOLTIPX = CreateFrame("EditBox", nil, SETTOOLTIP, "InputBoxTemplate")
		SETTOOLTIPX:SetPoint("CENTER", SETTOOLTIP, "CENTER", 45, 20)
		SETTOOLTIPX:SetWidth(100)
		SETTOOLTIPX:SetHeight(10)
		SETTOOLTIPX:SetAutoFocus(false)
		SETTOOLTIPX:Show()
		SETTOOLTIPX:SetText(ArenaHelperDB.TOOLTIPX)

		local SETTOOLTIPXText = SETTOOLTIP:CreateFontString(nil, nil, "GameFontHighlight")
		SETTOOLTIPXText:SetPoint("CENTER", SETTOOLTIPX, "LEFT", -60, 0)
		SETTOOLTIPXText:SetText("X Position")

		--TOOLTIP Y
		local SETTOOLTIPY = CreateFrame("EditBox", nil, SETTOOLTIP, "InputBoxTemplate")
		SETTOOLTIPY:SetPoint("CENTER", SETTOOLTIP, "CENTER", 45, -10)
		SETTOOLTIPY:SetWidth(100)
		SETTOOLTIPY:SetHeight(10)
		SETTOOLTIPY:SetAutoFocus(false)
		SETTOOLTIPY:Show()
		SETTOOLTIPY:SetText(ArenaHelperDB.TOOLTIPY)

		local SETTOOLTIPYText = SETTOOLTIP:CreateFontString(nil, nil, "GameFontHighlight")
		SETTOOLTIPYText:SetPoint("CENTER", SETTOOLTIPY, "LEFT", -60, 0)
		SETTOOLTIPYText:SetText("Y Position")

		--BUTTON
		local SETTOOLTIPButton = CreateFrame("Button", nil, SETTOOLTIP, "UIPanelButtonTemplate")
		SETTOOLTIPButton:SetPoint("BOTTOMLEFT", SETTOOLTIP, "BOTTOMLEFT", 20, 18)
		SETTOOLTIPButton:SetWidth(50)
		SETTOOLTIPButton:SetHeight(25)
		SETTOOLTIPButton:SetText("Save")

		SETTOOLTIPButton:SetScript(
			"OnClick",
			function(self, button, down)
				ArenaHelperDB.TOOLTIPX = (SETTOOLTIPX:GetText())
				ArenaHelperDB.TOOLTIPY = (SETTOOLTIPY:GetText())
				SETTOOLTIP:Hide()
				ArenaHelper:Show()
			end
		)
	end
	--

	--[[ Help ]] local function HELP()
		StaticPopupDialogs["HELP"] = {
			text = "Pls report Errors on curseforge.com",
			button1 = "Close",
			button2 = "Reset UI",
			OnAccept = function()
				ArenaHelperSHOW()
			end,
			OnCancel = function()
				ReloadUI()
			end,
			timeout = 0,
			whileDead = true,
			hideOnEscape = true,
			preferredIndex = 3
		}
		StaticPopup_Show("HELP")
	end
	--

	--[[ ArenaHelper ]] local title = ArenaHelper:CreateFontString(nil, nil, "GameFontNormalLarge")
	title:SetPoint("TOP", 0, -32)
	title:SetText("ArenaHelper Config v1")

	local help = CreateFrame("Button", nil, ArenaHelper, "UIPanelButtonTemplate")
	help:SetPoint("BOTTOMLEFT", ArenaHelper, "BOTTOMLEFT", 16, 30)
	help:SetWidth(100)
	help:SetHeight(25)
	help:SetText("Help & Reset")

	help:SetScript(
		"OnClick",
		function(self, button, down)
			ArenaHelper:Hide()
			HELP()
		end
	)

	-- UI
	local UITitle = ArenaHelper:CreateFontString(nil, nil, "GameFontNormalLarge")
	UITitle:SetPoint("TOPLEFT", 20, -75)
	UITitle:SetText("General")
	--

	--[[ NameplateNum ]] local ArenaNameplateNumBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	ArenaNameplateNumBtn:SetPoint("TOPLEFT", UITitle, "BOTTOMLEFT", 0, -10)
	ArenaNameplateNumBtn:SetScript(
		"OnClick",
		function(frame)
			local tick = frame:GetChecked()
			ArenaHelperDB.UNITFRAMES = tick
			if tick then
				NameplateNum:Enable()
				DEFAULT_CHAT_FRAME:AddMessage("Arena Nameplate Numbers Enabled", 0, 1, 0)
				ArenaHelperDB.UNITFRAMES = true
			else
				DEFAULT_CHAT_FRAME:AddMessage("Arena Nameplate Numbers Disabled", 1, 0, 0)
				ArenaHelperDB.UNITFRAMES = false
			end
		end
	)
	ArenaNameplateNumBtn:SetScript(
		"OnShow",
		function(frame)
			frame:SetChecked(ArenaHelperDB.UNITFRAMES)
		end
	)

	ArenaNameplateNumBtn:SetScript(
		"OnEnter",
		function(self)
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
			GameTooltip:AddLine("Adds arena target number to namesplates.", 248, 248, 255)
			GameTooltip:Show()
		end
	)
	ArenaNameplateNumBtn:SetScript("OnLeave", GameTooltip_Hide)

	--local ArenaNameplateNumBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--ArenaNameplateNumBtnText:SetPoint("LEFT", ArenaNameplateNumBtn, "RIGHT", 0, 1)
	--ArenaNameplateNumBtnText:SetText("Arena Nameplate Num")
	----
    --
	----[[ Cast Bars ]] local CustomCastbarsBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--CustomCastbarsBtn:SetPoint("TOPLEFT", ArenaNameplateNumBtn, "BOTTOMLEFT")
	--CustomCastbarsBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.CASTBARS = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("Castbars Enabled", 0, 1, 0)
	--			ArenaHelperDB.CASTBARS = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("Castbars Disabled", 1, 0, 0)
	--			ArenaHelperDB.CASTBARS = false
	--		end
	--	end
	--)
	--CustomCastbarsBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.CASTBARS)
	--	end
	--)
    --
	--CustomCastbarsBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("Custom Castbar design with Icons and Timers.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--CustomCastbarsBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local CustomCastbarsBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--CustomCastbarsBtnText:SetPoint("LEFT", CustomCastbarsBtn, "RIGHT", 0, 1)
	--CustomCastbarsBtnText:SetText("Custom Castbars")
	----
    --
	----[[ Hotkeys ]] local HotKeysBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--HotKeysBtn:SetPoint("TOPLEFT", CustomCastbarsBtn, "BOTTOMLEFT")
	--HotKeysBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.HOTKEYS = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("Hotkeys Enabled", 0, 1, 0)
	--			ArenaHelperDB.HOTKEYS = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("Hotkeys Disabled", 1, 0, 0)
	--			ArenaHelperDB.HOTKEYS = false
	--		end
	--	end
	--)
	--HotKeysBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.HOTKEYS)
	--	end
	--)
    --
	--HotKeysBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("Shows the Actionbar Hotkeys.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--HotKeysBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local HotKeysBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--HotKeysBtnText:SetPoint("LEFT", HotKeysBtn, "RIGHT", 0, 1)
	--HotKeysBtnText:SetText("Keys Text")
	----
    --
	----[[ Macro ]] local MacrosBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--MacrosBtn:SetPoint("TOPLEFT", HotKeysBtn, "BOTTOMLEFT")
	--MacrosBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.MACROS = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("Gryphones Enabled", 0, 1, 0)
	--			ArenaHelperDB.MACROS = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("Gryphones Disabled", 1, 0, 0)
	--			ArenaHelperDB.MACROS = false
	--		end
	--	end
	--)
	--MacrosBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.MACROS)
	--	end
	--)
    --
	--MacrosBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("Show Macro Text on Actionbars.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--MacrosBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local MacrosBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--MacrosBtnText:SetPoint("LEFT", MacrosBtn, "RIGHT", 0, 1)
	--MacrosBtnText:SetText("Macro Text")
	----
    --
	----[[ Gryphones ]] local GryphonesBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--GryphonesBtn:SetPoint("TOPLEFT", MacrosBtn, "BOTTOMLEFT")
	--GryphonesBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.GRYPHONES = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("Gryphones Enabled", 0, 1, 0)
	--			ArenaHelperDB.GRYPHONES = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("Gryphones Disabled", 1, 0, 0)
	--			ArenaHelperDB.GRYPHONES = false
	--		end
	--	end
	--)
	--GryphonesBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.GRYPHONES)
	--	end
	--)
    --
	--GryphonesBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("Shows Gryphones left and right of the Actionsbars.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--GryphonesBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local GryphonesBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--GryphonesBtnText:SetPoint("LEFT", GryphonesBtn, "RIGHT", 0, 1)
	--GryphonesBtnText:SetText("Gryphones")
	----
    --
	----[[ Chat ]] local CustomChatBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--CustomChatBtn:SetPoint("RIGHT", ArenaNameplateNumBtn, "RIGHT", 160, 0)
	--CustomChatBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.CHAT = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("Custom Chat Enabled", 0, 1, 0)
	--			ArenaHelperDB.CHAT = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("Custom Chat Disabled", 1, 0, 0)
	--			ArenaHelperDB.CHAT = false
	--		end
	--	end
	--)
	--CustomChatBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.CHAT)
	--	end
	--)
    --
	--CustomChatBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("Hide the chat buttons and moves the Friendlist down to the Bags.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--CustomChatBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local CustomChatBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--CustomChatBtnText:SetPoint("LEFT", CustomChatBtn, "RIGHT", 0, 1)
	--CustomChatBtnText:SetText("Custom Chat")
	----
    --
	----[[ Tooltip ]] local CustomTooltipBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--CustomTooltipBtn:SetPoint("TOPLEFT", CustomChatBtn, "BOTTOMLEFT")
	--CustomTooltipBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.TOOLTIP = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("Custom Tooltip Enabled", 0, 1, 0)
	--			ArenaHelperDB.TOOLTIP = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("Custom Tooltip Disabled", 1, 0, 0)
	--			ArenaHelperDB.TOOLTIP = false
	--		end
	--	end
	--)
	--CustomTooltipBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.TOOLTIP)
	--	end
	--)
    --
	--CustomTooltipBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("A custom Tooltip Design shows Guild Ranks etc.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--CustomTooltipBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local CustomTooltipBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--CustomTooltipBtnText:SetPoint("LEFT", CustomTooltipBtn, "RIGHT", 0, 1)
	--CustomTooltipBtnText:SetText("Custom Tooltip")
	----
    --
	----[[ Dark Frames ]] local DarkFramesBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--DarkFramesBtn:SetPoint("TOPLEFT", CustomTooltipBtn, "BOTTOMLEFT")
	--DarkFramesBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.DARKFRAMES = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("Dark Frames Enabled", 0, 1, 0)
	--			ArenaHelperDB.DARKFRAMES = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("Dark Frames Disabled", 1, 0, 0)
	--			ArenaHelperDB.DARKFRAMES = false
	--		end
	--	end
	--)
	--DarkFramesBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.DARKFRAMES)
	--	end
	--)
    --
	--DarkFramesBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("Skins the Interface Black or the color that you have selected.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--DarkFramesBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local DarkFramesBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--DarkFramesBtnText:SetPoint("LEFT", DarkFramesBtn, "RIGHT", 0, 1)
	--DarkFramesBtnText:SetText("Dark Frames")
	----
    --
	----[[ Range ]] local RangeBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--RangeBtn:SetPoint("TOPLEFT", DarkFramesBtn, "BOTTOMLEFT")
	--RangeBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.RANGE = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("Spell Range Enabled", 0, 1, 0)
	--			ArenaHelperDB.RANGE = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("Spell Range Disabled", 1, 0, 0)
	--			ArenaHelperDB.RANGE = false
	--		end
	--	end
	--)
	--RangeBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.RANGE)
	--	end
	--)
    --
	--RangeBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("When your Target is out of range the Actionsbar Buttons are Red.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--RangeBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local RangeBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--RangeBtnText:SetPoint("LEFT", RangeBtn, "RIGHT", 0, 1)
	--RangeBtnText:SetText("Spell Range")
	----
	--
	----[[ Textures ]] local TexturesBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--TexturesBtn:SetPoint("TOPLEFT", RangeBtn, "BOTTOMLEFT")
	--TexturesBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.TEXTURES = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("Textures Enabled", 0, 1, 0)
	--			ArenaHelperDB.TEXTURES = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("Textures Disabled", 1, 0, 0)
	--			ArenaHelperDB.TEXTURES = false
	--		end
	--	end
	--)
	--TexturesBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.TEXTURES)
	--	end
	--)
    --
	--TexturesBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("Modern Textures for Raid and UnitFrames.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--TexturesBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local TexturesBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--TexturesBtnText:SetPoint("LEFT", TexturesBtn, "RIGHT", 0, 1)
	--TexturesBtnText:SetText("Textures")
	----
    --
	----[[ Short Bar ]] local ShortBarBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--ShortBarBtn:SetPoint("RIGHT", CustomChatBtn, "RIGHT", 160, 0)
	--ShortBarBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.SHORTBAR = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("ShortBar Enabled", 0, 1, 0)
	--			ArenaHelperDB.SHORTBAR = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("ShortBar Disabled", 1, 0, 0)
	--			ArenaHelperDB.SHORTBAR = false
	--		end
	--	end
	--)
	--ShortBarBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.SHORTBAR)
	--	end
	--)
    --
	--ShortBarBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("Custom Actionsbar without Game menu.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--ShortBarBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local ShortBarBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--ShortBarBtnText:SetPoint("LEFT", ShortBarBtn, "RIGHT", 0, 1)
	--ShortBarBtnText:SetText("ShortBar")
	----
    --
	----[[ Buffs ]] local BuffsBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--BuffsBtn:SetPoint("TOPLEFT", ShortBarBtn, "BOTTOMLEFT")
	--BuffsBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.PARTYBUFFS = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("Big Party Buffs Enabled", 0, 1, 0)
	--			ArenaHelperDB.PARTYBUFFS = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("Big Party Buffs Disabled", 1, 0, 0)
	--			ArenaHelperDB.PARTYBUFFS = false
	--		end
	--	end
	--)
	--BuffsBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.PARTYBUFFS)
	--	end
	--)
    --
	--BuffsBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("Bigger Party Buffs.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--BuffsBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local BuffsBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--BuffsBtnText:SetPoint("LEFT", BuffsBtn, "RIGHT", 0, 1)
	--BuffsBtnText:SetText("PartyBuffs")
	----
    --
	----[[ OrderhallBar ]] local OrderhallBarBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--OrderhallBarBtn:SetPoint("TOPLEFT", BuffsBtn, "BOTTOMLEFT")
	--OrderhallBarBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.ORDERHALLBAR = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("OrderhallBar Enabled", 0, 1, 0)
	--			ArenaHelperDB.ORDERHALLBAR = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("OrderhallBar Disabled", 1, 0, 0)
	--			ArenaHelperDB.ORDERHALLBAR = false
	--		end
	--	end
	--)
	--OrderhallBarBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.ORDERHALLBAR)
	--	end
	--)
    --
	--OrderhallBarBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("Shows the Orderhallbar at the Top.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--OrderhallBarBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local OrderhallBarBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--OrderhallBarBtnText:SetPoint("LEFT", OrderhallBarBtn, "RIGHT", 0, 1)
	--OrderhallBarBtnText:SetText("OrderhallBar")
	----
    --
	----[[ TalkingHead ]] local TalkingHeadBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--TalkingHeadBtn:SetPoint("TOPLEFT", OrderhallBarBtn, "BOTTOMLEFT")
	--TalkingHeadBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.TALKINGHEAD = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("TalkingHead Enabled", 0, 1, 0)
	--			ArenaHelperDB.TALKINGHEAD = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("TalkingHead Disabled", 1, 0, 0)
	--			ArenaHelperDB.TALKINGHEAD = false
	--		end
	--	end
	--)
	--TalkingHeadBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.TALKINGHEAD)
	--	end
	--)
    --
	--TalkingHeadBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("Shows the Talkinghead over the Actionbar.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--TalkingHeadBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local TalkingHeadBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--TalkingHeadBtnText:SetPoint("LEFT", TalkingHeadBtn, "RIGHT", 0, 1)
	--TalkingHeadBtnText:SetText("TalkingHead")
	----
	--
	----[[ Only Bags ]] local BagsBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--BagsBtn:SetPoint("TOPLEFT", TalkingHeadBtn, "BOTTOMLEFT")
	--BagsBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.ONLYBAGS = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("Mini Menu Enabled", 0, 1, 0)
	--			ArenaHelperDB.ONLYBAGS = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("Mini Menu Disabled", 1, 0, 0)
	--			ArenaHelperDB.ONLYBAGS = false
	--		end
	--	end
	--)
	--BagsBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.ONLYBAGS)
	--	end
	--)
    --
	--BagsBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("Hide Bags and Micro Buttons.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--BagsBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local BagsBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--BagsBtnText:SetPoint("LEFT", BagsBtn, "RIGHT", 0, 1)
	--BagsBtnText:SetText("Mini Menu")
	----	
    --
	-----------------------
	----     MISCS       --
	-----------------------
    --
	--local ScriptsTitle = ArenaHelper:CreateFontString("ScriptsTitle", nil, "GameFontNormalLarge")
	--ScriptsTitle:SetPoint("TOPLEFT", GryphonesBtn, "BOTTOMLEFT", 0, -10)
	--ScriptsTitle:SetText("MISCS")
	----
    --
	----[[ Safequeue ]] local SafequeueBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--SafequeueBtn:SetPoint("TOPLEFT", ScriptsTitle, "BOTTOMLEFT", 0, -10)
	--SafequeueBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.SAFEQUEUE = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("Safequeue Enabled", 0, 1, 0)
	--			ArenaHelperDB.SAFEQUEUE = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("Safequeue Disabled", 1, 0, 0)
	--			ArenaHelperDB.SAFEQUEUE = false
	--		end
	--	end
	--)
	--SafequeueBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.SAFEQUEUE)
	--	end
	--)
    --
	--SafequeueBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("Shows Time left for joining the Arena when the Q pops.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--SafequeueBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local SafequeueBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--SafequeueBtnText:SetPoint("LEFT", SafequeueBtn, "RIGHT", 0, 1)
	--SafequeueBtnText:SetText("Safequeue")
	----
    --
	----[[ LoseControl ]] local LoseControlBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--LoseControlBtn:SetPoint("TOPLEFT", SafequeueBtn, "BOTTOMLEFT")
	--LoseControlBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.LOSECONTROL = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("LoseControl Enabled", 0, 1, 0)
	--			ArenaHelperDB.LOSECONTROL = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("LoseControl Disabled", 1, 0, 0)
	--			ArenaHelperDB.LOSECONTROL = false
	--		end
	--	end
	--)
	--LoseControlBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.LOSECONTROL)
	--	end
	--)
    --
	--LoseControlBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("Hides stuff from the PvP Losecontrol in the Middle of the Screen.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--LoseControlBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local LoseControlBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--LoseControlBtnText:SetPoint("LEFT", LoseControlBtn, "RIGHT", 0, 1)
	--LoseControlBtnText:SetText("LoseControl")
	----
    --
	----[[ TabBinder ]] local TabBinderBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--TabBinderBtn:SetPoint("TOPLEFT", LoseControlBtn, "BOTTOMLEFT")
	--TabBinderBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.TABBINDER = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("TabBinder Enabled", 0, 1, 0)
	--			ArenaHelperDB.TABBINDER = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("TabBinder Disabled", 1, 0, 0)
	--			ArenaHelperDB.TABBINDER = false
	--		end
	--	end
	--)
	--TabBinderBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.TABBINDER)
	--	end
	--)
    --
	--TabBinderBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("Change the Tabkey to Players only if you are in a PvP Zone.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--TabBinderBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local TabBinderBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--TabBinderBtnText:SetPoint("LEFT", TabBinderBtn, "RIGHT", 0, 1)
	--TabBinderBtnText:SetText("TabBinder")
	----
    --
	----[[ ShowRaid ]] local ShowRaidBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--ShowRaidBtn:SetPoint("TOPLEFT", TabBinderBtn, "BOTTOMLEFT")
	--ShowRaidBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.SHOWRAID = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("ShowRaid Enabled", 0, 1, 0)
	--			ArenaHelperDB.SHOWRAID = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("ShowRaid Disabled", 1, 0, 0)
	--			ArenaHelperDB.SHOWRAID = false
	--		end
	--	end
	--)
	--ShowRaidBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.SHOWRAID)
	--	end
	--)
    --
	--ShowRaidBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("Shows the Raidframe also when not in a Group.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--ShowRaidBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local ShowRaidBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--ShowRaidBtnText:SetPoint("LEFT", ShowRaidBtn, "RIGHT", 0, 1)
	--ShowRaidBtnText:SetText("ShowRaid")
	----
    --
	----[[ Hoverbind ]] local HoverBindBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--HoverBindBtn:SetPoint("RIGHT", SafequeueBtn, "RIGHT", 160, 0)
	--HoverBindBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.HOVERBIND = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("HoverBind Enabled", 0, 1, 0)
	--			ArenaHelperDB.HOVERBIND = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("Hoverbind Disabled", 1, 0, 0)
	--			ArenaHelperDB.HOVERBIND = false
	--		end
	--	end
	--)
	--HoverBindBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.HOVERBIND)
	--	end
	--)
    --
	--HoverBindBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("You can set Keybinds on the Actionsbar when you type /hb in the Chat.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--HoverBindBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local HoverBindBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--HoverBindBtnText:SetPoint("LEFT", HoverBindBtn, "RIGHT", 0, 1)
	--HoverBindBtnText:SetText("Hoverbind")
	----
    --
	----[[ Charlinks ]] local CharlinksBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--CharlinksBtn:SetPoint("TOPLEFT", HoverBindBtn, "BOTTOMLEFT")
	--CharlinksBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.CHARLINKS = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("Charlinks Enabled", 0, 1, 0)
	--			ArenaHelperDB.CHARLINKS = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("Charlinks Disabled", 1, 0, 0)
	--			ArenaHelperDB.CHARLINKS = false
	--		end
	--	end
	--)
	--CharlinksBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.CHARLINKS)
	--	end
	--)
    --
	--CharlinksBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("You have a Characterlinks Menu when you Rightclick a Target.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--CharlinksBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local CharlinksBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--CharlinksBtnText:SetPoint("LEFT", CharlinksBtn, "RIGHT", 0, 1)
	--CharlinksBtnText:SetText("Charlinks")
	----
    --
	----[[ ItemLevel ]] local ItemLevelBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--ItemLevelBtn:SetPoint("TOPLEFT", CharlinksBtn, "BOTTOMLEFT")
	--ItemLevelBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.ITEMLEVEL = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("Item Level Enabled", 0, 1, 0)
	--			ArenaHelperDB.ITEMLEVEL = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("Item Level Disabled", 1, 0, 0)
	--			ArenaHelperDB.ITEMLEVEL = false
	--		end
	--	end
	--)
	--ItemLevelBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.ITEMLEVEL)
	--	end
	--)
    --
	--ItemLevelBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("Shows the Itemlevel in the Character Menu.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--ItemLevelBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local ItemLevelBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--ItemLevelBtnText:SetPoint("LEFT", ItemLevelBtn, "RIGHT", 0, 1)
	--ItemLevelBtnText:SetText("ItemLevel")
    --
	----[[ InCombat ]]
	--local InCombatBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--InCombatBtn:SetPoint("TOPLEFT", ItemLevelBtn, "BOTTOMLEFT")
	--InCombatBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.INCOMBAT = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("InCombat Enabled", 0, 1, 0)
	--			ArenaHelperDB.INCOMBAT = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("InCombat Disabled", 1, 0, 0)
	--			ArenaHelperDB.INCOMBAT = false
	--		end
	--	end
	--)
	--InCombatBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.INCOMBAT)
	--	end
	--)
    --
	--InCombatBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("Shows a CombatIcon on the TargetFrame when the Target is in Combat.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--InCombatBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local InCombatBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--InCombatBtnText:SetPoint("LEFT", InCombatBtn, "RIGHT", 0, 1)
	--InCombatBtnText:SetText("InCombat")
	----
    --
	----[[ FriendList ]] local FriendListBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--FriendListBtn:SetPoint("RIGHT", HoverBindBtn, "RIGHT", 160, 0)
	--FriendListBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.FRIENDLIST = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("Friend Colors Enabled", 0, 1, 0)
	--			ArenaHelperDB.FRIENDLIST = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("Friend Colors Disabled", 1, 0, 0)
	--			ArenaHelperDB.FRIENDLIST = false
	--		end
	--	end
	--)
	--FriendListBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.FRIENDLIST)
	--	end
	--)
    --
	--FriendListBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("Friendlist Names colored by Class.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--FriendListBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local FriendListBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--FriendListBtnText:SetPoint("LEFT", FriendListBtn, "RIGHT", 0, 1)
	--FriendListBtnText:SetText("Friend Colors")
	----
    --
	----[[ SGrid ]] local SGridBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--SGridBtn:SetPoint("TOPLEFT", FriendListBtn, "BOTTOMLEFT")
	--SGridBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.SGRID = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("SGrid Enabled", 0, 1, 0)
	--			ArenaHelperDB.SGRID = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("SGrid Disabled", 1, 0, 0)
	--			ArenaHelperDB.SGRID = false
	--		end
	--	end
	--)
	--SGridBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.SGRID)
	--	end
	--)
    --
	--SGridBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("Type /sgrid + value 32/64/96/128.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--SGridBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local SGridBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--SGridBtnText:SetPoint("LEFT", SGridBtn, "RIGHT", 0, 1)
	--SGridBtnText:SetText("SGrid")
	----
    --
	----[[ Stats ]] local StatsBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--StatsBtn:SetPoint("TOPLEFT", SGridBtn, "BOTTOMLEFT")
	--StatsBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.STATS = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("Stats Enabled", 0, 1, 0)
	--			ArenaHelperDB.STATS = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("Stats Disabled", 1, 0, 0)
	--			ArenaHelperDB.STATS = false
	--		end
	--	end
	--)
	--StatsBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.STATS)
	--	end
	--)
    --
	--StatsBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("Shows MS/FPS at Bottomright of the Screen you can move it with Alt + Leftclick.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--StatsBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local StatsBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--StatsBtnText:SetPoint("LEFT", StatsBtn, "RIGHT", 0, 1)
	--StatsBtnText:SetText("FPS/MS")
	----
    --
	----[[ AutoRep ]] local AutoRepBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--AutoRepBtn:SetPoint("TOPLEFT", StatsBtn, "BOTTOMLEFT")
	--AutoRepBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.AUTOREP = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("AutoRep Enabled", 0, 1, 0)
	--			ArenaHelperDB.AUTOREP = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("AutoRep Disabled", 1, 0, 0)
	--			ArenaHelperDB.AUTOREP = false
	--		end
	--	end
	--)
	--AutoRepBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.AUTOREP)
	--	end
	--)
    --
	--AutoRepBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("Auto Repairs your Char when you open a Vendor.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--AutoRepBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local AutoRepBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--AutoRepBtnText:SetPoint("LEFT", AutoRepBtn, "RIGHT", 0, 1)
	--AutoRepBtnText:SetText("AutoRep")
	----
    --
	----[[ KeyPress ]] local KeyPressBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--KeyPressBtn:SetPoint("TOPLEFT", ShowRaidBtn, "BOTTOMLEFT")
	--KeyPressBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.KEYPRESS = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("KeyPress Enabled", 0, 1, 0)
	--			ArenaHelperDB.KEYPRESS = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("KeyPress Disabled", 1, 0, 0)
	--			ArenaHelperDB.KEYPRESS = false
	--		end
	--	end
	--)
	--KeyPressBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.KEYPRESS)
	--	end
	--)
    --
	--KeyPressBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("KeyPress shows Visual Effects on the Button that you press on the Actionbar.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--KeyPressBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local KeyPressBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--KeyPressBtnText:SetPoint("LEFT", KeyPressBtn, "RIGHT", 0, 1)
	--KeyPressBtnText:SetText("KeyPress")
    --
	----[[ Skins ]]
	--local SkinsBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--SkinsBtn:SetPoint("TOPLEFT", InCombatBtn, "BOTTOMLEFT")
	--SkinsBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.SKINS = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("Skins Enabled", 0, 1, 0)
	--			ArenaHelperDB.SKINS = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("Skins Disabled", 1, 0, 0)
	--			ArenaHelperDB.SKINS = false
	--		end
	--	end
	--)
	--SkinsBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.SKINS)
	--	end
	--)
    --
	--SkinsBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("Skins All Frames Black.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--SkinsBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local SkinsBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--SkinsBtnText:SetPoint("LEFT", SkinsBtn, "RIGHT", 0, 1)
	--SkinsBtnText:SetText("Skins Beta!")
    --
	----[[ EasyDelete ]]
	--local EasyDelteBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--EasyDelteBtn:SetPoint("TOPLEFT", AutoRepBtn, "BOTTOMLEFT")
	--EasyDelteBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.EASYDELETE = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("EasyDelete Enabled", 0, 1, 0)
	--			ArenaHelperDB.EASYDELETE = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("EasyDelete Disabled", 1, 0, 0)
	--			ArenaHelperDB.EASYDELETE = false
	--		end
	--	end
	--)
	--EasyDelteBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.EASYDELETE)
	--	end
	--)
    --
	--EasyDelteBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("When you delete a Item you can just cofirme without typing delete.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--EasyDelteBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local EasyDelteBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--EasyDelteBtnText:SetPoint("LEFT", EasyDelteBtn, "RIGHT", 0, 1)
	--EasyDelteBtnText:SetText("EasyDelete")
    --
	-----------------------
	----    ANNOUNCE     --
	-----------------------
    --
	--local AnnounceTitle = ArenaHelper:CreateFontString("AnnounceTitle", nil, "GameFontNormalLarge")
	--AnnounceTitle:SetPoint("TOPLEFT", ShowRaidBtn, "BOTTOMLEFT", 0, -35)
	--AnnounceTitle:SetText("ANNOUNCE")
	----
    --
	----[[ Interrupt ]] local InterruptBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--InterruptBtn:SetPoint("TOPLEFT", AnnounceTitle, "BOTTOMLEFT", 0, -10)
	--InterruptBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.INTERRUPT = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("Interrupt Enabled", 0, 1, 0)
	--			ArenaHelperDB.INTERRUPT = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("Interrupt Disabled", 1, 0, 0)
	--			ArenaHelperDB.INTERRUPT = false
	--		end
	--	end
	--)
	--InterruptBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.INTERRUPT)
	--	end
	--)
    --
	--InterruptBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("Announce your Interrupts in the Chat.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--InterruptBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local InterruptBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--InterruptBtnText:SetPoint("LEFT", InterruptBtn, "RIGHT", 0, 1)
	--InterruptBtnText:SetText("Interrupt")
	----
    --
	----[[ PullTimer ]] local PullTimerBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--PullTimerBtn:SetPoint("TOPLEFT", InterruptBtn, "BOTTOMLEFT")
	--PullTimerBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.AUTOREP = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("PullTimer Enabled", 0, 1, 0)
	--			ArenaHelperDB.PULLTIMER = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("PullTimer Disabled", 1, 0, 0)
	--			ArenaHelperDB.PULLTIMER = false
	--		end
	--	end
	--)
	--PullTimerBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.PULLTIMER)
	--	end
	--)
    --
	--PullTimerBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine("Shows a Pulltimer when someone starts a Timer with DBM or Bigwigs.", 248, 248, 255)
	--		GameTooltip:Show()
	--	end
	--)
	--PullTimerBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local PullTimerBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--PullTimerBtnText:SetPoint("LEFT", PullTimerBtn, "RIGHT", 0, 1)
	--PullTimerBtnText:SetText("PullTimer")
    --
	-----------------------
	----    FIXEs        --
	-----------------------
    --
	--local FIXESTitle = ArenaHelper:CreateFontString("FIXESTitle", nil, "GameFontNormalLarge")
	--FIXESTitle:SetPoint("TOPLEFT", PullTimerBtn, "BOTTOMLEFT", 0, -10)
	--FIXESTitle:SetText("Disable")
	----
    --
	----[[ Raidframe FIX ]] local RaidFrameFixBtn = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	--RaidFrameFixBtn:SetPoint("TOPLEFT", FIXESTitle, "BOTTOMLEFT", 0, -10)
	--RaidFrameFixBtn:SetScript(
	--	"OnClick",
	--	function(frame)
	--		local tick = frame:GetChecked()
	--		ArenaHelperDB.RAIDFRAMEFIX = tick
	--		if tick then
	--			DEFAULT_CHAT_FRAME:AddMessage("RaidFrameFix Enabled", 0, 1, 0)
	--			ArenaHelperDB.RAIDFRAMEFIX = true
	--		else
	--			DEFAULT_CHAT_FRAME:AddMessage("RaidFrameFix Disabled", 1, 0, 0)
	--			ArenaHelperDB.RAIDFRAMEFIX = false
	--		end
	--	end
	--)
	--RaidFrameFixBtn:SetScript(
	--	"OnShow",
	--	function(frame)
	--		frame:SetChecked(ArenaHelperDB.RAIDFRAMEFIX)
	--	end
	--)
    --
	--RaidFrameFixBtn:SetScript(
	--	"OnEnter",
	--	function(self)
	--		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
	--		GameTooltip:AddLine(
	--			"This is a Fix for the bug when someone leaves the Raid while you are in Combat, but it causing some other Errors i will look into it.",
	--			248,
	--			248,
	--			255
	--		)
	--		GameTooltip:Show()
	--	end
	--)
	--RaidFrameFixBtn:SetScript("OnLeave", GameTooltip_Hide)
    --
	--local RaidFrameFixBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	--RaidFrameFixBtnText:SetPoint("LEFT", RaidFrameFixBtn, "RIGHT", 0, 1)
	--RaidFrameFixBtnText:SetText("RaidFrame")
    --
	--ArenaHelper:Show()
end
--

local activ = false
--[[ Slash Handler ]] SlashCmdList["ArenaHelper"] = function()
	if activ == false then
	ArenaHelperSHOW()
	activ = true
	else
	ArenaHelper:Show()
	end
end
SLASH_ArenaHelper1 = "/ArenaHelper"
