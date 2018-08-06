--[[
	Arena Helper Configuration
	Author: Uberlicious2188
]]--

local addon, ns = ...

HelperDB = {}

local ArenaHelper=CreateFrame("Frame")
ArenaHelper:SetScript("OnEvent", function(self, event, ...) return self[event] and self[event](self, ...) end)
ArenaHelper:RegisterEvent("ADDON_LOADED")
ArenaHelper:RegisterEvent("PLAYER_LOGIN")
ArenaHelper:RegisterEvent("PLAYER_LOGOUT")

print("Welcome to |cff009cffArenaHelper|r use |CFFFE8A0E/arenahelper|r for Options.")

local defaults = {
	NameplateNum = true,
	MaxDebuffs = false,
	MacroHelper = false,
}

-- On Addon Loaded build tempDB with Defaults and Saved Variables
function ArenaHelper:ADDON_LOADED()
	local function initDB(def, tbl, saved)
		if type(def) ~= "table" then return {} end
		if type(tbl) ~= "table" then tbl = {} end
		if type(saved) ~= "table" then return {} end
		for k, v in pairs(def) do
		  if type(v) == "table" then
		    tbl[k] = initDB(v, tbl[k], saved[k])
		  elseif type(tbl[k]) ~= type(v) and saved[k] ~= nil then -- If saved value exists use it
			tbl[k] = saved[k]
		  elseif type(tbl[k]) ~= type(v) and saved[k] == nil then -- If saved value does not exist use default
		    tbl[k] = v
		  end
		end
		return tbl
	end
	HelperDB = initDB(defaults, HelperDB, ArenaHelperDB)
	self:UnregisterEvent("ADDON_LOADED")
end

-- On Logout Save variables that are not default
function ArenaHelper:PLAYER_LOGOUT()
	local function updateSave(def, tbl, saved)
		for k,v in pairs(tbl) do
			if type(v) == "table" then
				saved[k] = updateSave(def[k], v, saved[k])
			elseif type(saved[k]) ~= type(v) and v ~= def[k] then -- If temp value does not equal the default, save it
				saved[k] = v
			elseif type(saved[k]) ~= "table" and v == def[k] and saved[k] ~= def[k] then -- Unset saved value if temp == default and saved value exists
				saved[k] = nil
			elseif type(saved[k]) ~= "table" and saved[k] == def[k] then -- Cleanup if save value happens to == default
				saved[k] = nil
			end
		end
		for k,v in pairs(saved) do
			if type(v) == "table" then
				saved[k] = updateSave(def[k], tbl[k], saved)
			elseif type(saved[k]) ~= "table" and v ~= def[k] and v ~= tbl[k] then
				saved[k] = nil
			end
		end
		return saved
	end
	ArenaHelperDB = updateSave(defaults, HelperDB, ArenaHelperDB)
end

-- Reset the Temp DB to Defaults
function HelperDB_reset()
	local function dbreset(def, tbl)
		if type(def) ~= "table" then return {} end
		if type(tbl) ~= "table" then tbl = {} end
		for k,v in pairs(def) do
			if type(v) == "table" then
				tbl[k] = dbreset(v, tbl[k])
			elseif type(tbl[k]) ~= "table" then
				tbl[k] = v
			end
		end
		return tbl
	end
	HelperDB = dbreset(Defaults, LocalDB)
end

--[[
	SLASH COMMANDS
]]--

SlashCmdList.ARENAHELPER = function(msg, editbox)
	msg = msg:lower()
	if msg == "options" then
		Opt_ShowOptions()
	elseif msg == "mark" then
		PartyMark_markGroup()
	elseif msg == "toggle" then
		PartyMark_toggleEventListeners()
	elseif msg == "pvp" then
		PvPMacro_UpdateMacros()
	elseif msg == "help" or msg ~= "true" then
		print("|cff009cffArenaHelper|r Help")
		print("Commands:")
		print("|CFFFE8A0E/options|r: Opens options window.")
		print("|CFFFE8A0E/ah mark|r: Mark group members.")
		print("|CFFFE8A0E/ah toggle|r: Toggle automatic marking mode.")
		print("|CFFFE8A0E/ah pvp: Force update Macros (will also set icon).")
	end
end
SLASH_ARENAHELPER1 = "/arenahelper"
SLASH_ARENAHELPER2 = "/ah"