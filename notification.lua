local notification = {}
notification.optionEnable = Menu.AddOptionBool({"Awareness", "Notification"}, "Enable", false)
notification.optionRoshDrawInfo = Menu.AddOptionBool({"Awareness", "Notification"}, "Draw Rosh State", true)
notification.optionChatAlertEnable = Menu.AddOptionBool({"Awareness", "Notification", "Chat Alert"}, "Enable", true)
notification.optionBaraAlertEnable = Menu.AddOptionBool({"Awareness", "Notification", "Chat Alert"}, "Bara Alert", true)
notification.optionSkillAlertEnable = Menu.AddOptionBool({"Awareness", "Notification", "Chat Alert"}, "Skill Alert", true)
notification.optionRunesAlertEnable = Menu.AddOptionBool({"Awareness", "Notification", "Chat Alert"}, "Runes Alert", false)
notification.optionRoshAlertEnable = Menu.AddOptionBool({"Awareness", "Notification", "Chat Alert"}, "Roshan Alert", true)
notification.optionRoshAlertDelay = Menu.AddOptionSlider({"Awareness", "Notification", "Chat Alert"}, "Rosh Alert Delay", 0, 10, 1)
notification.optionLanguage = Menu.AddOptionCombo({"Awareness", "Notification", }, "Language", {"Русский", "English", "Український"}, 0)
notification.font = Renderer.LoadFont("Tahoma", 25, Enum.FontWeight.BOLD)
notification.font2 = Renderer.LoadFont("Tahoma", 15, Enum.FontWeight.BOLD)
notification.HeroNameTable = {}
notification.HeroNameTable["npc_dota_hero_abaddon"] = "Abaddon"
notification.HeroNameTable["npc_dota_hero_abyssal_underlord"] = "Abyssal Underlord"
notification.HeroNameTable["npc_dota_hero_alchemist"] = "Alchemist"
notification.HeroNameTable["npc_dota_hero_ancient_apparition"] = "Ancient Apparition"
notification.HeroNameTable["npc_dota_hero_antimage"] = "Anti-Mage"
notification.HeroNameTable["npc_dota_hero_arc_warden"] = "Arc Warden"
notification.HeroNameTable["npc_dota_hero_axe"] = "Axe"
notification.HeroNameTable["npc_dota_hero_bane"] = "Bane"
notification.HeroNameTable["npc_dota_hero_batrider"] = "Batrider"
notification.HeroNameTable["npc_dota_hero_beastmaster"] = "Beastmaster"
notification.HeroNameTable["npc_dota_hero_bloodseeker"] = "Bloodseeker"
notification.HeroNameTable["npc_dota_hero_bounty_hunter"] = "Bounty Hunter"
notification.HeroNameTable["npc_dota_hero_brewmaster"] = "Brewmaster"
notification.HeroNameTable["npc_dota_hero_bristleback"] = "Bristleback"
notification.HeroNameTable["npc_dota_hero_broodmother"] = "Broodmother"
notification.HeroNameTable["npc_dota_hero_centaur"] = "Centaur Warrunner"
notification.HeroNameTable["npc_dota_hero_chaos_knight"] = "Chaos Knight"
notification.HeroNameTable["npc_dota_hero_chen"] = "Chen"
notification.HeroNameTable["npc_dota_hero_clinkz"] = "Clinkz"
notification.HeroNameTable["npc_dota_hero_crystal_maiden"] = "Crystal Maiden"
notification.HeroNameTable["npc_dota_hero_dark_seer"] = "Dark Seer"
notification.HeroNameTable["npc_dota_hero_dazzle"] = "Dazzle"
notification.HeroNameTable["npc_dota_hero_death_prophet"] = "Death Prophet"
notification.HeroNameTable["npc_dota_hero_disruptor"] = "Disruptor"
notification.HeroNameTable["npc_dota_hero_doom_bringer"] = "Doom"
notification.HeroNameTable["npc_dota_hero_dragon_knight"] = "Dragon Knight"
notification.HeroNameTable["npc_dota_hero_drow_ranger"] = "Drow Ranger"
notification.HeroNameTable["npc_dota_hero_earth_spirit"] = "Earth Spirit"
notification.HeroNameTable["npc_dota_hero_earthshaker"] = "Earthshaker"
notification.HeroNameTable["npc_dota_hero_elder_titan"] = "Elder Titan"
notification.HeroNameTable["npc_dota_hero_ember_spirit"] = "Ember Spirit"
notification.HeroNameTable["npc_dota_hero_enchantress"] = "Enchantress"
notification.HeroNameTable["npc_dota_hero_enigma"] = "Enigma"
notification.HeroNameTable["npc_dota_hero_faceless_void"] = "Faceless Void"
notification.HeroNameTable["npc_dota_hero_furion"] = "Nature's Prophet"
notification.HeroNameTable["npc_dota_hero_gyrocopter"] = "Gyrocopter"
notification.HeroNameTable["npc_dota_hero_huskar"] = "Huskar"
notification.HeroNameTable["npc_dota_hero_invoker"] = "Invoker"
notification.HeroNameTable["npc_dota_hero_jakiro"] = "Jakiro"
notification.HeroNameTable["npc_dota_hero_juggernaut"] = "Juggernaut"
notification.HeroNameTable["npc_dota_hero_keeper_of_the_light"] = "Keeper of the Light"
notification.HeroNameTable["npc_dota_hero_kunkka"] = "Kunkka"
notification.HeroNameTable["npc_dota_hero_legion_commander"] = "Legion Commander"
notification.HeroNameTable["npc_dota_hero_leshrac"] = "Leshrac"
notification.HeroNameTable["npc_dota_hero_lich"] = "Lich"
notification.HeroNameTable["npc_dota_hero_life_stealer"] = "Lifestealer"
notification.HeroNameTable["npc_dota_hero_lina"] = "Lina"
notification.HeroNameTable["npc_dota_hero_lion"] = "Lion"
notification.HeroNameTable["npc_dota_hero_lone_druid"] = "Lone Druid"
notification.HeroNameTable["npc_dota_hero_luna"] = "Luna"
notification.HeroNameTable["npc_dota_hero_lycan"] = "Lycan"
notification.HeroNameTable["npc_dota_hero_magnataur"] = "Magnus"
notification.HeroNameTable["npc_dota_hero_medusa"] = "Medusa"
notification.HeroNameTable["npc_dota_hero_meepo"] = "Meepo"
notification.HeroNameTable["npc_dota_hero_mirana"] = "Mirana"
notification.HeroNameTable["npc_dota_hero_monkey_king"] = "Monkey King"
notification.HeroNameTable["npc_dota_hero_morphling"] = "Morphling"
notification.HeroNameTable["npc_dota_hero_naga_siren"] = "Naga Siren"
notification.HeroNameTable["npc_dota_hero_necrolyte"] = "Necrophos"
notification.HeroNameTable["npc_dota_hero_nevermore"] = "Shadow Fiend"
notification.HeroNameTable["npc_dota_hero_night_stalker"] = "Night Stalker"
notification.HeroNameTable["npc_dota_hero_nyx_assassin"] = "Nyx Assassin"
notification.HeroNameTable["npc_dota_hero_obsidian_destroyer"] = "Outworld Devourer"
notification.HeroNameTable["npc_dota_hero_ogre_magi"] = "Ogre Magi"
notification.HeroNameTable["npc_dota_hero_omniknight"] = "Omniknight"
notification.HeroNameTable["npc_dota_hero_oracle"] = "Oracle"
notification.HeroNameTable["npc_dota_hero_phantom_assassin"] = "Phantom Assassin"
notification.HeroNameTable["npc_dota_hero_phantom_lancer"] = "Phantom Lancer"
notification.HeroNameTable["npc_dota_hero_phoenix"] = "Phoenix"
notification.HeroNameTable["npc_dota_hero_puck"] = "Puck"
notification.HeroNameTable["npc_dota_hero_pudge"] = "Pudge"
notification.HeroNameTable["npc_dota_hero_pugna"] = "Pugna"
notification.HeroNameTable["npc_dota_hero_queenofpain"] = "Queen of Pain"
notification.HeroNameTable["npc_dota_hero_rattletrap"] = "Clockwerk"
notification.HeroNameTable["npc_dota_hero_razor"] = "Razor"
notification.HeroNameTable["npc_dota_hero_riki"] = "Riki"
notification.HeroNameTable["npc_dota_hero_rubick"] = "Rubick"
notification.HeroNameTable["npc_dota_hero_sand_king"] = "Sand King"
notification.HeroNameTable["npc_dota_hero_shadow_demon"] = "Shadow Demon"
notification.HeroNameTable["npc_dota_hero_shadow_shaman"] = "Shadow Shaman"
notification.HeroNameTable["npc_dota_hero_shredder"] = "Timbersaw"
notification.HeroNameTable["npc_dota_hero_silencer"] = "Silencer"
notification.HeroNameTable["npc_dota_hero_skeleton_king"] = "Wraith King"
notification.HeroNameTable["npc_dota_hero_skywrath_mage"] = "Skywrath Mage"
notification.HeroNameTable["npc_dota_hero_slardar"] = "Slardar"
notification.HeroNameTable["npc_dota_hero_slark"] = "Slark"
notification.HeroNameTable["npc_dota_hero_sniper"] = "Sniper"
notification.HeroNameTable["npc_dota_hero_spectre"] = "Spectre"
notification.HeroNameTable["npc_dota_hero_spirit_breaker"] = "Spirit Breaker"
notification.HeroNameTable["npc_dota_hero_storm_spirit"] = "Storm Spirit"
notification.HeroNameTable["npc_dota_hero_sven"] = "Sven"
notification.HeroNameTable["npc_dota_hero_techies"] = "Techies"
notification.HeroNameTable["npc_dota_hero_templar_assassin"] = "Templar Assassin"
notification.HeroNameTable["npc_dota_hero_terrorblade"] = "Terrorblade"
notification.HeroNameTable["npc_dota_hero_tidehunter"] = "Tidehunter"
notification.HeroNameTable["npc_dota_hero_tinker"] = "Tinker"
notification.HeroNameTable["npc_dota_hero_tiny"] = "Tiny"
notification.HeroNameTable["npc_dota_hero_treant"] = "Treant Protector"
notification.HeroNameTable["npc_dota_hero_troll_warlord"] = "Troll Warlord"
notification.HeroNameTable["npc_dota_hero_tusk"] = "Tusk"
notification.HeroNameTable["npc_dota_hero_undying"] = "Undying"
notification.HeroNameTable["npc_dota_hero_ursa"] = "Ursa"
notification.HeroNameTable["npc_dota_hero_vengefulspirit"] = "Vengeful Spirit"
notification.HeroNameTable["npc_dota_hero_venomancer"] = "Venomancer"
notification.HeroNameTable["npc_dota_hero_viper"] = "Viper"
notification.HeroNameTable["npc_dota_hero_visage"] = "Visage"
notification.HeroNameTable["npc_dota_hero_warlock"] = "Warlock"
notification.HeroNameTable["npc_dota_hero_weaver"] = "Weaver"
notification.HeroNameTable["npc_dota_hero_windrunner"] = "Windranger"
notification.HeroNameTable["npc_dota_hero_winter_wyvern"] = "Winter Wyvern"
notification.HeroNameTable["npc_dota_hero_wisp"] = "Io"
notification.HeroNameTable["npc_dota_hero_witch_doctor"] = "Witch Doctor"
notification.HeroNameTable["npc_dota_hero_zuus"] = "Zeus"
notification.HeroNameTable["npc_dota_hero_dark_willow"] = "Dark Willow"
notification.HeroNameTable["npc_dota_hero_pangolier"] = "Pangolier"
notification.cachedIcons = {}
notification.cachedIcons[1] = Renderer.LoadImage("resource/flash3/images/items/smoke_of_deceit.png")
notification.cachedIcons[2] = Renderer.LoadImage("resource/flash3/images/spellicons/nyx_assassin_vendetta.png")
notification.cachedIcons[3] = Renderer.LoadImage("resource/flash3/images/spellicons/mirana_invis.png")
local myHero, myPlayer
local chargHero
local nyx, mirana, bara = false, false, false
local vendetta
local x, y
local timerX, timerY, alertX, alertY, roshStateX, roshStateY
local roshAlive = false
local eventTable = {}
local posTable = {}
local idTable = {}
local time
local language
local roshTick = 0
local nextTick = 0
local checkTick = 0
local tempEnt, aegisEnt
function notification.Init( ... )
	myHero = Heroes.GetLocal()
	myPlayer = Players.GetLocal()
	idTable = {}
	posTable = {}
	roshTick = 0
	nextTick = 0
	checkTick = 0
	vendetta = nil
	mirana = false
	nyx = false
	bara = false
	tempEnt = nil
	eventTable = {}
	if not myHero then return end
	x, y = Renderer.GetScreenSize()
	roshStateX = x * 0.732
	roshStateY = y * 0.04
	timerX = x * 0.495
	timerY = y * 0.05
	alertX = x * 0.9
	alertY = y * 0.04
