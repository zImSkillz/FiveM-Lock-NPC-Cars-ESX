LockedVehicles = {}

RegisterNetEvent('mlrp_locknpccars:syncCars')
AddEventHandler('mlrp_locknpccars:syncCars', function(car)
	table.insert(LockedVehicles, car)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local xPlayers = ESX.GetPlayers()
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			TriggerClientEvent("mlrp_locknpccars:addCarSync", xPlayers[i], LockedVehicles)
		end	
	end
end)

ESX.RegisterServerCallback('mlrp_locknpccars:getV', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
	local full = {}
    if xPlayer then
        MySQL.Async.fetchAll("SELECT * FROM owned_vehicles", { ["@owner"] = xPlayer.getIdentifier() }, function(data)
            for k, v in pairs (data) do
				table.insert(full, {
					plate = v.plate
				})
			end
			cb(full)
        end)
    end
end)



--[[
- Created by zImSkillz
- Created at 21:22 GMT+1
- DD/MM/YYYY
- 26.11.2022
]]--