--[[ TO DO
	WEAVER, TA
	
--]]
local AutoDust = {}
local index
local myHero
local riki = nil
local treant = nil
local nyx = nil
local sandking = nil
local dust
local checked = {}
local pos = {}
AutoDust.optionEnable = Menu.AddOptionBool({"Utility", "Auto Dust"}, "Enable", false)
function AutoDust.Init( ... )
	myHero = Heroes.GetLocal()
	checked = {}
	if not myHero then return end
	riki = nil
	treant = nil
	nyx = nil
	sandking = nil
end
function AutoDust.OnGameStart( ... )
	AutoDust.Init()
end
function AutoDust.OnUpdate()
	if not Menu.IsEnabled(AutoDust.optionEnable) then return end
	if not myHero then return end
	dust = NPC.GetItem(myHero, "item_dust")
	if not dust then return end
	if not checked[Heroes.Count()] then
		for i = 1, Heroes.Count() do
			local hero = Heroes.Get(i)
			if NPC.GetUnitName(hero) == "npc_dota_hero_riki" and not Entity.IsSameTeam(myHero, hero) then
				riki = hero
			elseif NPC.GetUnitName(hero) == "npc_dota_hero_treant" and not Entity.IsSameTeam(myHero, hero) then
				treant = hero
			elseif NPC.GetUnitName(hero) == "npc_dota_hero_nyx_assassin" and not Entity.IsSameTeam(myHero, hero) then
				nyx = hero
			elseif NPC.GetUnitName(hero) == "npc_dota_hero_sand_king" and not Entity.IsSameTeam(myHero, hero) then
				sandking = hero	
			end		
		end
		checked[Heroes.Count()] = true
	end
	if riki then
		if NPC.IsVisible(riki) and NPC.IsEntityInRange(riki,myHero,950) then
			if Ability.GetLevel(NPC.GetAbilityByIndex(riki, 2)) > 0 then
				if Ability.GetCooldown(NPC.GetAbilityByIndex(riki,2)) <= 1 and not Ability.IsReady(NPC.GetAbilityByIndex(riki,2)) then
					if Ability.IsReady(dust) then
 						Ability.CastNoTarget(dust)
 					end
				end
			end
		end
	end
	if treant then
		if NPC.IsVisible(treant) and NPC.IsEntityInRange(treant,myHero,950) then
			if Ability.GetLevel(NPC.GetAbilityByIndex(treant,0)) > 0 then
				if Ability.GetCooldown(NPC.GetAbilityByIndex(treant,0)) <= 1 and not Ability.IsReady(NPC.GetAbilityByIndex(treant,0)) then
					if Ability.IsReady(dust) then
						Ability.CastNoTarget(dust)
					end
				end
			end
		end
	end
	if index and pos[index] then
		if NPC.IsPositionInRange(myHero,pos[index],950) then
			if Ability.IsReady(dust) then
				Ability.CastNoTarget(dust)
			end
			pos[index] = nil
			index = nil
		else
			pos[index] = nil
			index = nil
		end
	end
end
function AutoDust.OnParticleCreate(particle)
	if not myHero or not Menu.IsEnabled(AutoDust.optionEnable) then return end
	--Log.Write(tostring(sandking))
	if (particle.name == "nyx_assassin_vendetta_start" and nyx) or (particle.name == "sandking_sandstorm" and sandking) then
		--Log.Write("!")
		index = particle.index
	end
end
function AutoDust.OnParticleUpdate(particle)
	if not myHero or not Menu.IsEnabled(AutoDust.optionEnable) then return end
	if particle.index == index and not pos[particle.index] then
		pos[particle.index] = particle.position
	end
end
function AutoDust.OnModifierCreate(ent,mod)
	if not myHero or not Menu.IsEnabled(AutoDust.optionEnable) then return end
	if not dust then return end
	if Modifier.GetName(mod) == "modifier_item_invisibility_edge_windwalk" and NPC.GetUnitName(ent) == "npc_dota_hero_invoker" then
		if not NPC.HasItem(ent, "item_invis_sword") or Ability.IsReady(NPC.GetItem(ent, "item_invis_sword")) then
			return
		end
	end
	if Entity.IsSameTeam(myHero, ent) or NPC.HasModifier(ent,"modifier_bounty_hunter_track") or NPC.HasModifier(ent, "modifier_bloodseeker_thirst_vision") or NPC.HasModifier(ent, "modifier_slardar_amplify_damage") or NPC.HasModifier(ent, "modifier_item_dustofappearance") or ent == myHero or NPC.HasState(myHero, Enum.ModifierState.MODIFIER_STATE_INVISIBLE) then return end
	--Log.Write(Modifier.GetName(mod))
	if (Modifier.GetName(mod) == "modifier_item_invisibility_edge_windwalk" or Modifier.GetName(mod) == "modifier_item_glimmer_cape_fade" or Modifier.GetName(mod) == "modifier_item_shadow_amulet_fade" or Modifier.GetName(mod) == "modifier_rune_invis" or Modifier.GetName(mod) == "modifier_oracle_false_promise_invis" or Modifier.GetName(mod) == "modifier_mirana_moonlight_shadow" or Modifier.GetName(mod) == "modifier_clinkz_wind_walk" or Modifier.GetName(mod) == "modifier_item_silver_edge_windwalk" or Modifier.GetName(mod) == "modifier_bounty_hunter_wind_walk" or Modifier.GetName(mod) == "modifier_invoker_ghost_walk_self" or Modifier.GetName(mod) == "modifier_windrunner_windrun_invis") and Entity.GetAbsOrigin(ent) and NPC.IsPositionInRange(myHero, Entity.GetAbsOrigin(ent), 950) then
		if Ability.IsReady(dust) then
			--Log.Write("using -- "..Modifier.GetName(mod))
			Ability.CastNoTarget(dust)
		end
	end
end
AutoDust.Init()
return AutoDust