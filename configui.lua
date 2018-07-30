local addon, ns = ...

ArenaHelperDB = {}

local CF=CreateFrame("Frame")
CF:RegisterEvent("PLAYER_LOGIN")
CF:SetScript("OnEvent", function(self, event)

print("Welcome to |cff009cffArenaHelper|r use |CFFFE8A0E/arenahelper|r for Options.")

	--STANDARD CONFIG
	if ArenaHelperDB.RESET == nil then
		local function Defaults()
			ArenaHelperDB.RESET = true
			ArenaHelperDB.NameplateNum = true
			ArenaHelperDB.Gryphon = true
		end
		Defaults()
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

	--[[ Help ]] local function HELP()
		StaticPopupDialogs["HELP"] = {
			text = "Please report Errors on curseforge.com",
			button1 = "Close",
			button2 = "Reset UI",
			OnAccept = function()
				ArenaHelperSHOW()
			end,
			OnCancel = function()
				ArenaHelperDB.RESET = nil
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
	ArenaNameplateNumBtn:SetScript("OnClick", function(frame)
			local tick = frame:GetChecked()
			ArenaHelperDB.NameplateNum = tick
			if tick then
				NameplateNum:Enable()
				ArenaHelperDB.NameplateNum = true
			else
				NameplateNum:Disable()
				ArenaHelperDB.NameplateNum = false
			end
		end)
	ArenaNameplateNumBtn:SetScript("OnShow", function(frame)
			frame:SetChecked(ArenaHelperDB.NameplateNum)
		end)
	ArenaNameplateNumBtn:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
			GameTooltip:AddLine("Adds arena target number to enemy nameplates.", 248, 248, 255)
			GameTooltip:Show()
		end)
	ArenaNameplateNumBtn:SetScript("OnLeave", GameTooltip_Hide)

	local ArenaNameplateNumBtnText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	ArenaNameplateNumBtnText:SetPoint("LEFT", ArenaNameplateNumBtn, "RIGHT", 0, 1)
	ArenaNameplateNumBtnText:SetText("Arena Nameplate Num")
	
		--[[ Gryphon Test ]] local Gryphon = CreateFrame("CheckButton", nil, ArenaHelper, "OptionsBaseCheckButtonTemplate")
	Gryphon:SetPoint("TOPLEFT", UITitle, "BOTTOMLEFT", 0, -10)
	Gryphon:SetScript("OnClick", function(frame)
			local tick = frame:GetChecked()
			ArenaHelperDB.Gryphon = tick
			if tick then
				Gryphon:Enable()
				ArenaHelperDB.Gryphon = true
			else
				Gryphon:Disable()
				ArenaHelperDB.Gryphon = false
			end
		end)
	Gryphon:SetScript("OnShow", function(frame)
			frame:SetChecked(ArenaHelperDB.NameplateNum)
		end)
	Gryphon:SetScript("OnEnter", function(self)
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOM")
			GameTooltip:AddLine("Adds arena target number to enemy nameplates.", 248, 248, 255)
			GameTooltip:Show()
		end)
	Gryphon:SetScript("OnLeave", GameTooltip_Hide)

	local GryphonText = ArenaHelper:CreateFontString(nil, nil, "GameFontHighlight")
	GryphonText:SetPoint("LEFT", Gryphon, "RIGHT", 0, 1)
	GryphonText:SetText("Arena Nameplate Num")
end

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