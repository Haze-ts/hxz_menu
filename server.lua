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
    local Trigger = ESX.GetPlayerFromId(source)

    if Permission(Trigger) then
        if xPlayer == nil then
            TriggerClientEvent('esx:showNotification', source, 'Player non trovato')
        else
            SetPedArmour(xPlayer.source, 100)
        end
    else
        DropPlayer(source, Lang['NOTIFY_DROP_TRIGGER'])
    end
end)

RegisterNetEvent('hxz:wipepg')
AddEventHandler('hxz:wipepg', function(id)
    local xPlayer = ESX.GetPlayerFromId(id)
    local Trigger = ESX.GetPlayerFromId(source)

    if Permission(Trigger) then
        if xPlayer == nil then
            TriggerClientEvent('esx:showNotification', source, Lang['NOTIFY_PLAYER_NOT_FOUND'])
        else
            DropPlayer(id, Lang['NOTIFY_DROP_PLAYER'])
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
    else
        DropPlayer(source, Lang['NOTIFY_DROP_TRIGGER'])
    end
end)

RegisterServerEvent('hxz:setVehicle')
AddEventHandler('hxz:setVehicle', function (vehicleProps, playerID, VehicleType, plate)
	local _source = playerID
	local xPlayer = ESX.GetPlayerFromId(_source)
    local Trigger = ESX.GetPlayerFromId(source)


    if Permission(Trigger) then
        MySQL.Sync.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, stored, type) VALUES (@owner, @plate, @vehicle, @stored, @type)',
        {
            ['@owner']   = xPlayer.identifier,
            ['@plate']   = vehicleProps.plate,
            ['@vehicle'] = json.encode(vehicleProps),
            ['@stored']  = 1,
            ['@state']   = 0,
            ['type'] = VehicleType
        }, function ()
        end)
    else
        DropPlayer(source, Lang['NOTIFY_DROP_TRIGGER'])
    end
end)


function Permission(Trigger)
	for k,v in ipairs(Config.Staff) do
		if Trigger.getGroup() == v then 
			return true 
		end
	end
	return false
end