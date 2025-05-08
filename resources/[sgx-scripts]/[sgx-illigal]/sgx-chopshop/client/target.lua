Citizen.CreateThread(function()
  if Config.Target == "qb" then
    exports['qb-target']:AddBoxZone("ChopShopParts", vector3(471.5797, -1312.1295, 30.2579), 1.40, 1.35, {
      name="ChopShopParts",
      heading=113.1992,
      debugPoly=false,
      minZ=28.77834,
      maxZ=29.87834,
      }, {
    options = {
      {
        type = "client",
        event = "sgx-chopshop:StartMenu",
        icon = "fas fa-hammer",
        label = "Chop Parts",
        job = all,
      },
    },
    distance = 3.5
    })
--[[     exports['qb-target']:SpawnPed({
      [5487] = {
          model = 'csb_prologuedriver',
          coords = Config.StartLoc,
          minusOne = true,
          freeze = true,
          invincible = true,
          blockevents = true,
          scenario = 'WORLD_HUMAN_CLIPBOARD',
          target = {
            options = {
              {
                type = "client",
                event = "sgx-chopshop:jobaccept",
                icon = 'fas fa-car',
                label = 'Locate A Vehicle',
              }
            },
            distance = 1.5,
          }
      }
      }) ]]
      RequestModel(Config.Ped)
	while not HasModelLoaded(Config.Ped) do
		Wait(0)
	end
    spawnedped = CreatePed(0, Config.Ped, Config.PedLocation.x, Config.PedLocation.y, Config.PedLocation.z - 1.0, Config.PedLocation.w or 0.0, false, true)
    FreezeEntityPosition(spawnedped, true)
    SetEntityInvincible(spawnedped, true)
    SetBlockingOfNonTemporaryEvents(spawnedped, true)
    TaskStartScenarioInPlace(spawnedped, 'WORLD_HUMAN_AA_COFFEE', 0, true)

    exports['qb-target']:AddBoxZone('ChopPed', vector3(Config.PedLocation.x, Config.PedLocation.y, Config.PedLocation.z), 1.0, 1.0, {
        heading = Config.PedLocation.w,
        minZ = (Config.PedLocation.z - 1),
        maxZ = (Config.PedLocation.z + 1),
    }, {
        options = {
            {
              type = "client",
              event = "sgx-chopshop:jobaccept",
              icon = 'fas fa-car',
              label = 'Locate A Vehicle',
            },
        }, 
        distance = 3.0,
    })
  elseif Config.Target == "berkie" then
    exports['berkie-target']:AddBoxZone("ChopShopParts", vector3(471.5797, -1312.1295, 30.2579), 1.40, 1.35, {
      name="ChopShopParts",
      heading=113.1992,
      debugPoly=false,
      minZ=28.77834,
      maxZ=29.87834,
      }, {
    options = {
      {
        type = "client",
        event = "sgx-chopshop:StartMenu",
        icon = "fas fa-hammer",
        label = "Chop Parts",
        job = all,
      },
    },
    distance = 3.5
    })
  
    exports['qb-target']:SpawnPed({
      [2328] = {
          model = 'csb_prologuedriver',
          coords = Config.StartLoc,
          minusOne = true,
          freeze = true,
          invincible = true,
          blockevents = true,
          scenario = 'WORLD_HUMAN_CLIPBOARD',
          target = {
            options = {
              {
                type = "client",
                event = "sgx-chopshop:jobaccept",
                icon = 'fas fa-car',
                label = 'Locate A Vehicle',
              }
            },
            distance = 1.5,
          }
      }
      })
    elseif Config.Target == "bt" then
      exports['qb-target']:AddBoxZone("ChopShopParts", vector3(471.5797, -1312.1295, 30.2579), 1.40, 1.35, {
        name="ChopShopParts",
        heading=113.1992,
        debugPoly=false,
        minZ=28.77834,
        maxZ=29.87834,
        }, {
      options = {
        {
          type = "client",
          event = "sgx-chopshop:StartMenu",
          icon = "fas fa-hammer",
          label = "Chop Parts",
          job = {"all"},
        },
      },
      distance = 3.5
      })
      exports['qb-target']:AddBoxZone("StartChopJob", vector3(Config.StartLoc.x, Config.StartLoc.y, Config.StartLoc.z), 1, 1, {
        name="StartChopJob",
        heading=113.1992,
        debugPoly=false,
        minZ = Config.StartLoc.z - 1,
        maxZ = Config.StartLoc.z + 1,
        }, {
      options = {
        {
          type = "client",
          event = "sgx-chopshop:jobaccept",
          icon = "fas fa-car",
          label = "Locate A Vehicle",
          job = {"all"},
        },
      },
      distance = 3.5
      })
    end
end)