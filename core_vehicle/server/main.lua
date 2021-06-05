QBCore = nil

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

local VehicleHandling = {}

RegisterServerEvent("core_vehicle:canInstall")
AddEventHandler("core_vehicle:canInstall", function(partType, part)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local xItem = xPlayer.Functions.GetItemByName(part)

    if xItem ~= nil then 
        xPlayer.Functions.RemoveItem(part, 1)
        TriggerClientEvent("core_vehicle:startInstall", src, partType, part)
    else
        TriggerClientEvent("core_vehicle:SendTextMessage", src, Config.Text["not_enough"])
    end
end)

RegisterServerEvent("core_vehicle:returnItems")
AddEventHandler("core_vehicle:returnItems", function(parts)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)

    for k, v in pairs(parts) do
        xPlayer.Functions.AddItem(k, v)
    end
end)

RegisterServerEvent("core_vehicle:canRepair")
AddEventHandler("core_vehicle:canRepair", function(partType, part)
    local src = source
    local xPlayer = QBCore.Functions.GetPlayer(src)
    local repair = {}
    if Config.Engines[part] ~= nil then
        repair = Config.Engines[part].repair
    end
    if Config.Turbos[part] ~= nil then
        repair = Config.Turbos[part].repair
    end
    if Config.Transmissions[part] ~= nil then
        repair = Config.Transmissions[part].repair
    end
    if Config.Suspensions[part] ~= nil then
        repair = Config.Suspensions[part].repair
    end
    if Config.Oils[part] ~= nil then
        repair = Config.Oils[part].repair
    end
    if Config.Tires[part] ~= nil then
        repair = Config.Tires[part].repair
    end
    if Config.Brakes[part] ~= nil then
        repair = Config.Brakes[part].repair
    end
    if Config.Nitros[part] ~= nil then
        repair = Config.Nitros[part].repair
    end
	if Config.SparkPlugs[part] ~= nil then
        repair = Config.SparkPlugs[part].repair
    end
    local avail = true
    for k, v in pairs(repair) do
        if xPlayer.Functions.GetItemByName(k).amount < v.amount then 
            avail = false 
        end
    end
    local returnable = {}
    if avail then
        for k, v in pairs(repair) do
            if not v.reusable then
                xPlayer.Functions.RemoveItem(k, v.amount)
                returnable[k] = v.amount
            end
        end
        TriggerClientEvent("core_vehicle:startRepair", src, partType, part, returnable)
    else
        TriggerClientEvent("core_vehicle:SendTextMessage", src, Config.Text["not_enough"])
    end
end)

RegisterServerEvent("core_vehicle:getVehicleHandling")
AddEventHandler("core_vehicle:getVehicleHandling", function(plate)
    local src = source
    TriggerClientEvent("core_vehicle:getVehicleHandling_c", src, plate, VehicleHandling[plate])
end)

RegisterServerEvent("core_vehicle:setVehicleHandling")
AddEventHandler("core_vehicle:setVehicleHandling", function(plate, handlingData)
    VehicleHandling[plate] = handlingData
end)

RegisterServerEvent("core_vehicle:getVehicleParts")
AddEventHandler("core_vehicle:getVehicleParts", function(plate, vehId)
        local src = source
        exports.ghmattimysql:execute(
            "SELECT * FROM vehicle_parts WHERE plate = @plate",
            {
                ["@plate"] = plate
            },
        function(parts)
            if parts[1] ~= nil then
                local converted = json.decode(parts[1].parts)
                if  not converted["sparkplugs"] then
                    converted["sparkplugs"] = {type = "stock_sparkplugs", health = 100}
                end
                TriggerClientEvent(
                    "core_vehicle:getVehicleParts_c",
                    src,
                    converted,
                    parts[1].mileage
                )
                TriggerClientEvent("core_vehicle:syncVehicle", -1, converted["engine"].type, vehId)
            else
                local defaultParts = {
                    ["oil"] = {type = "stock_oil", health = 100},
					["tires"] = {type = "stock_tires", health = 100},
					["brakes"] = {type = "stock_brakes", health = 100},
                    ["suspension"] = {type = "stock_suspension", health = 100},
                    ["engine"] = {type = "stock_engine", health = 100.0},
                    ["transmission"] = {type = "stock_transmission", health = 100},
					["sparkplugs"] = {type = "stock_sparkplugs", health = 100}
                }
                exports.ghmattimysql:execute("REPLACE INTO vehicle_parts (plate, parts) values(@plate, @parts)",{
                    ["@parts"] = json.encode(defaultParts), ["@plate"] = plate
                },function()
                    end)
                TriggerClientEvent("core_vehicle:getVehicleParts_c", src, defaultParts, 0)
                TriggerClientEvent("core_vehicle:syncVehicle", -1, defaultParts["engine"].type, vehId)
            end
        end)
end)

RegisterServerEvent("core_vehicle:setVehicleParts")
AddEventHandler("core_vehicle:setVehicleParts", function(plate, parts, mileage)
    local src = source
    exports.ghmattimysql:execute("UPDATE `vehicle_parts` SET `parts`= @parts, `mileage` = @mileage WHERE `plate` = @plate",{
        ["@parts"] = parts, ["@plate"] = plate, ["@mileage"] = mileage
    },function()
    end)
end)

QBCore.Functions.CreateUseableItem("toolbox" , function(playerId)
    TriggerClientEvent('core_vehicle:toolUsed, playerId, "toolbox')
end)

QBCore.Functions.CreateUseableItem("mechanic_tools" , function(playerId)
    TriggerClientEvent('core_vehicle:toolUsed', playerId, "mechanic_tools")
end)

RegisterNetEvent("core_vehicle:syncNitro")
AddEventHandler("core_vehicle:syncNitro", function(boostEnabled, purgeEnabled, lastVehicle)
    local source = source

    for _, player in ipairs(GetPlayers()) do
        if player ~= tostring(source) then
            TriggerClientEvent("core_vehicle:sync", player, source, boostEnabled, purgeEnabled, lastVehicle)
        end
    end
end)

-- Get Vehicle Owned Status:
--[[QBCore.Functions.CreateCallback('core_vehicle:getIfVehicleOwned',function(source, cb, plate)
    exports.ghmattimysql:execute("SELECT * FROM owned_vehicles WHERE plate=@plate",{['@plate'] = plate}, function(data) 
        if Config.OnlyOwnedVehicles then
        if #data > 0 then
            cb(true)
        else
            cb(false)
        end
    else
            cb(true)
    end
    end)
end)--]]

-- Get Vehicle Owned Status:
QBCore.Functions.CreateCallback('core_vehicle:getIfVehicleOwned',function(source, cb, plate)
    local xPlayer = QBCore.Functions.GetPlayer(source)
    exports.ghmattimysql:execute("SELECT * FROM owned_vehicles WHERE plate=@plate",{['@plate'] = plate}, function(data) 
        if Config.OnlyOwnedVehicles then
			if(data[1] ~= nil) then
				cb(true)
			else
				cb(false)
			end
		else
            cb(true)
		end
    end)
end)