end
function notification.OnGameStart( ... )
	notification.Init()
end
function notification.OnUpdate( ... )
	if not myHero or not Menu.IsEnabled(notification.optionEnable) then return end
	time = GameRules.GetGameTime()
	if tempEnt then
		if Ability.GetName(PhysicalItem.GetItem(tempEnt)) == "item_aegis" then
			aegisEnt = tempEnt
		end
		tempEnt = nil
	end
	if time >= checkTick then
		for i = 1, Heroes.Count() do
			local k = Heroes.Get(i)
			if NPC.GetUnitName(k) == "npc_dota_hero_mirana" and not Entity.IsSameTeam(myHero, k) then
				mirana = true
			elseif NPC.GetUnitName(k) == "npc_dota_hero_nyx_assassin" and not Entity.IsSameTeam(myHero, k) then
				nyx = true
				vendetta = NPC.GetAbility(k, "nyx_assassin_vendetta")
			elseif NPC.GetUnitName(k) == "npc_dota_hero_spirit_breaker" and not Entity.IsSameTeam(myHero, k) then
				bara = true	
			end
			checkTick = time + 5
		end
	end
	language = Menu.GetValue(notification.optionLanguage)
	if Menu.IsEnabled(notification.optionRoshDrawInfo) then
		if roshAlive then
			Renderer.SetDrawColor(0,255,0)
			Renderer.DrawText(notification.font, roshStateX, roshStateY, "Alive")
		else
			Renderer.SetDrawColor(255,0,0)
			Renderer.DrawText(notification.font, roshStateX, roshStateY, "Dead")
		end	
	end
	if eventTable["roshDead"] and time - eventTable["roshDead"] <= 300 and not roshAlive then
		Renderer.SetDrawColor(255,255,255)
		local min = math.floor((time - eventTable["roshDead"]) / 60)
		local sec = math.floor((time - eventTable["roshDead"]) % 60)
		Renderer.DrawText(notification.font2, timerX, timerY, 4 - min..":"..60 - sec)
	end
	if Menu.IsEnabled(notification.optionChatAlertEnable) and Menu.IsEnabled(notification.optionRunesAlertEnable) then
		notification.runesAlert()
	end
	if Menu.IsEnabled(notification.optionChatAlertEnable) and Menu.IsEnabled(notification.optionBaraAlertEnable) and bara then
		notification.baraAlert()
	end
