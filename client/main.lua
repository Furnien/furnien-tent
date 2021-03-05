local ESX = nil
local round = 0
local cadirBlip = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	ESX.PlayerData = ESX.GetPlayerData()
    owner = ESX.GetPlayerData().identifier
end)

 local tents = {
    [1] = {['cadir-x'] = 160.959, ['cadir-y'] = -1211.1, ['cadir-z'] = 29.2950},
    [2] = {['cadir-x'] = 166.227, ['cadir-y'] = -1213.0, ['cadir-z'] = 29.3566},
    [3] = {['cadir-x'] = 166.506, ['cadir-y'] = -1220.8, ['cadir-z'] = 29.2950},
    [4] = {['cadir-x'] = 166.954, ['cadir-y'] = -1225.2, ['cadir-z'] = 29.2950},
    [5] = {['cadir-x'] = 175.021, ['cadir-y'] = -1212.3, ['cadir-z'] = 29.2950},
    [6] = {['cadir-x'] = 179.666, ['cadir-y'] = -1206.9, ['cadir-z'] = 29.2950},
    [7] = {['cadir-x'] = 172.779, ['cadir-y'] = -1201.7, ['cadir-z'] = 29.2950},
    [8] = {['cadir-x'] = 162.756, ['cadir-y'] = -1206.9, ['cadir-z'] = 29.3660},
    [9] = {['cadir-x'] = 143.256, ['cadir-y'] = -1197.1, ['cadir-z'] = 29.3659},
    [10]= {['cadir-x'] = 151.615, ['cadir-y'] = -1194.0, ['cadir-z'] = 29.3246},
    [11]= {['cadir-x'] = 163.030, ['cadir-y'] = -1193.9, ['cadir-z'] = 29.4462},
    [12]= {['cadir-x'] = 38.8581, ['cadir-y'] = -1219.9, ['cadir-z'] = 29.2679},
    [13]= {['cadir-x'] = 35.8972, ['cadir-y'] = -1217.2, ['cadir-z'] = 29.3816},
    [14]= {['cadir-x'] = 32.1377, ['cadir-y'] = -1220.9, ['cadir-z'] = 29.2692},
    [15]= {['cadir-x'] = 22.8521, ['cadir-y'] = -1216.3, ['cadir-z'] = 29.4181},
    [16]= {['cadir-x'] = 18.5270, ['cadir-y'] = -1223.0, ['cadir-z'] = 29.2952},
    [17]= {['cadir-x'] = 8.78315, ['cadir-y'] = -1218.6, ['cadir-z'] = 29.4391},
    [18]= {['cadir-x'] = 7.69499, ['cadir-y'] = -1220.5, ['cadir-z'] = 29.3144},
    [19]= {['cadir-x'] = -5.0819, ['cadir-y'] = -1226.7, ['cadir-z'] = 29.2952},
    [20]= {['cadir-x'] = -3.6743, ['cadir-y'] = -1235.7, ['cadir-z'] = 29.3009},
    [21]= {['cadir-x'] = -14.227, ['cadir-y'] = -1223.9, ['cadir-z'] = 29.3074},
    [22]= {['cadir-x'] = 16.5146, ['cadir-y'] = -1232.9, ['cadir-z'] = 29.2952},
    [23]= {['cadir-x'] = 23.6128, ['cadir-y'] = -1232.3, ['cadir-z'] = 29.3821},
    [24]= {['cadir-x'] = 40.5884, ['cadir-y'] = -1227.4, ['cadir-z'] = 29.2735},
    [25]= {['cadir-x'] = 33.6245, ['cadir-y'] = -1240.1, ['cadir-z'] = 29.2952},
    [26]= {['cadir-x'] = 22.1469, ['cadir-y'] = -1245.7, ['cadir-z'] = 29.2955},
    [27]= {['cadir-x'] = 20.0591, ['cadir-y'] = -1242.3, ['cadir-z'] = 29.2952},
    [28]= {['cadir-x'] = 0.27177, ['cadir-y'] = -1240.0, ['cadir-z'] = 29.3027},
    [29]= {['cadir-x'] = 10.0390, ['cadir-y'] = -1236.0, ['cadir-z'] = 29.2971},
} 

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function()
    RemoveBlip(cadirBlip)
    RastgeleCadirVer() 
end)

function RastgeleCadirVer()
	Citizen.CreateThread(function()
        local wait = 1250
		round = math.random(1, #tents)
        --print(round)
        cadirBlip = AddBlipForCoord(tents[round]["cadir-x"],tents[round]["cadir-y"],tents[round]["cadir-z"])
        SetBlipSprite(cadirBlip, 587)
        SetBlipColour(cadirBlip, 31)
        SetBlipAsShortRange(evBlip, true)
        SetBlipScale(cadirBlip, 0.5)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Çadırın")
        EndTextCommandSetBlipName(cadirBlip)
		while true do
			local plycoords = GetEntityCoords(PlayerPedId())
			local dstcheck2 = #(plycoords - vector3(tents[round]["cadir-x"],tents[round]["cadir-y"],tents[round]["cadir-z"])) 

			if dstcheck2 <= 5.0  then
				msg = 'Çadır'
                DrawMarker(20, tents[round]["cadir-x"],tents[round]["cadir-y"],tents[round]["cadir-z"]+0.50 - 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.8, 0.8, 0.8, 204, 102, 0, 200, false, true, 2, false, 0, 0, 0, 0)
				if dstcheck2 <= 1.0  then
					msg = '[E] Çadır'
					wait = 5
				if	IsControlJustReleased(0, 38) then
                     Config.Envanter()
				end
            end            
				DrawText3Ds(tents[round]["cadir-x"],tents[round]["cadir-y"],tents[round]["cadir-z"],msg)
			end
			Citizen.Wait(wait)
		end
	end)
end

function m3()
    TriggerEvent('m3:inventoryhud:client:openStash', 'Çadır', 'all')
end

function np()
    TriggerEvent("server-inventory-open", "1", "Cadır"..round.."-"..cid)
end

 function qb()
     TriggerServerEvent("inventory:server:OpenInventory", "cadir", "Çadır"..ESX.GetPlayerData().identifier)
     TriggerEvent("inventory:client:SetCurrentStash","Çadır"..ESX.GetPlayerData().identifier)
 end
 
function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
	DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 140)
	ClearDrawOrigin()
end
