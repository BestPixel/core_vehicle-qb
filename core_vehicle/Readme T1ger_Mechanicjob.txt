Add this to the t1ger_mechanicjob __resource.lua

export {
	'CarJackFunction',
	'IsOnLift'
}

Add this to the t1ger_mechanicjob at the end of the client.lua file

--export for is vehicle on lift
function IsOnLift()
	local vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
	local plate = GetVehicleNumberPlateText(vehicle):gsub("^%s*(.-)%s*$", "%1")
	if vehOnLift[plate] ~= nil then
		IsOnLift = true
	else
		IsOnLift = false
	end
   return IsOnLift
end
--export end

Add this to the server.lua (from core_vehicle) at the end to be able to use the carjack as item also for the users
if you use any kind of menu etc you can also use the exported trigger:

ESX.RegisterUsableItem('carjack', function(playerId)
    local xPlayer = ESX.GetPlayerFromId(playerId)
    local coords = GetEntityCoords(xPlayer)
    local veh, dst = ESX.Game.GetClosestVehicle(coords)
    if dst < 3.0 then
    exports.t1ger_mechanicjob:CarJackFunction('interact', veh)
    else
	TriggerClientEvent("core_vehicle:SendTextMessage", src, Config.Text["vehicle_notfound"])
    end
end)