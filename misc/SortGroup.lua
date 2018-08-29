--[[
    Sort Group
]]--
local addon, ns = ...
<<<<<<< HEAD
SortGroup = {}
=======
local SorGroup = {}
local UpdateTable = {}

local internValues_DB = {
    showChatMessages = false, -- true when "PLAYER_ENTERING_WORLD" fired or cb Event gets triggered
    inCombat = false, -- true when "PLAYER_REGEN_DISABLED" fired    
    ddmItems = {}, -- ddm content
    GroupMembersOoC = 0
}
>>>>>>> eb55cd2d8aaebde695a51d8d66f21a4baf7d5092

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
    if not IsInRaid() and GetNumGroupMembers(raid) <= 5 then
        if HelperDB.SortTop then
            SortGroup_SortTop()
        elseif HelperDB.SortBot then
            SortGroup_SortBot()
        end
    end
<<<<<<< HEAD
    
=======

    --Frame Events
    if ( event == "PLAYER_REGEN_ENABLED" ) then
        internValues_DB.inCombat = false;
        internValues_DB.GroupMembersOoC = 0;
        for k, v in pairs(UpdateTable) do
            UpdateTable[k] = nil
            _G[v](_G[k])
        end
        if ( defaultValues_DB.AutoActivate == true or SortGroup_Variable_Page2_AdditionalSwitchActive == true ) then
            SortInterstation(true);
        else
            SortInterstation(false);
        end
    elseif ( event == "GROUP_ROSTER_UPDATE" ) then
        if ( defaultValues_DB.AutoActivate == true or SortGroup_Variable_Page2_AdditionalSwitchActive == true ) then
            SortInterstation(true);
        else
            SortInterstation(false);
        end
        if ( defaultValues_DB.ShowGroupMembersInCombat == true ) then
            if ( internValues_DB.inCombat == true ) then
                local cacheText = L["SortGroup_numberOfMembers_output"];
                cacheText = cacheText:gsub("'replacement'", GetNumGroupMembers());
                if ( (GetNumGroupMembers() - internValues_DB.GroupMembersOoC) > 0 ) then
                    cacheText = cacheText:gsub("'replacement2'", ColorText( (GetNumGroupMembers() - internValues_DB.GroupMembersOoC), "green" ) );
                elseif ( (GetNumGroupMembers() - internValues_DB.GroupMembersOoC) < 0 ) then
                    cacheText = cacheText:gsub("'replacement2'", ColorText( (GetNumGroupMembers() - internValues_DB.GroupMembersOoC), "red" ) );
                else
                    cacheText = cacheText:gsub("'replacement2'", (GetNumGroupMembers() - internValues_DB.GroupMembersOoC) );
                end
                print(ColorText(cacheText, "option"));
                --print("Actuall members: "..GetNumGroupMembers().." , displayed members: ".. (GetNumGroupMembers() - internValues_DB.GroupMembersOoC) );
            else
                internValues_DB.GroupMembersOoC = 0;
            end
        end
    end
>>>>>>> eb55cd2d8aaebde695a51d8d66f21a4baf7d5092
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

<<<<<<< HEAD
ArenaHelper.SortGroup = SortGroup
=======
>>>>>>> eb55cd2d8aaebde695a51d8d66f21a4baf7d5092
