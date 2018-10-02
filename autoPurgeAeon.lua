local autoPurgeAeon = {}
autoPurgeAeon.optionEnable = Menu.AddOptionBool({"Utility"}, "Auto Purge Aeon Disk", false)
local myHero, myPlayer, myTeam
local skill
local skillCheck = nil
local purged = {}
function autoPurgeAeon.Init( ... )
	myHero = Heroes.GetLocal()
	skill = nil
	skillCheck = nil
	if not myHero then
		return
	end
	if NPC.GetUnitName(myHero) == "npc_dota_hero_oracle" then
		skill = NPC.GetAbility(myHero, "oracle_fortunes_end")
		skillCheck = 2
	elseif NPC.GetUnitName(myHero) == "npc_dota_hero_enchantress" then
		skill = NPC.GetAbility(myHero, "enchantress_enchant")
	elseif NPC.GetUnitName(myHero) == "npc_dota_hero_doom_bringer" then
		skill = NPC.GetAbility(myHero, "doom_bringer_doom")
	elseif NPC.GetUnitName(myHero) == "npc_dota_hero_shadow_demon" then
		skill = NPC.GetAbility(myHero, "shadow_demon_demonic_purge")
	elseif NPC.GetUnitName(myHero) == "npc_dota_hero_sven" then
		skill = NPC.GetAbility(myHero, "sven_storm_bolt")
		skillCheck = 1		
	end	
	myPlayer = Players.GetLocal()
	myTeam = Entity.GetTeamNum(myHero)
end
function autoPurgeAeon.OnGameStart( ... )
	autoPurgeAeon.Init()
end
function Ability.CanBeCastInMagicImmune(ability)
	if Ability.GetName(ability) == "doom_bringer_doom" or Ability.GetName(ability) == "shadow_demon_demonic_purge" then
		return true
	end
	return false	
end
function autoPurgeAeon.OnUpdate( ... )
	if not myHero or not Menu.IsEnabled(autoPurgeAeon.optionEnable) then
		return
	end
	local myMana = NPC.GetMana(myHero)
	local nullifier = NPC.GetItem(myHero, "item_nullifier")
	local tempTable = Entity.GetHeroesInRadius(myHero, 2000, Enum.TeamType.TEAM_ENEMY)
	if tempTable then
		for i, k in pairs(tempTable) do
			if NPC.HasModifier(k, "modifier_item_aeon_disk_buff") then
				local mod = NPC.GetModifier(k, "modifier_item_aeon_disk_buff")
				if nullifier and Ability.IsCastable(nullifier, myMana) and NPC.IsEntityInRange(myHero, k, Ability.GetCastRange(nullifier)) and not purged[mod] and not NPC.HasState(k, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
					Ability.CastTarget(nullifier, k)
					purged[mod] = true
					return
				end
				if skill and NPC.IsEntityInRange(myHero,k,Ability.GetCastRange(skill)) then
					if NPC.HasState(k, Enum.ModifierState.MODIFIER_STATE_MAGIC_IMMUNE) then
						if not Ability.CanBeCastInMagicImmune(skill) then
							return
						end
					end
					if skillCheck == 1 then
						if Ability.GetLevel(NPC.GetAbility(myHero, "special_bonus_unique_sven_3")) > 0 and not purged[mod] then
							if Ability.IsCastable(skill, myMana) then
								Ability.CastTarget(skill, k)
								purged[mod] = true
								return
							end
						end
					elseif skillCheck == 2 then
						if Ability.IsCastable(skill, myMana) then
							Ability.CastTarget(skill,k )
							purged[mod] = true
						end
						if Ability.IsChannelling(skill) then
							Player.HoldPosition(myPlayer, myHero)
						end	
					else
						if Ability.IsCastable(skill, myMana) and not purged[mod] then
							Ability.CastTarget(skill, k)
							purged[mod] = true
							return
						end
					end
				end
			end
		end
	end
end

autoPurgeAeon.Init()
return autoPurgeAeon