local autoStash = {}
autoStash.optionEnable = Menu.AddOptionBool({"Utility"}, "Auto Stash Duel", false)
local myHero, myPlayer
local needSwap = false
local itemSlots = {}
local stashItems = {
	item_phase_boots = true,
	item_mjollnir = true,
	item_desolator = true,
	item_demon_edge = true,
	item_echo_sabre = true,
	item_blight_stone = true,
	item_claymore = true,
	item_greater_crit = true,
	item_relic = true,
	item_maelstrom = true,
	item_lesser_crit = true,
	item_javelin = true,
	item_moon_shard = true,
	item_hyperstone = true,
	item_diffusal_blade = true,
	item_bloodthorn = true,
	item_monkey_king_bar = true,
	item_bfury = true,
	item_invis_sword = true,
	item_silver_edge = true,
	item_broadsword = true,
	item_orchid = true
}
function autoStash.Init( ... )
	myHero = Heroes.GetLocal()
	myPlayer = Players.GetLocal()
	itemSlots = {}
end
function autoStash.OnGameStart( ... )
	autoStash.Init()
end
function autoStash.OnUpdate( ... )
	if not myHero or not Menu.IsEnabled(autoStash.optionEnable) or not needSwap or GameRules.GetGameTime() < nextTick then
		return
	end
	for i = 0, 8 do
		local item = NPC.GetItemByIndex(myHero, i)
		if item and item ~= 0 then
			if itemSlots[item] and i ~= itemSlots[item] then
				autoStash.moveItem(item, itemSlots[item])
				itemSlots[item] = nil
			elseif itemSlots[item] and i == itemSlots[item] then
				itemSlots[item] = nil	
			end
		end
	end
	needSwap = false
end
function autoStash.OnUnitAnimation(anim)
	if not myHero or not Menu.IsEnabled(autoStash.optionEnable) or not anim or not anim.unit or Entity.IsSameTeam(myHero, anim.unit) or not NPC.IsEntityInRange(myHero, anim.unit, 225) or anim.sequenceName ~= "legion_commander_duel_anim" or autoStash.IsLinkensProtected(myHero) then
		return
	end
	if NPC.HasModifier(anim.unit, "modifier_item_blade_mail_reflect") then
		for i = 0, 5 do
			local item = NPC.GetItemByIndex(myHero, i)
			if item and item ~= 0 and stashItems[Ability.GetName(item)] then
				itemSlots[item] = i
				autoStash.moveItem(item, 6)
			end
		end
		needSwap = true
		nextTick = GameRules.GetGameTime() + 0.1 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING)
	end
end
function autoStash.IsLinkensProtected(npc)
	if NPC.IsLinkensProtected(npc) then
		return true
	end
	if NPC.HasModifier(npc, "modifier_special_bonus_spell_block") then
		local mod = NPC.GetModifier(npc, "modifier_special_bonus_spell_block")
		if GameRules.GetGameTime() - Modifier.GetLastAppliedTime(mod) > 15 then
			return true
		end
	end
	return false
end
function autoStash.moveItem(item, slot)
	Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_ITEM, slot, Vector(0,0,0), item, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
end
autoStash.Init()
return autoStash