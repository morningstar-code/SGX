local QBCore = exports['qb-core']:GetCoreObject()

-- all of your bodycam locations, same order as Config.Jobs keys
local bodycamLocations = {
  police     = vector3(446.7202, -998.7824, 34.9701),  -- Mission Row PD
  sheriff    = vector3(1855.358, 3688.718, 34.252), -- Sandy Shores Sheriff
  ambulance  = vector3(324.524, -600.161, 43.267),  -- Pillbox ER
}

-- once the player is fully in, register your target zones
RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
  local pd = QBCore.Functions.GetPlayerData()
  local job = pd.job and pd.job.name

  if not job or not Config.Jobs[job] then
    print("^1[bodycam] no matching Config.Jobs entry for your job:^7", job)
    return
  end

  local loc   = bodycamLocations[job]
  local text  = Config.Jobs[job].text or "[E] Open BodyCam"
  local dist  = Config.Jobs[job].distance or 3.0

  -- give each zone a unique name by appending your job
  exports['qb-target']:AddBoxZone(
    'bodycam_menu_'..job,  -- unique zone name
    loc,                   -- center
    1.5, 1.5,              -- width, length
    {
      name      = 'bodycam_menu_'..job,
      heading   = 0,
      debugPoly = true,    -- set to false once it works
      minZ      = loc.z - 1.0,
      maxZ      = loc.z + 1.0,
    },
    {
      options = {
        {
          event = 'bodycam:cl:openMenu',
          icon  = 'fas fa-video',
          label = text,
        },
      },
      distance = dist,
    }
  )
  print("^2[bodycam] zone added for job:", job)
end)

-- your NUI opener remains the same
RegisterNetEvent('bodycam:cl:openMenu', function()
  menustate = true
  SetNuiFocus(true, true)
  SendNUIMessage({ type = "OPEN_MENU" })
end)




RegisterCommand("menubodycam", function(source, args, rawCommand)
    menustate = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "OPEN_MENU",
    })
end, false)
