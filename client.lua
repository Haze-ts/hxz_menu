local inGodMode = false
local inGhostMode = false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function (job)
    ESX.PlayerData.job = job
end)

--Main Menu
function MainMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'informazioni_personali',
	  {
		  title    = "HXZ - menu principale",
		  align = 'top-left',
		  elements = {	  			  
			{label = Lang["PERSONAL_INFORMATIONS"],				value = 'info_menu'}, 
			{label = Lang['PERSONAL_WALLET'] ,      			value = 'wallet_menu'}, 
			{label = Lang["CLOTHES_MANAGEMENT"] ,  				value = 'clothes_menu'}, 
			{label = Lang["ACCESSORY_MANAGEMENT"],				value = 'accessory_menu'},
			{label = Lang["BULLET_MANAGEMENT"],					value = 'bullet'},
			{label = Lang["SIM_MANAGEMENT"]    ,               	value =  "sim"},
			{label = Lang["BILLING_MANAGEMENT"], 				value = 'billing_menu'},
			{label = Lang["THIEF_MENU"], 						value = 'thieft_menu'},
			{label = Lang['ROCKSTAR_EDITOR'], 					value = 'rockstar'},
			{label = Lang["ADMINISTRATION_MENU"], 				value = 'administration'},
		  	}
	  },function(data, menu)

		if data.current.value == 'info_menu' then
			PlayerInfoMenu()
		elseif data.current.value == 'wallet_menu' then
			WalletMenu()
		elseif data.current.value == "clothes_menu" then
			ClothesMenu()
		elseif data.current.value == "accessory_menu" then
			AccessoryMenu()
		elseif data.current.value == "bullet" then
			TriggerEvent('hxz:menubullet')
		elseif data.current.value == "sim" then
			TriggerEvent(Config.TriggerSimMenu)
		elseif data.current.value == "thieft_menu" then
			ThiefMenu()
		elseif data.current.value == "billing_menu" then
			TriggerEvent(Config.TriggerBillingMenu)
		elseif data.current.value == 'rockstar' then
			RockstarEditor()
		elseif data.current.value == 'administration' then
			ESX.TriggerServerCallback("hxz:checkgroup", function(playerRank)
       		if playerRank == "admin" or playerRank == "superadmin" then
				OpenAdminMenu()
	  		else 
		 		ESX.ShowNotification(Lang['NOTIFY_PERMISSION'])
	  		end
		end)
        end
	end, function(data, menu)
		menu.close()
	end)
end

--Wallet
function WalletMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'gestione_documenti',
	  {
		  title    = "HXZ - Gestione Documenti",
		  align = 'top-left',
		  elements = {	  			  
			{label = Lang['SHOW_DOCUMENT'] ,			value = 'show_document'}, 
			{label = Lang['VIEW_DOCUMENT'],		    	value = 'view_document'},
			{label = Lang['SHOW_DRIVING_LICENSE'],		value = 'show_driving_license'},
			{label = Lang['VIEW_DRIVING_LICENSE'],		value = 'view_driving_license'},
			{label = Lang['SHOW_WEAPON_LICENSE'],		value = 'show_weapon_license'},
			{label = Lang['VIEW_WEAPON_LICENSE'],		value = 'view_weapon_license'},
		  	}
	  },function(data, menu)
		if data.current.value == 'show_document' then
			local playerVicino, playerDistanza = ESX.Game.GetClosestPlayer()
			if playerVicino ~= -1 and playerDistanza <= 3.0 then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(playerVicino))
			else
				ESX.ShowNotification(Lang['NOTIFY_PLAYER_NOT_CLOSE'])
			end
		elseif data.current.value == 'view_document' then
			menu.close()
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
		elseif data.current.value == 'show_driving_license' then
			local playerVicino, playerDistanza = ESX.Game.GetClosestPlayer()
			if playerVicino ~= -1 and playerDistanza <= 3.0 then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(playerVicino), 'driver')
			else
				ESX.ShowNotification(Lang['NOTIFY_PLAYER_NOT_CLOSE'])
			end
		elseif data.current.value == 'view_driving_license' then
			print('Patente Mostrata')
			menu.close()
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
		elseif data.current.value == 'show_weapon_license' then
			local playerVicino, playerDistanza = ESX.Game.GetClosestPlayer()
			if playerVicino ~= -1 and playerDistanza <= 3.0 then
				TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(playerVicino), 'weapon')
			else
				ESX.ShowNotification(Lang['NOTIFY_PLAYER_NOT_CLOSE'])
			end
		elseif data.current.value == 'view_weapon_license' then
			menu.close()
			TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
		end
	end, function(data, menu)
		menu.close()
		MainMenu()
	end)
