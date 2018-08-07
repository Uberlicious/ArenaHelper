--[[ArenaHelper Nameplate Num v1.0]]
local addon, ns = ...
local MaxDebuffs

local MaxDebuffs=CreateFrame("Frame")
MaxDebuffs:RegisterEvent("PLAYER_ENTERING_WORLD")
MaxDebuffs:SetScript("OnEvent", function(self, event)
	local _, instanceType = IsInInstance()
	if instanceType == "pvp" or instanceType == "arena" and HelperDB.MaxDebuffs then
		MaxDebuffs_Enable()
	end
end)

function MaxDebuffs_Enable()
	local function SetPoint(f,i)
		tr="TOPRIGHT"
		f2=f.debuffFrames
		s=f2[1]:GetWidth()
		f3=f2[i]
		f3:SetSize(s,s)
		f3:ClearAllPoints()
		print(f2)
		print(f3)
		if i>6 then 
			f3:SetPoint("BOTTOMRIGHT",f2[i-3],tr,0,0) 
		else 
			f3:SetPoint(tr,f2[1],tr,-(s*(i-3)),0) 
		end 
	end
	local function CreateButtonFrame(f,i) 
		bf=CreateFrame("Button",f:GetName().."Debuff"..i,f,"CompactDebuffTemplate")
		bf.baseSize=22
		bf:SetSize(f.buffFrames[1]:GetSize()) 
		end
	
	local function mv(f) 
		for i=4,12 do 
			SetPoint(f,i) 
		end 
	end
	
	local function mv3(f) 
		CompactUnitFrame_SetMaxDebuffs(f,12) 
		if not f.debuffFrames[4] then 
			for i=4,12 do 
				CBF(f,i) 
			end 
		end 
	mv(f) 
	end
	hooksecurefunc("CompactUnitFrame_UpdateDebuffs",function(frame) 
		if frame:GetName():match("^Compact") then 
			mv3(frame) 
		end 
	end)
end