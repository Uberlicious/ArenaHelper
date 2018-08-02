--[[
	ArenaHelper Options Menu
]]--

local addon, ns = ...

local SOUND_OFF = SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF
local SOUND_ON = SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON

local Options = CreateFrame("Frame", "ArenaHelperOptions", InterfaceOptionsFramePanelContainer)
Options.name = GetAddOnMetadata(addon, "Title") or addon
InterfaceOptions_AddCategory(Options)

function Opt_ShowOptions()
	InterfaceOptionsFrame_OpenToCategory(Options)
end

--[[ Help ]] local function HELP()
	StaticPopupDialogs["HELP"] = {
		text = "Please report Errors on curseforge.com",
		button1 = "Close",
		button2 = "Reset to Defaults",
		OnAccept = function()
			self.ShowOptions()
		end,
		OnCancel = function()
			HelperDB_reset()
			ReloadUI()
		end,
		timeout = 0,
		whileDead = true,
		hideOnEscape = true,
		preferredIndex = 3
	}
	StaticPopup_Show("HELP")
end

Options:Hide()
Options:SetScript("OnShow", function(self)
	local Title = self:CreateFontString("$parentTitle", "ARTWORK", "GameFontNormalLarge")
	Title:SetPoint("TOPLEFT", 16, -16)
	Title:SetText(self.name)

	local SubText = self:CreateFontString("$parentSubText", "ARTWORK", "GameFontHighlightSmall")
	SubText:SetPoint("TOPLEFT", Title, "BOTTOMLEFT", 0, -8)
	SubText:SetPoint("RIGHT", -32, 0)
	SubText:SetHeight(32)
	SubText:SetJustifyH("LEFT")
	SubText:SetJustifyV("TOP")
	SubText:SetText("Useful PvP Tools.")

	--[[MarkParty Button]] 	local MarkParty = CreateFrame("Button", "$parentMarkParty" , self, "UIPanelButtonTemplate")
	MarkParty:SetPoint("LEFT", Title, "RIGHT", 30, 0)
	MarkParty:SetWidth(125)
	MarkParty:SetHeight(30)
	MarkParty:SetText("Mark Party")

	MarkParty:SetScript(
		"OnClick",
		function(self, button, down)
			ToggleGameMenu()
			PartyMark_markGroup()
		end
	)

	local help = CreateFrame("Button", "$parentHelp" , self, "UIPanelButtonTemplate")
	help:SetPoint("TOPRIGHT", MarkParty, "TOPRIGHT", 340, -525)
	help:SetWidth(100)
	help:SetHeight(25)
	help:SetText("Help & Reset")

	help:SetScript(
		"OnClick",
		function(self, button, down)
			Options:Hide()
			HELP()
		end
	)

	local NameplateNumBtn = CreateFrame("CheckButton", "$parentNameplateNumBtn", self, "InterfaceOptionsCheckButtonTemplate")
	NameplateNumBtn:SetPoint("TOPLEFT", SubText, "BOTTOMLEFT", 0, -12)
	NameplateNumBtn.Text:SetText("Show Arena Target Numberss")
	NameplateNumBtn.tooltipText = "Replate arena target nameplate names with target number."
	NameplateNumBtn:SetScript("OnClick", function(this)
		local checked = not not this:GetChecked()
		PlaySound(checked and SOUND_ON or SOUND_OFF)
		HelperDB.NameplateNum = checked
		if checked then
			DEFAULT_CHAT_FRAME:AddMessage("Arena Nameplate Numbers Enabled", 0, 1, 0)
			HelperDB.NameplateNum = true
			NameplateNum_Enabled()
		else
			DEFAULT_CHAT_FRAME:AddMessage("Arena Nameplate Numbers Disabled", 1, 0, 0)
			HelperDB.NameplateNum = false
		end
	end)

	local MaxDebuffsBtn = CreateFrame("CheckButton", "$parentHotkey", self, "InterfaceOptionsCheckButtonTemplate")
	MaxDebuffsBtn:SetPoint("TOPLEFT", NameplateNumBtn, "BOTTOMLEFT", 0, -12)
	MaxDebuffsBtn.Text:SetText("Increase Debuffs")
	MaxDebuffsBtn.tooltipText = "Increases debuffs shown on party members."
	MaxDebuffsBtn:SetScript("OnClick", function(this)
		local checked = not not this:GetChecked()
		PlaySound(checked and SOUND_ON or SOUND_OFF)
		HelperDB.MaxDebuffs = checked
		if checked then
			print("Enable")
			HelperDB.MaxDebuffs = true
		else
			HelperDB.MaxDebuffs = false
		end
	end)

	function self:refresh()
	end

	self:refresh()
	self:SetScript("OnShow", nil)
end)