end
function notification.OnEntityCreate(ent)
	if Entity.GetClassName(ent) == "C_DOTA_Item_Physical" then
		tempEnt = ent
	end
end
function notification.OnEntityDestroy(ent)
	if ent == aegisEnt then
		
		aegisEnt = nil
	end
end
function notification.OnDraw( ... )
	if not Menu.IsEnabled(notification.optionEnable) or not myHero then
		return
	end
	local drawed = 0
	if eventTable["roshAttack"] and time - eventTable["roshAttack"] <= 5 and time - eventTable["roshAttack"] > 0 then
		MiniMap.DrawCircle(Vector(-2253.187500, 1704.875000, 159.968750), 195, 255, 0, 255)
	end
	if eventTable["roshSpawn"] and time - eventTable["roshSpawn"] <= 5 then
		Renderer.SetDrawColor(255,0,255)
		MiniMap.DrawCircle(Vector(-2253.187500, 1704.875000, 159.968750), 195, 255, 0, 255)
		Renderer.DrawText(notification.font, x/2, y/2, "Roshan Respawned")
	end
	if eventTable["smoke"] and eventTable["smoke"] - time >= 0 then
		Renderer.SetDrawColor(255, 0, 0, 255)
		drawed = drawed + 1
		Renderer.DrawText(notification.font, alertX, alertY, "Smoke "..math.floor(eventTable["smoke"] - time))
		MiniMap.DrawCircle(posTable[eventTable["smoke"]], 255,0, 225)
		Renderer.SetDrawColor(255, 255, 255, 255) 
		Renderer.DrawImage(notification.cachedIcons[1], alertX - 24, alertY + 4, 22, 22)
	end
	if eventTable["vendetta"] and eventTable["vendetta"] - time >= 0 then
		Renderer.SetDrawColor(255, 0, 0, 255)
		local y = alertY + 25 * drawed
		drawed = drawed + 1
		Renderer.DrawText(notification.font, alertX, y, "Vendetta "..math.floor(eventTable["vendetta"] - time))
		MiniMap.DrawHeroIcon("npc_dota_hero_nyx_assassin", posTable[eventTable["vendetta"]], 255, 0, 0)
		Renderer.SetDrawColor(255, 255, 255, 255)
		Renderer.DrawImage(notification.cachedIcons[2], alertX - 24, y + 4, 22, 22)
	end
	if eventTable["moonlight"] and eventTable["moonlight"] - time >= 0 then
		local y = alertY + 25 * drawed
		Renderer.SetDrawColor(255, 0, 0, 255)
		Renderer.DrawText(notification.font, alertX, y, "Moon "..math.floor(eventTable["moonlight"] - time))
		Renderer.SetDrawColor(255, 255, 255, 255)
		Renderer.DrawImage(notification.cachedIcons[3], alertX - 24, y + 4, 22, 22)
	end
