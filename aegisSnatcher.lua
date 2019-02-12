local aegisSnatcher = {}
aegisSnatcher.optionEnableAegis = Menu.AddOptionBool({"Utility", "Item Snatcher"}, "Aegis", false)
aegisSnatcher.optionEnableCheese = Menu.AddOptionBool({"Utility", "Item Snatcher"}, "Cheese", false)
aegisSnatcher.optionEnableRefresher = Menu.AddOptionBool({"Utility", "Item Snatcher"}, "Refresher Shard", false)
aegisSnatcher.optionEnableRapier = Menu.AddOptionBool({"Utility", "Item Snatcher"}, "Divine Rapier", false)
aegisSnatcher.optionEnableGem = Menu.AddOptionBool({"Utility", "Item Snatcher"}, "Gem of True Sight", false)
aegisSnatcher.optionRangeToSnatch = Menu.AddOptionSlider({"Utility", "Item Snatcher"}, "Range to steal items", 100, 1000, 250)
local myHero, myPlayer
local nextTick = 0
local tempEnt = {}
local aegis = {}
local cheese = {}
local refresh = {}
local rapier = {}
local gem = {}
local roshpit = Vector(-2305.312500, 1852.406250, 159.968750)
function aegisSnatcher.Init( ... )
	myHero = Heroes.GetLocal()
	if not myHero then
		return
	end
	nextTick = 0
	myPlayer = Players.GetLocal()
end
function aegisSnatcher.OnGameStart( ... )
	aegisSnatcher.Init()
end
function aegisSnatcher.HasInventorySlotFree()
	if NPC.HasInventorySlotFree(myHero, true) then
		return true
	end
	for i = 6, 8 do
		local item = NPC.GetItemByIndex(myHero, i)
		if not item or item == 0 then
			return true
		end
	end	
	return false
end
function aegisSnatcher.OnUpdate( ... )
	if not myHero then
		return
	end
	local time = GameRules.GetGameTime()
	if #rapier > 0 and Menu.IsEnabled(aegisSnatcher.optionEnableRapier) and Entity.IsAlive(myHero) and NPC.HasInventorySlotFree(myHero, true) then
		for i, k in pairs(rapier) do
			if NPC.IsPositionInRange(myHero, k.pos, Menu.GetValue(aegisSnatcher.optionRangeToSnatch)) and time >= nextTick then
				Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_PICKUP_ITEM, k.ent,Vector(0,0,0),nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
				nextTick = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			end
		end
	end
	if #gem > 0 and Menu.IsEnabled(aegisSnatcher.optionEnableGem) and Entity.IsAlive(myHero) and NPC.HasInventorySlotFree(myHero, true) then
		for i, k in pairs(gem) do
			if NPC.IsPositionInRange(myHero, k.pos, Menu.GetValue(aegisSnatcher.optionRangeToSnatch)) and time >= nextTick then
				Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_PICKUP_ITEM, k.ent,Vector(0,0,0),nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
				nextTick = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			end
		end
	end
	if aegis["ent"] and Menu.IsEnabled(aegisSnatcher.optionEnableAegis) and NPC.IsPositionInRange(myHero, aegis["pos"], Menu.GetValue(aegisSnatcher.optionRangeToSnatch)) and Entity.IsAlive(myHero) and time >= nextTick and NPC.IsPositionInRange(myHero, roshpit, 750) and NPC.HasInventorySlotFree(myHero, true) then
		Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_PICKUP_ITEM, aegis["ent"],Vector(0,0,0),nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
		nextTick = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
	end
	if cheese["ent"] and Menu.IsEnabled(aegisSnatcher.optionEnableCheese) and NPC.IsPositionInRange(myHero, cheese["pos"], Menu.GetValue(aegisSnatcher.optionRangeToSnatch)) and Entity.IsAlive(myHero) and time >= nextTick and NPC.IsPositionInRange(myHero, roshpit, 750) and aegisSnatcher.HasInventorySlotFree() then
		Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_PICKUP_ITEM, cheese["ent"],Vector(0,0,0),nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
		nextTick = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
	end
	if refresh["ent"] and Menu.IsEnabled(aegisSnatcher.optionEnableRefresher) and NPC.IsPositionInRange(myHero, refresh["pos"], Menu.GetValue(aegisSnatcher.optionRangeToSnatch)) and Entity.IsAlive(myHero) and time >= nextTick and NPC.IsPositionInRange(myHero, roshpit, 750) and aegisSnatcher.HasInventorySlotFree() then
		Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_PICKUP_ITEM, refresh["ent"],Vector(0,0,0),nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
		nextTick = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
	end
	for i, k in pairs(tempEnt) do
		local name = Ability.GetName(PhysicalItem.GetItem(k))
		local origin = Entity.GetAbsOrigin(k)
		if name == "item_aegis" then
			aegis["ent"] = k
			aegis["pos"] = origin
		elseif name == "item_cheese" then
			cheese["ent"] = k
			cheese["pos"] = origin
		elseif name == "item_refresher_shard" then
			refresh["ent"] = k
			refresh["pos"] = origin
		elseif name == "item_rapier" then
			table.insert(rapier, {ent = k, pos = origin})
		elseif name == "item_gem" then
			table.insert(gem, {ent = k, pos = origin})	
		end
		tempEnt[i] = nil
	end
end
function aegisSnatcher.OnEntityCreate(ent)
	if Entity.GetClassName(ent) == "C_DOTA_Item_Physical" then
		table.insert(tempEnt, ent)
	end
end
function aegisSnatcher.OnEntityDestroy(ent)
	if aegis["ent"] and ent == aegis["ent"] then
		aegis["ent"] = nil
		aegis["pos"] = nil
	end
	if cheese["ent"] and ent == cheese["ent"] then
		cheese["ent"] = nil
		cheese["pos"] = nil
	end
	if refresh["ent"] and ent == refresh["ent"] then
		refresh["ent"] = nil
		refresh["pos"] = nil
	end
	if #rapier > 0 then
		for i, k in pairs(rapier) do
			if k.ent == ent then
				rapier[i] = nil
			end
		end
	end
	if #gem > 0 then
		for i, k in pairs(gem) do
			if k.ent == ent then
				gem[i] = nil
			end
		end
	end
end
aegisSnatcher.Init()
return aegisSnatcher