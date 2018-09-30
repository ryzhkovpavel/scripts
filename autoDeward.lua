local autoDeward = {}
autoDeward.optionEnable = Menu.AddOptionBool({"Utility"}, "Auto Deward", false)
local myHero, myTeam
local nearWard
local tango, qBlade, bf, pTango
local nextTick = 0
local time
function autoDeward.Init( ... )
	myHero = Heroes.GetLocal()
	nextTick = 0
	if not myHero then return end
	myTeam = Entity.GetTeamNum(myHero)
	myPlayer = Players.GetLocal()
end
function autoDeward.OnGameStart( ... )
	autoDeward.Init()
end
function autoDeward.clearVar( ... )
	tango = nil
	qBlade = nil
	bf = nil
	pTango = nil
end
function autoDeward.OnUpdate( ... )
	if not myHero or not Menu.IsEnabled(autoDeward.optionEnable) then
		return
	end
	time = GameRules.GetGameTime()
	if time >= nextTick then
		nearWard = nil
		local tempTable = Entity.GetUnitsInRadius(myHero, 450, Enum.TeamType.TEAM_ENEMY)
		if tempTable then
			for i, k in pairs(tempTable) do
				if NPC.GetUnitName(k) == "npc_dota_sentry_wards" or NPC.GetUnitName(k) == "npc_dota_observer_wards" then
					nearWard = k
					break
				end
			end
		end
		nextTick = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
	end
	autoDeward.clearVar()
	for i = 0, 5 do
		local item = NPC.GetItemByIndex(myHero, i)
		if item and item ~= 0 then
			local itemName = Ability.GetName(item)
			if itemName == "item_tango" then
				tango = item
			elseif itemName == "item_tango_single" then
				pTango = item
			elseif itemName == "item_quelling_blade" then
				qBlade = item
			elseif itemName == "item_bfury" then
				bf = item
			end	
		end
	end
	if not NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) or NPC.GetUnitName(myHero) == "npc_dota_hero_riki" then
		if nearWard and Entity.IsAlive(nearWard) and not NPC.IsChannellingAbility(myHero) and not NPC.HasModifier(myHero, "modifier_teleporting") then
			if qBlade and Ability.IsCastable(qBlade, 0) then
				Ability.CastTarget(qBlade, nearWard)
				return
			end
			if bf and Ability.IsCastable(bf, 0) then
				Ability.CastTarget(bf, nearWard)	
				return	
			end
			if tango and Ability.IsCastable(tango, 0) then
				Ability.CastTarget(tango, nearWard)
			end
			if pTango and Ability.IsCastable(pTango, 0) then
				Ability.CastTarget(pTango, nearWard)
			end
		end
	end
end
autoDeward.Init()
return autoDeward