end
function notification.runesAlert( ... )
	if GameRules.GetGameStartTime() < 1 then
		return
	end
	local gameTime = time - GameRules.GetGameStartTime()
	if gameTime >= 300 then
		gameTime = gameTime % 300 
	end
	if math.floor(gameTime) == 285 and time >= nextTick then
		Engine.ExecuteCommand("chatwheel_say 58")
		nextTick = time + 1
	end
	if math.floor(gameTime) == 290 and time >= nextTick then
		Engine.ExecuteCommand("chatwheel_say 58")
		nextTick = time + 1
	end
	if math.floor(gameTime) == 295 and time >= nextTick then
		Engine.ExecuteCommand("chatwheel_say 58")
		nextTick = time + 1
	end
end
function notification.baraAlert( ... )
	if chargHero and not NPC.HasModifier(chargHero, "modifier_spirit_breaker_charge_of_darkness_vision") then
		if language == 0 then
			Engine.ExecuteCommand("say_team Бара остановил разбег")
		elseif language == 1 then
			Engine.ExecuteCommand("say_team Spirit Breaker has canceled his charge")
		else
			Engine.ExecuteCommand("say_team Бара зупинив розбіг")
		end	
		chargHero = nil
	end
	for i = 1, Heroes.Count() do
		local hero = Heroes.Get(i)
		local heroName = NPC.GetUnitName(hero)
		if NPC.HasModifier(hero, "modifier_spirit_breaker_charge_of_darkness_vision") and Entity.IsSameTeam(myHero, hero) and not chargHero then
			if language == 0 then
				Engine.ExecuteCommand("say_team Бара разгоняется на "..notification.HeroNameTable[heroName])
			elseif language == 1 then
				Engine.ExecuteCommand("say_team Spirit Breaker charging in "..notification.HeroNameTable[heroName])
			else
				Engine.ExecuteCommand("say_team Бара розганяється на "..notification.HeroNameTable[heroName])	
			end
			chargHero = hero
		end
	end
