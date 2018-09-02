local MPHPAbuse = {}
MPHPAbuse.optionEnable = Menu.AddOptionBool({"Utility", "MP/HP Abuse"}, "Enable", false)
MPHPAbuse.optionToggleKey = Menu.AddKeyOption({"Utility", "MP/HP Abuse"}, "Toggle Key", Enum.ButtonCode.KEY_N)
MPHPAbuse.optionBackPackAbuseKey = Menu.AddKeyOption({"Utility", "MP/HP Abuse"}, "Key to quick abuse items to backpack", Enum.ButtonCode.KEY_Y)
MPHPAbuse.threshold = Menu.AddOptionSlider({"Utility", "MP/HP Abuse"}, "HP Percent Threshold", 0, 100, 5)
MPHPAbuse.font = Renderer.LoadFont("Tahoma", 18, Enum.FontWeight.BOLD)
MPHPAbuse.items = {
	item_soul_ring = true,
	item_arcane_boots = true,
	item_magic_wand = true,
	item_magic_stick = true,
	item_guardian_greaves = true,
	item_mango = true,
	item_cheese = true,
	item_mekansm = true,
	item_faerie_fire = true
}
MPHPAbuse.dropItems = {
	item_energy_booster = true,
	item_belt_of_strength = true,
	item_ogre_axe = true,
	item_mantle = true,
	item_mystic_staff = true,
	item_point_booster = true,
	item_robe = true,
	item_staff_of_wizardry = true,
	item_ultimate_orb = true,
	item_arcane_boots = true,
	item_aether_lens = true,
	item_ultimate_scepter = true,
	item_aeon_disk = true,
	item_reaver = true,
	item_vitality_booster = true,
	item_abyssal_blade = true,
	item_heavens_halberd = true,
	item_vanguard = true,
	item_bloodstone = true,
	item_blade_mail = true,
	item_bloodthorn = true,
	item_bracer = true,
	item_buckler = true,
	item_crimson_guard = true,
	item_dagon = true,
	item_dagon_2 = true,
	item_dagon_3 = true,
	item_dagon_4 = true,
	item_dagon_5 = true,
	item_diffusal_blade = true,
	item_ancient_janggo = true,
	item_echo_sabre = true,
	item_ethereal_blade = true,
	item_cyclone = true,
	item_skadi = true,
	item_force_staff = true,
	item_guardian_greaves = true,
	item_headdress = true,
	item_helm_of_the_dominator = true,
	item_hurricane_pike = true,
	item_kaya = true,
	item_sphere = true,
	item_lotus_orb = true,
	item_magic_wand = true,
	item_manta = true,
	item_mekansm = true,
	item_meteor_hammer = true,
	item_null_talisman = true,
	item_oblivion_staff = true,
	item_octarine_core = true,
	item_orchid = true,
	item_ring_of_aquila = true,
	item_rod_of_atos = true,
	item_sheepstick = true,
	item_shivas_guard = true,
	item_silver_edge = true,
	item_soul_booster = true,
	item_veil_of_discord = true,
	item_wraith_band = true,
	item_vladmir = true,
	item_vanguard = true,
	item_urn_of_shadows = true,
	item_spirit_vessel = true,
	item_basher = true,
	item_satanic = true,
	item_sange_and_yasha = true,
	item_sange = true,
	item_heart = true,
	item_black_king_bar = true
}
local changed = false
local dropped = 0
local toggled = false
local needSwap = false
local time
local nextTick = 0
local nextTick2 = 0
local x,y
local myHero, myPlayer
MPHPAbuse.itemsSlots = {}
function MPHPAbuse.OnGameStart()
	MPHPAbuse.Init()
end
function MPHPAbuse.Init()
	myHero = Heroes.GetLocal()
	myPlayer = Players.GetLocal()
	nextTick = 0
	nextTick2 = 0
	x, y = Renderer.GetScreenSize()
	x = x * 0.59
	y = y * 0.8426
	y = y - 20	
