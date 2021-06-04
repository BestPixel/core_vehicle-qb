Config = {

-------------------------------------------------------------
-- IMPORTANT  
-- All parts need to be added to inventory
-- Custom vehicle sounds for engines (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
-------------------------------------------------------------


WearRate = 200000, -- The rate parts wear off (Higher the value less wear on the parts)
UseMiles = true, -- If set to false it will use kilometers
UseRelativeValues = true, -- If set to true cars performance wouldnt be affected with stock parts. Otherwise stock car parts will make the car slower
UseT1gerMechanic = false, -- If set to true Vehicles will use the CarJack (toolbox) and Lift (mechanic_toolbox) from the t1ger_mechanic script. Look at the Readme for using this
DetectDistance = 3.0, -- Distance where vehicles are being detected
OnlyOwnedVehicles = true, -- Script excludes not owned cars
--Double UI----------------------------------------------------------------------------------------------------------------------
SetWaitTimeBeforeLoadHud = 500, -- Wait time for show/hide the HUD when entering/leaving the vehicle in ms. Play with this value
---------------------------------------------------------------------------------------------------------------------------------

--Times to repair/install certain parts in miliseconds
EngineRepairTime = 10000, 
EngineInstallTime = 15000,

TurboRepairTime = 10000, 
TurboInstallTime = 15000,

NitroInstallTime = 10000,

OilInstallTime = 5000,

TransmissionInstallTime = 14000,
TransmissionRepairTime = 10000,

TireRepairTime = 3000,
TireInstallTime = 3000,

BreaksInstallTime = 4000,
BreaksRepairTime = 4000,

SuspensionInstallTime = 5000,
SuspensionRepairTime = 5000,


SparkPlugsInstallTime = 5000,
SparkPlugsRepairTime = 5000,


MechanicWorkshop = { -- Mechanic Workshops where mechanics can use MechanicWorkshopAccess

    {coords = vector3(-211.58894348145,6241.2221679688,31.62286376953), radius = 20.0}

},

--Check engine, Low oil, Mileage location on screen
InfoBottom = 1,
InfoRight = 1,


-- Parts of vehicle certain condicions can access! For example with mechanic tool box you will be able to access parts mentioned in MechanicTools
-- PART LIST (engine, oil, brakes, suspension, turbo, nitro )

BearHandsAccessCommand = 'inspect',
BearHandsAccess = {
    ['oil'] = true
},

ToolBoxAccess = {
	['oil'] = true,
	['nitro'] = true,
    ['tires'] = true,
	['sparkplugs'] = true
},

MechanicToolsAccess = {
    ['oil'] = true,
	['nitro'] = true,
    ['tires'] = true,
	['brakes'] = true,
    ['suspension'] = true,
	['sparkplugs'] = true
},

MechanicWorkshopAccess = {
    ['oil'] = true,
    ['nitro'] = true,
    ['tires'] = true,
    ['brakes'] = true,
    ['suspension'] = true,
    ['engine'] = true,
    ['transmission'] = true,
    ['turbo'] = true,
	['sparkplugs'] = true
},


-- Parts that your vehicle will be able to use to modify its performance on the road. These parts also need to be added to the item databse.
-- usability - is to exclude some parts to be used on some vehicles exclusive is usually car spawn code
-- power - depends if using relative values but it will increase vehicles power
-- durability - (IMPORTANT) Enter value from 0 to 100. 100 means that the part will never break
-- repair - enter ingrediants to fix up the part. If part is at 0 percent you will need to replace.

Turbos = { -- Turbos affect your car speed at higher rpm's. When turbos break you lose power

    ['turbo_lvl_1'] = {
        label = "GARET TURBO", 
        usability = {exclusive = {}, vehicletypes = {}}, 
        power = 10.0,
        durability = 50.0,
        repair = {
            ['iron'] = {amount = 5, label = "Eisen", reusable = false}
        }
    }

},

NitroKey = 'LEFTSHIFT', -- Key to use nitro when available

Nitros = { -- Nitro affect vehicle power and increases vehicle wear during usage

    ['nos'] = {
        label = "NOS", 
        usability = {exclusive = {}, vehicletypes = {}},
        power = 100.0,
        durability = 30.0 -- Here enter seconds until nitro will run out
    }

},

Transmissions = {

['stock_transmission'] = {
    label = "STANDARD", 
    usability = {exclusive = {}, vehicletypes = {}},
    shiftingtime = 0.9,
    drivingwheels = 'DEFAULT',
    durability = 80.0,
    repair = {
            ['iron'] = {amount = 5, label = "Iron", reusable = false}
        }
},

['race_transmission'] = {
    label = "R. RWD", 
    usability = {exclusive = {}, vehicletypes = {}},
    shiftingtime = 3.0,
    drivingwheels = 'RWD',
    durability = 50.0,
    repair = {
            ['iron'] = {amount = 5, label = "Iron", reusable = false}
        }
},
['race_transmission_4wd'] = {
    label = "R. AWD", 
    usability = {exclusive = {}, vehicletypes = {}},
    shiftingtime = 3.0,
    drivingwheels = 'AWD', -- FWD RWD AWD
    durability = 50.0,
    repair = {
            ['iron'] = {amount = 5, label = "Iron", reusable = false}
        }
},

['race_transmission_fwd'] = {
    label = "R. FWD", 
    usability = {exclusive = {}, vehicletypes = {}},
    shiftingtime = 3.0,
    drivingwheels = 'FWD', -- FWD RWD 4WD
    durability = 50.0,
    repair = {
            ['iron'] = {amount = 5, label = "Iron", reusable = false}
        }
}

},

Suspensions = { -- Suspension will affect handling and will look super cool. Decrease power to lower the vehicle and give better handling.

['stock_suspension'] = {
    label = "STANDARD", 
    usability = {exclusive = {}, vehicletypes = {}},
    height = 0,
    traction = 0,
    durability = 80.0,
    repair = {
            ['iron'] = {amount = 5, label = "Iron", reusable = false}
        }
},

['race_suspension'] = {
    label = "RACE", 
    usability = {exclusive = {}, vehicletypes = {}},
    height = -0.04,
    traction = 1.0,
    durability = 50.0,
    repair = {
            ['iron'] = {amount = 5, label = "Iron", reusable = false}
        }
}



},

Oils = { -- Oils keep your car cool and happy if oil runs out car parts will start to wear off fast.

['stock_oil'] = {
    label = "STANDARD", 
    usability = {exclusive = {}, vehicletypes = {}},
    durability = 10.0,
},

['shell_oil'] = {
    label = "SHELL", 
    usability = {exclusive = {}, vehicletypes = {}},
    durability = 50.0,
}

},



Engines = { -- Engines will make your car faster and will give it a different sound. Increase power to make car faster. 

['stock_engine'] = {
        label = "STANDARD", 
        power = 0.0,
        durability = 80.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "DEFAULT",
        repair = {
            ['iron'] = {amount = 10, label = "Iron", reusable = false},
            ['piston'] = {amount = 6, label = "Piston", reusable = false}
        }
}, 

['v8engine'] = {
        label = "V8", 
        power = 30.0,
        durability = 50.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "brabus850", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
        repair = {
            ['iron'] = {amount = 10, label = "Iron", reusable = false},
            ['piston'] = {amount = 6, label = "Piston", reusable = false}
        }
}, 

['2jzengine'] = {
        label = "2JZ", 
        power = 50.0,
        durability = 50.0,
        usability = {exclusive = {}, vehicletypes = {}},
        sound = "toysupmk4", -- These sounds are not in by default download from (https://www.gta5-mods.com/vehicles/brabus-inspired-custom-engine-sound-add-on-sound)
        repair = {
            ['iron'] = {amount = 10, label = "Iron", reusable = false},
            ['piston'] = {amount = 6, label = "Piston", reusable = false}
        }
} 

},
 
Tires = { -- Tires affect your cars handling when launching and in corners. Increase traction for better grip or decrease for more drift. When they wear off you will drive without tires lol

['stock_tires'] = {
    label = "STANDARD", 
    usability = {exclusive = {}, vehicletypes = {}},
    traction = -0.04,
    width = 0.00,
    size = 0.00,
    lowspeedtraction = 0.0,
    durability = 80.0,
    repair = {
            ['rubber'] = {amount = 5, label = "Rubber", reusable = false}
        }
},

['michelin_tires'] = {
    label = "MICHELIN", 
    usability = {exclusive = {}, vehicletypes = {}},
    traction = 1.0,
    width = 0.00,
    size = 0.00,
    lowspeedtraction = 2.7,
    durability = 30.0,
    repair = {
            ['rubber'] = {amount = 5, label = "Rubber", reusable = false}
        }
}


},

Brakes = { -- Brakes allow you to stop your car. Increase power to make brakes more affective. When brakes break you will lose ability to break 

['stock_brakes'] = {
    label = "STANDARD", 
    usability = {exclusive = {}, vehicletypes = {}},
    power = 1.0,
    durability = 30.0,
    repair = {
            ['iron'] = {amount = 5, label = "Iron", reusable = false}
        }
},

['race_brakes'] = {
    label = "RACE", 
    usability = {exclusive = {}, vehicletypes = {}},
    power = 2.0,
    durability = 30.0,
    repair = {
            ['iron'] = {amount = 5, label = "Iron", reusable = false}
        }
},

},

SparkPlugs = { -- Spark Plugs affect your car ignition. This will cause the vehicle to switch the engine off randomly

    ['stock_sparkplugs'] = {
        label = "STANDARD", 
        usability = {exclusive = {}, vehicletypes = {}}, 
        durability = 50.0, -- (IMPORTANT) Enter value from 0 to 100. 100 means that the part will never break
		startbreak = 25.0, -- the health set when the engine starts to switch of random. At < 1 health the engine wont start again. Values from 1-100 are allowed
		minfail = 10000, -- min time when engine turns off in ms
		maxfail = 50000, -- max time when engine turns off in ms
    },
	['ngk_sparkplugs'] = {
        label = "NGK", 
        usability = {exclusive = {}, vehicletypes = {}}, 
        durability = 90.0, -- (IMPORTANT) Enter value from 0 to 100. 100 means that the part will never break
		startbreak = 15.0, -- the health set when the engine starts to switch of random. At < 1 health the engine wont start again. Values from 1-100 are allowed
		minfail = 20000, -- min time when engine turns off in ms
		maxfail = 60000, -- max time when engine turns off in ms
    }

},

--en
Text = {

    ['hood_closed'] = 'hood closed!',
    ['mechanic_action_complete'] = 'repair finihed',
    ['mechanic_action_started'] = 'repair startet',
    ['wrong_job'] = 'wrong Job',
    ['not_enough'] = 'not enough items',
	
	--Added
	['vehicle_locked'] = 'vehicle locked!',
	['vehicle_nearby'] = 'no vehicle nearby!',
	['vehicle_notonlift'] = 'vehicle not on the lift!',
	['vehicle_notoncarjack'] = 'vehicle not on the carjack!',
	
	--Parts Stuff
	['install_engine'] = '[~r~E~w~] install engine',
	['repair_engine'] = '[~r~E~w~] repair engine',
	['installing_engine'] = '~r~engine is being installed',
	['repairing_engine'] = '~r~engine is being repaired',
	['install_turbo'] = '[~r~E~w~] install turbo',
	['repair_turbo'] = '[~r~E~w~] repair turbo',
	['installing_turbo'] = '~r~turbo is being installed',
	['repairing_turbo'] = '~r~turbo is being repaired',
	['install_nitro'] = '[~r~E~w~] install nitro',
	['repair_nitro'] = '[~r~E~w~] repair nitro',
	['installing_nitro'] = '~r~nitro is being installed',
	['repairing_nitro'] = '~r~nitro is being repaired',
	['exchange_oil'] = '[~r~E~w~] change oil',
	['refill_oil'] = '[~r~E~w~] refill oil',
	['refilling_oil'] = '~r~oil is being refilled',
	['exchanging_oil'] = '~r~oil is being changed',
	['install_transmission'] = '[~r~E~w~] install transmission',
	['repair_transmission'] = '[~r~E~w~] repair transmission',
	['installing_transmission'] = '~r~transmission is being installed',
	['repairing_transmission'] = '~r~transmission is being repaired',
	['install_tire'] = '[~r~E~w~] install tire',
	['install_brakes'] = '[~r~E~w~] install brake',
	['install_suspension'] = '[~r~E~w~] install suspension',
	
		
	--New
	['install_sparkplugs'] = '[~r~E~w~] install sparkplugs'
}

}



function SendTextMessage(msg)
	QBCore.Functions.Notify(msg)
end
