local ptswitch = {}
ptswitch.optionEnable = Menu.AddOptionBool({"Utility"}, "PT Switcher", false)
local myHero
local lastStat
local nextTick = 0
local changed = true
function ptswitch.Init()
	myHero = Heroes.GetLocal()
	changed = true
	nextTick = 0
end
function ptswitch.OnGameStart()
	ptswitch.Init()
end
function ptswitch.OnUpdate()
	if not Menu.IsEnabled(ptswitch.optionEnable) then return end
	if not myHero then return end
	if lastStat and GameRules.GetGameTime() >= nextTick and not NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) and not NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVULNERABLE) and not NPC.HasModifier(myHero, "modifier_item_silver_edge_windwalk") and not NPC.HasModifier(myHero, "modifier_item_invisibility_edge_windwalk") then
		local pt = NPC.GetItem(myHero, "item_power_treads", true)
		if pt and not NPC.IsChannellingAbility(myHero) then
			if PowerTreads.GetStats(pt) ~= lastStat and not changed then
				Ability.CastNoTarget(pt)							
			end
			if PowerTreads.GetStats(pt) == lastStat then
				lastStat = nil
				changed = true
			end
			nextTick = nextTick + 0.15 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)	
		end
	end
end
function ptswitch.OnPrepareUnitOrders(orders)
	if not Menu.IsEnabled(ptswitch.optionEnable) or not myHero then return end
	if NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) or NPC.HasModifier(myHero, "modifier_item_silver_edge_windwalk") or NPC.HasModifier(myHero, "modifier_item_invisibility_edge_windwalk") then return end
	if orders.order ~= 5 and orders.order ~= 6 and orders.order ~= 7 and orders.order ~= 8 and orders.order ~= 9 then return end
	if not orders.ability or not Entity.IsAbility(orders.ability) then return end
	if Ability.GetManaCost(orders.ability) < 1 then return end
	local pt = NPC.GetItem(myHero, "item_power_treads", true)
	if pt and not NPC.IsChannellingAbility(myHero) and not NPC.HasModifier(myHero, "modifier_teleporting") then
		if NPC.IsStunned(myHero) then return end
		if changed then
			lastStat = PowerTreads.GetStats(pt)
		end
		if PowerTreads.GetStats(pt) == 0 then
			Ability.CastNoTarget(pt)
		elseif PowerTreads.GetStats(pt) == 2 then
			Ability.CastNoTarget(pt)
			Ability.CastNoTarget(pt)
		end
		changed = false
		nextTick = GameRules.GetGameTime() + Ability.GetCastPoint(orders.ability) + 0.45 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
	end
end
ptswitch.Init()
return ptswitch