ESX = nil

local currentHouse = nil

function Draw3DText(coords, text)
    local camCoords = GetGameplayCamCoord()
    local distance = #(coords - camCoords)

    local scale = (1 / distance) * 2
    local fov = (1 / GetGameplayCamFov()) * 100
    local scale = scale * fov

    SetTextScale(0.0, 0.35 * scale)
    SetTextFont(4)
    SetTextProportional(true)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextCentre(true)

    SetDrawOrigin(coords, 0)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()
end

function DrawMarker(position)
    DrawMarker(1, position.x, position.y, position.z - 1.0, 0, 0, 0, 0, 0, 0, 0.75, 0.75, 0.75, 255, 255, 255, 200, 0, 0, 0, 1, 0, 0, 0)
end

function DrawHouseMarker(house)
    DrawMarker(house.position)
end

function ShowHouseMenu()
    local elements = {}

    -- Add the options to the menu e.g. enter house, add furniture etc.

    WarMenu.OpenMenu("house_menu")
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)

        for playerId, house in pairs(playerHouses) do
            local distance = #(playerCoords - house.position)

            if distance <= 10.0 then
                DrawHouseMarker(house)

                if distance <= 1.5 then
                    if IsControlJustReleased(0, 38) then
                        currentHouse = house
                        ShowHouseMenu()
                    end

                    Draw3DText(house.position + vector3(0, 0, 1.0), "Drücke E, um das Haus zu betreten")
                end
            end
        end
    end
end)

-- Code to receive notifications for burglary and police operations

RegisterNetEvent("house_robbery_notification")
AddEventHandler("house_robbery_notification", function(message)
    -- Code to display intrusion message
end)

RegisterNetEvent("police_dispatch")
AddEventHandler("police_dispatch", function(message)
    -- Code to display police message
end)

-- Code to receive homeowner notifications

RegisterNetEvent("house_owner_notification")
AddEventHandler("house_owner_notification", function(message)
    -- Code to show notification to homeowner
end)
