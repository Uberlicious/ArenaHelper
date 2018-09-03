--[[
	PvP Macro Setter
]]--
local addon, ns = ...
PvPMacro = {}

local PvPMacro=CreateFrame("frame")
PvPMacro:RegisterEvent("PLAYER_TALENT_UPDATE")
PvPMacro:SetScript("OnEvent", function(self, event)
  self:BuildPvpTalentList()
  self:UpdateMacros()

  if event == PLAYER_REGEN_ENABLED then
    self:PLAYER_REGEN_ENABLED()
  end
end)

function PvPMacro:BuildPvpTalentList()
  if type(PvpTalDB) ~= "table" then PvpTalDB = {} end
    local pclass = UnitClass("player")
    local spec = GetSpecialization()
    local _, spname = GetSpecializationInfo(spec)
    if not PvpTalDB[pclass] then
      PvpTalDB[pclass] = {}
    end
    if PvpTalDB[pclass][spname] ~= "table" then
      PvpTalDB[pclass][spname] = {}
    end
    if UnitLevel("player") >= C_SpecializationInfo.GetPvpTalentSlotUnlockLevel(2) then
        ids  = C_SpecializationInfo.GetPvpTalentSlotInfo(2).availableTalentIDs
        for k,v in pairs(ids) do
          id, name = GetPvpTalentInfoByID(v)
          PvpTalDB[pclass][spname][id] = name
        end
    end
end 

local function GetSelTalent(slot)
   	if type(tbl) ~= "table" then tbl = {} end
  	if UnitLevel("player") >= C_SpecializationInfo.GetPvpTalentSlotUnlockLevel(slot) then
    	local _, name, icon = GetPvpTalentInfoByID(C_SpecializationInfo.GetPvpTalentSlotInfo(slot).selectedTalentID)
      	return name, icon
   	end
end

local function GetMacroNames(slot)
   	local tbl = {}
    mG, mC = GetNumMacros()
    if HelperCharDB.MacroChar then
       for m = 120, (120 + mC) do
          local name = GetMacroInfo(m)
          if name ~= nil and string.find(name, "ptalc s"..(slot-1)) then
             tbl[#tbl+1] = name
          end
       end
    else
       for m = 1, mG do
          local name = GetMacroInfo(m)
          if name ~= nil and string.find(name, "ptal s"..(slot-1)) then
             tbl[#tbl+1] = name
          end
       end
    end
   	return tbl
end

function PvPMacro:AvailableTalents()
  local pclass = UnitClass("player")
  local spec = GetSpecialization()
  local _, spname = GetSpecializationInfo(spec)

  local function initTals(tbl, saved)
    tbl = {}
    if HelperCharDB.MacroChar then
      for k,v in pairs(saved[pclass]) do
         for k2,v2 in pairs(v) do
            table.insert(tbl, v2)
         end
      end
    else
      for k,v in pairs(saved) do
        for k1,v1 in pairs(v) do
          for k2,v2 in pairs(v1) do
            table.insert(tbl,v2)
          end
        end
      end
    end
    return tbl
  end
  avail = initTals(tals, PvpTalDB)
  return avail
end


  

function PvPMacro:PLAYER_REGEN_ENABLED()
	self:UnregisterEvent("PLAYER_REGEN_ENABLED")
	PvPMacro_UpdateMacros()
end

function PvPMacro:UpdateMacros()
	local body = "#showtooltip\n/cast %s"
	if InCombatLockdown() then
		PvPMacro:RegisterEvent("PLAYER_REGEN_ENABLED")
		return
	end

  loopcount = 0
  msgcount = 0
  local pclass = UnitClass("player")
  local spec = GetSpecialization()
  local _, spname = GetSpecializationInfo(spec)
  local avail = self:AvailableTalents()
  if C_SpecializationInfo.GetPvpTalentSlotUnlockLevel(1) then
    for slot = 2,4 do
		  if UnitLevel("player") >= C_SpecializationInfo.GetPvpTalentSlotUnlockLevel(slot) then
   	  		local sTname, sTicon = GetSelTalent(slot)
   	  		local macros = GetMacroNames(slot)
   	  		if next(macros) then
   	  			for _,name in pairs(macros) do
              print(name)
      			  _, icon, body = GetMacroInfo(name)
      			  if string.find(body, "showtooltip") then
      			   icon = nil
      			  end
              for k,v in pairs(avail) do
                print(v)
      			   	if string.find(body, v) then
      			      	if v ~= sTname then
      			         	body = string.gsub(body, v, sTname)
                    --print("new: "..body)
      			      	end
      			      	break
      			    end
      			  end
              --print(body)
      			  EditMacro(name, nil, sTicon , body)
   	  			end
   	  		else
   	  			if HelperCharDB.MacroChar and msgcount == 0 then
              local _, num = GetNumMacros()
              print(num - 14)
              if (num - (14 - loopcount)) ~= 0 then
   	  				  CreateMacro("ptalc s"..(slot-1), sTicon, body:gsub("%%s", sTname),1)
              else
                print("|cffff0000Only "..(18-num).." macro slots available, need 3!")
                msgcount = msgcount + 1
              end
   	  			elseif msgcount == 0 then
              local num = GetNumMacros()
              if (num - (116 - loopcount)) ~= 0 then
   	  				  CreateMacro("ptal s"..(slot-1), sTicon, body:gsub("%%s", sTname),nil)
              else
                print("|cffff0000Only "..(120-num).." macro slots available, need 3!")
                msgcount = msgcount + 1
              end
   	  			end
        end
   	    loopcount = loopcount + 1
      end
    end
  end
end

ArenaHelper['PvPMacro'] = PvPMacro