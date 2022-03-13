


-- Citizen.CreateThread(function()
--     while true do
--         Citizen.Wait(500)
--             if IsPedArmed(GetPlayerPed(-1), 6) then
--                 SendNUIMessage({
--                     action = "toggle",
--                     show = IsPlayerFreeAiming(PlayerId()),
--                 })
--             else
--                 SendNUIMessage({
--                     action = "toggle",
--                     show = false,
--                 })
--                 Citizen.Wait(250)
--             end
--     end
-- end)


-- Avoid accident punch someone when using inventory or phone
Citizen.CreateThread(function()
    while true do
    Citizen.Wait(0)
    DisableControlAction(0, 140, true) -- Disable the Light Dmg Contr ol
    SetPedStealthMovement(GetPlayerPed(-1),false,"")
	-- HideHudComponentThisFrame( 14 )
    if not IsPlayerTargettingAnything(PlayerId()) then
    DisableControlAction(1, 141, true)
    DisableControlAction(1, 142, true)
    end
    end
    end)
local zones = {
	{ ['x'] = -630.787292, ['y'] = -362.844727, ['z'] = 34.811371},
	
}
-- RegisterCommand("pprpParachute", function(source, args, rawCommand)
--     GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("GADGET_PARACHUTE"), true)
-- end, false)
-- RegisterNetEvent('qb-parachute:client:add')
-- AddEventHandler('qb-parachute:client:add', function()
--     GiveWeaponToPed(GetPlayerPed(-1), GetHashKey("GADGET_PARACHUTE"), true)
-- end)
local notifIn = false
local notifOut = false
local closestZone = 1

Citizen.CreateThread(function()
    while true do
		ClearAreaOfVehicles(-630.787292,  -362.844727, 34.811371, 18.0, false, false, false, false, false);
        Citizen.Wait(50)
    end
end)

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	while true do
	
		Citizen.Wait(100)
		local player = GetPlayerPed(-1)
		local x,y,z = table.unpack(GetEntityCoords(player, true))
		local dist = Vdist(zones[closestZone].x, zones[closestZone].y, zones[closestZone].z, x, y, z)
	
		if dist <= 8.0 then  ------------------------------------------------------------------------------ Here you can change the RADIUS of the Safe Zone. Remember, whatever you put here will DOUBLE because 

		 local v3 = vector4(-622.540527, -371.142242, 35.769272,46.588688)
			 SetEntityCoords(PlayerPedId(), v3.x, v3.y, v3.z, true, true, true, false)
			 SetEntityHeading(PlayerPedId(), v3.w)
			if not notifIn then																			  -- it is a sphere. So 50 will actually result in a diameter of 100. I assume it is meters. No clue to be honest.
				NetworkSetFriendlyFireOption(false)
				ClearPlayerWantedLevel(PlayerId())
				SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
				notifIn = true
				notifOut = false
			end
		else
			if not notifOut then
				NetworkSetFriendlyFireOption(true)
				notifOut = true
				notifIn = false
			end
		end
	end
end)

RegisterNetEvent('qb-weapons:client:remove:dot')
AddEventHandler('qb-weapons:client:remove:dot', function()
 if not IsPlayerFreeAiming(PlayerId()) then
    SendNUIMessage({
        action = "toggle",
        show = false,
    })
 end
end)