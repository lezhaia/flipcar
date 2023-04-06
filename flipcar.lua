-- Remake by Lezhaia
local ESX = exports['mc-core']:getSharedObject()
local VehicleData = nil

RegisterNetEvent('mc-flipcar:flipcar')
AddEventHandler('mc-flipcar:flipcar', function()
    local ped = PlayerPedId()
    local inside = IsPedInAnyVehicle(ped, true)
    if inside then
        TriggerEvent("DoShortHudText","你無法再車輛執行此行為",2)
    else
        local pedcoords = GetEntityCoords(ped)
        VehicleData = ESX.Game.GetClosestVehicle()
        local dist = #(pedcoords - GetEntityCoords(VehicleData))
        if dist <= 3 then
            RequestAnimDict('missfinale_c2ig_11')
            while not HasAnimDictLoaded("missfinale_c2ig_11") do
                Wait(0)
            end
            TaskPlayAnim(ped, 'missfinale_c2ig_11', 'pushcar_offcliff_m', 2.0, -8.0, -1, 35, 0, 0, 0, 0)
			exports['mc-base']:FreezePlayer(ped,true)
			local taskbar = exports["mc-taskbar"]:taskBar(5000,"Flipping Vehicle...")
			if (taskbar == 100) then
            	local carCoords = GetEntityRotation(VehicleData, 2)
            	SetEntityRotation(VehicleData, carCoords[1], 0, carCoords[3], 2, true)
            	SetVehicleOnGroundProperly(VehicleData)
            	ClearPedTasks(ped)
				exports['mc-base']:FreezePlayer(ped,false)
			else
				exports['mc-base']:FreezePlayer(ped,false)
			end
        else
			TriggerEvent("DoShortHudText","附近沒有車輛",0)
        end
    end
end)

CreateThread(function()
    exports['mc-target']:Vehicle({
        options = {
            {
                event = "mc-flipcar:flipcar",
                icon = "fas fa-arrow-rotate-right",
                label = "翻轉車輛",
                distance = 2
            },
        },
    })
end)