end


--Player Info
function PlayerInfoMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'player_info',
	  {
		  title    = "HXZ - Informazioni personali",
		  align = 'top-left',
		  elements = {	  			  
			{label = Lang["PERSONAL_ID"]   		        ..GetPlayerServerId(NetworkGetEntityOwner(PlayerPedId()))}, 
			{label = Lang["PERSONAL_STEAM_NAME"]		..GetPlayerName(NetworkGetEntityOwner(PlayerPedId()))},
			{label = Lang["PERSONAL_JOB"]      			..ESX.PlayerData.job.label}, 
			{label = Lang["PERSONAL_MONEY"]				..ESX.PlayerData.money},
		  	}
	  },function(data, menu)
		menu.close()
		MainMenu()
	end, function(data, menu)
		menu.close()
		MainMenu()
	end)
end

--Clothes Menu
function ClothesMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'vestiti',
	  {
		  title    = "HXZ - Menu Vestiti",
		  align = 'top-left',
		  elements = {	  	
			{label = Lang['JACKET'], 		value = "giacca"},
			{label = Lang["SHIRT"], 		value = "shirt"},
			{label = Lang["PANTS"],			value = "pantaloni"},
			{label = Lang["SHOES"], 		value = "scarpe"},
			{label = Lang["BULLET"], 		value = "giubbotto"},	
			{label = Lang['RESET_PERSONAL DRESS'], 		value = "base_skin"}, 
		  	}
	  },function(data, menu)
		if data.current.value == 'base_skin' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)

				local model = nil
		  
				if skin.sex == 0  then
					model = GetHashKey("mp_m_freemode_01")
				else
					model = GetHashKey("mp_f_freemode_01")
				end		 
		  
				RequestModel(model)
				while not HasModelLoaded(model) do
				RequestModel(model)
				Citizen.Wait(1)
				end
		  
				SetPlayerModel(PlayerId(), model)
				SetModelAsNoLongerNeeded(model)
		  
				TriggerEvent('skinchanger:loadSkin', skin)
				TriggerEvent('esx:restoreLoadout')
			end)
		elseif data.current.value == 'shirt' then
			startAnim("clothingtie", "try_tie_negative_a")
			Citizen.Wait(1200)
			ClearPedTasks(PlayerPedId())
			SetPedComponentVariation(PlayerPedId(), 8, 3, 0, 0)
	  	elseif data.current.value == 'giacca' then
			startAnim("clothingtie", "try_tie_negative_a")
			Citizen.Wait(1200)
			ClearPedTasks(PlayerPedId())
			SetPedComponentVariation(PlayerPedId(), 11, 0, 0, 0)
		elseif data.current.value == 'pantaloni' then
			startAnim("re@construction", "out_of_breath")
			Citizen.Wait(1300)
			ClearPedTasks(PlayerPedId())
			SetPedComponentVariation(PlayerPedId(), 4, 14, 0, 0)
		elseif data.current.value == 'scarpe' then
			startAnim("random@domestic", "pickup_low")
			Citizen.Wait(1300)
			ClearPedTasks(PlayerPedId())
			SetPedComponentVariation(PlayerPedId(), 6, 34, 0, 0)
		elseif data.current.value == 'giubbotto' then
			startAnim("random@domestic", "pickup_low")
			Citizen.Wait(1300)
			ClearPedTasks(PlayerPedId())
			SetPedComponentVariation(PlayerPedId(), 9, 0, 0, 0)
		end
	end, function(data, menu)
		menu.close()
		MainMenu()
	end)
