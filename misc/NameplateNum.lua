--[[ArenaHelper Nameplate Num v1.0]]

local NameplateNum = {}

local CF=CreateFrame("Frame")
CF:RegisterEvent("PLAYER_LOGIN")
CF:SetScript("OnEvent", function(self, event)

if AddonHelperDB.NameplateNum then
	NameplateNum:Enable
end

function NameplateNum:Enable()
	DEFAULT_CHAT_FRAME:AddMessage("Arena Nameplate Numbers Enabled", 0, 1, 0)
	local U=UnitIsUnit 
	hooksecurefunc("CompactUnitFrame_UpdateName", function(F)
		if IsActiveBattlefieldArena() and F.unit:find("nameplate") then 
			for i=1,5 do 
				if U(F.unit,"arena"..i) then 
					F.name:SetText(i)F.name:SetTextColor(1,1,0)
					break
				end
			end
		end
	end)
end