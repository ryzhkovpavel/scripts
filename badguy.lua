local badguy = {}
badguy.optionEnable = Menu.AddOptionBool({"Utility", "Bad Guy"}, "Enable", false)
badguy.optionEnableAutoFeed = Menu.AddOptionBool({"Utility", "Bad Guy"}, "Auto-Feed", false)
badguy.optionCourierLock = Menu.AddOptionBool({"Utility", "Bad Guy"}, "Lock Courier", false)
badguy.optionEnableAutoUnpause = Menu.AddOptionBool({"Utility", "Bad Guy"}, "AutoUnpause", false)
badguy.optionEnableAutoLaugh = Menu.AddOptionBool({"Utility", "Bad Guy"}, "Auto Laugh", false)
badguy.optionSliderAutoLaugh = Menu.AddOptionSlider({"Utility", "Bad Guy"}, "Laugh delay", 15,100,15)
badguy.optionToxicFlame = Menu.AddOptionBool({"Utility", "Bad Guy"}, "Toxic Flame", false)
badguy.optionLanguage = Menu.AddOptionCombo({"Utility","Bad Guy"}, "Language", {"Русский", "English"}, 0)
badguy.phrase = {
	"куколды ебаные",
	"выпей моей спермы, сын дерьма",
	"да вы вафлеры",
	"Как два пальца в анус твоей матери",
	"Слишком легко я тебя выебал"
}
badguy.engphrase = {
	"cunt",
	"cuckold",
	"drink my semen",
	"yeah you are bad and drink my semen.",
	"my anus and my dick in your face?"
}
local lastlaugh = nil
local laughed = false
local aliveHeroes = {}
local myHero = nil
local myPlayer
local unpauseTick = 0
local base = nil
local feedBase
local courier
function badguy.Init()
	myHero = Heroes.GetLocal()
	myPlayer = Players.GetLocal()
	courier = nil
	if not myHero then return end
	myTeam = Entity.GetTeamNum(myHero)
	local radiant = Vector(-7317.406250, -6815.406250, 512.000000)
	local dire = Vector(7264.000000, 6560.000000, 512.000000)
	if myTeam == 2 then
		base = radiant
		feedBase = dire
	elseif myTeam == 3 then
		base = dire
		feedBase = radiant
	end
	needInit = false
	unpauseTick = 0
end
function badguy.OnGameStart()
	aliveHeroes = {}
	lastlaugh = nil
	laughed = false
	badguy.Init()
end
function badguy.OnGameEnd()
	aliveHeroes = {}
	lastlaugh = nil
	laughed = false
end
function badguy.OnUpdate()
	if not myHero or not Menu.IsEnabled(badguy.optionEnable) then lastlaugh = nil aliveHeroes = {} return end
	if Menu.IsEnabled(badguy.optionCourierLock) then
		badguy.lockCour()
	end	
	if Menu.IsEnabled(badguy.optionEnableAutoUnpause) then
		badguy.autoUnpause()
	end
	if Menu.IsEnabled(badguy.optionEnableAutoFeed) then
		badguy.autofeed()
	end
	if Menu.IsEnabled(badguy.optionEnableAutoLaugh) then
		badguy.autolaugh()
	end
	if Menu.IsEnabled(badguy.optionToxicFlame) then
		badguy.toxicFlame()
	end	
end
function badguy.lockCour( ... )
	if not courier then
		for i = 1, Couriers.Count() do
			local npc = Couriers.Get(i)
			if Entity.IsSameTeam(npc, myHero) then
				courier = npc
			end
		end
	end
	if courier and NPC.IsCourier(courier) then
		if not NPC.IsPositionInRange(courier, base, 250) then
			Player.PrepareUnitOrders(myPlayer,Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION,nil,base,nil, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, courier)
		end
	end
end
function badguy.autoUnpause()
	if GameRules.IsPaused() and os.clock() >= unpauseTick then
		Engine.ExecuteCommand("dota_pause")
		unpauseTick = unpauseTick + 0.1 + NetChannel.GetLatency(Enum.Flow.FLOW_OUTGOING)
	end
end
function badguy.autofeed()
	if Entity.IsAlive(myHero) then
		Player.PrepareUnitOrders(myPlayer,Enum.UnitOrder.DOTA_UNIT_ORDER_MOVE_TO_POSITION,nil,feedBase,nil,Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY,myHero)
	end
end
function badguy.autolaugh()
	if not Entity.IsAlive(myHero) then return end
	if not lastlaugh then
		lastlaugh = GameRules.GetGameTime()
	end	
	if math.floor(lastlaugh) == math.floor(GameRules.GetGameTime()) and laughed == false then
		Engine.ExecuteCommand("say /laugh")
		lastlaugh = lastlaugh + Menu.GetValue(badguy.optionSliderAutoLaugh)
		laughed = true
	else
		laughed = false	
	end	
end
function badguy.toxicFlame()
	for i = 1, Heroes.Count() do
		local hero = Heroes.Get(i)
		if Entity.IsAlive(hero) and not aliveHeroes[Hero.GetPlayerID(hero)] then
			aliveHeroes[Hero.GetPlayerID(hero)] = hero
		end	
	end
	if #aliveHeroes > 0 then
		for i, hero in pairs(aliveHeroes) do
			if not Entity.IsAlive(hero) and aliveHeroes[Hero.GetPlayerID(hero)] and not Entity.IsSameTeam(myHero, hero) then
				for i = 1, Players.Count() do
					local player = Players.Get(i)
					if Player.GetPlayerID(player) == Hero.GetPlayerID(hero) and not Entity.IsSameTeam(myHero, hero) then
						local language = Menu.GetValue(badguy.optionLanguage)
						if language == 0 then
							Engine.ExecuteCommand("say "..Player.GetName(player).." "..badguy.phrase[math.random(#badguy.phrase)])
						else
							Engine.ExecuteCommand("say "..Player.GetName(player).." "..badguy.engphrase[math.random(#badguy.engphrase)])
						end	
						aliveHeroes[Hero.GetPlayerID(hero)] = nil
					end	
				end
			end	
		end	
	end	
end
badguy.Init()
return badguy
