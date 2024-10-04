local carryingPlayer = nil

RegisterNetEvent('carry:carryPlayer')
AddEventHandler('carry:carryPlayer', function(target)
    local playerPed = PlayerPedId()
    local targetPed = GetPlayerPed(GetPlayerFromServerId(target))

    if not IsPedInAnyVehicle(playerPed, false) and not IsPedInAnyVehicle(targetPed, false) then
        if not carryingPlayer then
            AttachEntityToEntity(playerPed, targetPed, 0, 0.0, 0.5, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
            carryingPlayer = target
            TriggerEvent('carry:startCarry')
        else
            DetachEntity(playerPed, true, false)
            carryingPlayer = nil
            TriggerEvent('carry:stopCarry')
        end
    end
end)

RegisterCommand('carry', function(source, args)
    local target = tonumber(args[1])

    if target then
        TriggerServerEvent('carry:requestCarry', target)
    else
        print("You must specify a player ID!")
    end
end, false)


Citizen.CreateThread(function()
    while true do
        Wait(0)
        if carryingPlayer then
            if IsPedDeadOrDying(PlayerPedId(), true) then
                DetachEntity(PlayerPedId(), true, false)
                carryingPlayer = nil
            end
        end
    end
end)

AddEventHandler('carry:startCarry', function()
    print('You are now carrying someone.')
end)

AddEventHandler('carry:stopCarry', function()
    print('You have stopped carrying someone.')
end)
