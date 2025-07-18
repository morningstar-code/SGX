## Updates

v1.3.0
- Added cuff, ziptie, broken handcuffs, cuffkeys, bolt cutter and flush cutter
- You can cuff players with handcuffs and uncuff them with cuffkeys
- You can only uncuff them from the side (front / back) where the cuffs are (same for zipties)
- You can ziptie players and cut it with flush cutter
- Illegals can use bolt cutter to cut the cuffs and will get broken cuffs

v1.3.1
- When used cuff, you'll get cuff key and cuffs will be removed
- When you use keys, it will be removed and give you cuffs again
- Added vehicle livery menu
- Added prices for police vehicles

v1.3.2 :

- Added new prop item for zipties
- Fixed the rob player when cuffed from front
- Added configurable cufftypes into config where you can choose from wether the player can move with that kind handcuffs or not

v1.3.3
- Fingerprint UI has been changed
- Added evidence research option. Police can research filled evidence bags in lab and will see more info about the evidence
- Changed depot and impound system for police. Able to use target on vehicle and charging for depot / impound
- Citizens can access police impound and will see their own cars. When they pay the charge they can get their own vehicle
- Added breakout option. When you enable this in config, the cuffed player will see a minigame and when they success they can escape.
- Fixed the problem with negative amounts for depot / impound
- Fixed warning with missing phrases
- Animation fix for dead or in last stand players

v1.3.4
- Fixed general evidence stash not opening problem
- Added ps-ui option for breakout system
- Officier will get notification when successfully cuffed or citizen broke out
- Added support for qb-target / qtarget / ox_target
- Fixed fingerprint image showing wrong person
- Added more possibility to drop bullet when shooting
- If you are LEO then you can't drop bullets when shooting
- Optimize blips network event

v1.3.5
- Fixed lab evidence menu not showing with blood or fingerprint (thnx @ F7)
- Disabled police running / jumping when escorting someone

v1.3.6
- Fixed the error from target when starting the script up
- Optimized the blip system
- Added color options for each seperate LEO job (bcso = orange, police = blue, sasp = green etc.)
- Added leo-gps item for activating / deactivating the blips (inside images folder)
- When you loose or drop your gps item, your blip will be deleted (when someone robs you and gets your gps)
- Different blip sprites depending on vehicle type (heli, boats, plane, motorbike, emergency vehicles and for all other vehicles)

v1.3.7
- Option to switch between ox_lib or qb-menu
- Fixed the bug that you can't run when you put escorted player in vehicle
- EMS job type can use GPS now, blip color is red (see config)
- Fixed the targetbone not working for impound issue
- Fixed the issue that blip was staying when player quits the game
- PlayerJob is set automatically when restarting resource
- Added config option for ps-ui circle game

v1.3.8
- Fixed the impound menu error
- GPS was still showing after going offduty
- GPS will show on short range and on big map
- Some other minor fixes and cleanups

v1.3.9
- Added ped repair stations for repairing weapons
- Added syncronized walking while escorting
- Added version checker
- Fixed police impound menu not showing for other jobs then LEO
- Fixed tow menu not showing because of error

v1.4.0

- Added ox_inventory support
- Removed leftover debug and prints
- Fixed evidence status 'unknown' to language

v.1.4.1
- Added quick equip option for armoury
- Moved phrases to language file
- Fixed ps-ui not working from config
- Addes ox_lib for skillcheck

v1.4.2
- Added cooldown for cuff spamming
	- config.lua - Config.CuffCooldown option
- Added option for disabling running and jumping while escorting
	- config.lua - Config.DisableSprintJump option
- Fixed the problem with ox_inventory not opening when uncuffed or boltcutter used
	- See readme for instructions to change an event in ox_inventory/modules/bridge/qb/client.lua
- Fixed the price in submenu for taking vehicles
- Added option to spawn multiple helicopters like vehicle garage
	- language added : info.heli_plate
- Added functionality for breatheanalyzer (Thnx @semfx for UI fix)
	- Added alcoholmeter item

v1.4.3
- Fixed the issue with weapon repair in ox_inventory
- Added object spawner menu
	- command : /objectmenu
	- language added objmenu and sub languages (en.lua 231 - 239)
- Added bridge for progressbar
	- config.lua - Config.ProgressBar option
- Added bridge for DrawText
	config.lua - Config.DrawText

v1.4.4
- Fixed an issue when placing a prop with object menu that you can't pick it up with qb-target
	- objects.lua : 137 - 138
- Changed alcohol event to add or remove alcohol promille
	- config.lua - Config.AlcoholReleaseInterval option
	- Use the next trigger to add or remove promille : 
		-- This will add between 0.01 and 0.04 promille alcohol to the user
		TriggerServerEvent('police:server:UpdateAlcohol', (math.random(1,4)/100), 'add')
- Code cleanup and removed forgotten debugs
- Fixed heli cam not working while in police helicopter
- Added a config option to enable or disable the version checking
	- config.lua - Config.EnableVersionCheck

v1.5.0
- Added config option for new qb-inventory
	- Config.Inventory = 'new-qb-inventory'
- Fixed repair ped not working after server restart
- Removed debug print of weapon data
- Fixed issue with drawtext and evidence not working
- Fixed issue policetrash not removing items when restarting script
- Fixed Armoury not opening with new qb-inventory
- Fixed version checking not working (gsub error)
- Code cleanup not used events
- Fixed bug with synced walking if the dragged player is dead or in last stand
- Stopping escorting if the escorting officier is dead
- Added config option to set repair ped as public or bound to a jobtype
	- Config.RepairStations.locations.jobtype
- Moved phrases in repair ped to locales file
	- target.repairweapon
	- target.takeback
- Fixed taking helicopter with drawtext option

v1.5.1 (hotfix)
- Fixed cuffed player being kicked when cuffing
	- Changed server\main.lua event : police:server:AddRemove

v.1.5.2
- Fixed weapon repair not working with new inventory
- Fixed repair ped not giving weapon back with public repair stations
- Police vehicles are optionally owned now so you can store it in garage
	- Added new phrase : en.lua - success.purchased
	- Config.OwnedPoliceCars
- Changed gps name from leo-gps to leo_gps to prevent errors with new items formatting
- Added polyzone support for evidence labs