end

--Accessory Menu
function AccessoryMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'accessori',
	  {
		  title    = "HXZ - Menu Accessori",
		  align = 'top-left',
		  elements = {	  			  
			{label = Lang["MASK"], 		value = "maschera"},
			{label = Lang["GLASS"], 	value = "occhiali"},
			{label = Lang["HAT"], 		value = "casco"},
			{label = Lang["BAG"], 		value = "borsa"},
			{label = Lang['RESET_PERSONAL DRESS'], 		value = "base_skin"},
		  	}
	  },function(data, menu)
		if data.current.value == 'base_skin' then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)

				local model = nil
		  
				if skin.sex == 0  then
				model = GetHashKey("mp_m_freemode_01")
				else
				model = GetHashKey("mp_f_freemode_01")
				end		 
		  
				RequestModel(model)
				while not HasModelLoaded(model) do
				RequestModel(model)
				Citizen.Wait(1)
				end
		  
				SetPlayerModel(PlayerId(), model)
				SetModelAsNoLongerNeeded(model)
		  
				TriggerEvent('skinchanger:loadSkin', skin)
				TriggerEvent('esx:restoreLoadout')
			end)
		elseif data.current.value == 'maschera' then
			startAnim("mp_masks@standard_car@ds@", "put_on_mask")
			Citizen.Wait(1300)
			ClearPedTasks(PlayerPedId())
			SetPedComponentVariation(PlayerPedId(), 1, 0, 0, 0)
		elseif data.current.value == 'occhiali' then
			startAnim("clothingspecs", "take_off")
			Citizen.Wait(1300)
			ClearPedTasks(PlayerPedId())
			SetPedPropIndex(PlayerPedId(), 1, 11, 0, 0 )
		elseif data.current.value == 'casco' then
			startAnim("missheist_agency2ahelmet", "take_off_helmet_stand")
			Citizen.Wait(1300)
			ClearPedTasks(PlayerPedId())
			SetPedPropIndex(PlayerPedId(), 0, 8, 0, 0 )
		elseif data.current.value == 'borsa' then
			startAnim("clothingtie", "try_tie_negative_a")
			Citizen.Wait(1300)
			ClearPedTasks(PlayerPedId())
			SetPedComponentVariation(PlayerPedId(), 5, 0, 0, 0)
		end
	end, function(data, menu)
		menu.close()
		MainMenu()
	end)
end

--Thieft Menu
function ThiefMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'thief',
	  {
		  title    = "HXZ - Menu Illegale",
		  align = 'top-left',
		  elements = {	  			  
			{label = Lang["BODY_SEARCH"],      value = 'perquisizione'},
		  	}
	  },function(data, menu)

		local playerVicino, playerDistanza = ESX.Game.GetClosestPlayer()
			if playerVicino ~= -1 and playerDistanza <= 3.0 then
				if data.current.value == "perquisizione" then
					if IsPedArmed(PlayerPedId(), 4) then
						if IsEntityPlayAnim(GetPlayerPed(playerVicino), 'anim@move_m@prisoner_cuffed_rc', 'aim_low_loop', 1) or IsEntityPlayAnim(GetPlayerPed(playerVicino), 'mp_arresting', 'idle', 1) then
							ESX.TriggerServerEvent('hxz:checkTarget', function(Target)  
								if Target then
									exports.ox_inventory:openNearbyInventory()
									ExecuteCommand('me Sta Perquisendo')
								end
							end)
						else
							ESX.ShowNotification(Lang['NOTIFY_PLAYER_NOT_SURRENDER'] )
						end
					else
						ESX.ShowNotification(Lang['YOU_ARE_NOT_ARMED'])
					end
				end
			else
				ESX.ShowNotification(Lang['NOTIFY_PLAYER_NOT_CLOSE'])
			end
		end, function(data, menu)
		menu.close()
		MainMenu()
	end)