end
function notification.OnParticleCreate(particle)
	if not myHero or not Menu.IsEnabled(notification.optionEnable) then
		return
	end
	if particle.name == "roshan_spawn" then
		if Menu.IsEnabled(notification.optionRoshAlertEnable) and Menu.IsEnabled(notification.optionChatAlertEnable) then
			if language == 0 then
				Engine.ExecuteCommand("say_team Рошан реснулся")
			elseif language == 1 then
				Engine.ExecuteCommand("say_team Roshan has respawned")		
			else
				Engine.ExecuteCommand("say_team З'явився рошан")	
			end
		end
		roshAlive = true
		eventTable["roshSpawn"] = time
	end	
	if Menu.IsEnabled(notification.optionChatAlertEnable) then
		if Menu.IsEnabled(notification.optionSkillAlertEnable) then
			if particle.name == "sandking_epicenter_tell" then
				for i = 1, Heroes.Count() do
					local hero = Heroes.Get(i)
					local heroName = NPC.GetUnitName(hero)
					if heroName == "npc_dota_hero_sand_king" and not Entity.IsSameTeam(myHero, hero) then
						local ability = NPC.GetAbility(hero, "sandking_epicenter")
						Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_PING_ABILITY, ability, Vector(0,0,0), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
					end
				end
			end
			if particle.name == "sven_spell_gods_strength_ambient" or particle.name == "sven_spell_gods_strength" then
				for i = 1, Heroes.Count() do
					local hero = Heroes.Get(i)
					local heroName = NPC.GetUnitName(hero)
					if heroName == "npc_dota_hero_sven" and not Entity.IsSameTeam(myHero, hero) then
						local ability = NPC.GetAbility(hero, "sven_gods_strength")
						Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_PING_ABILITY, ability, Vector(0,0,0), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
					end
				end
			end
			if particle.name == "lycan_shapeshift_cast" then
				for i = 1, Heroes.Count() do
					local hero = Heroes.Get(i)
					local heroName = NPC.GetUnitName(hero)
					if heroName == "npc_dota_hero_lycan" and not Entity.IsSameTeam(myHero, hero) then
						local ability = NPC.GetAbility(hero, "lycan_shapeshift")
						Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_PING_ABILITY, ability, Vector(0,0,0), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
					end
				end
			end
		end	
	end
	if particle.name == "roshan_slam" and time >= roshTick then
		if Menu.IsEnabled(notification.optionRoshAlertEnable) and Menu.IsEnabled(notification.optionChatAlertEnable) then
			if language == 0 then
				Engine.ExecuteCommand("say_team Кто-то бьет рошана")
			elseif language == 1 then
				Engine.ExecuteCommand("say_team Roshan is under attack")		
			else
				Engine.ExecuteCommand("say_team Хтось б'є рошана")	
			end
		end
		eventTable["roshAttack"] = time
		roshTick = time + Menu.GetValue(notification.optionRoshAlertDelay)
	end
	if particle.name == "dropped_aegis" then
		if Menu.IsEnabled(notification.optionRoshAlertEnable) and Menu.IsEnabled(notification.optionChatAlertEnable) then
			local gameTime
			if GameRules.GetGameStartTime() >= 1 then
				gameTime = time - GameRules.GetGameStartTime()
			else
				gameTime = time
			end
			local min = math.floor(gameTime / 60)
			local sec = math.floor(gameTime % 60)
			if language == 0 then
				Engine.ExecuteCommand("say_team Рошан умер - "..min..":"..sec)
			elseif language == 1 then
				Engine.ExecuteCommand("say_team Roshan died at - "..min..":"..sec)
			else
				Engine.ExecuteCommand("say_team Рошан помер - "..min..":"..sec)	
			end
		end
		eventTable["roshDead"] = time
		roshAlive = false
	end
	if particle.name == "nyx_assassin_vendetta_start" and nyx then
		if Menu.IsEnabled(notification.optionChatAlertEnable) and Menu.IsEnabled(notification.optionSkillAlertEnable) then
			if language == 0 then
				Engine.ExecuteCommand("say_team Nyx использовал ультимейт")
			elseif language == 1 then				
				Engine.ExecuteCommand("say_team Nyx has used ultimate")		
			else
				Engine.ExecuteCommand("say_team Nyx використовував ультімейт")	
			end
		end
		eventTable["vendetta"] = time + notification.getVendettaDuration()
		idTable[particle.index] = time + notification.getVendettaDuration()
	end
	if particle.name == "mirana_moonlight_recipient" and mirana then
		if Menu.IsEnabled(notification.optionChatAlertEnable) and Menu.IsEnabled(notification.optionSkillAlertEnable) then
			if language == 0 then
				Engine.ExecuteCommand("say_team Вражеская мирана использовала ультимейт")
			elseif language == 1 then
				Engine.ExecuteCommand("say_team Mirana has used ultimate")		
			else
				Engine.ExecuteCommand("say_team Ворожа Мірана використовувала ультімейт")	
			end
		end
		eventTable["moonlight"] = time + 18
	end
	if particle.name == "smoke_of_deceit" then
		if Menu.IsEnabled(notification.optionChatAlertEnable) and Menu.IsEnabled(notification.optionSkillAlertEnable) then
			if language == 0 then
				Engine.ExecuteCommand("say_team Кто-то использовал смок")
			elseif language == 1 then
				Engine.ExecuteCommand("say_team Smoke has been used")		
			else
				Engine.ExecuteCommand("say_team Хтось використовав смок")	
			end
		end
		eventTable["smoke"] = time + 35
		idTable[particle.index] = time + 35
	end
