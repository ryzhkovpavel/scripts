local wisp = {}
wisp.optionEnable = Menu.AddOptionBool({"Hero Specific", "Io"}, "Auto TP After Relocate", false)
wisp.toggleKey = Menu.AddKeyOption({"Hero Specific", "Io"}, "Toggle Key", Enum.ButtonCode.KEY_NONE)
local font = Renderer.LoadFont("Tahoma", 18, Enum.FontWeight.BOLD)
local toggled1 = false
local base = nil
local myHero
local myTeam
local dieTime
local x,y
function wisp.Init()
	myHero = Heroes.GetLocal()
	myTeam = Entity.GetTeamNum(myHero)
	if myTeam == 3 then 
		base = Vector(7264.000000, 6560.000000, 512.000000)
	else
		base = Vector(-7317.406250, -6815.406250, 512.000000)
	end
	x,y = Renderer.GetScreenSize()
	x = x * 0.59
	y = y * 0.8426
end
function wisp.OnGameStart()
	wisp.Init()
end
function wisp.OnUpdate() 
	if not Menu.IsEnabled(wisp.optionEnable) or not myHero then return end
	if NPC.GetUnitName(myHero) ~= "npc_dota_hero_wisp" then return end
	if Menu.IsKeyDownOnce(wisp.toggleKey) then
		if toggled1 == false then
			toggled1 = true
		else
			toggled1 = false
		end
	end
	if not toggled1 then return end
	if NPC.HasModifier(myHero, "modifier_wisp_relocate_return") then
		local mod = NPC.GetModifier(myHero, "modifier_wisp_relocate_return")
		local tp = NPC.GetItemByIndex(myHero, 15)
		if not tp then
			tp = NPC.GetItem(myHero, "item_travel_boots", true)
			if not tp then
				tp = NPC.GetItem(myHero, "item_travel_boots_2", true)
			end
		end
		if not dieTime then
			dieTime = Modifier.GetCreationTime(mod) + 12
		end
		if tp and Ability.IsReady(tp) and dieTime - GameRules.GetGameTime() <= 2.96 + NetChannel.GetAvgLatency(Enum.Flow.FLOW_OUTGOING) then
			Ability.CastPosition(tp, base)
		end
	else
		dieTime = nil	
	end
end
function wisp.OnDraw()
	if not Menu.IsEnabled(wisp.optionEnable) or not myHero then return end
	if NPC.GetUnitName(myHero) ~= "npc_dota_hero_wisp" then return end
	if toggled1 then
		Renderer.SetDrawColor(90, 255, 100)
		Renderer.DrawText(font,x,y, "[Auto-TP: ON]")
	else
		Renderer.SetDrawColor(255, 90, 100)
		Renderer.DrawText(font, x, y, "[Auto-TP: OFF]")
	end	
end
wisp.Init()
return wisp