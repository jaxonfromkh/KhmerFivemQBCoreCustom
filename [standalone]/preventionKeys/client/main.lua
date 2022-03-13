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
