local AutoBuy = {}
AutoBuy.optionEnableTome = Menu.AddOptionBool({"Utility"}, "AutoBuyTome", false)
local myHero,myPlayer
local checked = {}
function AutoBuy.Init()
	myHero = Heroes.GetLocal()
	if not myHero then return end
	myPlayer = Players.GetLocal()
end
function AutoBuy.OnGameStart( ... )
	AutoBuy.Init()
end
function AutoBuy.OnUpdate( ... )
	if not Menu.IsEnabled(AutoBuy.optionEnableTome) or not myHero then return end
	local time = (GameRules.GetGameTime() - GameRules.GetGameStartTime())%602
	if time > 597 and not checked[597] and NPC.GetCurrentLevel(myHero) ~= 25 then 
		Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_PURCHASE_ITEM, 257, Vector(0,0,0), 257, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
		checked[597] = true
	end
	if time > 598 and not checked[598] and NPC.GetCurrentLevel(myHero) ~= 25 then 
		Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_PURCHASE_ITEM, 257, Vector(0,0,0), 257, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
		checked[598] = true
	end
	if time > 599 and not checked[599] and NPC.GetCurrentLevel(myHero) ~= 25 then 
		Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_PURCHASE_ITEM, 257, Vector(0,0,0), 257, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
		checked[599] = true
	end
	if time > 600 and not checked[600] and NPC.GetCurrentLevel(myHero) ~= 25 then 
		Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_PURCHASE_ITEM, 257, Vector(0,0,0), 257, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
		checked[600] = true
	end
	if time > 601 and not checked[601] and NPC.GetCurrentLevel(myHero) ~= 25 then
		Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_PURCHASE_ITEM, 257, Vector(0,0,0), 257, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
		checked[601] = true
	end
	if checked[601] and time <= 1 then
		checked = {}
	end
end
AutoBuy.Init()
return AutoBuy