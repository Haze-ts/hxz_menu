RegisterServerEvent("NoclipStatus")
AddEventHandler("NoclipStatus",function (arg)
    Noclip = arg
end)

ESX.RegisterServerCallback("hxz:checkgroup", function(source, cb)
    local player = ESX.GetPlayerFromId(source)

    if player ~= nil then
        local playerGroup = player.getGroup()

        if playerGroup ~= nil then 
            cb(playerGroup)
        else
            cb("user")
        end
    else
        cb("user")
    end
end)


ESX.RegisterServerCallback('hxz:checkTarget', function(source, cb, target)
    local xTarget = ESX.GetPlayerFromId(target)
    if xTarget then
        cb(xTarget.identifier)
    end
end)

RegisterNetEvent("hxz:bullet")
AddEventHandler("hxz:bullet", function(id)
    local xPlayer = ESX.GetPlayerFromId(id)
    if xPlayer == nil then
        TriggerClientEvent('esx:showNotification', source, 'Player non trovato')
    else
        SetPedArmour(xPlayer.source, 100)
    end
end)

RegisterServerEvent('hxz:wipepg')
AddEventHandler('hxz:wipepg', function(id)

    local xPlayer = ESX.GetPlayerFromId(id)
    if xPlayer == nil then
        TriggerClientEvent('esx:showNotification', source, Lang['notify_player_not_found'])
    else
        DropPlayer(id, Lang['drop_notify'])

        MySQL.Sync.execute('DELETE FROM billing WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        })
        MySQL.Sync.execute('DELETE FROM datastore_data WHERE owner = @identifier', {
            ['@identifier'] = xPlayer.identifier
        })
        MySQL.Sync.execute('DELETE FROM owned_properties WHERE owner = @identifier', {
            ['@identifier'] = xPlayer.identifier
        })
        MySQL.Sync.execute('DELETE FROM owned_vehicles WHERE owner = @identifier', {
            ['@identifier'] = xPlayer.identifier
        })
        MySQL.Sync.execute('DELETE FROM users WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        })
        MySQL.Sync.execute('DELETE FROM user_licenses WHERE owner = @identifier', {
            ['@identifier'] = xPlayer.identifier
        })
        MySQL.Sync.execute('DELETE FROM multicharacter_slots WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        })
        MySQL.Sync.execute('DELETE FROM tattoos WHERE identifier = @identifier', {
            ['@identifier'] = xPlayer.identifier
        })
    end
end)