end
function notification.OnParticleUpdate(particle)
	for i, k in pairs(idTable) do
		if particle.index == i then
			posTable[k] = particle.position
			idTable[i] = nil
		end
	end
end
function notification.OnUnitAnimation(animation)
	if not Menu.IsEnabled(notification.optionEnable) then return end
	if animation.sequenceName == "roshan_attack" or animation.sequenceName == "roshan_attack2" then
		if Menu.IsEnabled(notification.optionChatAlertEnable) and Menu.IsEnabled(notification.optionRoshAlertEnable) and time >= roshTick then
			local language = Menu.GetValue(notification.optionLanguage)
			if language == 0 then
				Engine.ExecuteCommand("say_team Кто-то бьет рошана")
			elseif language == 1 then
				Engine.ExecuteCommand("say_team Roshan is under attack")
			else
				Engine.ExecuteCommand("say_team Хтось б'є рошана")	
			end
			roshTick = time + Menu.GetValue(notification.optionRoshAlertDelay)	
		end
		eventTable["roshAttack"] = time
	end
end
function notification.getVendettaDuration()
	if not nyx or not vendetta or Ability.GetLevel(vendetta) == 0 then
		return 0 
	end
	if Ability.GetLevel(vendetta) == 1 then
		return 40
	elseif Ability.GetLevel(vendetta) == 2 then
		return 50
	else
		return 60
	end	
