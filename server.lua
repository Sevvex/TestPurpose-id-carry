RegisterServerEvent('carry:requestCarry')
AddEventHandler('carry:requestCarry', function(target)
    local source = source
    if target and GetPlayerPing(target) > 0 then
        TriggerClientEvent('carry:carryPlayer', target, source)
    else
        TriggerClientEvent('chat:addMessage', source, { args = { 'Carry', 'Player not found or offline.' } })
    end
end)
