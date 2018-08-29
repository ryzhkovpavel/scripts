local AutoBuy = {}
AutoBuy.optionEnableTome = Menu.AddOptionBool({"Utility"}, "AutoBuyTome", false)
local myHero,myPlayer
local checked = false
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
	local time = (GameRules.GetGameTime() - GameRules.GetGameStartTime())%601
	if time > 600 and not checked and NPC.GetCurrentLevel(myHero) ~= 25 then 
		Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_PURCHASE_ITEM, 257, Vector(0,0,0), 257, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
		checked = true
	end
	if checked and time <= 1 then
		checked = false
	end
end
AutoBuy.Init()
return AutoBuy