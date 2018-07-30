--[[ArenaHelper Nameplate Num v1.0]]

local Gryphon = {}

local CF=CreateFrame("Frame")
CF:RegisterEvent("PLAYER_LOGIN")
CF:SetScript("OnEvent", function(self, event)

if AddonHelperDB.Gryphon then
	Gryphon:Enable()
else
	Gryphon:Disable()
end

function Gryphon:Enable()
	DEFAULT_CHAT_FRAME:AddMessage("Gryphon Enabled", 0, 1, 0)
	MainMenuBarArtFrame.LeftEndCap:Show()
	MainMenuBarArtFrame.RightEndCap:Show()
end

function Gryphon:Disable()
	DEFAULT_CHAT_FRAME:AddMessage("Gryphon Disabled", 0, 1, 0)
	MainMenuBarArtFrame.LeftEndCap:Hide()
	MainMenuBarArtFrame.RightEndCap:Hide()
end