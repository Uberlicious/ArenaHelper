﻿--[[
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
			Opt_ShowOptions()
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

	local CreateMacros = CreateFrame("Button", "$parentHelp" , self, "UIPanelButtonTemplate")
	CreateMacros:SetPoint("RIGHT", help, "LEFT", -12, 0)
	CreateMacros:SetWidth(100)
	CreateMacros:SetHeight(25)
	CreateMacros:SetText("Create Macros")

	CreateMacros:SetScript(
		"OnClick",
		function(self, button, down)
			PvPMacro_UpdateMacros()
			DEFAULT_CHAT_FRAME:AddMessage("Macros Created", 0, 1, 0)
		end
	)

	local NameplateNumBtn = CreateFrame("CheckButton", "$parentNameplateNumBtn", self, "InterfaceOptionsCheckButtonTemplate")
	NameplateNumBtn:SetPoint("TOPLEFT", SubText, "BOTTOMLEFT", 0, -12)
	NameplateNumBtn.Text:SetText("Show Arena Target Numberss")
	NameplateNumBtn.tooltipText = "Replate arena target nameplate names with target number."
	NameplateNumBtn:SetScript("OnClick", function(this)
		local checked = this:GetChecked()
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

	local MaxDebuffsBtn = CreateFrame("CheckButton", "$parentMaxDebuffsBtn", self, "InterfaceOptionsCheckButtonTemplate")
	MaxDebuffsBtn:SetPoint("TOPLEFT", NameplateNumBtn, "BOTTOMLEFT", 0, -12)
	MaxDebuffsBtn.Text:SetText("Increase Debuffs")
	MaxDebuffsBtn.tooltipText = "Increases debuffs shown on party members."
	MaxDebuffsBtn:SetScript("OnClick", function(this)
		local checked = this:GetChecked()
		PlaySound(checked and SOUND_ON or SOUND_OFF)
		HelperDB.MaxDebuffs = checked
		if checked then
			DEFAULT_CHAT_FRAME:AddMessage("Increased Debuffs Enabled", 0, 1, 0)
			HelperDB.MaxDebuffs = true
		else
			DEFAULT_CHAT_FRAME:AddMessage("Increased Debuffs Disabled", 1, 0, 0)
			HelperDB.MaxDebuffs = false
		end
	end)

	local MacroHelperBtn = CreateFrame("CheckButton", "$parentMacroHelperBtn", self, "InterfaceOptionsCheckButtonTemplate")
	MacroHelperBtn:SetPoint("TOPLEFT", MaxDebuffsBtn, "BOTTOMLEFT", 0, -12)
	MacroHelperBtn.Text:SetText("Macro Helper")
	MacroHelperBtn.tooltipText = "Make and manage macros for pvp talents.\n\nTalents will start with the name \"ptal s%n\" (ex. slot 1). Multiple talents can be created and managed for a single slot.\n\nCharacter Specific"
	MacroHelperBtn:SetScript("OnClick", function(this)
		local checked = this:GetChecked()
		PlaySound(checked and SOUND_ON or SOUND_OFF)
		HelperCharDB.MacroHelper = checked
		if checked then
			DEFAULT_CHAT_FRAME:AddMessage("Macro Helper Enabled", 0, 1, 0)
		else
			DEFAULT_CHAT_FRAME:AddMessage("Macro Helper Disabled", 1, 0, 0)
		end
	end)

	local MacroCharSpecBtn = CreateFrame("CheckButton", "$parentMacroCharSpecBtn", self, "InterfaceOptionsCheckButtonTemplate")
	MacroCharSpecBtn:SetPoint("TOPLEFT", MacroHelperBtn, "BOTTOMLEFT", 17, 0)
	MacroCharSpecBtn.Text:SetText("Character Specific")
	MacroCharSpecBtn.tooltipText = "Make macros character specific?"
	MacroCharSpecBtn:SetScript("OnClick", function(this)
		local checked = this:GetChecked()
		PlaySound(checked and SOUND_ON or SOUND_OFF)
		HelperCharDB.MacroChar = checked
	end)

	local SortTopBtn = CreateFrame("CheckButton", "$parentSortTopBtn", self, "InterfaceOptionsCheckButtonTemplate")
	SortTopBtn:SetPoint("TOPLEFT", MacroCharSpecBtn, "BOTTOMLEFT", -17, -12)
	SortTopBtn.Text:SetText("Sort Group Player Top")
	SortTopBtn.tooltipText = "Sorts raid style part frames with yourself at the top at all times when not in a raid with more than 5 people."
	SortTopBtn:SetScript("OnClick", function(this)
		local checked = this:GetChecked()
		PlaySound(checked and SOUND_ON or SOUND_OFF)
		HelperDB.SortTop = checked
		if checked then
			HelperDB.SortBot = false
			SortGroup_SortTop()
			self:refresh()
			DEFAULT_CHAT_FRAME:AddMessage("Group sorting player top enabled.", 0, 1, 0)
		else
			SortGroup_SortTop()
			DEFAULT_CHAT_FRAME:AddMessage("Group sorting player bottom enabled.", 1, 0, 0)
		end
	end)

	local SortBotBtn = CreateFrame("CheckButton", "$parentSortBotBtn", self, "InterfaceOptionsCheckButtonTemplate")
	SortBotBtn:SetPoint("TOPLEFT", SortTopBtn, "BOTTOMLEFT", 17, 0)
	SortBotBtn.Text:SetText("Sort Group Player Bottom")
	SortBotBtn.tooltipText = "Sorts raid style part frames with yourself at the bottom at all times when not in a raid with more than 5 people."
	SortBotBtn:SetScript("OnClick", function(this)
		local checked = this:GetChecked()
		PlaySound(checked and SOUND_ON or SOUND_OFF)
		HelperDB.SortBot = checked
		if checked then
			HelperDB.SortTop = false
			SortGroup_SortBot()
			self:refresh()
			DEFAULT_CHAT_FRAME:AddMessage("Group sorting player bottom enabled.", 0, 1, 0)
		else
			SortGroup_SortBot()
			DEFAULT_CHAT_FRAME:AddMessage("Group sorting player bottom enabled.", 1, 0, 0)
		end
	end)

	function self:refresh()
		NameplateNumBtn:SetChecked(HelperDB.NameplateNum)
		MaxDebuffsBtn:SetChecked(HelperDB.MaxDebuffs)
		MacroHelperBtn:SetChecked(HelperCharDB.MacroHelper)
		MacroCharSpecBtn:SetChecked(HelperCharDB.MacroChar)
		SortTopBtn:SetChecked(HelperDB.SortTop)
		SortBotBtn:SetChecked(HelperDB.SortBot)
	end

	self:refresh()
	self:SetScript("OnShow", nil)
end)