end

--Rockstar Editor
function RockstarEditor()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'rockstar_editor',
	  {
		  title    = "HXZ - Rockstar Editor",
		  align = 'top-left',
		  elements = {	  		  
			{label = Lang['ROCKSTAR_EDITOR_OPEN'] ,	 	value = "open"},
			{label = Lang['ROCKSTAR_EDITO_START_REC'],			value = "startrec"},
			{label = Lang['ROCKSTAR_EDITO_STOP_REC'],			value = "stoprec"},
		  	}
	  },function(data, menu)
		if data.current.value == 'open' then
			ActivateRockstarEditor()
		elseif data.current.value == 'rec' then
			StartRecording(1)
			menu.close()
        elseif data.current.value == 'stoprec' then
			StopRecordingAndSaveClip()
			menu.close()
		end
	end, function(data, menu)
		menu.close()
		MainMenu()
	end)
end


--Admin Menu
function OpenAdminMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'menu_admin',
	  {
		  title    = "HXZ - menu amministrazione",
		  align = 'top-left',
		  elements = {	  			
			{label = Lang["NOCLIP"],					value = 'noclip'},
			{label = Lang["TELEPORT_ON_WAYPOINT"],		value = "tpm"},
			{label = Lang["REPAIR_VEHICLE"],    		value = "rveicolo"},
			{label = Lang["FLIP_VEHICLE"],      		value = "gveicolo"},
			{label = Lang["SPAWN_CAR"],       			value = "car"},
			{label = Lang["GIVE_BULLETPROOF"],     		value = "giub"},
			{label = Lang["GODMODE"],       			value = "godmode"},
			{label = Lang["GODMODE"],       			value = "godmode"},
			{label = Lang["GHOSTMODE"],       			value = "ghostmode"},
			{label = Lang["OPEN_PLAYER_INVENTORY"], 	value = "open_inventory"},
			{label = Lang["GIVE_MONEY"],       			value = "give_money"},
			{label = Lang["GIVE_PLAYER_CAR"] ,			value = "givecar"},
			{label = Lang["WIPE_PLAYER"],       		value = "wipe"},
		  	}
	  },function(data, menu)

		local val = data.current.value
		if val == "noclip" then 
            	TriggerServerEvent("hxz:noclipStatus")
            	if not inNoclip then
                	NoClip()
                	noclip_pos = GetEntityCoords(PlayerPedId(), false)
            	else
                	inNoclip = false
            	end
        elseif val == "rveicolo" then
            if IsPedInAnyVehicle(PlayerPedId(), false) then
                SetVehicleFixed(GetVehiclePedIsUsing(PlayerPedId()))	
                SetVehicleDirtLevel(GetVehiclePedIsUsing(PlayerPedId()),0)
				ESX.ShowNotification(Lang['NOTIFY_REPAIR_VEHICLE'])
            else
				ESX.ShowNotification(Lang['NOTIFY_NO_VEHICLE'])
            end
        elseif val == "gveicolo" then
            local player = PlayerPedId()
            local posdepmenu = GetEntityCoords(player)
            local carTargetDep = GetClosestVehicle(posdepmenu['x'], posdepmenu['y'], posdepmenu['z'], 10.0,0,70)
            SetPedIntoVehicle(player , carTargetDep, -1)
            Citizen.Wait(200)
            ClearPedTasksImmediately(player)
            Citizen.Wait(100)
            local playerCoords = GetEntityCoords(PlayerPedId())
            playerCoords = playerCoords + vector3(0, 2, 0)
            SetEntityCoords(carTargetDep, playerCoords)
			ESX.ShowNotification(Lang['NOTIFY_FLIP_VEHICLE'])
		elseif val == "car" then
			local input = lib.inputDialog('Spawna un veicolo', {'Inserisci il nome del veicolo'})

			if input then
				local ModelHash = input[1]

				if not IsModelInCdimage(ModelHash) then return end
				RequestModel(ModelHash)
				while not HasModelLoaded(ModelHash) do 
				Citizen.Wait(10)
				end
				local MyPed = PlayerPedId() 
				local Vehicle = CreateVehicle(ModelHash, GetEntityCoords(MyPed), GetEntityHeading(MyPed), true, false)
				SetModelAsNoLongerNeeded(ModelHash)
				TaskWarpPedIntoVehicle(PlayerPedId(), Vehicle, -1)
				ESX.UI.Menu.CloseAll()
				ESX.ShowNotification(Lang['NOTIFY_SPAWN_VEHICLE'])
			end
		elseif val == "tpm" then
			TriggerEvent(Config.TriggerTPM)
		elseif val == "wipe" then

			local input = lib.inputDialog('Wipe Giocatore', {
				{ type = "input", label = "ID Player" },
				{ type = "input", label = "Password", password = true, icon = 'lock' },
			})
			if not input then return end
			ESX.TriggerServerCallback('hxz:wipepassword', function(h)
				if h == true then
					TriggerServerEvent("hxz:wipepg", input[1])
				end
			end, input[2])
		elseif val == "giub" then
			local input = lib.inputDialog('Dai Giubbotto', {'Id Player'})

			if input then
				TriggerServerEvent("hxz:bullet", input[1])
			end
		elseif val == "godmode" then
			if inGodMode == false then
				ESX.ShowNotification(Lang['NOTIFY_GODMODE_ENABLE'])
				inGodMode = true
				HXZ_GodMode()
			elseif inGodMode == true then
				ESX.ShowNotification(Lang['NOTIFY_GODMODE_DISABLE'])
				inGodMode = false
			end
		elseif val == "ghostmode" then
			if inGhostMode == false then
				ESX.ShowNotification(Lang['NOTIFY_GHOSTMODE_ENABLE'])
				inGhostMode = true
				HXZ_GhostMode()
			elseif inGhostMode == true then
				ESX.ShowNotification(Lang['NOTIFY_GHOSTMODE_DISABLE'])
				inGhostMode = false
			end
		elseif val == 'open_inventory' then
			local input = lib.inputDialog('Apri inventario', {'ID Player'})

			if input then
				exports.ox_inventory:openInventory('player', input[1])
			end
		elseif val == 'give_money' then
			local input = lib.inputDialog('Dai Veicolo', {
				{ type = "input", label = "ID Player" },
				{ type = "input", label = "Quantità" },
			})
			if not input then return end
			TriggerServerEvent('hxz:givemoney', input[1], input[2])
		elseif val == 'givecar' then
			print('car')
			local playerPed = GetPlayerPed(-1)
			local coords    = GetEntityCoords(playerPed)

			local input = lib.inputDialog('Dai Veicolo', {
				{ type = "input", label = "ID Player" },
				{ type = "input", label = "Nome Veicolo" },
				{ type = "input", label = "Password", password = true, icon = 'lock' },
			})
			if not input then return end
			ESX.TriggerServerCallback('hxz:vpassword', function(r)
				if r == true then
					ESX.Game.SpawnVehicle(input[2], coords, 0.0, function(vehicle) 
						SetEntityVisible(vehicle, false, false)
						SetEntityCollision(vehicle, false)

						local newPlate     = exports.esx_vehicleshop:GeneratePlate()
						local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
						vehicleProps.plate = newPlate
			
						TriggerServerEvent('hxz:setVehicle', vehicleProps, input[1], input[2])
						ESX.Game.DeleteVehicle(vehicle)
					end)
				end
			end, input[3])
        end
	end, function(data, menu)
		menu.close()
		MainMenu()
	end)
