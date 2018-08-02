--[[Party Mark Num v1.0]]
local addon, ns = ...
local PartyMark

local usedMarkers = {false, false, false, false, false, false, false, false}

-- 1 Star
-- 2 Circle
-- 3 Diamond
-- 4 Triangle
-- 5 Moon
-- 6 Square
-- 7 Cross
-- 8 Skull
local markers = {
    DRUID       = {2, 5, 7, 1},
    HUNTER      = {4, 2, 3, 5},
    MAGE        = {6, 5, 3, 1},
    PALADIN     = {3, 2, 1, 7},
    PRIEST      = {5, 6, 3, 1},
    ROGUE       = {1, 2, 5, 3},
    SHAMAN      = {6, 5, 3, 7},
    WARLOCK     = {3, 7, 4, 5},
    WARRIOR     = {2, 1, 4, 5},
    DEATHKNIGHT = {7, 3, 2, 5},
    MONK        = {4, 2, 3, 6},
    DEMONHUNTER = {3, 7, 6, 2}
};

local function resetUsedMarkers()
    usedMarkers[1] = false
    usedMarkers[2] = false
    usedMarkers[3] = false
    usedMarkers[4] = false
    usedMarkers[5] = false
    usedMarkers[6] = false
    usedMarkers[7] = false
    usedMarkers[8] = false
end

-- Helper function for marking
local function setTargetMarker(unit)
    local class, classFileName = UnitClass(unit)
    for i=1,4 do
        if not usedMarkers[markers[classFileName][i]] then
            SetRaidTarget(unit, markers[classFileName][i])
            usedMarkers[markers[classFileName][i]] = true
            break
        end
    end
end


-- mark entire group
function PartyMark_markGroup()
    resetUsedMarkers()
    setTargetMarker("player")
    for p=1,GetNumGroupMembers()-1 do
        setTargetMarker("party"..p)
    end
end

-- Auto marking mode
local PartyMark = CreateFrame("FRAME", "EasyPartyMarkersFrame");
local listening = false
local function eventHandler(self, event, arg1, ...)
    PartyMark.markGroup()
end

PartyMark:SetScript("OnEvent", eventHandler);

function PartyMark_toggleEventListeners()
    if listening then
        print("Deactivated auto marking mode");
        PartyMark:UnregisterEvent("GROUP_ROSTER_UPDATE");
        PartyMark:UnregisterEvent("PLAYER_LEAVE_COMBAT");
        listening = false
    else
        print("Activated auto marking mode");
        PartyMark:RegisterEvent("GROUP_ROSTER_UPDATE");
        PartyMark:RegisterEvent("PLAYER_LEAVE_COMBAT");
        listening = true
    end
end