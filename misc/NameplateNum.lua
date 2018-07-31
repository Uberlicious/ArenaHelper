--[[ArenaHelper Nameplate Num v1.0]]

NameplateNum = {}

local NameplateNum=CreateFrame("Frame")
NameplateNum:RegisterEvent("PLAYER_LOGIN")
NameplateNum:SetScript("OnEvent", function(self, event)

if ArenaHelperDB.NameplateNum then
	self:Enable()
end
end)

function NameplateNum.Enable()
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

function NameplateNum.Disable()
	DEFAULT_CHAT_FRAME:AddMessage("Arena Nameplate Numbers Disabled", 0, 1, 0)
	local U=UnitIsUnit 
	hooksecurefunc("CompactUnitFrame_UpdateName", function(F)
		if IsActiveBattlefieldArena() and F.unit:find("nameplate") then 
			for i=1,5 do 
				if U(F.unit,"arena"..i) then 
					break
				end
			end
		end
	end)
end

return NameplateNum