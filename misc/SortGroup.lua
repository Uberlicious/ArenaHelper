--[[
    Sort Group
]]--
local addon, ns = ...
SorGroup = {}

local SortGroup = CreateFrame("frame")
SortGroup:RegisterEvent("ADDON_LOADED")
SortGroup:RegisterEvent("COMPACT_UNIT_FRAME_PROFILES_LOADED")
SortGroup:RegisterEvent("PLAYER_ENTERING_WORLD")
SortGroup:RegisterEvent("PLAYER_LOGOUT")
SortGroup:RegisterEvent("PLAYER_REGEN_DISABLED")
SortGroup:RegisterEvent("PLAYER_REGEN_ENABLED")
SortGroup:RegisterEvent("GROUP_ROSTER_UPDATE")
SortGroup:SetScript("OnEvent", function(self,event)
    local Partyraid = GetCVar("useCompactPartyFrames")
    if HelperDB.SortTop then
        SortGroup_SortTop()
    elseif HelperDB.SortBot then
        SortGroup_SortBot()
    end
end)

function SortGroup_SortTop()
    if Partyraid ~= 1 then
        SetCVar("useCompactPartyFrames", 1)
    end
    LoadAddOn("CompactRaidFrameContainer");
    local CRFSort_TopDownwards = function(t1, t2)
        if UnitIsUnit(t1, "player") then
            return true;
        elseif UnitIsUnit(t2, "player") then
            return false;
        else
            return t1 < t2;
        end
    end
    CompactRaidFrameContainer_SetFlowSortFunction(CompactRaidFrameContainer, CRFSort_TopDownwards)
end

function SortGroup_SortBot()
    if Partyraid ~= 1 then
        SetCVar("useCompactPartyFrames", 1)
    end
    LoadAddOn("CompactRaidFrameContainer");
    local CRFSort_BottomUpwards = function(t1, t2)
        if UnitIsUnit(t1, "player") then
            return false;
        elseif UnitIsUnit(t2, "player") then
            return true;
        else
            return t1 > t2;
        end
    end
    CompactRaidFrameContainer_SetFlowSortFunction(CompactRaidFrameContainer, CRFSort_BottomUpwards)
end