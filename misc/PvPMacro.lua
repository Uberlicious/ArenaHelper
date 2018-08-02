--[[
	PvP Macro Setter
]]--

local selTalents = {}

function PvPMacro_GetIDs()
	tt = C_SpecializationInfo.GetPvpTalentSlotInfo(1)
	s1 = C_SpecializationInfo.GetPvpTalentSlotInfo(2)
	s2 = C_SpecializationInfo.GetPvpTalentSlotInfo(3)
	s3 = C_SpecializationInfo.GetPvpTalentSlotInfo(4)

	for i = 1,4 do
		if UnitLevel("player") >= C_SpecializationInfo.GetPvpTalentSlotUnlockLevel(i) then
			_, name, icon  = GetPvpTalentInfoByID(C_SpecializationInfo.GetPvpTalentSlotInfo(i).selectedTalentID)
			selTalents[i] = name
			print(name..": "..icon)
		end
	end
	for i,v in pairs(selTalents) do
		print(i)
		print(v)
	end
end

--gsub("string", "pattern", "rep", [maxReplaced])