end
function notification.OnModifierCreate(ent, mod)
	if not myHero or not Menu.IsEnabled(notification.optionEnable) or not Menu.IsEnabled(notification.optionChatAlertEnable) or not Menu.IsEnabled(notification.optionSkillAlertEnable) then
		return
	end
	if Modifier.GetName(mod) == "modifier_invoker_sun_strike" then
		for i = 1, Heroes.Count() do
			local hero = Heroes.Get(i)
			local heroName = NPC.GetUnitName(hero)
			if heroName == "npc_dota_hero_invoker" and not Entity.IsSameTeam(myHero, hero) then
				local ability = NPC.GetAbility(hero, "invoker_sun_strike")
				Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_PING_ABILITY, ability, Vector(0,0,0), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
			end
		end
	end
	if Modifier.GetName(mod) == "modifier_kunkka_torrent_thinker" then
		for i = 1, Heroes.Count() do
			local hero = Heroes.Get(i)
			local heroName = NPC.GetUnitName(hero)
			if heroName == "npc_dota_hero_kunkka" and not Entity.IsSameTeam(myHero, hero) then
				local ability = NPC.GetAbility(hero, "kunkka_torrent")
				Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_PING_ABILITY, ability, Vector(0,0,0), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
			end
		end
	end
	if Modifier.GetName(mod) == "modifier_lina_light_strike_array" then
		for i = 1, Heroes.Count() do
			local hero = Heroes.Get(i)
			local heroName = NPC.GetUnitName(hero)
			if heroName == "npc_dota_hero_invoker" and not Entity.IsSameTeam(myHero, hero) then
				local ability = NPC.GetAbility(hero, "invoker_sun_strike")
				Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_PING_ABILITY, ability, Vector(0,0,0), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
			end
		end
	end
	if Modifier.GetName(mod) == "modifier_tusk_snowball_visible" then
		for i = 1, Heroes.Count() do
			local hero = Heroes.Get(i)
			local heroName = NPC.GetUnitName(hero)
			if heroName == "npc_dota_hero_tusk" and not Entity.IsSameTeam(myHero, hero) then
				local ability = NPC.GetAbility(hero, "tusk_snowball")
				Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_PING_ABILITY, ability, Vector(0,0,0), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
			end
		end
	end
	if Modifier.GetName(mod) == "modifier_leshrac_split_earth_thinker" then
		for i = 1, Heroes.Count() do
			local hero = Heroes.Get(i)
			local heroName = NPC.GetUnitName(hero)
			if heroName == "npc_dota_hero_leshrac" and not Entity.IsSameTeam(myHero, hero) then
				local ability = NPC.GetAbility(hero, "leshrac_split_earth")
				Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_PING_ABILITY, ability, Vector(0,0,0), ability, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, myHero)
			end
		end
	end
end
notification.Init()
return notification