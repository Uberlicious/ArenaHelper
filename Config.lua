local addon, ns = ...

--local ArenaHelperDB = {}

local ArenaHelper=CreateFrame("Frame")
ArenaHelper:SetScript("OnEvent", function(self, event, ...) return self[event] and self[event](self, ...) end)
ArenaHelper:RegisterEvent("ADDON_LOADED")
ArenaHelper:RegisterEvent("PLAYER_LOGIN")
ArenaHelper:RegisterEvent("PLAYER_LOGOUT")

print("Welcome to |cff009cffArenaHelper|r use |CFFFE8A0E/arenahelper|r for Options.")

defaults = {
	NameplateNum = true,
	MaxDebuffs = false,
}

function ArenaHelper:ADDON_LOADED()
	local function initDB(def, tbl)
		if type(def) ~= "table" then return {} end
		if type(tbl) ~= "table" then tbl = {} end
		if type(tbl) == "table" and tbl.reset then tbl = {} end
		for k,v in pairs(def) do
			if type(v) == "table" then
				tbl[k] = initDB(v, tbl[k])
			elseif type(tbl[k]) ~= type(v) then
				tbl[k] = v
			end
		end
		return tbl
	end
ArenaHelperDB = initDB(defaults, ArenaHelperDB)
end

--[[
	SLASH COMMANDS
]]--

SlashCmdList.ARENAHELPER = function(msg, editbox)
	msg = msg:lower()
	if msg == "options" then
		Opt_ShowOptions()
	elseif msg == "toggle" then
		PartyMark_toggleEventListeners()
	elseif msg == "mark" then
		PartyMark_markGroup()
	elseif msg == "pvp" then
		PvPMacro_GetIDs()
	elseif msg == "help" or msg ~= "true" then
		print("|cff009cffArenaHelper|r Help")
		print("Commands:")
		print("|CFFFE8A0E/options|r: Opens options window.")
		print("|CFFFE8A0E/mark|r: Mark group members.")
		print("|CFFFE8A0E/toggle|r: Toggle automatic marking mode.")
	end
end
SLASH_ARENAHELPER1 = "/arenahelper"
SLASH_ARENAHELPER2 = "/ah"

return ArenaHelperDB