end

local heading = 0
local speed = 0.1
local up_down_speed = 0.1
NoClip = function()

    inNoclip = true
    
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1)
            local ped = PlayerPedId()
            local targetVeh = GetVehiclePedIsUsing(ped)
            if IsPedInAnyVehicle(ped) then
                ped = targetVeh
            end

            if inNoclip then

                SetEntityInvincible(ped, true)
                SetEntityVisible(ped, false, false)

                SetEntityLocallyVisible(ped)
                SetEntityAlpha(ped, 100, false)
                SetBlockingOfNonTemporaryEvents(ped, true)
                ForcePedMotionState(ped, -1871534317, 0, 0, 0)

                SetLocalPlayerVisibleLocally(ped)
                SetEntityCollision(ped, false, false)
                
                SetEntityCoordsNoOffset(ped, noclip_pos.x, noclip_pos.y, noclip_pos.z, true, true, true)

                if IsControlPressed(1, 34) then
                    heading = heading + 2.0
                    if heading > 359.0 then
                        heading = 0.0
                    end

                    SetEntityHeading(ped, heading)
                end

                if IsControlPressed(1, 9) then
                    heading = heading - 2.0
                    if heading < 0.0 then
                        heading = 360.0
                    end

                    SetEntityHeading(ped, heading)
                end
                heading = GetEntityHeading(ped)

                if IsControlJustPressed(1, 21) then
                    if speed == 0.1 then
                        speed = 0.2
                        up_down_speed = 0.2
                    elseif speed == 0.2 then
                        speed = 0.3
                        up_down_speed = 0.3
                    elseif speed == 0.3 then
                        speed = 0.5
                        up_down_speed = 0.5
                    elseif speed == 0.5 then
                        speed = 1.5
                        up_down_speed = 0.5
                    elseif speed == 1.5 then
                        speed = 2.5
                        up_down_speed = 0.9
                    elseif speed == 2.5 then
                        speed = 3.5
                        up_down_speed = 1.3
                    elseif speed == 3.5 then
                        speed = 4.5
                        up_down_speed = 1.5
                    elseif speed == 4.5 then
                        speed = 0.1
                        up_down_speed = 0.1
                    end
                end

                if IsControlPressed(1, 8) then
                    noclip_pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, -speed, 0.0)
                end

                if IsControlPressed(1, 44) and IsControlPressed(1, 32) then -- Q e W
                    noclip_pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, speed, up_down_speed)
                elseif IsControlPressed(1, 44) then -- Q
                    noclip_pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, up_down_speed)
                elseif IsControlPressed(1, 32) then -- W
                    noclip_pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, speed, 0.0)
                end

                if IsControlPressed(1, 20) and IsControlPressed(1, 32) then -- Z e W
                    noclip_pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, speed, -up_down_speed)
                elseif IsControlPressed(1, 20) then -- Z
                    noclip_pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 0.0, -up_down_speed)
                end
            else
                SetEntityInvincible(ped, false)
                ResetEntityAlpha(ped)
                SetEntityVisible(ped, true, false)
                SetEntityCollision(ped, true, false)
                SetBlockingOfNonTemporaryEvents(ped, false)

                return
            end
        end
    end)
end

function HXZ_GodMode()
	local ped = PlayerPedId()

	Citizen.CreateThread(function()
    	while true do
    		Citizen.Wait(1)
			if inGodMode == true then
				SetEntityInvincible(ped, true)
			elseif inGodMode == false then
				SetEntityInvincible(ped, false)
				break;
			end
		end
	end)
end

function HXZ_GhostMode()
    local ped = PlayerPedId()
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1)
            if inGhostMode == true then
                SetEntityInvincible(ped, true)
				SetEntityVisible(ped, false, false)
            elseif inGhostMode == false then
                SetEntityInvincible(ped, false)
				SetEntityVisible(ped, true, false)
				break;
            end
        end
    end)
end


function startAnim(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(GetPlayerPed(-1), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
		RemoveAnimDict(lib)
	end)
end


RegisterKeyMapping("hxz-menu", "ApripersonalMenu", "keyboard", "F5")

RegisterCommand("hxz-menu", function()
	MainMenu()
end)