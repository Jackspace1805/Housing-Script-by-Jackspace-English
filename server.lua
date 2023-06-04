ESX = nil

local playerHouses = {}
local availableMLOs = {
    {name = "MLO1", price = 1000},
    {name = "MLO2", price = 2000},
    {name = "MLO3", price = 3000}
}

function GenerateHouseKey()
    -- Code to generate a unique key, e.g. B. a random character string
    return houseKey
end

function AssignHouseKey(playerId)
    local houseKey = GenerateHouseKey()
    -- Code to store key in database for player with playerId    return houseKey
end

function CreateHouse(playerId)
    local house = {}
    house.owner = playerId
    house.furniture = {}
    house.position = vector3(0, 0, 0)
    house.renovated = false
    house.wallColor = {r = 255, g = 255, b = 255}
    house.selectedMLO = nil
    house.houseKey = AssignHouseKey(playerId)
    house.isBeingRobbed = false

    playerHouses[playerId] = house
end

function AddFurniture(playerId, furniture)
    local house = playerHouses[playerId]
    if house and house.renovated then
        table.insert(house.furniture, furniture)
    end
end

function PlaceFurniture(playerId, furniture)
    local house = playerHouses[playerId]
    if house and house.renovated then
        if --[code to check furniture in inventory] then
        -- Code to place furniture in game
        -- Code to remove furniture from inventory
    else
        -- Code to display a notification that the player does not own the furniture
        end
    end
end

function RenovateHouse(playerId, wallColor)
    local house = playerHouses[playerId]
    if house then
        if not house.renovated then
    -- Code to check player inventory for required materials

    if --[code to check materials in inventory] then
    -- Code to remove materials from inventory
    house. renovated = true
    house.wallColor = wallColor
else
    -- Code to display a notification that the player does not have enough materials
    end
else
-- Code to display a notification that the house has already been renovated
        end
    end
end

function BuyMLO(playerId, mloName)
    local house = playerHouses[playerId]
    if house and not house.renovated then
        local mlo = GetMLOByName(mloName)
        if mlo and not house.selectedMLO then
            -- Code to check player money and deduct MLO price
            house.selectedMLO = mloName
        else
            -- Code to display a notification that the MLO is not available or has already been selected
        end
    end
end

function StealHouseKey(playerId)
    local house = playerHouses[playerId]
    if house then
        local targetPlayerId = -- Code to determine the target player ID to steal the key from
        local targetHouse = playerHouses[targetPlayerId]
        if targetHouse and targetHouse.houseKey then
            -- Code to steal key and store in player's database with playerId
        else
            -- Code to display a notification that the target player does not have a key
        end
    end
end

function StartHouseRobbery(playerId)
    local house = playerHouses[playerId]
    if house and house.renovated and not house.isBeingRobbed then
        -- Code to check if the homeowner is online
        -- Code to check player inventory for required tools (lock pick, explosives, etc.)

        if --[code to check tools in inventory] then
        -- Code to start break-in
        house.isBeingRobbed = true
        -- Code to send a notification to the homeowner about the burglary
        -- Code to notify the police of the burglary
    else
        -- Code to display a notification that the player does not have the required tools
        end
    end
end

function FinishHouseRobbery(playerId)
    local house = playerHouses[playerId]
    if house and house.isBeingRobbed then
        -- Code to complete break-in
        -- Code to reset home burglary status
        house.isBeingRobbed = false
    end
end

RegisterCommand("createhouse", function(source, args, rawCommand)
    local playerId = source
    CreateHouse(playerId)
end)

RegisterCommand("addfurniture", function(source, args, rawCommand)
    local playerId = source
    local furniture = args[1]
    AddFurniture(playerId, furniture)
end)

RegisterCommand("placefurniture", function(source, args, rawCommand)
    local playerId = source
    local furniture = args[1]
    PlaceFurniture(playerId, furniture)
end)

RegisterCommand("renovatehouse", function(source, args, rawCommand)
    local playerId = source
    local r = tonumber(args[1])
    local g = tonumber(args[2])
    local b = tonumber(args[3])
    local wallColor = {r = r, g = g, b = b}
    RenovateHouse(playerId, wallColor)
end)

RegisterCommand("buymlo", function(source, args, rawCommand)
    local playerId = source
    local mloName = args[1]
    BuyMLO(playerId, mloName)
end)

RegisterCommand("stealkey", function(source, args, rawCommand)
    local playerId = source
    StealHouseKey(playerId)
end)

RegisterCommand("starthrobbing", function(source, args, rawCommand)
    local playerId = source
    StartHouseRobbery(playerId)
end)

RegisterCommand("finishrobbing", function(source, args, rawCommand)
    local playerId = source
    FinishHouseRobbery(playerId)
end)
 