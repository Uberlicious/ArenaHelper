local addon, ns = ...

--[[
	ArenaHelper Options Menu
]]--

local addon, ns = ...

Opt = {}

local SOUND_OFF = SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF
local SOUND_ON = SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON

local Options = CreateFrame("Frame", "ArenaHelperOptions", InterfaceOptionsFramePanelContainer)
Options.name = GetAddOnMetadata(addon, "Title") or addon
InterfaceOptions_AddCategory(Options)

function opt.ShowOptions()
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
			ArenaHelperDB.RESET = true
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

	--[[MarkParty Button]] 	local MarkParty = CreateFrame("Button", nil, SUI, "UIPanelButtonGrayTemplate")
	MarkParty:SetPoint("RIGHT", Title, "CENTER", 30, 0)
	MarkParty:SetWidth(125)
	MarkParty:SetHeight(30)
	MarkParty:SetText("Mark Party Members")

	MarkParty:SetScript(
		"OnClick",
		function(self, button, down)
			Options:Hide()
			PartyMark.markGroup()
		end
	)

	local help = CreateFrame("Button", nil, ArenaHelper, "UIPanelButtonTemplate")
	help:SetPoint("BOTTOMLEFT", ArenaHelper, "BOTTOMLEFT", 16, 30)
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

	local NameplateNumBtn = CreateFrame("CheckButton", "$parentGryphon", self, "InterfaceOptionsCheckButtonTemplate")
	NameplateNumBtn:SetPoint("TOPLEFT", SubText, "BOTTOMLEFT", 0, -12)
	NameplateNumBtn.Text:SetText("Show Gryphons")
	NameplateNumBtn.tooltipText = "Replate arena target nameplate names with target number."
	NameplateNumBtn:SetScript("OnClick", function(this)
		local checked = not not this:GetChecked()
		PlaySound(checked and SOUND_ON or SOUND_OFF)
		ArenaHelperDB.NameplateNum = checked
		if checked then
			DEFAULT_CHAT_FRAME:AddMessage("Arena Nameplate Numbers Enabled", 0, 1, 0)
			ArenaHelperDB.NameplateNum = true
			NameplateNum.Enable()
		else
			DEFAULT_CHAT_FRAME:AddMessage("Arena Nameplate Numbers Disabled", 0, 1, 0)
			ArenaHelperDB.NameplateNum = false
			NameplateNum.Disable()
		end
	end)

	local MaxDebuffsBtn = CreateFrame("CheckButton", "$parentHotkey", self, "InterfaceOptionsCheckButtonTemplate")
	MaxDebuffsBtn:SetPoint("TOPLEFT", NameplateNumBtn, "BOTTOMLEFT", 0, -12)
	MaxDebuffsBtn.Text:SetText("Increase Debuffs")
	MaxDebuffsBtn.tooltipText = "Increases debuffs shown on party members."
	MaxDebuffsBtn:SetScript("OnClick", function(this)
		local checked = not not this:GetChecked()
		PlaySound(checked and SOUND_ON or SOUND_OFF)
		ArenaHelperDB.MaxDebuffs = checked
		if checked then
			print("Enable")
			ArenaHelperDB.MaxDebuffs = true
		else
			ArenaHelperDB.MaxDebuffs = false
		end
	end)

	function self:refresh()
		Gryphon:SetChecked(UberuiDB.Gryphon)
		Hotkey:SetChecked(UberuiDB.Hotkey)
		Macroname:SetChecked(UberuiDB.Macroname)
	end

	self:refresh()
	self:SetScript("OnShow", nil)
end)

return Opt