end
function MPHPAbuse.OnPrepareUnitOrders(orders)
	if not myHero or not Engine.IsInGame() or not Menu.IsEnabled(MPHPAbuse.optionEnable) or not orders or not Entity.IsAbility(orders.ability) then return end
	if not toggled then return end
	if Entity.GetHealth(myHero)/Entity.GetMaxHealth(myHero) < Menu.GetValue(MPHPAbuse.threshold)/100 then return end
	if orders.order ~= 8 then return end
	if Entity.IsAlive(myHero) and not NPC.IsStunned(myHero) then
	local name = Ability.GetName(orders.ability)
		if MPHPAbuse.items[name] then
			if MPHPAbuse.dropItems[name] == true then
				changed = true
				MPHPAbuse.dropItems[name] = false
			end
			for i = 0, 5 do
				local item = NPC.GetItemByIndex(myHero, i)
				if item ~= 0 then
					local itemName = Ability.GetName(item)
					if MPHPAbuse.dropItems[itemName] then
						MPHPAbuse.itemsSlots[itemName] = i			
						MPHPAbuse.dropItem(myHero, item)
						dropped = dropped + 1
					end
				end
			end
			if changed == true then 
				MPHPAbuse.dropItems[name] = true 
				changed = false 
			end
		end
	end
end
function MPHPAbuse.AbuseBackPack( ... )
	if not toggled then
		return
	end
	for i = 0, 5 do
		local item = NPC.GetItemByIndex(myHero, i)
		if item ~= 0 and MPHPAbuse.dropItems[Ability.GetName(item)] then
			MPHPAbuse.itemsSlots[Ability.GetName(item)] = i
			MPHPAbuse.moveItem(item, 6)
		end
		if i == 5 then
			nextTick = time + 0.35 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
			needSwap = true
		end
	end
end
function MPHPAbuse.OnUpdate()
	if not Menu.IsEnabled(MPHPAbuse.optionEnable) then return end
	if not myHero then return end
	time = GameRules.GetGameTime()
	if Menu.IsKeyDownOnce(MPHPAbuse.optionToggleKey) then
		if toggled == false then
			toggled = true
		else
			toggled = false	
		end	
	end
	if Menu.IsKeyDownOnce(MPHPAbuse.optionBackPackAbuseKey) and time >= nextTick2 then
		MPHPAbuse.AbuseBackPack()
		nextTick2 = time + 1
	end
	if needSwap and time >= nextTick then
		for i = 0, 8 do
			local item = NPC.GetItemByIndex(myHero, i)
			if item and item ~= 0 then
				if MPHPAbuse.itemsSlots[Ability.GetName(item)] then
					if i ~= MPHPAbuse.itemsSlots[Ability.GetName(item)] then
						MPHPAbuse.moveItem(item, MPHPAbuse.itemsSlots[Ability.GetName(item)])
					end
				end
			end
		end
		needSwap = false
	end
end
function MPHPAbuse.OnDraw()
	if not Menu.IsEnabled(MPHPAbuse.optionEnable) or not myHero then return end
	if toggled then 
		Renderer.SetDrawColor(90, 255, 100)
		Renderer.DrawText(MPHPAbuse.font, x, y, "[MP/HP Abuse: ON]")
	else
		Renderer.SetDrawColor(255, 90, 100)
		Renderer.DrawText(MPHPAbuse.font, x, y, "[MP/HP Abuse: OFF]")	
	end	
end
function MPHPAbuse.OnEntityCreate(ent)
	if not myHero or not Engine.IsInGame() or not Menu.IsEnabled(MPHPAbuse.optionEnable) then return end
	if not toggled then return end
	if Entity.GetClassName(ent) == "C_DOTA_Item_Physical" and dropped > 0 then
		MPHPAbuse.pickItem(myHero, ent)
		dropped = dropped - 1
		if dropped == 0 then
			needSwap = true
			nextTick = time + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
		end
	end
end
function MPHPAbuse.moveItem(item, newPos)
	Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_ITEM, newPos, Vector(0,0,0), item, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
end
function MPHPAbuse.dropItem(myHero, item)
	Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_DROP_ITEM, nil, Entity.GetAbsOrigin(myHero), item, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
end
function MPHPAbuse.pickItem(myHero, item)
	Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_PICKUP_ITEM, item, Vector(0, 0, 0), nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
end
MPHPAbuse.Init()
return MPHPAbuse