local courierReuse = {}
courierReuse.optionEnable = Menu.AddOptionBool({"Utility", "Courier"}, "Enabled", false)
courierReuse.optionKey = Menu.AddKeyOption({ "Utility", "Courier"}, "Toggle to reuse", Enum.ButtonCode.KEY_T)
courierReuse.optionMuteFilter = Menu.AddOptionBool({"Utility", "Courier"}, "Mute Filter", false)
local players = {}
local muted = {}
local added = false
local myHero, myPlayer, myTeam, courier, x, y
local bReuse = false
local font = Renderer.LoadFont("Tahoma", 18, Enum.FontWeight.BOLD)
function courierReuse.Init( ... )
	myHero = Heroes.GetLocal()
	myPlayer = Players.GetLocal()
	if not myHero then return end
	myTeam = Entity.GetTeamNum(myHero)
	x, y = Renderer.GetScreenSize()
	courier = nil
	cReuse = false
	added = false
	x = x * 0.8785
	y = y * 0.879
	for i = 1, 10 do
		if players[i] then
			Menu.RemoveOption(players[i])
		end
	end
end
function courierReuse.OnGameStart( ... )
	courierReuse.Init()
end
function courierReuse.OnDraw( ... )
	if not myHero then return end
	if bReuse then
		Renderer.SetDrawColor(0,255,0)
		Renderer.DrawText(font,x,y,"сReuse")
	end
end
function courierReuse.OnUpdate( ... )
	if not myHero or not Menu.IsEnabled(courierReuse.optionEnable) then return end
	if Menu.IsKeyDownOnce(courierReuse.optionKey) then
		if bReuse then
			bReuse = false
		else
			bReuse = true
		end
	end
	if not added then
		for i = 1, Heroes.Count() do
			local hero = Heroes.Get(i)
			if Entity.IsSameTeam(myHero, hero) and hero ~= myHero then
				players[Hero.GetPlayerID(hero)] = Menu.AddOptionBool({"Utility", "Courier"}, string.upper(string.sub(NPC.GetUnitName(hero), 15)), false)
			end
		end
		added = true
	end
	for i = 1, Players.Count() do
		local player = Players.Get(i)
		if Player.IsMuted(player) then
			muted[Player.GetPlayerID(player)] = Player.GetPlayerID(player)
		else
			muted[Player.GetPlayerID(player)] = nil
		end
	end
	if not courier then
		for i = 1, Couriers.Count() do
			local npc = Couriers.Get(i)
			if Entity.IsSameTeam(npc, myHero) then
				courier = npc
			end
		end
	end
	if courier and Entity.IsAlive(courier) then
		local courierEnt = Courier.GetCourierStateEntity(courier)
		local reuse = NPC.GetAbilityByIndex(courier, 4)
		local reuse2 = NPC.GetAbilityByIndex(courier, 3)
		local go_home = NPC.GetAbilityByIndex(courier, 0)
		if bReuse and courierEnt ~= myHero then
			local hasItem = false
			local pickItem = false
			for i = 0, 8 do
				if NPC.GetItemByIndex(courier,i) and NPC.GetItemByIndex(courier,i) ~= 0 and Item.GetPlayerOwnerID(NPC.GetItemByIndex(courier,i)) == Hero.GetPlayerID(myHero) then
					hasItem = true
					break	
				end
			end
			for i = 9, 14 do
				if NPC.GetItemByIndex(myHero, i) and NPC.GetItemByIndex(myHero, i) ~= 0 and Item.GetPlayerOwnerID(NPC.GetItemByIndex(myHero, i)) == Hero.GetPlayerID(myHero) then
					pickItem = true
					break
				end
			end
			if pickItem and Entity.IsAlive(myHero) and NPC.HasInventorySlotFree(courier) and NPC.HasInventorySlotFree(myHero) then
				Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET, nil, Vector(0,0,0), reuse2, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, courier)
			elseif hasItem and Entity.IsAlive(myHero) then
				Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET, nil, Vector(0, 0, 0), reuse, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, courier)
			end
		end
		if courierEnt and players[Hero.GetPlayerID(courierEnt)] then
			if (Menu.IsEnabled(courierReuse.optionMuteFilter) and muted[Hero.GetPlayerID(courierEnt)] and Hero.GetPlayerID(courierEnt) == muted[Hero.GetPlayerID(courierEnt)] ) or Menu.IsEnabled(players[Hero.GetPlayerID(courierEnt)]) then
				Player.PrepareUnitOrders(myPlayer, Enum.UnitOrder.DOTA_UNIT_ORDER_CAST_NO_TARGET, nil, Vector(0, 0, 0), go_home, Enum.PlayerOrderIssuer.DOTA_ORDER_ISSUER_PASSED_UNIT_ONLY, courier)
			end
		end	
	end	
end
courierReuse.Init()
return courierReuse