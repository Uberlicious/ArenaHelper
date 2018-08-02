local addon, ns = ...

--local ArenaHelperDB = {}

HelperDB = {}

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
	local function initDB(def, tbl, saved)
		print("init")
		if type(def) ~= "table" then return {} end
		if type(tbl) ~= "table" then tbl = {} end
		if type(saved) ~= "table" then return {} end
		for k, v in pairs(def) do
		  if type(v) == "table" then
		    tbl[k] = initDB(v, tbl[k], saved[k])
		  elseif type(tbl[k]) ~= type(v) and saved[k] ~= nil then
			tbl[k] = saved[k]
		  elseif type(tbl[k]) ~= type(v) and saved[k] == nil then
		    tbl[k] = v
		  end
		end
		return tbl
	end
	HelperDB = initDB(defaults, HelperDB, ArenaHelperDB)
	self:UnregisterEvent("ADDON_LOADED")
end

function ArenaHelper:PLAYER_LOGOUT()
	local function updateSave(def, tbl, saved)
		for k,v in pairs(tbl) do
			if type(v) == "table" then
				saved[k] = updateSave(def[k], v, saved[k])
			elseif type(saved[k]) ~= type(v) and v ~= def[k] then
				saved[k] = v
			elseif type(saved[k]) ~= "table" and saved[k] == def[k] then
				saved[k] = nil
			end
		end
		return saved
	end
	ArenaHelperDB = initDB(defaults, HelperDB, ArenaHelperDB)
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

return HelperDB
