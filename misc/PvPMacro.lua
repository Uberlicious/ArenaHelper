--[[
	PvP Macro Setter
]]--
local addon, ns = ...
PvPMacro = {}

local PvPMacro=CreateFrame("frame")
PvPMacro:RegisterEvent("PLAYER_TALENT_UPDATE")
PvPMacro:RegisterEvent("PLAYER_PVP_TALENT_UPDATE")
PvPMacro:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
PvPMacro:SetScript("OnEvent", function(self, event)
	if HelperCharDB.MacroHelper then
		PvPMacro_UpdateMacros()
	end

  if event == PLAYER_REGEN_ENABLED then
    PvPMacro_PLAYER_REGEN_ENABLED()
  end
end)

local function GetSelTalent(slot)
   	if type(tbl) ~= "table" then tbl = {} end
  	if UnitLevel("player") >= C_SpecializationInfo.GetPvpTalentSlotUnlockLevel(slot) then
    	local _, name, icon = GetPvpTalentInfoByID(C_SpecializationInfo.GetPvpTalentSlotInfo(slot).selectedTalentID)
      	return name, icon
   	end
end

local function GetAvailTalents(slot)
   	local tbl = {}
   	if UnitLevel("player") >= C_SpecializationInfo.GetPvpTalentSlotUnlockLevel(slot) then
      	ids  = C_SpecializationInfo.GetPvpTalentSlotInfo(slot).availableTalentIDs
      	for k,v in pairs(ids) do
         	_, name = GetPvpTalentInfoByID(v)
         	tbl[#tbl+1] = name
      	end
   	end
   	return tbl
end   
local function GetMacroNames(slot)
   	local tbl = {}
   	for m = 1, select(1, GetNumMacros()) do
      	local name = GetMacroInfo(m)
      	if HelperCharDB.MacroChar then
      		if string.find(name, "ptalc s"..(slot-1)) then
         	tbl[#tbl+1] = name
         	end
        else
        	if string.find(name, "ptal s"..(slot-1)) then
         	tbl[#tbl+1] = name
         	end
      	end
   	end
   	return tbl
end

function PvPMacro:PLAYER_REGEN_ENABLED()
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	PvPMacro_UpdateMacros()
end

function PvPMacro_UpdateMacros()
	SetCVar("scriptErrors", 1)
	local body = "#showtooltip\n/cast %s"
	if InCombatLockdown() then
		print("Unable to create macros while in combat!\nWaiting until combat is finished.")
		PvPMacro:RegisterEvent("PLAYER_REGEN_ENABLED")
		return
	end

  msgcount = 0
  if C_SpecializationInfo.GetPvpTalentSlotUnlockLevel(1) then
    for slot = 2,4 do
		  if UnitLevel("player") >= C_SpecializationInfo.GetPvpTalentSlotUnlockLevel(slot) then
   	  		local sTname, sTicon = GetSelTalent(slot)
   	  		local availTalents = GetAvailTalents(slot)
   	  		local macros = GetMacroNames(slot)
   	  		if next(macros) then
   	  			for _,name in pairs(macros) do
      			  	_, icon, body = GetMacroInfo(name)
      			  	if not string.find(body, "showtooltip") then
      			    	icon = nil
      			  	end
      			  	for k,v in pairs(availTalents) do
      			    	if string.find(body, v) then
      			        	if v ~= sTname then
      			           	body = string.gsub(body, v, sTname)
      			        	end
      			        	break
      			     	end
      			  	end
      			  	EditMacro(name, nil, sTicon , body)
   	  			end
   	  		else
   	  			if HelperCharDB.MacroChar and msgcount == 0 then
              local num = select(2, GetNumMacros())
              if num < 15 then
   	  				  CreateMacro("ptalc s"..(slot-1), sTicon, body:gsub("%%s", sTname))
              else
                print("|cffff0000Only "..(18-num).." macro slots available, need 3!")
                msgcount = msgcount + 1
              end
   	  			elseif msgcount == 0 then
              local num = select(1, GetNumMacros())
              if num  < 77 then
   	  				  CreateMacro("ptal s"..(slot-1), sTicon, body:gsub("%%s", sTname),nil)
              else
                print("|cffff0000Only "..(80-num).." macro slots available, need 3!")
                msgcount = msgcount + 1
              end
   	  			end
   	  		end
   	  	end
   	  end
   	  SetCVar("scriptErrors", 0)
    end
end